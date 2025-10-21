#!/usr/bin/env bash
# Smart PDF Extraction with Automatic Fallback
# Tries MinerU first (fast, free), falls back to Vision-LLM for failures

set -Eeuo pipefail

PDF_FILE="$1"
OUTPUT_DIR="${2:-literature/pdfs/extractions-smart}"

MINERU_OUTPUT="$OUTPUT_DIR/mineru"
VLM_OUTPUT="$OUTPUT_DIR/vlm"

mkdir -p "$MINERU_OUTPUT" "$VLM_OUTPUT"

PDF_NAME=$(basename "$PDF_FILE" .pdf)

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Smart PDF Extraction: $PDF_NAME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Stage 1: Try MinerU (GPU-accelerated, local)
echo ""
echo "📊 Stage 1: MinerU extraction (GPU)"
echo "  Model: DocLayout-YOLO + Unimernet + RapidTable"
echo "  Cost: $0 (local GPU)"

conda run -n mineru magic-pdf \
    -p "$PDF_FILE" \
    -o "$MINERU_OUTPUT" \
    -m auto \
    2>&1 | tee "$MINERU_OUTPUT/${PDF_NAME}_log.txt"

MINERU_EXIT=$?

# Check if MinerU succeeded
if [ $MINERU_EXIT -eq 0 ]; then
    EXTRACTED_MD="$MINERU_OUTPUT/$PDF_NAME/auto/${PDF_NAME}.md"

    if [ -f "$EXTRACTED_MD" ]; then
        WORD_COUNT=$(wc -w < "$EXTRACTED_MD")

        # Quality check: extracted markdown should have reasonable content
        if [ "$WORD_COUNT" -gt 100 ]; then
            echo ""
            echo "✅ MinerU SUCCESS"
            echo "  Words extracted: $WORD_COUNT"
            echo "  Output: $EXTRACTED_MD"
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            exit 0
        else
            echo ""
            echo "⚠️  MinerU extraction too short ($WORD_COUNT words)"
            echo "  Falling back to Vision-LLM..."
        fi
    else
        echo ""
        echo "⚠️  MinerU output file not found"
        echo "  Falling back to Vision-LLM..."
    fi
else
    echo ""
    echo "❌ MinerU failed (exit code: $MINERU_EXIT)"
    echo "  Falling back to Vision-LLM..."
fi

# Stage 2: Vision-LLM extraction (Ollama Cloud)
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖 Stage 2: Vision-LLM extraction (Cloud)"
echo "  Model: deepseek-v3.1:671b-cloud"
echo "  Provider: Ollama Cloud API"
echo "  Cost: API credits (pay-per-use)"
echo ""

python tools/scripts/extract-hard-ocr-ollama.py \
    "$PDF_FILE" \
    "$VLM_OUTPUT"

VLM_EXIT=$?

if [ $VLM_EXIT -eq 0 ]; then
    echo ""
    echo "✅ Vision-LLM SUCCESS"
    echo "  Output: $VLM_OUTPUT/${PDF_NAME}.md"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 0
else
    echo ""
    echo "❌ Vision-LLM also failed"
    echo "  Manual intervention required"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
fi
