# Zotero Import Guide - KANNA Thesis

**Status**: ✅ Ready for import (142 PDFs pre-organized by chapter)
**Last Updated**: October 6, 2025

---

## Quick Start

**If you just want to get started:**
1. Install Zotero + Better BibTeX (steps below)
2. Drag PDFs from `chapter-XX/` folders to Zotero
3. Tag automatically by chapter based on folder
4. Configure auto-export to `kanna.bib`

**Estimated time**: 1.5-2 hours (install 30 min + import/tag 1-2 hours)

---

## Step 1: Install Zotero Desktop + Better BibTeX

### 1.1 Download & Install Zotero
```bash
# Fedora/RHEL
sudo dnf install zotero

# Or download manually
# https://www.zotero.org/download/
# Choose: Linux 64-bit (.tar.bz2)
```

### 1.2 Install Better BibTeX Plugin
1. Download latest release: https://github.com/retorquere/zotero-better-bibtex/releases/latest
   - File: `zotero-better-bibtex-*.xpi`
2. Open Zotero → **Tools → Add-ons**
3. Click gear icon ⚙️ → **Install Add-on From File**
4. Select downloaded `.xpi` file
5. Restart Zotero
6. Verify: Tools → Add-ons → "Better BibTeX for Zotero" appears

---

## Step 2: Create Collection Structure

1. Open Zotero
2. Right-click **"My Library"** → **New Collection**
3. Name: `KANNA Thesis`
4. Create sub-collections (right-click "KANNA Thesis"):
   ```
   KANNA Thesis/
   ├── Chapter 1: Introduction
   ├── Chapter 2: Botany & Taxonomy
   ├── Chapter 3: Ethnobotany
   ├── Chapter 4: Pharmacology & Chemistry
   ├── Chapter 5: Clinical Evidence
   ├── Chapter 6: Addiction & Neurobiology
   ├── Chapter 7: Legal & Ethics
   └── Chapter 8: Synthesis
   ```

---

## Step 3: Import PDFs (Batch by Chapter)

### Method A: Drag-and-Drop (Recommended)

PDFs are pre-organized in:
```
~/LAB/projects/KANNA/literature/zotero-import-staging/
├── chapter-02/  (19 PDFs - Botany/Taxonomy)
├── chapter-03/  (6 PDFs - Ethnobotany)
├── chapter-04/  (31 PDFs - Pharmacology/Chemistry)
├── chapter-05/  (6 PDFs - Clinical)
├── chapter-06/  (7 PDFs - Addiction)
├── chapter-07/  (2 PDFs - Legal/Ethics)
└── general/     (71 PDFs - Unclassified, needs manual review)
```

**Import Workflow**:
1. Open Zotero → Select "Chapter 2: Botany & Taxonomy" collection
2. Open file manager → Navigate to `chapter-02/`
3. Select all PDFs (Ctrl+A) → Drag to Zotero window
4. Zotero auto-extracts metadata (DOI, title, authors, year)
5. Repeat for chapters 3-7
6. Manually review `general/` folder (71 PDFs need classification)

**Metadata Extraction**:
- ✅ Automatic if PDF has DOI embedded
- ⚠️ Manual if DOI missing: Right-click → **Retrieve Metadata for PDF** → **From DOI**
- 💡 Tip: Add missing DOIs from extracted text corpus

### Method B: Watch Folder (Advanced)
```bash
# Configure Zotero to auto-import from folder
# Zotero Preferences → Advanced → Files and Folders
# Set "Linked Attachment Base Directory": ~/LAB/projects/KANNA/literature/pdfs/
```

---

## Step 4: Tag & Organize

### Auto-Tagging by Chapter
Since PDFs are pre-sorted into chapter folders, batch-tag after import:

1. Select all items in "Chapter 2" collection (Ctrl+A)
2. Right-click → **Add Tag** → Type: `Chapter 2`
3. Repeat for other chapters

### Additional Tags (Recommended)
- **Methodology**: `Review`, `RCT`, `In vitro`, `In vivo`, `QSAR`, `Meta-analysis`
- **Key Topics**: `PDE4`, `Mesembrine`, `Anxiety`, `Khoisan`, `Biopiracy`
- **Publication Type**: `Journal`, `Book Chapter`, `Thesis`, `Patent`

**Batch Tagging**:
- Select multiple items → Right-click → Add Tag
- Use Zotero's tag autocomplete (start typing)

---

## Step 5: Configure Better BibTeX Auto-Export

### 5.1 Export Collection to .bib File
1. Right-click **"KANNA Thesis"** collection
2. **Export Collection...**
3. Format: **Better BibLaTeX** (NOT "BibTeX" - BibLaTeX has better Unicode support)
4. Save as: `~/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
5. ✓ **Check**: **Keep updated** (auto-export on every change)

### 5.2 Verify Auto-Export
```bash
cat ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib | head -20

# Count entries
grep -c "^@article\|^@book\|^@inbook" ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib
# Should show: ~142 (minus duplicates Zotero removed)
```

### 5.3 Configure Citation Keys
Zotero → **Edit → Preferences → Better BibTeX → Citation Keys**
- Pattern: `[auth:lower][year]` (e.g., `gericke2023`)
- ✓ Check: **On conflict**: `Keep both`
- ✓ Check: **Force citation key to plain text`

---

## Step 6: Handle Duplicates

Zotero auto-detects duplicates based on:
- DOI (exact match)
- Title similarity (fuzzy match)
- ISBN for books

**Merge Duplicates**:
1. Zotero → Left sidebar → **Duplicate Items**
2. Select duplicates → **Merge Items**
3. Choose which metadata to keep (usually newer/more complete)

