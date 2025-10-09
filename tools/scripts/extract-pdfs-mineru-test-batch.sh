#!/usr/bin/env bash
set -euo pipefail

# MinerU Batch Extraction Script - Test Papers
# Phase 2.1: Extract 20 pharmacology/chemistry papers for quality comparison

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PDF_DIR="$PROJECT_ROOT/literature/pdfs/BIBLIOGRAPHIE"
OUTPUT_DIR="$PROJECT_ROOT/literature/pdfs/extractions-TEST"
TEST_LIST="/tmp/test-papers.txt"
LOG_FILE="/tmp/mineru-batch-extraction-$(date +%Y%m%d-%H%M%S).log"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}MinerU Batch Test Extraction${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${GREEN}Configuration:${NC}"
echo "  Config: ~/.config/mineru/mineru.json"
echo "  Conda Env: mineru (GPU-accelerated)"
echo "  Device: GPU (CUDA 12.4)"
echo "  Models: DocLayout-YOLO (2501), Unimernet (2503), RapidTable"
echo "  Papers: 20 pharmacology/chemistry papers"
echo "  Output: $OUTPUT_DIR"
echo "  Log: $LOG_FILE"
echo ""

# Verify test list exists
if [ ! -f "$TEST_LIST" ]; then
    echo -e "${RED}ERROR: Test paper list not found: $TEST_LIST${NC}"
    exit 1
fi

# Count papers to extract
TOTAL_PAPERS=$(wc -l < "$TEST_LIST")
echo -e "${GREEN}Papers to extract: $TOTAL_PAPERS${NC}"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Extraction loop
CURRENT=0
SUCCESS=0
FAILED=0

cd "$PDF_DIR" || exit 1

while IFS= read -r pdf_file; do
    CURRENT=$((CURRENT + 1))

    # Skip if already extracted (check for output directory)
    PDF_BASE=$(basename "$pdf_file" .pdf)
    if [ -d "$OUTPUT_DIR/$PDF_BASE/auto" ]; then
        echo -e "${YELLOW}[$CURRENT/$TOTAL_PAPERS] SKIPPED (already extracted): $pdf_file${NC}"
        SUCCESS=$((SUCCESS + 1))
        continue
    fi

    echo -e "${BLUE}[$CURRENT/$TOTAL_PAPERS] Extracting: $pdf_file${NC}"

    # Run extraction (using dedicated mineru environment for GPU acceleration)
    START_TIME=$(date +%s)
    PDF_FILENAME=$(basename "$pdf_file")
    if ~/miniforge3/bin/conda run -n mineru magic-pdf \
        -p "$PDF_FILENAME" \
        -o "$OUTPUT_DIR" \
        -m auto \
        >> "$LOG_FILE" 2>&1; then

        END_TIME=$(date +%s)
        ELAPSED=$((END_TIME - START_TIME))
        echo -e "${GREEN}[$CURRENT/$TOTAL_PAPERS] ✓ SUCCESS ($ELAPSED seconds): $pdf_file${NC}"
        SUCCESS=$((SUCCESS + 1))
    else
        END_TIME=$(date +%s)
        ELAPSED=$((END_TIME - START_TIME))
        echo -e "${RED}[$CURRENT/$TOTAL_PAPERS] ✗ FAILED ($ELAPSED seconds): $pdf_file${NC}"
        FAILED=$((FAILED + 1))
    fi

done < "$TEST_LIST"

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Extraction Complete${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${GREEN}Summary:${NC}"
echo "  Total papers: $TOTAL_PAPERS"
echo "  Successful: $SUCCESS"
echo "  Failed: $FAILED"
echo "  Output directory: $OUTPUT_DIR"
echo "  Full log: $LOG_FILE"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All extractions completed successfully!${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠ Some extractions failed. Check log: $LOG_FILE${NC}"
    exit 1
fi
