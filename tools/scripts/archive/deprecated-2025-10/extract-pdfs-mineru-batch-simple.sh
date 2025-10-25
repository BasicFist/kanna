#!/usr/bin/env bash
# Simple MinerU Batch Extraction (GPU-accelerated)
# Usage: ./extract-pdfs-mineru-batch-simple.sh

set -Eeuo pipefail

# Configuration
PROJECT_ROOT="$HOME/LAB/projects/KANNA"
INPUT_DIR="$PROJECT_ROOT/literature/pdfs/BIBLIOGRAPHIE"
OUTPUT_DIR="$PROJECT_ROOT/literature/pdfs/extractions"
LOG_FILE="$HOME/LAB/logs/mineru-batch-gpu-$(date +%Y%m%d-%H%M%S).log"
CONDA_ENV="mineru"  # Dedicated environment for GPU-accelerated PDF extraction

# Create directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# Log header
{
    echo "========================================="
    echo "MinerU GPU Batch Extraction"
    echo "Started: $(date)"
    echo "========================================="
    echo "Input:  $INPUT_DIR"
    echo "Output: $OUTPUT_DIR"
    echo "========================================="
    echo ""
} | tee "$LOG_FILE"

# Count total PDFs
TOTAL_PDFS=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.pdf" | wc -l)
echo "Found $TOTAL_PDFS PDFs to extract" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Extract PDFs
SUCCESSFUL=0
FAILED=0
CURRENT=0

while IFS= read -r pdf_file; do
    CURRENT=$((CURRENT + 1))
    pdf_name=$(basename "$pdf_file" .pdf)

    # Check if already extracted (has auto/ directory)
    extraction_dir="$OUTPUT_DIR/$pdf_name"
    if [ -d "$extraction_dir/auto" ]; then
        echo "[$CURRENT/$TOTAL_PDFS] SKIP: $pdf_name (already extracted)" | tee -a "$LOG_FILE"
        SUCCESSFUL=$((SUCCESSFUL + 1))
        continue
    fi

    echo "[$CURRENT/$TOTAL_PDFS] Extracting: $pdf_name" | tee -a "$LOG_FILE"

    # Run MinerU in conda environment
    if conda run -n "$CONDA_ENV" magic-pdf -p "$pdf_file" -o "$OUTPUT_DIR" -m auto >> "$LOG_FILE" 2>&1; then
        echo "  ✅ SUCCESS" | tee -a "$LOG_FILE"
        SUCCESSFUL=$((SUCCESSFUL + 1))
    else
        echo "  ❌ FAILED" | tee -a "$LOG_FILE"
        FAILED=$((FAILED + 1))
    fi

    echo "" | tee -a "$LOG_FILE"
done < <(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.pdf" | sort)

# Summary
{
    echo "========================================="
    echo "Extraction Complete"
    echo "========================================="
    echo "Total:      $TOTAL_PDFS"
    echo "Successful: $SUCCESSFUL"
    echo "Failed:     $FAILED"
    echo "Success rate: $(( SUCCESSFUL * 100 / TOTAL_PDFS ))%"
    echo "========================================="
    echo "Log: $LOG_FILE"
} | tee -a "$LOG_FILE"

exit 0
