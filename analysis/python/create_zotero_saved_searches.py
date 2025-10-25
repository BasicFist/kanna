#!/usr/bin/env python3
"""
Create standard saved searches in Zotero for the KANNA project.

Searches created (AND across conditions):
  - "KANNA: Untriaged": tag contains project:KANNA, tag contains status:untriaged
  - "KANNA: PDE4":      tag contains project:KANNA, tag contains concept:PDE4
  - "KANNA: Mesembrine":tag contains project:KANNA, tag contains alkaloid:mesembrine
  - "KANNA: Year 2020": tag contains project:KANNA, tag contains year:2020

Env:
  ZOTERO_API_KEY, ZOTERO_LIBRARY_ID, ZOTERO_LIBRARY_TYPE (default user)
"""
from __future__ import annotations

import json
import os
import urllib.request
from typing import Dict, List
try:
    import yaml  # type: ignore
except Exception:
    yaml = None  # type: ignore


def require_env(name: str) -> str:
    v = os.getenv(name)
    if not v:
        raise SystemExit(f"Environment variable {name} is required")
    return v


def api_base() -> str:
    lib_type = os.getenv("ZOTERO_LIBRARY_TYPE", "user")
    lib_id = require_env("ZOTERO_LIBRARY_ID")
    return f"https://api.zotero.org/{lib_type}s/{lib_id}"


def load_config() -> Dict[str, object]:
    cfg_path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'config', 'zotero.yaml')
    if yaml and os.path.exists(cfg_path):
        try:
            with open(cfg_path, 'r', encoding='utf-8') as fh:
                return yaml.safe_load(fh) or {}
        except Exception:
            return {}
    return {}


def get_json(url: str, headers: Dict[str, str]) -> object:
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=20) as r:
        return json.loads(r.read().decode("utf-8", "ignore"))


def post_json(url: str, headers: Dict[str, str], payload: object) -> object:
    data = json.dumps(payload).encode("utf-8")
    req = urllib.request.Request(url, headers=headers, data=data, method="POST")
    with urllib.request.urlopen(req, timeout=30) as r:
        return json.loads(r.read().decode("utf-8", "ignore"))


def main() -> int:
    api_key = require_env("ZOTERO_API_KEY")
    base = api_base()
    headers = {
        "Zotero-API-Key": api_key,
        "Content-Type": "application/json",
        "Accept": "application/json",
    }

    existing = get_json(f"{base}/searches?format=json", headers)
    existing_names = {s.get("data", {}).get("name", "") for s in existing or []}

    cfg = load_config()
    yr_start = int(cfg.get('saved_search_year_start', 2015))
    yr_end = int(cfg.get('saved_search_year_end', 2025))

    targets: List[Dict[str, object]] = [
        {
            "name": "KANNA: Untriaged",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "status:untriaged"},
            ],
        },
        {
            "name": "KANNA: PDE4",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "concept:PDE4"},
            ],
        },
        {
            "name": "KANNA: SERT",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "concept:SERT"},
            ],
        },
        {
            "name": "KANNA: Mesembrine",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "alkaloid:mesembrine"},
            ],
        },
        {
            "name": "KANNA: Alkaloids",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "alkaloid:"},
            ],
        },
        {
            "name": "KANNA: Year 2020",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": "year:2020"},
            ],
        },
    ]

    # Year range searches (2015..2025)
    for yr in range(yr_start, yr_end + 1):
        targets.append({
            "name": f"KANNA: Year {yr}",
            "conditions": [
                {"condition": "tag", "operator": "contains", "value": "project:KANNA"},
                {"condition": "tag", "operator": "contains", "value": f"year:{yr}"},
            ],
        })

    to_create = [t for t in targets if t["name"] not in existing_names]
    if not to_create:
        print("No new searches to create")
        return 0

    # API accepts an array payload
    resp = post_json(f"{base}/searches?format=json", headers, to_create)
    print("=== Saved Searches ===")
    print(f"Requested: {len(to_create)}")
    # Response has success map indexed by payload order
    success = resp.get("success") if isinstance(resp, dict) else None
    if isinstance(success, dict):
        print(f"Created:  {len(success)}")
    else:
        print("Created:  unknown (check library)")
    failed = resp.get("failed") if isinstance(resp, dict) else None
    if failed:
        print(f"Failed:   {len(failed)} -> {failed}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
