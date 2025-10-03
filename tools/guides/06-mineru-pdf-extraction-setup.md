# Guide 6: MinerU PDF Extraction for Scientific Literature

**Extraction Automatique de PDF : MinerU pour Formules, Tableaux et Texte Scientifique**

⏱️ **Temps d'installation** : 1-2 heures
💾 **Prérequis** : conda environment 'kanna' (completed in Week 1)
🎯 **Objectif** : Extract formulas (LaTeX), tables, and text from 500+ scientific papers automatically

---

## Quick Start

### Why MinerU for KANNA Thesis?

**Problem**: Scientific PDFs contain complex formulas, multi-column layouts, tables, and figures that traditional PDF extractors mangle.

**MinerU Solution**:
- **Formula extraction** → LaTeX format (preserve pharmacology equations like IC₅₀ calculations)
- **Table extraction** → Markdown tables (clinical trial data, meta-analysis results)
- **Structure preservation** → Maintains sections, headings, lists (ethnobotany interview protocols)
- **Batch processing** → Handle 8 French PDFs now, 500+ papers over 42 months
- **Markdown output** → Direct integration with Obsidian notes

**Use Cases in Thesis**:
- Chapter 2 (Botany): Extract phylogenetic data tables
- Chapter 3 (Ethnobotany): OCR scanned ethnographic field notes
- Chapter 4 (Pharmacology): Extract chemical structures, IC₅₀ tables, QSAR formulas
- Chapter 5 (Clinical): Meta-analysis effect size tables, forest plot data
- Chapter 6 (Neuroscience): PDE4/SERT mechanism diagrams, molecular formulas

---

## Part A: Installation

### Step 1: Update requirements.txt

**IMPORTANT**: Package name changed from `magic-pdf` to `mineru` in v2.0.

```bash
cd ~/LAB/projects/KANNA
source ~/miniforge3/etc/profile.d/conda.sh
conda activate kanna
```

**Edit requirements.txt**:
```bash
# OLD (line 58):
# magic-pdf[full]>=0.6.0  # MinerU - Extract formulas, tables, text from scientific PDFs

# NEW:
mineru[core]>=2.0.0  # MinerU - Extract formulas, tables, text from scientific PDFs
```

### Step 2: Install MinerU

```bash
# Upgrade pip and install uv (package manager for mineru)
pip install --upgrade pip
pip install uv

# Install mineru with core features (CPU + OCR + formula/table extraction)
uv pip install -U "mineru[core]"

# Verify installation
mineru --version
# Expected output: mineru version 2.x.x
```

**Alternative: Install with GPU acceleration** (if CUDA available):
```bash
# For CUDA 11.8+ systems (faster processing)
uv pip install -U "mineru[full]"
```

### Step 3: Download Model Weights

MinerU requires AI models for formula and table recognition:

```bash
# Install huggingface_hub for model downloads
pip install huggingface_hub

# Download model downloader script
wget https://github.com/opendatalab/MinerU/raw/master/scripts/download_models_hf.py -O download_models_hf.py

# Download models (formula: unimernet, table: rapid_table, layout: layoutlmv3)
python download_models_hf.py
```

**Models downloaded to**: `~/.cache/huggingface/hub/` (~2GB total)

**Models**:
- `unimernet_small` - Formula recognition (LaTeX output)
- `rapid_table` - Table structure detection
- `layoutlmv3` - Document layout analysis
- `yolo_v8_mfd` - Formula detection

### Step 4: Configure MinerU

Create configuration file with formulas and tables enabled:

```bash
# Configuration file location
mkdir -p ~/.config/mineru
nano ~/.config/mineru/magic-pdf.json
```

**Configuration** (`magic-pdf.json`):
```json
{
  "layout-config": {
    "model": "layoutlmv3"
  },
  "formula-config": {
    "mfd_model": "yolo_v8_mfd",
    "mfr_model": "unimernet_small",
    "enable": true
  },
  "table-config": {
    "model": "rapid_table",
    "enable": true,
    "max_time": 400
  },
  "device-mode": "cpu"
}
```

**For GPU acceleration** (if available), change:
```json
{
  "device-mode": "cuda"
}
```

**Save and exit**: `Ctrl+X`, then `Y`, then `Enter`.

---

## Part B: Test with Sample PDF

