#!/usr/bin/env bash
set -euo pipefail

# Usage: ./check-grammar-french.sh input.md [output.txt]
# Example: ./check-grammar-french.sh writing/chapter-01.md

INPUT="${1:?Missing input file. Usage: $0 input.md [output.txt]}"
OUTPUT="${2:-${INPUT%.md}-grammar-report.txt}"

if [ ! -f "$INPUT" ]; then
  echo "❌ Input file not found: $INPUT" >&2
  exit 1
fi

LANGUAGETOOL_DIR="$HOME/LAB/academic/KANNA/tools/languagetool/LanguageTool-6.4"

if [ ! -d "$LANGUAGETOOL_DIR" ]; then
    echo "❌ LanguageTool not found. Run: bash tools/scripts/setup-languagetool.sh" >&2
    exit 1
fi

echo "🔍 Checking French grammar: $INPUT"

# Run LanguageTool for French
java -jar "$LANGUAGETOOL_DIR/languagetool-commandline.jar" \
    --language fr \
    --disable WHITESPACE_RULE \
    "$INPUT" > "$OUTPUT" 2>&1

# Count issues
ISSUE_COUNT=$(grep -c "^[0-9]\+\.\)" "$OUTPUT" 2>/dev/null || echo "0")

echo "📊 Found $ISSUE_COUNT grammar issues"
echo "📄 Full report saved: $OUTPUT"

# Show first 20 lines of report
head -20 "$OUTPUT"

exit 0
