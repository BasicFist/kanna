#!/usr/bin/env bash
# =============================================================================
# MinerU Extraction Quality Validation
# =============================================================================
# Purpose: Auto-check extraction quality and flag issues
# Usage: ./validate-extraction-quality.sh
# =============================================================================

set -euo pipefail

EXTRACTED_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"

echo "========================================"
echo "MinerU Extraction Quality Validation"
echo "========================================"
echo ""

# Check if extraction directory exists
if [ ! -d "$EXTRACTED_DIR" ]; then
    echo "⚠ No extractions found at: $EXTRACTED_DIR"
    exit 1
fi

TOTAL=0
SUCCESS=0
WARNINGS=0
TOTAL_FORMULAS=0
TOTAL_TABLES=0
TOTAL_IMAGES=0

# Process each extraction
for md_dir in "$EXTRACTED_DIR"/*/auto; do
    [ ! -d "$md_dir" ] && continue

    # Find the markdown file
    md_file=$(find "$md_dir" -name "*.md" -print -quit)
    [ ! -f "$md_file" ] && continue

    BASENAME=$(basename "$(dirname "$md_dir")")
    ((TOTAL++))

    # Check 1: File size (if <1KB, likely extraction failure)
    SIZE=$(stat -c%s "$md_file" 2>/dev/null || stat -f%z "$md_file")

    # Check 2: Formulas extracted
    FORMULA_COUNT=$(grep -c '\$\$' "$md_file" 2>/dev/null || echo 0)
    ((TOTAL_FORMULAS+=FORMULA_COUNT))

    # Check 3: Tables extracted
    TABLE_COUNT=$(grep -c '^|' "$md_file" 2>/dev/null || echo 0)
    ((TOTAL_TABLES+=TABLE_COUNT))

    # Check 4: Images extracted
    IMAGE_DIR="$md_dir/images"
    IMAGE_COUNT=0
    if [ -d "$IMAGE_DIR" ]; then
        IMAGE_COUNT=$(find "$IMAGE_DIR" -name "*.png" 2>/dev/null | wc -l)
    fi
    ((TOTAL_IMAGES+=IMAGE_COUNT))

    # Check 5: French accents preserved (if French)
    FRENCH_ACCENTS=$(grep -o '[éèêëàâäôùûüç]' "$md_file" 2>/dev/null | wc -l)

    # Flag issues
    if [ "$SIZE" -lt 1024 ]; then
        echo "⚠ $BASENAME: Extraction FAILED (file too small: ${SIZE}B)"
        ((WARNINGS++))
    elif [ "$SIZE" -lt 5120 ]; then
        echo "⚠ $BASENAME: Low content (${SIZE}B) - $FORMULA_COUNT formulas, $TABLE_COUNT tables, $IMAGE_COUNT images"
        ((WARNINGS++))
    else
        echo "✓ $BASENAME: ${SIZE}B | Formulas: $FORMULA_COUNT | Tables: $TABLE_COUNT | Images: $IMAGE_COUNT | French chars: $FRENCH_ACCENTS"
        ((SUCCESS++))
    fi
done

echo ""
echo "========================================"
echo "Validation Summary"
echo "========================================"
echo "Total PDFs processed: $TOTAL"
echo "Successful extractions: $SUCCESS"
echo "Warnings/Issues: $WARNINGS"
echo ""
echo "Aggregated Statistics:"
echo "  - Total formulas extracted: $TOTAL_FORMULAS"
echo "  - Total tables extracted: $TOTAL_TABLES"
echo "  - Total images extracted: $TOTAL_IMAGES"
echo ""

if [ "$WARNINGS" -gt 0 ]; then
    echo "⚠ $WARNINGS PDFs need manual review"
    exit 1
else
    echo "✓ All extractions passed quality checks"
    exit 0
fi
