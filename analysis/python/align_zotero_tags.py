#!/usr/bin/env python3
"""
Align Zotero tags at scale (idempotent):
  - Ensure project:KANNA on all bibliographic items
  - Ensure year:YYYY from item date (if year present)
  - Ensure a status:* tag exists; if none, add status:untriaged

Env:
  ZOTERO_API_KEY (required)
  ZOTERO_LIBRARY_ID (required)
  ZOTERO_LIBRARY_TYPE (default: user)
"""
from __future__ import annotations

import os
import re
import time
from typing import Dict, List

from pyzotero import zotero


def require_env(name: str) -> str:
    v = os.getenv(name)
    if not v:
        raise SystemExit(f"Environment variable {name} is required")
    return v


def get_zot() -> zotero.Zotero:
    api = require_env("ZOTERO_API_KEY")
    lib = require_env("ZOTERO_LIBRARY_ID")
    typ = os.getenv("ZOTERO_LIBRARY_TYPE", "user")
    return zotero.Zotero(lib, typ, api)


def extract_year(date_str: str) -> str:
    if not date_str:
        return ""
    m = re.search(r"(\d{4})", date_str)
    return m.group(1) if m else ""


def has_prefix(tags: List[Dict[str, str]], prefix: str) -> bool:
    return any((t.get("tag") or "").startswith(prefix) for t in tags or [])


def main() -> int:
    z = get_zot()
    updated = 0
    skipped = 0
    items = z.everything(z.items())
    for it in items:
        d = it.get("data", {})
        if d.get("itemType") in {"attachment", "note"}:
            continue
        tags = d.get("tags") or []
        changed = False

        if not has_prefix(tags, "project:"):
            tags.append({"tag": "project:KANNA"})
            changed = True

        year = extract_year(d.get("date") or "")
        if year and not has_prefix(tags, "year:"):
            tags.append({"tag": f"year:{year}"})
            changed = True

        if not has_prefix(tags, "status:"):
            tags.append({"tag": "status:untriaged"})
            changed = True

        if changed:
            d["tags"] = tags
            z.update_item(it)
            updated += 1
            time.sleep(0.1)
        else:
            skipped += 1

    print("=== Tag Alignment ===")
    print(f"Updated: {updated}")
    print(f"Unchanged: {skipped}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

