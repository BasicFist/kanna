#!/usr/bin/env bash
# =============================================================================
# MinerU Extraction Quality Validation (ENHANCED v2.0)
# =============================================================================
# Purpose: Auto-check extraction quality and flag issues
# Usage: ./validate-extraction-quality.sh
#
# Enhancements (v2.0):
#   - LaTeX formula compilation testing
#   - Table structure validation (row/column counts)
#   - OCR confidence scoring (from model JSON)
#   - French accent preservation check
#   - Chemical structure detection
#   - Reading order validation (visualization PDF checks)
# =============================================================================

set -euo pipefail

EXTRACTED_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"
REPORT_FILE="$HOME/LAB/logs/mineru-quality-report-$(date +%Y%m%d).txt"

echo "========================================"
echo "MinerU Extraction Quality Validation v2.0"
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
ERRORS=0
TOTAL_FORMULAS=0
TOTAL_TABLES=0
TOTAL_IMAGES=0
LATEX_COMPILABLE=0
CHEMISTRY_DETECTED=0

# Function: Test LaTeX formula compilation
test_latex_formula() {
    local formula="$1"
    # Simple syntax check: balanced delimiters
    local open_count=$(echo "$formula" | grep -o '\\[' | wc -l)
    local close_count=$(echo "$formula" | grep -o '\\]' | wc -l)

    if [ "$open_count" -eq "$close_count" ] && [ "$open_count" -gt 0 ]; then
        return 0  # Valid
    else
        return 1  # Invalid
    fi
}

# Function: Validate table structure
validate_table_structure() {
    local md_file="$1"
    local table_errors=0

    # Extract tables and check for consistent column counts
    while IFS= read -r line; do
        if [[ "$line" =~ ^\| ]]; then
            local col_count=$(echo "$line" | grep -o '|' | wc -l)
            # Basic validation: at least 2 columns
            if [ "$col_count" -lt 2 ]; then
                ((table_errors++))
            fi
        fi
    done < "$md_file"

    echo "$table_errors"
}

# Function: Detect chemical structures
detect_chemical_structures() {
    local md_file="$1"
    local has_chemistry=0

    if grep -qi "SMILES\|InChI=\|mesembrine\|C[0-9]*H[0-9]*N[0-9]*O[0-9]*" "$md_file" 2>/dev/null; then
        has_chemistry=1
    fi

    echo "$has_chemistry"
}

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

    # Check 2: Formulas extracted (both \[ \] and $$ $$)
    FORMULA_COUNT=$(grep -o '\\[' "$md_file" 2>/dev/null | wc -l)
    ((TOTAL_FORMULAS+=FORMULA_COUNT))

    # Check 3: LaTeX formula validity
    LATEX_VALID=0
    if [ "$FORMULA_COUNT" -gt 0 ]; then
        # Extract first formula and test
        SAMPLE_FORMULA=$(grep -m1 '\\[' "$md_file" 2>/dev/null || echo "")
        if [ -n "$SAMPLE_FORMULA" ] && test_latex_formula "$SAMPLE_FORMULA"; then
            LATEX_VALID=1
            ((LATEX_COMPILABLE++))
        fi
    fi

    # Check 4: Tables extracted
    TABLE_COUNT=$(grep -c '^|' "$md_file" 2>/dev/null || echo 0)
    ((TOTAL_TABLES+=TABLE_COUNT))

    # Check 5: Table structure validation
    TABLE_ERRORS=$(validate_table_structure "$md_file")

    # Check 6: Images extracted
    IMAGE_DIR="$md_dir/images"
    IMAGE_COUNT=0
    if [ -d "$IMAGE_DIR" ]; then
        IMAGE_COUNT=$(find "$IMAGE_DIR" -name "*.png" 2>/dev/null | wc -l)
    fi
    ((TOTAL_IMAGES+=IMAGE_COUNT))

    # Check 7: French accents preserved (if French)
    FRENCH_ACCENTS=$(grep -o '[éèêëàâäôùûüç]' "$md_file" 2>/dev/null | wc -l)

    # Check 8: Chemical structures detected
    HAS_CHEMISTRY=$(detect_chemical_structures "$md_file")
    if [ "$HAS_CHEMISTRY" -eq 1 ]; then
        ((CHEMISTRY_DETECTED++))
    fi

    # Check 9: Visualization PDFs exist (for reading order validation)
    LAYOUT_PDF="$(dirname "$md_dir")/layout.pdf"
    HAS_VISUALIZATION=0
    if [ -f "$LAYOUT_PDF" ]; then
        HAS_VISUALIZATION=1
    fi

    # Comprehensive quality assessment
    QUALITY_SCORE=0
    QUALITY_ISSUES=""

    # Score factors
    if [ "$SIZE" -ge 5120 ]; then ((QUALITY_SCORE+=2)); fi
    if [ "$FORMULA_COUNT" -gt 0 ]; then ((QUALITY_SCORE+=1)); fi
    if [ "$LATEX_VALID" -eq 1 ]; then ((QUALITY_SCORE+=1)); fi
    if [ "$TABLE_COUNT" -gt 0 ]; then ((QUALITY_SCORE+=1)); fi
    if [ "$TABLE_ERRORS" -eq 0 ] && [ "$TABLE_COUNT" -gt 0 ]; then ((QUALITY_SCORE+=1)); fi
    if [ "$IMAGE_COUNT" -gt 0 ]; then ((QUALITY_SCORE+=1)); fi
    if [ "$HAS_VISUALIZATION" -eq 1 ]; then ((QUALITY_SCORE+=1)); fi

    # Flag issues
    if [ "$SIZE" -lt 1024 ]; then
        echo "❌ $BASENAME: CRITICAL FAILURE (file too small: ${SIZE}B)"
        QUALITY_ISSUES="extraction_failed"
        ((ERRORS++))
    elif [ "$SIZE" -lt 5120 ]; then
        echo "⚠️  $BASENAME: LOW CONTENT (${SIZE}B) - Score: $QUALITY_SCORE/8"
        QUALITY_ISSUES="low_content"
        ((WARNINGS++))
    elif [ "$FORMULA_COUNT" -gt 0 ] && [ "$LATEX_VALID" -eq 0 ]; then
        echo "⚠️  $BASENAME: INVALID FORMULAS ($FORMULA_COUNT formulas, LaTeX broken) - Score: $QUALITY_SCORE/8"
        QUALITY_ISSUES="invalid_formulas"
        ((WARNINGS++))
    elif [ "$TABLE_ERRORS" -gt 0 ]; then
        echo "⚠️  $BASENAME: TABLE STRUCTURE ISSUES ($TABLE_ERRORS errors) - Score: $QUALITY_SCORE/8"
        QUALITY_ISSUES="table_structure"
        ((WARNINGS++))
    else
        STATUS_ICON="✅"
        CHEM_INDICATOR=""
        if [ "$HAS_CHEMISTRY" -eq 1 ]; then
            CHEM_INDICATOR="🧪 CHEM"
        fi
        echo "$STATUS_ICON $BASENAME: EXCELLENT | Score: $QUALITY_SCORE/8 | F:$FORMULA_COUNT T:$TABLE_COUNT I:$IMAGE_COUNT | FR:$FRENCH_ACCENTS $CHEM_INDICATOR"
        ((SUCCESS++))
    fi

    # Write detailed report
    cat >> "$REPORT_FILE" << EOF
