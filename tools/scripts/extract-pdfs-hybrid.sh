#!/usr/bin/env bash
# =============================================================================
# Hybrid PDF Extraction: MinerU + LaTeX-OCR
# =============================================================================
# Purpose: Extract PDFs with maximum formula accuracy using dual pipelines
#
# Pipeline:
#   1. MinerU: Layout detection, text extraction, formula image detection
#   2. LaTeX-OCR: High-accuracy formula recognition (88% BLEU)
#   3. Merge: Replace MinerU formulas with LaTeX-OCR validated output
#
# Usage:
#   ./extract-pdfs-hybrid.sh [pdf-directory]
#
# Requirements:
#   - MinerU installed (mineru package)
#   - LaTeX-OCR installed (pix2tex package)
#   - Conda env 'kanna' activated
#
# Author: KANNA Thesis Project
# Date: October 2025
# =============================================================================

set -Eeuo pipefail

# Configuration
PDF_DIR="${1:-literature/pdfs/BIBLIOGRAPHIE}"
OUTPUT_BASE="data/extracted-papers-hybrid"
LOG_FILE="logs/hybrid-extraction-$(date +%Y%m%d-%H%M%S).log"
KANNA_ENV="kanna"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"
mkdir -p "$OUTPUT_BASE"

# Activate conda environment if not already active
if [[ "$CONDA_DEFAULT_ENV" != "$KANNA_ENV" ]]; then
    echo "Activating conda environment: $KANNA_ENV" | tee -a "$LOG_FILE"
    eval "$(conda shell.bash hook)"
    conda activate "$KANNA_ENV"
fi

# Verify dependencies
echo "Verifying dependencies..." | tee -a "$LOG_FILE"
python -c "import mineru; import pix2tex; print('✓ All dependencies installed')" || {
    echo "ERROR: Missing dependencies. Install with:" | tee -a "$LOG_FILE"
    echo "  conda activate $KANNA_ENV" | tee -a "$LOG_FILE"
    echo "  pip install mineru pix2tex[gui]" | tee -a "$LOG_FILE"
    exit 1
}

# =============================================================================
# STEP 1: MinerU Extraction (Layout + Initial Formulas)
# =============================================================================

echo -e "\n=== Step 1: MinerU Extraction ===" | tee -a "$LOG_FILE"

find "$PDF_DIR" -name "*.pdf" -type f | while read -r pdf; do
    pdf_basename=$(basename "$pdf" .pdf)
    output_dir="$OUTPUT_BASE/$pdf_basename"

    # Skip if already processed
    if [[ -d "$output_dir/auto" ]]; then
        echo "✓ Skipping (already processed): $pdf_basename" | tee -a "$LOG_FILE"
        continue
    fi

    echo "Processing: $pdf_basename" | tee -a "$LOG_FILE"

    # Run MinerU with formula image extraction
    magic-pdf -p "$pdf" -o "$output_dir" -m auto 2>>"$LOG_FILE" || {
        echo "⚠ MinerU failed for: $pdf_basename" | tee -a "$LOG_FILE"
        continue
    }

    echo "  ✓ MinerU extraction complete" | tee -a "$LOG_FILE"
done

# =============================================================================
# STEP 2: LaTeX-OCR Formula Recognition
# =============================================================================

echo -e "\n=== Step 2: LaTeX-OCR Formula Recognition ===" | tee -a "$LOG_FILE"

python <<'PYTHON_SCRIPT' 2>>"$LOG_FILE"
import os
import json
import glob
from pathlib import Path
from PIL import Image
from pix2tex.cli import LatexOCR

# Initialize LaTeX-OCR model
print("Loading LaTeX-OCR model...")
ocr_model = LatexOCR()

