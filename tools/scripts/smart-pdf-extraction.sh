#!/usr/bin/env bash
# Smart PDF Extraction with Automatic Fallback
# Tries MinerU first (fast, free), falls back to Vision-LLM for failures
# Refactored: October 21, 2025 (MP-1 Phase 2)
#
# CONFIGURATION:
# - Config: ~/LAB/academic/KANNA/tools/config/mineru/production.json
# - Symlinked: ~/.config/mineru/mineru.json -> production.json
# - See: tools/config/mineru/CONFIG-FIELDS.md for field documentation
#
# Usage:
#   ./smart-pdf-extraction.sh <pdf-file> [output-dir]

set -Eeuo pipefail

# Load shared library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/pdf-common.sh"

PDF_FILE="$1"
OUTPUT_DIR="${2:-literature/pdfs/extractions-smart}"

MINERU_OUTPUT="$OUTPUT_DIR/mineru"
VLM_OUTPUT="$OUTPUT_DIR/vlm"

# Create output directories using shared library
create_output_dir "$MINERU_OUTPUT" || exit 1
create_output_dir "$VLM_OUTPUT" || exit 1

PDF_NAME=$(basename "$PDF_FILE" .pdf)
START_TIME=$(date +%s)

log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "INFO"
log "🔍 Smart PDF Extraction: $PDF_NAME" "INFO"
log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "INFO"

# Stage 1: Try MinerU (GPU-accelerated, local)
log "" "INFO"
log "📊 Stage 1: MinerU extraction (GPU)" "INFO"
log "  Model: DocLayout-YOLO + Unimernet + RapidTable" "INFO"
log "  Cost: \$0 (local GPU)" "INFO"

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
        # Quality check using shared library
        if check_output_quality "$EXTRACTED_MD" 100 200; then
            WORD_COUNT=$(wc -w < "$EXTRACTED_MD")
            END_TIME=$(date +%s)
            DURATION=$(format_duration $((END_TIME - START_TIME)))

            log "" "INFO"
            log "✅ MinerU SUCCESS" "INFO"
            log "  Words extracted: $WORD_COUNT" "INFO"
            log "  Duration: $DURATION" "INFO"
            log "  Output: $EXTRACTED_MD" "INFO"
            log "" "INFO"
            log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "INFO"
            exit 0
        else
            log "" "WARN"
            log "⚠️  MinerU extraction quality check failed" "WARN"
            log "  Falling back to Vision-LLM..." "WARN"
        fi
    else
        log "" "WARN"
        log "⚠️  MinerU output file not found" "WARN"
        log "  Falling back to Vision-LLM..." "WARN"
    fi
else
    log "" "ERROR"
    log "❌ MinerU failed (exit code: $MINERU_EXIT)" "ERROR"
    log "  Falling back to Vision-LLM..." "WARN"
fi

# Stage 2: Vision-LLM extraction (Ollama Cloud)
log "" "INFO"
log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "INFO"
log "🤖 Stage 2: Vision-LLM extraction (Cloud)" "INFO"
log "  Model: deepseek-v3.1:671b-cloud" "INFO"
log "  Provider: Ollama Cloud API" "INFO"
log "  Cost: API credits (pay-per-use)" "INFO"
log "" "INFO"

python tools/scripts/extract-hard-ocr-ollama.py \
    "$PDF_FILE" \
    "$VLM_OUTPUT"

VLM_EXIT=$?

if [ $VLM_EXIT -eq 0 ]; then
    END_TIME=$(date +%s)
    DURATION=$(format_duration $((END_TIME - START_TIME)))

    log "" "INFO"
    log "✅ Vision-LLM SUCCESS" "INFO"
    log "  Duration: $DURATION" "INFO"
    log "  Output: $VLM_OUTPUT/${PDF_NAME}.md" "INFO"
    log "" "INFO"
    log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "INFO"
    exit 0
else
    END_TIME=$(date +%s)
    DURATION=$(format_duration $((END_TIME - START_TIME)))

    log "" "ERROR"
    log "❌ Vision-LLM also failed" "ERROR"
    log "  Duration: $DURATION" "ERROR"
    log "  Manual intervention required" "ERROR"
    log "" "ERROR"
    log "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "ERROR"
    exit 1
fi
