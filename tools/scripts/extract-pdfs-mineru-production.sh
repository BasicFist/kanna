#!/usr/bin/env bash
# MinerU Production Extraction Script for KANNA Thesis
# Created: October 6, 2025
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

# Configuration
LAB_HOME="${LAB_HOME:-$HOME/LAB}"
PROJECT_ROOT="$LAB_HOME/projects/KANNA"
LOG_DIR="$LAB_HOME/logs"
CONDA_ENV="mineru"  # Dedicated environment for GPU-accelerated PDF extraction

# Input/Output directories
INPUT_DIR="${1:-$PROJECT_ROOT/literature/pdfs/BIBLIOGRAPHIE}"
OUTPUT_DIR="${2:-$PROJECT_ROOT/literature/pdfs/extractions}"

# Create directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# Log file
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/mineru-extraction-$TIMESTAMP.log"

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
    cat <<'EOF' >&2
ERROR: MinerU config not found.
Expected at least one of:
  - ~/magic-pdf.json
  - ~/.config/mineru/magic-pdf.json
  - ~/.config/mineru/mineru.json

Create one using the configure scripts, for example:
  mkdir -p ~/.config/mineru
  cp ~/LAB/projects/KANNA/tools/templates/mineru.json ~/.config/mineru/mineru.json
EOF
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
    echo "ERROR: Neither 'magic-pdf' nor 'mineru' command found in PATH." >&2
    echo "Install MinerU with: pip install uv && uv pip install -U 'mineru[core]'" >&2
    exit 1
fi

# Function: Extract single PDF
extract_pdf() {
    local pdf_file="$1"
    local pdf_name=$(basename "$pdf_file" .pdf)

    echo "[$(date +%H:%M:%S)] Extracting: $pdf_name" | tee -a "$LOG_FILE"

    # Run MinerU with pipeline backend (GPU-accelerated YOLO+Unimernet+RapidTable)
    conda run -n "$CONDA_ENV" "$MINERU_BIN" \
        -p "$pdf_file" \
        -o "$OUTPUT_DIR" \
        -m auto \
        >> "$LOG_FILE" 2>&1

    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "  ✅ SUCCESS: $pdf_name" | tee -a "$LOG_FILE"
        return 0
    else
        echo "  ❌ FAILED: $pdf_name (exit code: $exit_code)" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Main extraction loop
echo "=====================================" | tee "$LOG_FILE"
echo "MinerU Production Extraction" | tee -a "$LOG_FILE"
echo "=====================================" | tee -a "$LOG_FILE"
echo "Input:  $INPUT_DIR" | tee -a "$LOG_FILE"
echo "Output: $OUTPUT_DIR" | tee -a "$LOG_FILE"
echo "Log:    $LOG_FILE" | tee -a "$LOG_FILE"
echo "=====================================" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Count PDFs
TOTAL_PDFS=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.pdf" | wc -l)
echo "Found $TOTAL_PDFS PDFs to extract" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Extract all PDFs
SUCCESSFUL=0
FAILED=0
CURRENT=0

while IFS= read -r pdf_file; do
    CURRENT=$((CURRENT + 1))
    echo "[$CURRENT/$TOTAL_PDFS]" | tee -a "$LOG_FILE"

    if extract_pdf "$pdf_file"; then
        SUCCESSFUL=$((SUCCESSFUL + 1))
    else
        FAILED=$((FAILED + 1))
    fi

    echo "" | tee -a "$LOG_FILE"
done < <(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.pdf" | sort)

# Summary
echo "=====================================" | tee -a "$LOG_FILE"
echo "Extraction Complete" | tee -a "$LOG_FILE"
echo "=====================================" | tee -a "$LOG_FILE"
echo "Total:      $TOTAL_PDFS" | tee -a "$LOG_FILE"
echo "Successful: $SUCCESSFUL" | tee -a "$LOG_FILE"
echo "Failed:     $FAILED" | tee -a "$LOG_FILE"
echo "Success rate: $(( SUCCESSFUL * 100 / TOTAL_PDFS ))%" | tee -a "$LOG_FILE"
echo "=====================================" | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"

# Exit code
if [ $FAILED -eq 0 ]; then
    exit 0
else
    exit 1
fi
