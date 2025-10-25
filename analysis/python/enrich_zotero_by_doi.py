#!/usr/bin/env python3
"""
Enrich Zotero journalArticle items with Crossref metadata using DOI.

Adds missing fields only (non-destructive): publicationTitle, journalAbbreviation,
volume, issue, pages, ISSN, publisher, language, date, url, abstractNote,
and improves creators if empty.

Requirements:
  - Environment variables:
      * ZOTERO_API_KEY
      * ZOTERO_LIBRARY_ID
      * ZOTERO_LIBRARY_TYPE (default: user)
      * CROSSREF_MAILTO (optional; polite header for Crossref requests)

Usage:
  python analysis/python/enrich_zotero_by_doi.py [--limit N]

This script is idempotent and respects basic rate limits and backoff.
"""

from __future__ import annotations

import json
import os
import re
import time
import urllib.error
import urllib.parse
import urllib.request
from typing import Dict, List, Optional, Tuple

from pyzotero import zotero


def require_env(name: str) -> str:
    v = os.getenv(name)
    if not v:
        raise SystemExit(f"Environment variable {name} is required")
    return v


def get_zot() -> zotero.Zotero:
    api = require_env("ZOTERO_API_KEY")
    lib_id = require_env("ZOTERO_LIBRARY_ID")
    lib_type = os.getenv("ZOTERO_LIBRARY_TYPE", "user")
    return zotero.Zotero(lib_id, lib_type, api)


def norm_doi(raw: str) -> str:
    if not raw:
        return ""
    doi = raw.strip()
    doi = re.sub(r"^doi:\s*", "", doi, flags=re.I)
    doi = doi.strip().strip("[]{}()")
    doi = re.sub(r"\s+", "", doi)
    return doi.rstrip(".")


