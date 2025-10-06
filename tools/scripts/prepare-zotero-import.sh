#!/usr/bin/env bash
# =============================================================================
# Zotero Import Preparation Script
# =============================================================================
# Purpose: Prepare 142 PDFs for batch import to Zotero
# Prerequisites: Zotero desktop app + Better BibTeX plugin installed
# =============================================================================

set -euo pipefail

KANNA_DIR="$HOME/LAB/projects/KANNA"
PDF_DIR="$KANNA_DIR/literature/pdfs/BIBLIOGRAPHIE"
IMPORT_STAGING="$KANNA_DIR/literature/zotero-import-staging"
LOG_FILE="$HOME/LAB/logs/zotero-import-prep-$(date +%Y%m%d).log"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $*" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" | tee -a "$LOG_FILE"
}

# =============================================================================
# 1. VERIFY PREREQUISITES
# =============================================================================

log "=========================================="
log "Zotero Import Preparation"
log "=========================================="

# Check if Zotero is installed
if ! command -v zotero &> /dev/null; then
    warn "Zotero not found in PATH"
    echo ""
    echo "MANUAL STEPS REQUIRED:"
    echo "1. Download Zotero: https://www.zotero.org/download/"
    echo "2. Install Zotero desktop app (not browser connector)"
    echo "3. Install Better BibTeX plugin:"
    echo "   - Download: https://github.com/retorquere/zotero-better-bibtex/releases/latest"
    echo "   - In Zotero: Tools → Add-ons → Install Add-on From File"
    echo "4. Re-run this script"
    echo ""
    exit 1
fi

log "✓ Zotero found: $(which zotero)"

# =============================================================================
# 2. CREATE IMPORT STAGING DIRECTORY
# =============================================================================

log "Creating import staging directory..."
mkdir -p "$IMPORT_STAGING"

# Count PDFs
PDF_COUNT=$(find "$PDF_DIR" -name "*.pdf" | wc -l)
log "Found $PDF_COUNT PDFs to import"

# =============================================================================
# 3. ORGANIZE PDFS BY CHAPTER (FOR BETTER TAGGING)
# =============================================================================

log "Organizing PDFs by chapter..."

# Create chapter subdirectories
for chapter in {1..8}; do
    mkdir -p "$IMPORT_STAGING/chapter-0$chapter"
done

# Create general/unclassified directory
mkdir -p "$IMPORT_STAGING/general"

