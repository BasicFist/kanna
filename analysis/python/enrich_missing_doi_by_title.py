#!/usr/bin/env python3
"""
Find DOIs for Zotero items missing DOI/url by searching Crossref with title+year.
High-confidence only: simple token Jaccard >= 0.6 on normalized titles (or exact start substring).
If match found, set DOI and url, then (optionally) you may run enrich_zotero_by_doi.py separately.

Env:
  ZOTERO_API_KEY, ZOTERO_LIBRARY_ID, ZOTERO_LIBRARY_TYPE (default user)
  CROSSREF_MAILTO (optional polite header)
"""
from __future__ import annotations

import json
import os
import re
import time
import urllib.parse
import urllib.request
from typing import Dict, Optional, Tuple

from pyzotero import zotero


def require_env(name: str) -> str:
    v = os.getenv(name)
    if not v:
        raise SystemExit(f"Environment variable {name} is required")
    return v


def get_zot() -> zotero.Zotero:
    return zotero.Zotero(require_env("ZOTERO_LIBRARY_ID"), os.getenv("ZOTERO_LIBRARY_TYPE", "user"), require_env("ZOTERO_API_KEY"))


def norm_title(s: str) -> str:
    s = (s or "").lower()
    s = re.sub(r"\s+", " ", s)
    return re.sub(r"[^a-z0-9 ]+", "", s).strip()


def year_from_date(s: str) -> str:
    m = re.search(r"(\d{4})", s or "")
    return m.group(1) if m else ""


def jaccard(a: str, b: str) -> float:
    sa = set(a.split())
    sb = set(b.split())
    if not sa or not sb:
        return 0.0
    return len(sa & sb) / len(sa | sb)


def crossref_search(title: str, year: str, mailto: Optional[str]) -> Optional[Dict]:
    q = urllib.parse.quote(title)
    base = f"https://api.crossref.org/works?rows=3&query.title={q}"
    if year:
        base += f"&filter=from-pub-date:{year}-01-01,until-pub-date:{year}-12-31"
    headers = {
        "Accept": "application/json",
        "User-Agent": f"KANNA-Zotero-DOIFind/1.0{(' mailto:'+mailto) if mailto else ''}",
    }
    req = urllib.request.Request(base, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            data = json.loads(r.read().decode("utf-8", "ignore"))
            return data
    except Exception:
        return None


def main() -> int:
    z = get_zot()
    mailto = os.getenv("CROSSREF_MAILTO")
    items = z.everything(z.items())
    updated = 0
    skipped = 0
    for it in items:
        d = it.get("data", {})
        if d.get("itemType") in {"attachment", "note"}:
            continue
        if d.get("DOI") or d.get("url"):
            continue

        title = d.get("title") or ""
        year = year_from_date(d.get("date") or "")
        if not title:
            skipped += 1
            continue
        res = crossref_search(title, year, mailto)
        if not res or not isinstance(res.get("message"), dict):
            skipped += 1
            continue
        items_cr = res["message"].get("items") or []
        if not items_cr:
            skipped += 1
            continue
        nt = norm_title(title)
        best = None
        best_score = 0.0
        for cand in items_cr:
            ct = norm_title((cand.get("title") or [""])[0])
            if not ct:
                continue
            # quick exact-start check
            if ct.startswith(nt) or nt.startswith(ct):
                score = 1.0
            else:
                score = jaccard(nt, ct)
            if score > best_score:
                best_score = score
                best = cand
        if not best or best_score < 0.6:
            skipped += 1
            continue
        doi = (best.get("DOI") or "").strip()
        if not doi:
            skipped += 1
            continue
        d["DOI"] = doi
        d["url"] = f"https://doi.org/{doi}"
        try:
            z.update_item(it)
            updated += 1
        except Exception:
            skipped += 1
        time.sleep(0.25)

    print("=== Missing DOI by Title ===")
    print(f"Updated (set DOI+url): {updated}")
    print(f"Skipped:               {skipped}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

