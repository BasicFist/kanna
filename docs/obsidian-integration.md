Obsidian Integration with Zotero (Templates + Plugins)
======================================================

Goal
- Create literature notes in Obsidian from Zotero items with consistent frontmatter and tags; complement MinerU-generated notes.

Vault & Paths
- Obsidian vault: `writing/obsidian-notes/`
- Notes directory: `writing/obsidian-notes/literature/`
- Templates directory: `writing/obsidian-notes/templates/`
- Bibliography: `literature/zotero-export/kanna.bib`

Recommended Plugins
- Obsidian Citation Plugin (hans/obsidian-citation-plugin)
  - Uses Better BibTeX `.bib` for citation + literature note templates.
- Obsidian Zotero Integration (mgmeyers/obsidian-zotero-integration)
  - Directly pulls from Zotero DB (fast metadata, annotations import); optional but powerful.
- Dataview (blacksmithgu/obsidian-dataview)
  - Optional query views across notes (by year, tags, etc.).

Citation Plugin Setup
1) Install “Citations” in Obsidian (Community Plugins), then enable it.
2) Settings → Citations:
   - Bibliography path: `literature/zotero-export/kanna.bib`
   - Literature note folder: `writing/obsidian-notes/literature`
   - Template folder: `writing/obsidian-notes/templates`
   - Literature note template: `writing/obsidian-notes/templates/literature-note.md`
3) Create new literature note with Ctrl/Cmd+P → “Insert Literature Note” → pick a Zotero item.

Zotero Integration Plugin Setup (optional)
1) Install “Zotero Integration” in Obsidian (Community Plugins), then enable it.
2) Settings → Zotero Integration:
   - “Zotero DB Path”: let the plugin auto-detect or set manually:
     - Linux: `~/.zotero/zotero/<profile>/zotero/zotero.sqlite`
     - macOS: `~/Library/Application Support/Zotero/Profiles/<profile>/zotero/zotero.sqlite`
   - “Export folder” → point to `writing/obsidian-notes/literature` (for notes) or an annotations subfolder if desired.
3) Use commands “Create literature note from Zotero item” or “Import annotations”.

Templates
- A ready-to-use literature note template is provided at:
  - `writing/obsidian-notes/templates/literature-note.md`
  - Compatible with the Citation plugin’s template variables.

Dataview Examples (optional)
```
TABLE year, doi, url
FROM "writing/obsidian-notes/literature"
WHERE contains(tags, "project:KANNA")
SORT year DESC
```

Notes
- This flow complements existing MinerU notes; keep both when helpful:
  - MinerU notes → extracted content summaries
  - Zotero literature notes → metadata-first with links to attachments + annotations
- Ensure Better BibTeX auto-export keeps `kanna.bib` fresh.