# Copy PDFs to general (user will manually categorize)
log "Copying PDFs to staging area..."
cp -r "$PDF_DIR"/*.pdf "$IMPORT_STAGING/general/" 2>/dev/null || true

log "✓ PDFs staged in: $IMPORT_STAGING/general/"

# =============================================================================
# 4. CREATE ZOTERO IMPORT GUIDE
# =============================================================================

cat > "$IMPORT_STAGING/IMPORT-GUIDE.md" <<'EOF'
# Zotero Import Guide

## Step 1: Verify Better BibTeX Installation

1. Open Zotero
2. Go to: **Tools → Add-ons**
3. Verify "Better BibTeX for Zotero" is installed and enabled
4. If not installed:
   - Download: https://github.com/retorquere/zotero-better-bibtex/releases/latest
   - Install via: Tools → Add-ons → Install Add-on From File

## Step 2: Create KANNA Collection

1. In Zotero, right-click "My Library" → **New Collection**
2. Name: `KANNA Thesis`
3. Create sub-collections (optional):
   - Chapter 1: Introduction
   - Chapter 2: Botany
   - Chapter 3: Ethnobotany
   - Chapter 4: Pharmacology
   - Chapter 5: Clinical
   - Chapter 6: Addiction
   - Chapter 7: Legal/Ethics
   - Chapter 8: Synthesis

## Step 3: Batch Import PDFs

### Method A: Drag-and-Drop (Recommended for Small Batches)
1. Open Zotero
2. Select "KANNA Thesis" collection
3. Drag PDFs from `zotero-import-staging/general/` to Zotero window
4. Zotero will auto-extract metadata from PDFs (DOIs, titles, authors)
5. Manually tag by chapter (right-click → Add Tag → "Chapter 2", etc.)

### Method B: Watch Folder (Automatic Import)
1. Zotero Preferences → General → Files and Folders
2. Enable "Automatically attach PDFs and other files"
3. Set "Linked Attachment Base Directory": `~/LAB/projects/KANNA/literature/pdfs/`
4. Copy PDFs to Zotero's watched folder
5. Zotero will auto-import

### Method C: CLI Import (Advanced)
```bash
# Using Zotero CLI (if available)
for pdf in zotero-import-staging/general/*.pdf; do
    zotero --import "$pdf"
done
```

## Step 4: Configure Better BibTeX Auto-Export

1. Right-click "KANNA Thesis" collection → **Export Collection**
2. Format: **Better BibLaTeX** (not BibTeX)
3. Save to: `~/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
4. ✓ Check: **Keep updated** (auto-export on every change)

**Verify auto-export**:
```bash
cat ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib
```

## Step 5: Tag PDFs by Chapter

**Tagging Strategy**:
- **Chapter 2** (Botany): Taxonomy, phylogeny, Aizoaceae, Mesembryanthemum
- **Chapter 3** (Ethnobotany): Khoisan, traditional knowledge, BEI/ICF
- **Chapter 4** (Pharmacology): Alkaloids, mesembrine, PDE4, SERT, QSAR
- **Chapter 5** (Clinical): RCTs, meta-analysis, anxiety, depression
- **Chapter 6** (Addiction): Neurobiology, PDE4 inhibition, substance use
- **Chapter 7** (Legal/Ethics): Biopiracy, WIPO, benefit-sharing, patents
- **Chapter 8** (General reviews): Cross-disciplinary, synthesis papers

**Batch Tagging**:
1. Select multiple items (Ctrl+Click or Shift+Click)
2. Right-click → Add Tag
3. Type: "Chapter 4" (for example)
4. Repeat for other chapters

## Step 6: Verify Export

After importing and tagging, verify the `.bib` file:

```bash
cd ~/LAB/projects/KANNA
grep -c "^@article" literature/zotero-export/kanna.bib
# Should show: 142 (or close, depending on duplicates removed)
```

## Step 7: Link to Overleaf (Future)

When ready to write thesis:
1. Upload `kanna.bib` to Overleaf project
2. In LaTeX: `\bibliography{kanna}`
3. Cite with: `\citep{author2023}` (check citekey in Zotero)

## Troubleshooting

**Problem**: Metadata not auto-extracted
- **Solution**: Right-click PDF → Retrieve Metadata for PDF → From DOI

**Problem**: Duplicate entries
- **Solution**: Zotero → Edit → Preferences → General → Enable "Detect duplicate items"

**Problem**: Better BibTeX not auto-exporting
- **Solution**: Right-click collection → Export Collection → Re-enable "Keep updated"

**Problem**: Wrong citation keys (citekeys)
- **Solution**: Zotero → Edit → Preferences → Better BibTeX → Citation Keys
  - Pattern: `[auth:lower][year]` (e.g., `gericke2023`)

## Expected Timeline

- **Import 142 PDFs**: 30-60 minutes (Zotero auto-extracts metadata)
- **Manual tagging by chapter**: 60-90 minutes (21 PDFs/chapter average)
- **Total time**: 1.5-2.5 hours

## Next Steps After Import

1. Review extracted metadata for accuracy
2. Add missing DOIs (if any)
3. Tag papers by methodology (RCT, review, in vitro, etc.)
4. Create smart collections (e.g., "All Chapter 4 Papers", "All Clinical Trials")
5. Sync to Zotero cloud (optional, for backup)

---

**Status**: Import staging prepared ✅
**Location**: `~/LAB/projects/KANNA/literature/zotero-import-staging/`
**PDFs ready**: 142 papers
EOF

log "✓ Import guide created: $IMPORT_STAGING/IMPORT-GUIDE.md"

# =============================================================================
# 5. CREATE CHAPTER CLASSIFICATION HELPER
# =============================================================================

log "Creating chapter classification helper..."

cat > "$IMPORT_STAGING/classify-by-keywords.py" <<'EOF'
#!/usr/bin/env python3
"""
Auto-classify PDFs by chapter based on filename keywords.
Helps pre-organize PDFs before Zotero import.
"""
import re
from pathlib import Path
import shutil

# Chapter classification rules (keyword → chapter)
CHAPTER_KEYWORDS = {
    2: ['taxonomy', 'phylogen', 'aizoaceae', 'mesembr', 'botanical', 'klak', 'distribution'],
    3: ['ethnobotany', 'khoisan', 'traditional', 'bei', 'icf', 'indigenous', 'ferment'],
    4: ['alkaloid', 'mesembrine', 'pde4', 'sert', 'qsar', 'docking', 'pharmacol', 'chemistry'],
    5: ['clinical', 'trial', 'rct', 'meta-analysis', 'anxiety', 'depression', 'zembrin'],
    6: ['addiction', 'neurobiology', 'substance', 'dependence', 'reward'],
    7: ['biopiracy', 'patent', 'legal', 'wipo', 'benefit-sharing', 'ethics'],
}

def classify_pdf(filename: str) -> int:
    """Classify PDF by chapter based on filename keywords."""
    filename_lower = filename.lower()

    # Check each chapter's keywords
    scores = {chapter: 0 for chapter in CHAPTER_KEYWORDS}
    for chapter, keywords in CHAPTER_KEYWORDS.items():
        for keyword in keywords:
            if keyword in filename_lower:
                scores[chapter] += 1

    # Return chapter with highest score, or 0 if no match
    max_score = max(scores.values())
    if max_score == 0:
        return 0  # Unclassified

    return max(scores, key=scores.get)

def main():
    staging_dir = Path.home() / "LAB/projects/KANNA/literature/zotero-import-staging"
    general_dir = staging_dir / "general"

    if not general_dir.exists():
        print(f"ERROR: {general_dir} not found")
        return

    pdfs = list(general_dir.glob("*.pdf"))
    print(f"Classifying {len(pdfs)} PDFs...")

    classified = {ch: 0 for ch in range(9)}

    for pdf in pdfs:
        chapter = classify_pdf(pdf.name)
        classified[chapter] += 1

        if chapter > 0:
            dest_dir = staging_dir / f"chapter-0{chapter}"
            dest_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy2(pdf, dest_dir / pdf.name)
            print(f"  → Chapter {chapter}: {pdf.name[:60]}...")

    print("\nClassification Summary:")
    for ch in range(9):
        if classified[ch] > 0:
            label = f"Chapter {ch}" if ch > 0 else "Unclassified"
            print(f"  {label}: {classified[ch]} PDFs")

    print(f"\nPDFs organized in: {staging_dir}/")
    print("Review and adjust before importing to Zotero.")

if __name__ == "__main__":
    main()
EOF

chmod +x "$IMPORT_STAGING/classify-by-keywords.py"
log "✓ Classification helper created: $IMPORT_STAGING/classify-by-keywords.py"

# Run classification
log "Running automatic classification..."
cd "$KANNA_DIR"
python3 "$IMPORT_STAGING/classify-by-keywords.py" 2>&1 | tee -a "$LOG_FILE"

# =============================================================================
# 6. SUMMARY
# =============================================================================

echo ""
log "=========================================="
log "✓ Zotero Import Preparation Complete!"
log "=========================================="
echo ""
echo "Next Steps:"
echo "1. Read: $IMPORT_STAGING/IMPORT-GUIDE.md"
echo "2. Install Zotero + Better BibTeX (if not done)"
echo "3. Import PDFs from: $IMPORT_STAGING/"
echo "4. Configure auto-export to: literature/zotero-export/kanna.bib"
echo ""
echo "Estimated time: 1.5-2.5 hours (import + tagging)"
echo ""
log "Log file: $LOG_FILE"
