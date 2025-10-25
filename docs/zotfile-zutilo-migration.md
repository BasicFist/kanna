ZotFile + Zutilo Migration Checklist (Legacy Attachments → Linked Files)
=======================================================================

Purpose
- Migrate legacy Zotero “stored files” and heterogeneous attachments to consistent linked-file attachments under the repo, without risking data loss.
- Keep new, script-imported content as-is (already linked_file with attachments: paths).

Pre‑requisites
- Zotero desktop installed
- Plugins:
  - ZotFile: https://github.com/jlegewie/zotfile
  - Zutilo: https://github.com/wshanks/Zutilo
- Zotero → Preferences → Advanced → Files and Folders:
  - Set Linked Attachment Base Directory to your repo root (e.g., `/home/miko/LAB/academic/KANNA`).
 - Optional helper for installer script: install `jq` for auto-downloading latest releases;
   otherwise download `.xpi` manually from the plugin release pages and copy them into your
   Zotero profile extensions directory.

Safe Test‑First Flow
1) Create a temporary collection “MIGRATION‑TEST (10 items)”, copy ~10 legacy items (stored files) into it.
2) ZotFile → Preferences:
   - Location of Files: Custom Location → your repo’s `literature/pdfs/BIBLIOGRAPHIE`.
   - Check “Use Zotero Linked Attachment Base Directory”.
   - Renaming Rules: keep simple: `{%y} - {title}` (or leave off to preserve current filenames).
3) Convert stored files → linked files:
   - Select attachments in the test collection → right‑click → Manage Attachments → Rename Attachments (ZotFile) → this both renames/moves and converts to linked file, respecting Base Directory.
   - Verify: attachment icon shows a chain‐link (linked); path begins with `attachments:` in the item JSON (Zutilo can show raw JSON or use our audit script).
4) Fix edge cases with Zutilo:
   - If any attachments don’t convert or remain orphans, use Zutilo “Set parent item” on a few.
5) Rollback plan (if needed):
   - Zotero → Edit → Undo (if recent), or delete converted attachments and re‑add from a backup copy.

Production Migration (Batch)
1) Work per collection (e.g., “Imported 2019”, “Legacy Library”).
2) Multi‑select stored attachments → Rename Attachments (ZotFile) to convert to linked files under the repo.
3) Confirm in the UI and via audit (see below).
4) Keep a backup snapshot until satisfied.

Verification & Audit (Scripts)
- Audit attachments and metadata:
  ```bash
  conda run -n kanna python analysis/python/audit_zotero_metadata.py \
    --output tools/reports/zotero-metadata-audit.json \
    --csv tools/reports/zotero-metadata-audit.csv
  ```
- Conservative fixer (optional):
  ```bash
  BASE_DIR=/home/miko/LAB/academic/KANNA \
  conda run -n kanna python analysis/python/fix_zotero_attachments.py
  ```

Notes & Tips
- Don’t mass‑convert web snapshots or special attachment types; keep them as stored or URLs.
- Use Saved Searches to stage work (e.g., “project:KANNA AND status:untriaged”).
- New imports via `import_zotero_linked_files.py` already use linked files; migration is only for older items.