### Step 5: Test Installation

Download sample scientific PDF:

```bash
cd ~/LAB/projects/KANNA
wget https://github.com/opendatalab/MinerU/raw/master/demo/small_ocr.pdf -O test-mineru.pdf
```

**Run MinerU**:
```bash
mineru -p test-mineru.pdf -o ./mineru-test-output
```

**Expected output** (1-2 minutes):
```
Processing test-mineru.pdf...
├── Detecting layout... ✓
├── Extracting formulas... ✓ (3 formulas found)
├── Extracting tables... ✓ (1 table found)
├── Generating markdown... ✓
Output: ./mineru-test-output/test-mineru/test-mineru.md
```

### Step 6: Verify Output

Check generated files:

```bash
ls -la mineru-test-output/test-mineru/
```

**Output structure**:
```
mineru-test-output/test-mineru/
├── test-mineru.md                    # Markdown output (main file)
├── images/                           # Extracted images/figures
│   ├── figure_001.png
│   └── formula_001.png
├── test-mineru_model.json            # AI model inference results
├── test-mineru_content_list.json     # Structured content (for programmatic access)
└── test-mineru_layout.pdf            # Annotated PDF showing detected regions
```

**Inspect markdown**:
```bash
cat mineru-test-output/test-mineru/test-mineru.md | head -50
```

**Verify**:
- ✓ Formulas converted to LaTeX: `$$E = mc^2$$`
- ✓ Tables converted to markdown tables
- ✓ Images saved to `images/` directory with references
- ✓ Text extracted in reading order

---

## Part C: Process KANNA PDFs

### Step 7: Process 8 French PDFs

Create batch processing script:

```bash
nano ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh
```

**Script content**:
```bash
#!/usr/bin/env bash
# =============================================================================
# MinerU Batch PDF Extraction for KANNA Literature
# =============================================================================
set -euo pipefail

SOURCE_DIR="$HOME/LAB/projects/KANNA/literature/pdfs"
OUTPUT_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"
LOG_FILE="$HOME/LAB/logs/mineru-extraction.log"

# Activate conda environment
source ~/miniforge3/etc/profile.d/conda.sh
conda activate kanna

# Create output directory
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "========================================"
log "Starting batch PDF extraction..."
log "========================================"

# Count PDFs
PDF_COUNT=$(find "$SOURCE_DIR" -name "*.pdf" | wc -l)
log "Found $PDF_COUNT PDF files to process"

# Process each PDF
COUNTER=1
find "$SOURCE_DIR" -name "*.pdf" | while read -r pdf_file; do
    BASENAME=$(basename "$pdf_file" .pdf)
    log "[$COUNTER/$PDF_COUNT] Processing: $BASENAME"

    # Run mineru
    mineru -p "$pdf_file" -o "$OUTPUT_DIR" 2>&1 | tee -a "$LOG_FILE"

    if [ $? -eq 0 ]; then
        log "✓ Successfully extracted: $BASENAME"
    else
        log "✗ Error extracting: $BASENAME"
    fi

    ((COUNTER++))
done

log "========================================"
log "Batch extraction complete!"
log "Output directory: $OUTPUT_DIR"
log "========================================"
```

**Make executable**:
```bash
chmod +x ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh
```

**Run batch extraction**:
```bash
~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh
```

**Expected runtime**: ~3-5 minutes per PDF (depends on length, complexity)

### Step 8: Organize Extracted Content

After extraction, organize outputs:

```bash
cd ~/LAB/projects/KANNA/data/extracted-papers
ls -la
```

**Structure**:
```
data/extracted-papers/
├── paper-001/
│   ├── paper-001.md              # Markdown content
│   ├── images/                   # Extracted figures
│   ├── paper-001_content_list.json
│   └── paper-001_model.json
├── paper-002/
│   └── ...
└── ...
```

**Copy markdown to Obsidian notes**:
```bash
# Create symlink for easy access
ln -s ~/LAB/projects/KANNA/data/extracted-papers ~/LAB/projects/KANNA/literature/notes/extracted-papers
```

---

## Part D: Integration with Obsidian

### Step 9: Import to Obsidian

**Manual import** (for quality control):