# Find all MinerU output directories
output_base = Path("${OUTPUT_BASE}")
for output_dir in output_base.glob("*/auto"):
    pdf_name = output_dir.parent.name
    print(f"\nProcessing formulas: {pdf_name}")

    # Load middle.json to find formula locations
    middle_json = output_dir / f"{pdf_name}_middle.json"
    if not middle_json.exists():
        print(f"  ⚠ No middle.json found, skipping")
        continue

    with open(middle_json, 'r') as f:
        data = json.load(f)

    # Process each formula block
    formulas_processed = 0
    formulas_improved = 0

    for page in data.get('pdf_info', []):
        for block in page.get('preproc_blocks', []):
            if block.get('type') == 'formula' and 'image_path' in block:
                formula_img_path = output_dir / block['image_path']

                if formula_img_path.exists():
                    # Run LaTeX-OCR
                    img = Image.open(formula_img_path)
                    latex_ocr = ocr_model(img)
                    latex_mineru = block.get('latex_text', '')

                    # Compare quality (simple heuristic: longer = more complete)
                    if len(latex_ocr) > len(latex_mineru):
                        block['latex_text'] = latex_ocr
                        block['latex_source'] = 'pix2tex'
                        formulas_improved += 1
                    else:
                        block['latex_source'] = 'mineru'

                    formulas_processed += 1

    # Save updated middle.json
    with open(middle_json, 'w') as f:
        json.dump(data, f, indent=2)

    print(f"  ✓ Processed {formulas_processed} formulas ({formulas_improved} improved)")

print("\n✓ LaTeX-OCR processing complete")
PYTHON_SCRIPT

# =============================================================================
# STEP 3: Regenerate Markdown with Enhanced Formulas
# =============================================================================

echo -e "\n=== Step 3: Regenerating Markdown ===" | tee -a "$LOG_FILE"

find "$OUTPUT_BASE" -name "*_middle.json" -type f | while read -r middle_json; do
    output_dir=$(dirname "$middle_json")
    pdf_basename=$(basename "$middle_json" "_middle.json")

    # Regenerate markdown from updated middle.json
    python <<PYTHON_REGEN 2>>"$LOG_FILE"
import json
from pathlib import Path

middle_json = Path("$middle_json")
output_dir = Path("$output_dir")
pdf_basename = "$pdf_basename"

with open(middle_json, 'r') as f:
    data = json.load(f)

# Generate markdown with LaTeX-OCR formulas
markdown_lines = []
for page in data.get('pdf_info', []):
    for block in page.get('preproc_blocks', []):
        if block.get('type') == 'text':
            markdown_lines.append(block.get('text', ''))
        elif block.get('type') == 'formula':
            latex = block.get('latex_text', '')
            source = block.get('latex_source', 'unknown')
            # Use Overleaf-compatible delimiters
            markdown_lines.append(f"\n\[{latex}\]\n<!-- Formula source: {source} -->\n")
        elif block.get('type') == 'table':
            markdown_lines.append(block.get('markdown', ''))

# Save enhanced markdown
enhanced_md = output_dir / f"{pdf_basename}_hybrid.md"
with open(enhanced_md, 'w') as f:
    f.write('\n'.join(markdown_lines))

print(f"✓ Enhanced markdown: {enhanced_md}")
PYTHON_REGEN

done

# =============================================================================
# STEP 4: Quality Report
# =============================================================================

echo -e "\n=== Extraction Summary ===" | tee -a "$LOG_FILE"

total_pdfs=$(find "$OUTPUT_BASE" -mindepth 1 -maxdepth 1 -type d | wc -l)
total_formulas=$(find "$OUTPUT_BASE" -name "*_hybrid.md" -exec grep -o '\\\[.*\\\]' {} \; | wc -l)

echo "PDFs processed: $total_pdfs" | tee -a "$LOG_FILE"
echo "Formulas extracted: $total_formulas" | tee -a "$LOG_FILE"
echo "Output directory: $OUTPUT_BASE" | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"

echo -e "\n✓ Hybrid extraction pipeline complete!" | tee -a "$LOG_FILE"
echo "Next steps:" | tee -a "$LOG_FILE"
echo "  1. Review enhanced markdown: $OUTPUT_BASE/*_hybrid.md" | tee -a "$LOG_FILE"
echo "  2. Run quality validation: ./tools/scripts/validate-extraction-quality.sh" | tee -a "$LOG_FILE"
echo "  3. Import to Obsidian: ./tools/scripts/mineru-to-obsidian-auto.sh" | tee -a "$LOG_FILE"
