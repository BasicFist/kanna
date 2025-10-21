#!/usr/bin/env bash
# MinerU Production Extraction Script for KANNA Thesis
# Created: October 6, 2025
# Refactored: October 21, 2025 (MP-1 Phase 2)
# Status: PRODUCTION-READY (DocLayout_YOLO + Kilo API)
#
# WORKING CONFIGURATION:
# - Layout: DocLayout_YOLO (bypasses layoutlmv3/transformers dependency)
# - Formula: Disabled (no timm dependency issues)
# - Tables: RapidTable (working)
# - LLM: Kilo API ready (not needed for text-only extraction)
#
# Usage:
#   ./extract-pdfs-mineru-production.sh [input_dir] [output_dir]
#
# Example:
#   ./extract-pdfs-mineru-production.sh \
#     ~/LAB/projects/KANNA/literature/pdfs/BIBLIOGRAPHIE \
#     ~/LAB/projects/KANNA/literature/pdfs/extractions

set -Eeuo pipefail

# Load shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/pdf-common.sh"

# Configuration
LAB_HOME="${LAB_HOME:-$HOME/LAB}"
PROJECT_ROOT="$LAB_HOME/academic/KANNA"
LOG_DIR="$LAB_HOME/logs"
CONDA_ENV="mineru"  # Dedicated environment for GPU-accelerated PDF extraction

# Input/Output directories
INPUT_DIR="${1:-$PROJECT_ROOT/literature/pdfs/BIBLIOGRAPHIE}"
OUTPUT_DIR="${2:-$PROJECT_ROOT/literature/pdfs/extractions}"

# Create directories using shared library
create_output_dir "$OUTPUT_DIR" || exit 1
create_output_dir "$LOG_DIR" || exit 1

# Log file (set for library to use)
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
export LOG_FILE="$LOG_DIR/mineru-extraction-$TIMESTAMP.log"

# Verify MinerU config exists (support both legacy and new locations)
CONFIG_CANDIDATES=(
    "$HOME/magic-pdf.json"
    "$HOME/.config/mineru/magic-pdf.json"
    "$HOME/.config/mineru/mineru.json"
)

CONFIG_IN_USE=""
for cfg in "${CONFIG_CANDIDATES[@]}"; do
    if [ -f "$cfg" ]; then
        CONFIG_IN_USE="$cfg"
        break
    fi
done

if [ -z "$CONFIG_IN_USE" ]; then
    log "MinerU config not found" "ERROR"
    log "Expected at least one of:" "ERROR"
    log "  - ~/magic-pdf.json" "ERROR"
    log "  - ~/.config/mineru/magic-pdf.json" "ERROR"
    log "  - ~/.config/mineru/mineru.json" "ERROR"
    log "" "ERROR"
    log "Create one using:" "ERROR"
    log "  mkdir -p ~/.config/mineru" "ERROR"
    log "  cp ~/LAB/academic/KANNA/tools/templates/mineru.json ~/.config/mineru/mineru.json" "ERROR"
    exit 1
fi

# Ensure legacy location exists for older mineru/magic-pdf binaries
if [ "$CONFIG_IN_USE" != "$HOME/magic-pdf.json" ] && [ ! -f "$HOME/magic-pdf.json" ]; then
    ln -sf "$CONFIG_IN_USE" "$HOME/magic-pdf.json"
fi

# Determine mineru CLI name (prefer mineru over magic-pdf for -b flag support)
if command -v mineru >/dev/null 2>&1; then
    MINERU_BIN="mineru"
elif command -v magic-pdf >/dev/null 2>&1; then
    MINERU_BIN="magic-pdf"
else
    log "Neither 'magic-pdf' nor 'mineru' command found in PATH" "ERROR"
    log "Install MinerU with: pip install uv && uv pip install -U 'mineru[core]'" "ERROR"
    exit 1
fi

# Function: Extract single PDF
extract_pdf() {
    local pdf_file="$1"
    local pdf_name=$(basename "$pdf_file" .pdf)

    log "Extracting: $pdf_name" "INFO"

    # Run MinerU with pipeline backend (GPU-accelerated YOLO+Unimernet+RapidTable)
    conda run -n "$CONDA_ENV" "$MINERU_BIN" \
        -p "$pdf_file" \
        -o "$OUTPUT_DIR" \
        -m auto \
        >> "$LOG_FILE" 2>&1

    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        log "  ✅ SUCCESS: $pdf_name" "INFO"
        return 0
    else
        log "  ❌ FAILED: $pdf_name (exit code: $exit_code)" "ERROR"
        return 1
    fi
}

# Main extraction loop
START_TIME=$(date +%s)

log "=====================================" "INFO"
log "MinerU Production Extraction" "INFO"
log "=====================================" "INFO"
log "Input:  $INPUT_DIR" "INFO"
log "Output: $OUTPUT_DIR" "INFO"
log "Config: $CONFIG_IN_USE" "INFO"
log "Binary: $MINERU_BIN" "INFO"
log "Log:    $LOG_FILE" "INFO"
log "=====================================" "INFO"

# Count PDFs using shared library
TOTAL_PDFS=$(count_pdfs "$INPUT_DIR" "flat")
log "Found $TOTAL_PDFS PDFs to extract" "INFO"
log "" "INFO"

# Extract all PDFs
SUCCESSFUL=0
FAILED=0
CURRENT=0

while IFS= read -r pdf_file; do
    CURRENT=$((CURRENT + 1))
    log "[$CURRENT/$TOTAL_PDFS]" "INFO"

    if extract_pdf "$pdf_file"; then
        SUCCESSFUL=$((SUCCESSFUL + 1))
    else
        FAILED=$((FAILED + 1))
    fi

    log "" "INFO"
done < <(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.pdf" | sort)

# Summary
END_TIME=$(date +%s)
DURATION=$(format_duration $((END_TIME - START_TIME)))
SUCCESS_RATE=$(calculate_success_rate "$SUCCESSFUL" "$TOTAL_PDFS")

log "=====================================" "INFO"
log "Extraction Complete" "INFO"
log "=====================================" "INFO"
log "Total:        $TOTAL_PDFS" "INFO"
log "Successful:   $SUCCESSFUL" "INFO"
log "Failed:       $FAILED" "INFO"
log "Success rate: ${SUCCESS_RATE}%" "INFO"
log "Duration:     $DURATION" "INFO"
log "=====================================" "INFO"
log "Log file: $LOG_FILE" "INFO"

# Exit code
if [ $FAILED -eq 0 ]; then
    log "✅ All extractions successful" "INFO"
    exit 0
else
    log "⚠️  Some extractions failed ($FAILED/$TOTAL_PDFS)" "WARN"
    exit 1
fi
