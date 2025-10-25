#!/usr/bin/env python3
"""
Audit Zotero library for missing/weak metadata and attachment hygiene.

Checks (bibliographic items):
  - title, creators, date (year), DOI or url
  - publicationTitle, journalAbbreviation, volume, issue, pages, ISSN, language
  - abstractNote
  - tags: project:KANNA, year:YYYY, status:*
  - has linked-file attachment child

Checks (attachments):
  - linkMode == linked_file
  - path uses attachments: (not absolute), parentItem present

Also flags potential duplicates by normalized (title+year) when DOI missing.

Outputs JSON and optional CSV summary.

Env vars:
  ZOTERO_API_KEY (required)
  ZOTERO_LIBRARY_ID (required)
  ZOTERO_LIBRARY_TYPE (default: user)
"""

from __future__ import annotations

import argparse
import csv
import os
import re
from collections import Counter, defaultdict
from datetime import datetime
from pathlib import Path
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


def normalize_title(s: str) -> str:
    s = (s or "").lower()
    s = re.sub(r"\s+", " ", s)
    return re.sub(r"[^a-z0-9 ]+", "", s).strip()


def extract_year(date_str: str) -> str:
    if not date_str:
        return ""
    m = re.search(r"(\d{4})", date_str)
    return m.group(1) if m else ""


def has_tag(data: dict, prefix: str) -> bool:
    tags = [t.get("tag", "") for t in data.get("tags", [])]
    return any(tag.startswith(prefix) for tag in tags)


def audit_library(z: zotero.Zotero) -> Dict[str, object]:
    items = z.everything(z.items())

    biblio_items: List[dict] = []
    attachments: List[dict] = []
    for it in items:
        dtype = it.get("data", {}).get("itemType")
        if dtype == "attachment":
            attachments.append(it)
        elif dtype != "note":
            biblio_items.append(it)

    # Parent attachment index
    parents_with_att: set[str] = set()
    attachment_issues: List[Dict[str, object]] = []
    for att in attachments:
        d = att.get("data", {})
        key = att.get("key")
        issues: List[str] = []
        lm = d.get("linkMode")
        if lm != "linked_file":
            issues.append("attachment:not_linked_file")
        # Only consider absolute path issues for linked_file attachments
        p = d.get("path") or ""
        if lm == "linked_file" and p and not str(p).startswith("attachments:"):
            issues.append("attachment:absolute_path")
        if not d.get("parentItem"):
            issues.append("attachment:orphan")
        else:
            parents_with_att.add(d["parentItem"])
        if issues:
            attachment_issues.append({
                "key": key,
                "title": d.get("title", ""),
                "issues": issues,
            })

    # Duplicate detection by normalized title+year when DOI missing
    sig_to_keys: Dict[Tuple[str, str], List[str]] = defaultdict(list)
    for it in biblio_items:
        d = it.get("data", {})
        doi = (d.get("DOI") or "").strip()
        if doi:
            continue
        sig = (normalize_title(d.get("title", "")), extract_year(d.get("date", "")))
        if sig != ("", ""):
            sig_to_keys[sig].append(it.get("key"))

    potential_dups = [{"signature": sig, "keys": keys} for sig, keys in sig_to_keys.items() if len(keys) > 1]

    # Audit biblio items
    biblio_audit: List[Dict[str, object]] = []
    missing_counter: Counter[str] = Counter()
    for it in biblio_items:
        d = it.get("data", {})
        k = it.get("key")
        title = d.get("title", "")
        year = extract_year(d.get("date", ""))
        missing: List[str] = []

        # Minimal identity
        if not title:
            missing.append("title")
        if not d.get("creators"):
            missing.append("creators")
        if not year:
            missing.append("year")
        if not (d.get("DOI") or d.get("url")):
            missing.append("identifier")

        # Publication metadata
        if d.get("itemType") == "journalArticle":
            if not d.get("publicationTitle"):
                missing.append("publicationTitle")
            if not d.get("volume"):
                missing.append("volume")
            if not d.get("issue"):
                missing.append("issue")
            if not d.get("pages"):
                missing.append("pages")
            if not d.get("journalAbbreviation"):
                missing.append("journalAbbreviation")
            if not d.get("ISSN"):
                missing.append("ISSN")

        if not d.get("abstractNote"):
            missing.append("abstractNote")

        # Tag hygiene
        if not has_tag(d, "project:KANNA"):
            missing.append("tag:project")
        if not has_tag(d, "year:"):
            missing.append("tag:year")
        if not has_tag(d, "status:"):
            missing.append("tag:status")

        # Attachment presence
        if k not in parents_with_att:
            missing.append("attachment:missing")

        for m in missing:
            missing_counter[m] += 1

        biblio_audit.append({
            "key": k,
            "itemType": d.get("itemType"),
            "title": title,
            "year": year,
            "DOI": d.get("DOI", ""),
            "url": d.get("url", ""),
            "missing": missing,
        })

    summary = {
        "totals": {
            "biblio_items": len(biblio_items),
            "attachments": len(attachments),
        },
        "missing_counts": dict(missing_counter),
        "potential_duplicates": potential_dups,
        "attachment_issues": attachment_issues,
    }

    return {"summary": summary, "biblio": biblio_audit}


