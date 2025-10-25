#!/usr/bin/env python3
"""
Attachment hygiene fixer (idempotent, conservative):
  - Convert absolute paths under BASE_DIR to attachments:relative paths
  - Ensure linkMode remains linked_file
  - Link orphan attachments to a parent by matching title to exactly one parent title

Env:
  ZOTERO_API_KEY, ZOTERO_LIBRARY_ID, ZOTERO_LIBRARY_TYPE (default user)
  BASE_DIR (required to convert absolute → attachments:)
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


def build_parent_title_index(items: List[dict]) -> Dict[str, List[str]]:
    idx: Dict[str, List[str]] = {}
    for it in items:
        d = it.get("data", {})
        if d.get("itemType") in {"attachment", "note"}:
            continue
        t = (d.get("title") or "").strip()
        if not t:
            continue
        idx.setdefault(t, []).append(it.get("key"))
    return idx


def main() -> int:
    z = get_zot()
    base_dir = Path(require_env("BASE_DIR")).resolve()
    all_items = z.everything(z.items())
    parents_by_title = build_parent_title_index(all_items)

    fixed_paths = 0
    linked_parents = 0
    skipped = 0

    for it in all_items:
        d = it.get("data", {})
        if d.get("itemType") != "attachment":
            continue

        changed = False
        path = d.get("path") or ""
        if path and not str(path).startswith("attachments:"):
            # Convert absolute path under base_dir to attachments:
            p = Path(path)
            try:
                rel = p.resolve().relative_to(base_dir)
                d["path"] = f"attachments:{rel.as_posix()}"
                changed = True
                fixed_paths += 1
            except Exception:
                pass

        if not d.get("parentItem"):
            # Try to link to a parent with the same title (exact match, unique)
            t = (d.get("title") or "").strip()
            if t and t in parents_by_title and len(parents_by_title[t]) == 1:
                d["parentItem"] = parents_by_title[t][0]
                changed = True
                linked_parents += 1

        if changed:
            z.update_item(it)
        else:
            skipped += 1

    print("=== Attachment Hygiene ===")
    print(f"Paths converted: {fixed_paths}")
    print(f"Linked parents: {linked_parents}")
    print(f"Unchanged:      {skipped}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