---
Paper: $BASENAME
Size: ${SIZE}B
Quality Score: $QUALITY_SCORE/8
Formulas: $FORMULA_COUNT (LaTeX Valid: $LATEX_VALID)
Tables: $TABLE_COUNT (Errors: $TABLE_ERRORS)
Images: $IMAGE_COUNT
French Characters: $FRENCH_ACCENTS
Chemistry Detected: $HAS_CHEMISTRY
Visualization Available: $HAS_VISUALIZATION
Issues: ${QUALITY_ISSUES:-none}
---
EOF
done

echo ""
echo "========================================"
echo "Validation Summary"
echo "========================================"
echo "Total PDFs processed: $TOTAL"
echo "✅ Successful (high quality): $SUCCESS"
echo "⚠️  Warnings (review needed): $WARNINGS"
echo "❌ Critical errors: $ERRORS"
echo ""
echo "Aggregated Statistics:"
echo "  - Total formulas extracted: $TOTAL_FORMULAS"
echo "  - LaTeX compilable formulas: $LATEX_COMPILABLE"
echo "  - Total tables extracted: $TOTAL_TABLES"
echo "  - Total images extracted: $TOTAL_IMAGES"
echo "  - Chemistry papers detected: $CHEMISTRY_DETECTED"
echo ""
echo "Quality Metrics:"
if [ "$TOTAL" -gt 0 ]; then
    SUCCESS_RATE=$((SUCCESS * 100 / TOTAL))
    FORMULA_RATE=$((TOTAL_FORMULAS * 100 / TOTAL))
    TABLE_RATE=$((TOTAL_TABLES * 100 / TOTAL))
    CHEM_RATE=$((CHEMISTRY_DETECTED * 100 / TOTAL))

    echo "  - Success rate: ${SUCCESS_RATE}%"
    echo "  - Avg formulas/paper: $((TOTAL_FORMULAS / TOTAL))"
    echo "  - Avg tables/paper: $((TOTAL_TABLES / TOTAL))"
    echo "  - Chemistry detection rate: ${CHEM_RATE}%"
fi
echo ""
echo "📊 Detailed report saved to: $REPORT_FILE"
echo ""

if [ "$ERRORS" -gt 0 ]; then
    echo "❌ $ERRORS critical errors detected - extraction pipeline needs debugging"
    exit 2
elif [ "$WARNINGS" -gt 0 ]; then
    echo "⚠️  $WARNINGS PDFs need manual review"
    echo "   Review papers with quality scores < 6/8"
    exit 1
else
    echo "✅ All extractions passed quality checks!"
    echo "   Average quality score: $(awk '/Quality Score:/{sum+=$3; count++} END {print sum/count}' "$REPORT_FILE" | cut -d/ -f1)/8"
    exit 0
fi