def write_json(path: Path, obj: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(__import__("json").dumps(obj, indent=2, ensure_ascii=False), encoding="utf-8")


def write_csv(path: Path, rows: List[Dict[str, object]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fields = ["key", "itemType", "title", "year", "DOI", "url", "missing"]
    with path.open("w", newline="", encoding="utf-8") as fh:
        w = csv.DictWriter(fh, fieldnames=fields)
        w.writeheader()
        for r in rows:
            rr = r.copy()
            rr["missing"] = ",".join(r.get("missing", []))
            w.writerow(rr)


def write_md(path: Path, report: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    s = report["summary"]
    lines = []
    lines.append("# Zotero Metadata Audit Summary")
    lines.append("")
    lines.append(f"- Biblio items: {s['totals']['biblio_items']}")
    lines.append(f"- Attachments:  {s['totals']['attachments']}")
    lines.append("")
    lines.append("## Top Missing Fields")
    mc = s["missing_counts"]
    for k, v in sorted(mc.items(), key=lambda kv: kv[1], reverse=True)[:10]:
        lines.append(f"- {k}: {v}")
    lines.append("")
    lines.append(f"- Potential duplicates: {len(s['potential_duplicates'])}")
    lines.append(f"- Attachment issues:   {len(s['attachment_issues'])}")
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> int:
    p = argparse.ArgumentParser(description="Audit Zotero library metadata completeness")
    p.add_argument("--output", type=str, help="JSON output path", default="tools/reports/zotero-metadata-audit.json")
    p.add_argument("--csv", type=str, help="CSV output path", default="tools/reports/zotero-metadata-audit.csv")
    p.add_argument("--md", type=str, help="Markdown summary path", default="tools/reports/zotero-metadata-audit.md")
    args = p.parse_args()

    z = get_zot()
    report = audit_library(z)
    write_json(Path(args.output), report)
    write_csv(Path(args.csv), report["biblio"]) 
    write_md(Path(args.md), report)

    # Print concise summary
    print("=== Zotero Metadata Audit ===")
    print(f"Biblio items: {report['summary']['totals']['biblio_items']}")
    print(f"Attachments:  {report['summary']['totals']['attachments']}")
    print("Top missing fields:")
    # Show top 10
    from collections import Counter
    mc = Counter(report["summary"]["missing_counts"]) 
    for k, v in mc.most_common(10):
        print(f"  - {k}: {v}")
    print(f"Potential duplicates: {len(report['summary']['potential_duplicates'])}")
    print(f"Attachment issues:   {len(report['summary']['attachment_issues'])}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
