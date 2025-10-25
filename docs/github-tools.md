GitHub/Plugin Tools Catalog (Zotero Workflow)
============================================

Core Plugins (Zotero Desktop)
- ZotFile (jlegewie/zotfile)
  - Move/rename attachments; convert stored files → linked files under Linked Attachment Base Directory.
  - Use for legacy migration; pair with our audits.
- ZotMoov (wileyyugioh/zotmoov)
  - Rule-based attachment file management in Zotero; alternative to ZotFile if you prefer declarative configs.
- Zutilo (wshanks/Zutilo)
  - Power utilities: batch operations on attachments, tags, and fields.
- Better BibTeX (retorquere/zotero-better-bibtex)
  - Continuous auto-export and citekey control for LaTeX workflows.
- Zotero Storage Scanner (retorquere/zotero-storage-scanner)
  - Diagnose missing/orphaned attachment files before/after migrations.
- mdnotes (argen0s/zotero-mdnotes)
  - Export metadata/notes/annotations to Markdown (useful for Obsidian when needed).
- Remarks (lucasrla/remarks)
  - Export Zotero Reader annotations to Markdown; modern option for annotation workflows.

CLI/Library Clients
- pyzotero (urschrei/pyzotero)
  - Python client. We use it in all Python scripts (import, enrich, audit, saved searches).
- habanero (sckott/habanero)
  - Python Crossref client. We use it for robust DOI lookups/enrichment.
- zotero-cli (jbaiter/zotero-cli)
  - Optional Python CLI for quick queries/exports.
- zotero-api-client (tnajdek/zotero-api-client)
  - JS client (optional). We provide a Node quickcheck using bare fetch; switch to this client if desired for JS-based maintenance.

Obsidian Integrations
- Obsidian Zotero Integration (mgmeyers/obsidian-zotero-integration)
  - Deep Obsidian ↔ Zotero integration; live citations, note imports, annotation handling.
- Obsidian Citation Plugin (hans/obsidian-citation-plugin)
  - Uses Better BibTeX exports for citation insertion and literature notes.

CI Workflows Added
- .github/workflows/zotero-audit.yml
  - Runs metadata audit; uploads JSON/CSV/Markdown summary.
- .github/workflows/zotero-maintenance.yml
  - Performs saved searches, tag alignment, title-based DOI fallback, DOI enrichment, then audit (manual dispatch).
- .github/workflows/zotero-js-quickcheck.yml
  - Node quickcheck: saved search presence and tag counts.

Local Docs
- docs/zotfile-zutilo-migration.md → Guided legacy attachment migration
- docs/zotero-tools.md → End-to-end scripts and CI usage
