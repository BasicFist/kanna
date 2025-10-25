#!/usr/bin/env bash
# Test MinerU on 10-document subset (Codex recommendation)

set -e

OUTPUT_DIR="literature/pdfs/test-extractions"
mkdir -p "$OUTPUT_DIR"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "MinerU 10-Document Test (Codex-guided)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get first 10 PDFs (handle spaces in filenames)
count=0
success=0
failed=0
total=10

while IFS= read -r pdf; do
    [ -z "$pdf" ] && continue
    count=$((count + 1))
    [ $count -gt $total ] && break

    name=$(basename "$pdf")

    echo "[$count/$total] Processing: $name"

    if magic-pdf -p "$pdf" -o "$OUTPUT_DIR" -m auto > /dev/null 2>&1; then
        success=$((success + 1))
        echo "        ✓ Success"
    else
        failed=$((failed + 1))
        echo "        ✗ Failed"
    fi
    echo ""
done < <(find literature/pdfs/BIBLIOGRAPHIE -maxdepth 1 -name "*.pdf" -type f | head -10)

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Extraction Complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Total:   $count"
echo "Success: $success"
echo "Failed:  $failed"
echo ""
echo "Next: Run quality validation"
echo "  python tools/scripts/validate-mineru-quality.py $OUTPUT_DIR"
