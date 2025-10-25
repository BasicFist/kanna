#!/usr/bin/env python3
"""
Generate a detailed attachment issues report (Markdown) with direct links
to Zotero web items for manual triage.

Issues flagged (from live library):
  - attachment:not_linked_file
  - attachment:absolute_path (for linked_file only)
  - attachment:orphan (no parentItem)

Env:
  ZOTERO_API_KEY, ZOTERO_LIBRARY_ID, ZOTERO_LIBRARY_TYPE (default user)
"""
from __future__ import annotations

import os
from pathlib import Path
from typing import Dict, List

from pyzotero import zotero


def require_env(name: str) -> str:
    v = os.getenv(name)
    if not v:
        raise SystemExit(f"Environment variable {name} is required")
    return v


def get_zot() -> zotero.Zotero:
    return zotero.Zotero(require_env("ZOTERO_LIBRARY_ID"), os.getenv("ZOTERO_LIBRARY_TYPE", "user"), require_env("ZOTERO_API_KEY"))


def web_item_url(library_type: str, library_id: str, key: str) -> str:
    if library_type == "group":
        return f"https://www.zotero.org/groups/{library_id}/items/{key}"
    return f"https://www.zotero.org/users/{library_id}/items/{key}"


def main() -> int:
    z = get_zot()
    lib_type = os.getenv("ZOTERO_LIBRARY_TYPE", "user")
    lib_id = require_env("ZOTERO_LIBRARY_ID")

    items = z.everything(z.items())
    issues: List[Dict[str, str]] = []
    for it in items:
        d = it.get("data", {})
        if d.get("itemType") != "attachment":
            continue
        key = it.get("key")
        title = d.get("title", "")
        lm = d.get("linkMode")
        path = d.get("path") or ""
        parent = d.get("parentItem") or ""
        val_issues: List[str] = []
        if lm != "linked_file":
            val_issues.append("attachment:not_linked_file")
        if lm == "linked_file" and path and not str(path).startswith("attachments:"):
            val_issues.append("attachment:absolute_path")
        if not parent:
            val_issues.append("attachment:orphan")
        if val_issues:
            issues.append({
                "key": key,
                "title": title,
                "link": web_item_url(lib_type, lib_id, key),
                "issues": ", ".join(val_issues),
            })

    out = Path("tools/reports/attachment-issues.md")
    out.parent.mkdir(parents=True, exist_ok=True)
    with out.open("w", encoding="utf-8") as fh:
        fh.write("# Attachment Issues Report\n\n")
        fh.write(f"Total issues: {len(issues)}\n\n")
        for row in issues:
            fh.write(f"- [{row['key']}]({row['link']}) — {row['title']}\n")
            fh.write(f"  - Issues: {row['issues']}\n")
    print(f"Wrote {len(issues)} attachment issues to {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

