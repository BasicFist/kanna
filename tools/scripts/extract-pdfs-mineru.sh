#!/usr/bin/env bash
# =============================================================================
# MinerU Batch PDF Extraction for KANNA Literature
# =============================================================================
# Purpose: Extract formulas, tables, and text from scientific PDFs
# Input: PDFs in literature/pdfs/
# Output: Markdown in data/extracted-papers/
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
log "Starting batch PDF extraction with MinerU"
log "Source: $SOURCE_DIR"
log "Output: $OUTPUT_DIR"
log "========================================"

# Count PDFs
PDF_COUNT=$(find "$SOURCE_DIR" -name "*.pdf" | wc -l)
log "Found $PDF_COUNT PDF files to process"

if [ "$PDF_COUNT" -eq 0 ]; then
    log "⚠ WARNING: No PDF files found in $SOURCE_DIR"
    exit 0
fi

# Process each PDF
COUNTER=1
SUCCESS=0
FAILED=0

find "$SOURCE_DIR" -name "*.pdf" | while read -r pdf_file; do
    BASENAME=$(basename "$pdf_file" .pdf)

    # Smart caching: Skip if already extracted
    OUTPUT_MD="$OUTPUT_DIR/$BASENAME/auto/$BASENAME.md"
    if [ -f "$OUTPUT_MD" ]; then
        log "⏭ [$COUNTER/$PDF_COUNT] Skipping (already extracted): $BASENAME"
        ((COUNTER++))
        continue
    fi

    log "[$COUNTER/$PDF_COUNT] Processing: $BASENAME"

    # Run mineru
    if mineru -p "$pdf_file" -o "$OUTPUT_DIR" 2>&1 | tee -a "$LOG_FILE"; then
        log "✓ Successfully extracted: $BASENAME"
        ((SUCCESS++))
    else
        log "✗ Error extracting: $BASENAME"
        ((FAILED++))
    fi

    ((COUNTER++))
done

log "========================================"
log "Batch extraction complete!"
log "Successful: $SUCCESS PDFs"
log "Failed: $FAILED PDFs"
log "Output directory: $OUTPUT_DIR"
log "Log file: $LOG_FILE"
log "========================================"

# Summary statistics
log ""
log "Extraction Statistics:"
log "  - Total formulas extracted: $(grep -r '\$\$' "$OUTPUT_DIR"/*/\*.md 2>/dev/null | wc -l)"
log "  - Total tables extracted: $(grep -r '^|' "$OUTPUT_DIR"/*/\*.md 2>/dev/null | wc -l)"
log "  - Total images extracted: $(find "$OUTPUT_DIR"/*/images/ -name "*.png" 2>/dev/null | wc -l)"
log ""
log "Next steps:"
log "  1. Review extracted content in: $OUTPUT_DIR"
log "  2. Import to Obsidian: ln -s $OUTPUT_DIR $HOME/LAB/projects/KANNA/literature/notes/extracted-papers"
log "  3. Verify formula/table extraction quality manually"
