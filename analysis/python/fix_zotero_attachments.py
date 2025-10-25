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
from typing import Dict, List, Tuple
import re

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


def build_parent_title_index(items: List[dict]) -> Tuple[Dict[str, List[str]], Dict[str, List[str]]]:
    exact: Dict[str, List[str]] = {}
    fuzzy: Dict[str, List[str]] = {}
    for it in items:
        d = it.get("data", {})
        if d.get("itemType") in {"attachment", "note"}:
            continue
        t = (d.get("title") or "").strip()
        if not t:
            continue
        exact.setdefault(t, []).append(it.get("key"))
        nt = norm_title(t)
        if nt:
            fuzzy.setdefault(nt, []).append(it.get("key"))
    return exact, fuzzy


def main() -> int:
    z = get_zot()
    base_dir = Path(require_env("BASE_DIR")).resolve()
    all_items = z.everything(z.items())
    exact_index, fuzzy_index = build_parent_title_index(all_items)

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
            candidate_key = None
            if t and t in exact_index and len(exact_index[t]) == 1:
                candidate_key = exact_index[t][0]
            else:
                nt = norm_title(t)
                if nt and nt in fuzzy_index and len(fuzzy_index[nt]) == 1:
                    candidate_key = fuzzy_index[nt][0]
            if candidate_key:
                d["parentItem"] = candidate_key
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