1. Open extracted markdown: `data/extracted-papers/paper-001/paper-001.md`
2. Review for extraction quality:
   - Are formulas correctly formatted? (`$$..$$` syntax)
   - Are tables readable?
   - Are figures referenced correctly?
3. If quality is good:
   - Copy to `literature/notes/papers/paper-001-notes.md`
   - Add Obsidian metadata header:

```markdown
---
title: "Paper Title"
authors: "Author et al."
year: 2025
tags: [#chapter-4, #pharmacology, #alkaloids, #sceletium]
source: paper-001.pdf
extracted: 2025-10-03
mineru_version: 2.0.0
---

# Paper Title

## Summary
[Your summary here]

## Key Findings
- Finding 1
- Finding 2

## Extracted Content
[Paste MinerU markdown below]

...
```

**Automated import script** (optional):
```bash
nano ~/LAB/projects/KANNA/tools/scripts/mineru-to-obsidian.sh
```

```bash
#!/usr/bin/env bash
# Convert MinerU output to Obsidian notes with metadata
# Usage: ./mineru-to-obsidian.sh paper-001

PAPER_ID="$1"
SOURCE_MD="$HOME/LAB/projects/KANNA/data/extracted-papers/$PAPER_ID/$PAPER_ID.md"
DEST_MD="$HOME/LAB/projects/KANNA/literature/notes/papers/$PAPER_ID-extracted.md"

if [ ! -f "$SOURCE_MD" ]; then
    echo "Error: $SOURCE_MD not found"
    exit 1
fi

# Create Obsidian note with metadata
cat > "$DEST_MD" << EOF
---
title: "$PAPER_ID"
extracted: $(date +%Y-%m-%d)
tags: [#extracted, #needs-review]
---

# $PAPER_ID - Extracted Content

**Source**: literature/pdfs/$PAPER_ID.pdf
**Extraction Date**: $(date +%Y-%m-%d)
**Tool**: MinerU v2.0.0

---

EOF

# Append MinerU content
cat "$SOURCE_MD" >> "$DEST_MD"

echo "✓ Created: $DEST_MD"
```

---

## Part E: Quality Control

### Step 10: Validate Extraction Accuracy

**Check for common issues**:

1. **Formula extraction**:
   - ✓ Good: `$$IC_{50} = 10^{-6} \, \text{M}$$`
   - ✗ Bad: `IC50 = 10^-6 M` (missing LaTeX)

2. **Table extraction**:
   - ✓ Good: Proper markdown table with aligned columns
   - ✗ Bad: Mangled text, no table structure

3. **Image references**:
   - ✓ Good: `![Figure 1](images/figure_001.png)`
   - ✗ Bad: Missing images, broken links

**Manual correction**:
- If formula extraction fails: Manually add LaTeX from original PDF
- If table is mangled: Use MinerU's `content_list.json` for structured data

**Statistics on extraction quality** (across 8 PDFs):
```bash
# Count extracted formulas
grep -r "$$" data/extracted-papers/*/\*.md | wc -l

# Count extracted tables
grep -r "^|" data/extracted-papers/*/\*.md | wc -l

# Count extracted figures
find data/extracted-papers/*/images/ -name "*.png" | wc -l
```

---

## Part F: Workflow Integration

### Updated Literature Workflow

**Old workflow** (Guide 1):
```
Elicit → Zotero → Obsidian notes (manual) → Overleaf
```

**New workflow** (with MinerU):
```
Elicit → Zotero → MinerU extraction → Obsidian notes (semi-automated) → Overleaf
```

**Step-by-step**:
1. **Elicit**: Search "Sceletium tortuosum QSAR" → Export 20 results
2. **Zotero**: Import 20 PDFs, auto-tag with `#chapter-4`
3. **MinerU**: Batch extract all 20 PDFs
   ```bash
   find ~/Zotero/storage/ -name "*.pdf" -path "*/KANNA-Thesis/*" | \
   while read pdf; do
       mineru -p "$pdf" -o ~/LAB/projects/KANNA/data/extracted-papers
   done
   ```
4. **Obsidian**: Review extracted markdown, add metadata, link to concepts
5. **Overleaf**: Cite in thesis using `\citep{author2025}` from `kanna.bib`

---

## Troubleshooting

### Issue 1: Formula Extraction Fails

**Symptom**: Formulas appear as plain text, not LaTeX