**Expected duplicates**: ~5-10 (some papers appear in multiple folders)

---

## Step 7: Quality Control

### Check Metadata Completeness
1. Zotero → Select all items (Ctrl+A)
2. Right-click → **Show Item Info**
3. Verify fields populated:
   - ✅ Title
   - ✅ Authors (all listed)
   - ✅ Year
   - ✅ DOI (if available)
   - ✅ Journal/Conference
   - ✅ Volume/Issue/Pages

**Add Missing DOIs**:
- Use extracted text corpus: `data/extracted-papers-simple/`
- Search first page for DOI (usually format: `10.XXXX/YYYY`)
- Add to Zotero: Item → Info tab → DOI field

### Validate BibLaTeX Export
```bash
# Check for encoding errors (should be UTF-8)
file ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib

# Validate LaTeX syntax (optional)
biber --tool kanna.bib
```

---

## Step 8: Link to Overleaf (Future)

When ready to write thesis:

### 8.1 Upload to Overleaf
1. Overleaf project → Files → Upload
2. Select `kanna.bib`
3. Overwrites automatically update (if using Git sync)

### 8.2 Cite in LaTeX
```latex
% In thesis.tex preamble
\usepackage[style=apa,backend=biber]{biblatex}
\addbibresource{kanna.bib}

% In document
According to \textcite{gericke2023}, mesembrine...

% Bibliography
\printbibliography
```

### 8.3 Sync Workflow
```
Zotero (desktop) → kanna.bib (auto-export) → Git commit → Overleaf (pull)
```

---

## Troubleshooting

### Problem: Metadata not extracted
**Solution**: Right-click PDF → **Retrieve Metadata for PDF** → **From DOI**

### Problem: DOI not found
**Solution**:
1. Open PDF in `data/extracted-papers-simple/`
2. Search for DOI (format: `10.XXXX/YYYY`)
3. Add manually to Zotero item

### Problem: Better BibTeX not auto-exporting
**Solution**:
1. Right-click "KANNA Thesis" → Export Collection
2. Re-enable "Keep updated"
3. Check file permissions: `ls -l ~/LAB/projects/KANNA/literature/zotero-export/`

### Problem: Duplicate citekeys (e.g., `gericke2023a`, `gericke2023b`)
**Solution**: This is expected - add disambiguation manually or use Better BibTeX's auto-disambiguation

### Problem: Special characters broken in .bib file
**Solution**:
1. Zotero Preferences → Better BibTeX → Export
2. ✓ Check: **Use BibLaTeX extended name format**
3. ✓ Check: **Export unicode as plain-text LaTeX commands**

---

## Classification Summary

**Pre-classified (71 PDFs)**:
- Chapter 2 (Botany): 19 PDFs
- Chapter 3 (Ethnobotany): 6 PDFs
- Chapter 4 (Pharmacology): 31 PDFs
- Chapter 5 (Clinical): 6 PDFs
- Chapter 6 (Addiction): 7 PDFs
- Chapter 7 (Legal/Ethics): 2 PDFs

**Unclassified (71 PDFs)**: Review `general/` folder manually

**Total**: 142 PDFs

**Classification Rules Used**:
- Ch 2: taxonomy, phylogeny, Aizoaceae, botanical
- Ch 3: ethnobotany, Khoisan, traditional, fermentation
- Ch 4: alkaloid, mesembrine, PDE4, SERT, QSAR, pharmacology
- Ch 5: clinical, trial, RCT, meta-analysis, Zembrin
- Ch 6: addiction, neurobiology, substance, reward
- Ch 7: biopiracy, patent, legal, WIPO, benefit-sharing

---

## Expected Timeline

| Task | Time | Notes |
|------|------|-------|
| Install Zotero + Better BibTeX | 15-30 min | One-time setup |
| Create collection structure | 5 min | 8 sub-collections |
| Import PDFs (drag-and-drop) | 30-60 min | Zotero auto-extracts metadata |
| Manual tagging by chapter | 30-60 min | Batch tag after import |
| Review metadata | 20-40 min | Fix missing DOIs, authors |
| Configure auto-export | 5 min | One-time setup |
| **Total** | **1.5-2.5 hours** | Includes quality control |

---

## Next Steps After Import

1. ✅ Review unclassified PDFs in `general/` (71 papers)
2. ✅ Add missing DOIs from extracted text corpus
3. ✅ Tag by methodology (RCT, review, in vitro, etc.)
4. ✅ Create smart collections:
   - "All Clinical Trials" (filter: tag=RCT)
   - "Chapter 4 QSAR Papers" (filter: tag=Chapter 4 AND tag=QSAR)
5. ✅ Sync to Zotero cloud (optional, for backup)
6. ✅ Integrate with Obsidian (Week 2):
   - Install Zotero Integration plugin
   - Link citations to Obsidian notes
   - Build knowledge graph

---

## Resources

- **Zotero Documentation**: https://www.zotero.org/support/
- **Better BibTeX Guide**: https://retorque.re/zotero-better-bibtex/
- **APA 7th Edition (thesis style)**: https://www.zotero.org/styles?q=apa
- **KANNA Literature Workflow**: `tools/guides/01-literature-workflow-setup.md`

---

**Status**: ✅ Ready for import
**Location**: `~/LAB/projects/KANNA/literature/zotero-import-staging/`
**Pre-classified**: 71/142 PDFs (50%)
**Manual review needed**: 71 PDFs in `general/`

**Created**: October 6, 2025
**Last Updated**: October 6, 2025