def http_get_json(url: str, headers: Dict[str, str], timeout: float = 20.0) -> Tuple[int, Dict[str, str], Optional[dict]]:
    req = urllib.request.Request(url, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            code = r.getcode()
            hdrs = {k.lower(): v for k, v in r.headers.items()}
            data = json.loads(r.read().decode("utf-8", "ignore"))
            return code, hdrs, data
    except urllib.error.HTTPError as e:
        hdrs = {k.lower(): v for k, v in e.headers.items()} if e.headers else {}
        return e.code, hdrs, None
    except Exception:
        return 0, {}, None


def backoff_sleep(attempt: int, hdrs: Dict[str, str]) -> None:
    ra = hdrs.get("retry-after")
    if ra:
        try:
            delay = float(ra)
            time.sleep(delay)
            return
        except Exception:
            pass
    # Exponential backoff with jitter
    base = 1.5
    delay = min(60.0, base * (2 ** (attempt - 1)))
    delay *= 0.75 + 0.5 * (time.time() % 1.0)
    time.sleep(delay)


def fetch_crossref(doi: str, mailto: Optional[str], verbose: bool = False) -> Optional[dict]:
    url = f"https://api.crossref.org/works/{urllib.parse.quote(doi)}"
    headers = {
        "Accept": "application/json",
        "User-Agent": f"KANNA-Zotero-Enrich/1.0 (+https://example.org){(' mailto:' + mailto) if mailto else ''}",
    }
    attempt = 0
    while attempt < 5:
        attempt += 1
        code, hdrs, data = http_get_json(url, headers)
        if code == 200 and data and isinstance(data, dict):
            return data.get("message") or data
        if code in (429, 503):
            backoff_sleep(attempt, hdrs)
            continue
        if code == 404:
            return None
        if verbose and attempt == 1:
            print(f"Crossref fetch non-OK for {doi}: HTTP {code}")
        # transient
        backoff_sleep(attempt, hdrs)
    return None


def get_first(arr: List) -> str:
    if not arr:
        return ""
    v = arr[0]
    return v if isinstance(v, str) else str(v)


def crossref_to_zotero_fields(cr: dict) -> Dict[str, str]:
    out: Dict[str, str] = {}
    out["publicationTitle"] = get_first(cr.get("container-title") or [])
    out["journalAbbreviation"] = get_first(cr.get("short-container-title") or [])
    out["volume"] = cr.get("volume") or ""
    out["issue"] = cr.get("issue") or cr.get("journal-issue", {}).get("issue") or ""
    out["pages"] = cr.get("page") or ""
    issn = cr.get("ISSN") or []
    if issn:
        out["ISSN"] = ", ".join(issn)
    # Language (prefer ISO code)
    out["language"] = cr.get("language") or ""
    # Date
    issued = cr.get("issued", {}).get("'date-parts") or cr.get("issued", {}).get("date-parts") or []
    if issued and issued[0]:
        parts = issued[0]
        out["date"] = "-".join(str(p) for p in parts if p)
    # Abstract
    abstract = cr.get("abstract") or ""
    if abstract:
        # strip HTML tags
        abstract = re.sub(r"<[^>]+>", " ", abstract)
        abstract = re.sub(r"\s+", " ", abstract).strip()
        out["abstractNote"] = abstract
    return out


def crossref_authors(cr: dict) -> List[Dict[str, str]]:
    authors = []
    for a in cr.get("author") or []:
        given = a.get("given") or ""
        family = a.get("family") or ""
        name = a.get("name") or ""
        if family or given:
            authors.append({"creatorType": "author", "firstName": given, "lastName": family})
        elif name:
            authors.append({"creatorType": "author", "name": name})
    return authors


def needs_update(zdata: dict, proposed: Dict[str, str]) -> bool:
    for k, v in proposed.items():
        cur = zdata.get(k)
        if not cur and v:
            return True
    return False


def apply_updates(z: zotero.Zotero, item: dict, proposed: Dict[str, str], new_creators: List[Dict[str, str]]) -> bool:
    data = item.get("data", {})
    changed = False
    for k, v in proposed.items():
        if v and not data.get(k):
            data[k] = v
            changed = True
    if new_creators and not data.get("creators"):
        data["creators"] = new_creators
        changed = True
    if changed:
        z.update_item(item)
    return changed


def main(limit: Optional[int] = None, verbose: bool = False) -> int:
    z = get_zot()
    mailto = os.getenv("CROSSREF_MAILTO")
    updates = 0
    skips = 0
    errors = 0

    items = z.everything(z.items())
    count = 0
    err_printed = 0
    for it in items:
        data = it.get("data", {})
        if data.get("itemType") in {"attachment", "note"}:
            continue
        doi = norm_doi(data.get("DOI") or "")
        if not doi:
            continue
        count += 1
        if limit and count > limit:
            break

        # Propose fields
        cr = fetch_crossref(doi, mailto, verbose=verbose)
        if not cr:
            skips += 1
            continue
        proposed = crossref_to_zotero_fields(cr)
        new_authors = crossref_authors(cr)
        # Ensure URL is DOI resolver if missing or non-http
        if doi and (not data.get("url") or not str(data.get("url")).startswith("http")):
            proposed["url"] = f"https://doi.org/{doi}"

        try:
            if needs_update(data, proposed) or (new_authors and not data.get("creators")):
                if apply_updates(z, it, proposed, new_authors):
                    updates += 1
            else:
                skips += 1
        except Exception as e:
            errors += 1
            if verbose and err_printed < 8:
                print(f"Update failed for {it.get('key')} doi:{doi} -> {type(e).__name__}: {e}")
                err_printed += 1
            # Brief backoff in case of version conflict
            time.sleep(0.5)

        # Polite pacing
        time.sleep(0.25)

    print("=== Enrich by DOI (Crossref) ===")
    print(f"Processed: {count}")
    print(f"Updated:   {updates}")
    print(f"Skipped:   {skips}")
    print(f"Errors:    {errors}")
    return 0


if __name__ == "__main__":
    import argparse
    p = argparse.ArgumentParser(description="Enrich Zotero items by DOI via Crossref")
    p.add_argument("--limit", type=int, help="Limit number of DOI items to process")
    p.add_argument("--verbose", action="store_true", help="Verbose logging")
    args = p.parse_args()
    raise SystemExit(main(limit=args.limit, verbose=args.verbose))