**Cause**: `formula-config.enable = false` or missing model weights

**Solution**:
```bash
# Verify formula config
cat ~/.config/mineru/magic-pdf.json | grep -A5 "formula-config"

# Should show:
# "formula-config": {
#     "enable": true,
#     ...
# }

# Re-download models if missing
python download_models_hf.py
```

### Issue 2: Table Extraction Mangled

**Symptom**: Tables appear as unstructured text

**Cause**: Complex table layout (merged cells, rotated tables)

**Solution**:
- Check `content_list.json` for structured table data
- Manually reconstruct table from JSON
- Use alternative: Extract table as image, manually transcribe

### Issue 3: Out of Memory (Large PDFs)

**Symptom**: MinerU crashes with OOM error

**Cause**: Processing 100+ page PDFs with limited RAM

**Solution**:
```bash
# Process in chunks (split PDF first)
pdftk large.pdf cat 1-50 output part1.pdf
pdftk large.pdf cat 51-end output part2.pdf
mineru -p part1.pdf -o output/
mineru -p part2.pdf -o output/
```

### Issue 4: French Text Mangled (OCR)

**Symptom**: French accents (é, è, ç) appear as gibberish

**Cause**: OCR language not set to French

**Solution**:
MinerU auto-detects language (supports 84 languages including French). If issues persist:
- Verify PDF is not scanned at very low resolution
- Consider re-scanning original at 300 DPI minimum

---

## Advanced: Programmatic Access

### Using MinerU Python API

For custom processing (e.g., extract only tables, ignore text):

```python
from magic_pdf.integrations.rag.api import DataReader

# Initialize reader
reader = DataReader(
    path_or_directory="literature/pdfs/paper-001.pdf",
    method="auto",  # or "ocr" for scanned PDFs
    output_dir="data/extracted-papers"
)

# Get document count
n_docs = reader.get_documents_count()
print(f"Found {n_docs} documents")

# Get parsed content for first document
doc = reader.get_document_result(0)

# Access specific page
page = doc.get_page(0)

# Get tables from page
tables = page.get_tables()
for table in tables:
    print(table.to_markdown())  # Markdown table

# Get formulas from page
formulas = page.get_formulas()
for formula in formulas:
    print(formula.latex)  # LaTeX string
```

**Use case**: Automate extraction of IC₅₀ tables from 50 pharmacology papers

---

## Best Practices

### Extraction Quality
- **Before batch processing**: Test 1-2 PDFs manually, verify quality
- **Check extracted content**: Review formulas, tables, images for accuracy
- **Manual correction**: Budget time for fixing extraction errors (5-10% of PDFs)

### Storage Organization
- **Keep originals**: Never delete source PDFs
- **Version extracted content**: Use Git to track changes to extracted markdown
- **Structured naming**: `data/extracted-papers/{paper-id}/{paper-id}.md`

### Integration with Thesis
- **Link Obsidian notes**: Create bidirectional links between extracted content and concept notes
- **Cite properly**: Use Zotero citation keys in Obsidian, sync to `kanna.bib`
- **Quality over quantity**: Better to manually annotate 100 papers well than auto-process 500 poorly

---

## Next Steps

**Week 2** (after installing external tools):
1. Install Zotero + Better BibTeX (Guide 1)
2. Install Obsidian (Guide 1)
3. Process 8 French PDFs with MinerU
4. Import extracted content to Obsidian
5. Test Zotero → MinerU → Obsidian workflow

**Month 2-3** (literature review phase):
1. Use Elicit to find 100 papers on Sceletium pharmacology
2. Batch extract all 100 PDFs with MinerU
3. Create Obsidian knowledge graph (500+ notes, 1000+ connections)
4. Draft Chapter 1 literature review (5,000 words)

---

## Further Resources

- MinerU Official Docs: https://opendatalab.github.io/MinerU/
- GitHub Repository: https://github.com/opendatalab/MinerU
- MinerU Beginner's Guide: https://stable-learn.com/en/mineru-tutorial/
- HuggingFace Demo: https://huggingface.co/spaces/opendatalab/MinerU

---

**Last Updated**: October 2025
**Workflow Integration**: Extract → Obsidian → Overleaf
**Processing Speed**: ~3-5 min/PDF (CPU), ~1-2 min/PDF (GPU)
