Zotero Tools: Import, Enrichment, Audit
======================================

This project ships a minimal, reproducible toolkit for managing the Zotero library using existing MinerU extractions (no re‑extraction required).

Prerequisites
- Zotero desktop: set Linked Attachment Base Directory to your repo root (e.g., `/home/miko/LAB/academic/KANNA`)
- Env vars:
  - `ZOTERO_API_KEY` (read/write key)
  - `ZOTERO_LIBRARY_ID` (user or group ID)
  - `ZOTERO_LIBRARY_TYPE` (`user` or `group`, default `user`)
  - Optional: `CROSSREF_MAILTO` for polite Crossref requests

Workflow
1) Import with MinerU enrichment (no collections by default)
```
conda run -n kanna python analysis/python/import_zotero_linked_files.py \
  --no-collections \
  --base-dir /home/miko/LAB/academic/KANNA \
  --mineru-dir literature/pdfs/extractions-mineru
```

2) Enrich DOI‑bearing items via Crossref (Habanero client)
```
conda run -n kanna python analysis/python/enrich_zotero_by_doi.py
```

3) Fill missing identifiers by title (high‑confidence matches via Habanero)
```
conda run -n kanna python analysis/python/enrich_missing_doi_by_title.py
```

4) Align tags across the library
```
conda run -n kanna python analysis/python/align_zotero_tags.py
```

5) Create standard Saved Searches
```
conda run -n kanna python analysis/python/create_zotero_saved_searches.py
```

6) Audit metadata completeness
```
conda run -n kanna python analysis/python/audit_zotero_metadata.py \
  --output tools/reports/zotero-metadata-audit.json \
  --csv tools/reports/zotero-metadata-audit.csv
```

Notes
- Scripts are idempotent and conservative.
- No MinerU extraction is performed; existing extractions are used for enrichment.
- Attachment fixer (optional):
```
BASE_DIR=/home/miko/LAB/academic/KANNA \
conda run -n kanna python analysis/python/fix_zotero_attachments.py
```

CI (GitHub Actions)
- Manual audit: Actions → “Zotero Audit” → Run workflow
- Maintenance (writes): Actions → “Zotero Maintenance” → Run workflow
  - Requires: secrets.ZOTERO_API_KEY, vars ZOTERO_LIBRARY_ID and ZOTERO_LIBRARY_TYPE
  - Optional: secrets.CROSSREF_MAILTO

Saved Searches Created
- KANNA: Untriaged, KANNA: PDE4, KANNA: SERT
- KANNA: Mesembrine, KANNA: Alkaloids
- KANNA: Year 2015 … KANNA: Year 2025

Security
- Store keys as GitHub Secrets; see [docs/SECURITY-API-KEY-ROTATION.md](SECURITY-API-KEY-ROTATION.md) for rotation guidance.
