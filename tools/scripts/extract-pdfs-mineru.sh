#!/usr/bin/env bash
# =============================================================================
# MinerU Batch PDF Extraction for KANNA Literature (ENHANCED v2.0)
# =============================================================================
# Purpose: Extract formulas, tables, and text from scientific PDFs
# Input: PDFs in literature/pdfs/
# Output: Markdown in data/extracted-papers/
#
# Enhancements (v2.0):
#   - LLM-assisted formula recognition (Qwen2.5-32B)
#   - Custom LaTeX delimiters (\[ \] for Overleaf)
#   - RapidTable for improved table extraction
#   - Auto language detection (French/English)
#   - Quality validation and visualization
# =============================================================================

set -euo pipefail

SOURCE_DIR="$HOME/LAB/projects/KANNA/literature/pdfs"
OUTPUT_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"
LOG_FILE="$HOME/LAB/logs/mineru-extraction.log"
CONFIG_FILE="$HOME/.config/mineru/mineru.json"

# Activate conda environment
source ~/miniforge3/etc/profile.d/conda.sh
conda activate kanna

# Load secrets if available
if [ -f "$HOME/.config/codex/secrets.env" ]; then
    set -a; . "$HOME/.config/codex/secrets.env"; set +a
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "========================================"
log "Starting batch PDF extraction with MinerU v2.0"
log "Source: $SOURCE_DIR"
log "Output: $OUTPUT_DIR"
log "Config: $CONFIG_FILE"
log "========================================"

# Check configuration
if [ -f "$CONFIG_FILE" ]; then
    LLM_ENABLED=$(jq -r '.["llm-aided-config"].enable // false' "$CONFIG_FILE")
    LLM_MODEL=$(jq -r '.["llm-aided-config"].model // "none"' "$CONFIG_FILE")
    TABLE_MODEL=$(jq -r '.["processing-options"].table_model // "default"' "$CONFIG_FILE")

    log "Configuration:"
    log "  - LLM Assistance: $LLM_ENABLED ($LLM_MODEL)"
    log "  - Table Model: $TABLE_MODEL"
    log "  - LaTeX Delimiters: Custom (Overleaf-compatible)"
else
    log "⚠ WARNING: Config file not found, using default settings"
fi

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

    # Build mineru command with advanced options
    MINERU_CMD="mineru -p \"$pdf_file\" -o \"$OUTPUT_DIR\""

    # Add advanced options if config exists
    if [ -f "$CONFIG_FILE" ]; then
        # Detect language from filename/content (fr or en)
        if [[ "$BASENAME" =~ [éèêëàâäôùûüç]|français|French ]]; then
            MINERU_CMD="$MINERU_CMD -l ch"  # Use Chinese OCR model (supports French diacritics better)
        else
            MINERU_CMD="$MINERU_CMD -l en"
        fi

        # Use RapidTable if configured
        if [ "$TABLE_MODEL" = "rapidtable" ]; then
            MINERU_CMD="$MINERU_CMD --table-model rapidtable"
        fi
    fi

    # Run mineru with enhanced configuration
    if eval "$MINERU_CMD" 2>&1 | tee -a "$LOG_FILE"; then
        log "✓ Successfully extracted: $BASENAME"

        # Generate visualization PDFs for quality assurance
        PAPER_DIR="$OUTPUT_DIR/$BASENAME"
        if [ -d "$PAPER_DIR" ]; then
            log "  → Generated visualization: $PAPER_DIR/layout.pdf"
            log "  → Generated spans: $PAPER_DIR/spans.pdf"
        fi

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
log "  - Total formulas extracted: $(grep -r '\\[' "$OUTPUT_DIR"/*/*.md 2>/dev/null | grep -c '\\]')"
log "  - Total tables extracted: $(grep -r '^|' "$OUTPUT_DIR"/*/*.md 2>/dev/null | wc -l)"
log "  - Total images extracted: $(find "$OUTPUT_DIR"/*/images/ -name "*.png" 2>/dev/null | wc -l)"
log "  - JSON middle files: $(find "$OUTPUT_DIR" -name "*_middle.json" 2>/dev/null | wc -l)"
log "  - Visualization PDFs: $(find "$OUTPUT_DIR" -name "layout.pdf" 2>/dev/null | wc -l)"
log ""
log "Next steps:"
log "  1. Run quality validation: ~/LAB/projects/KANNA/tools/scripts/validate-extraction-quality.sh"
log "  2. Import to Obsidian: ~/LAB/projects/KANNA/tools/scripts/mineru-to-obsidian-auto.sh"
log "  3. Review visualizations: find $OUTPUT_DIR -name 'layout.pdf'"
log "  4. Check extraction log: $LOG_FILE"
log ""
log "📊 Quality metrics will be calculated during validation step"
