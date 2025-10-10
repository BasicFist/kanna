#!/usr/bin/env bash
set -euo pipefail

# check-grammar-french.sh - French Grammar Checker for KANNA Thesis
#
# Purpose: Run Grammalecte grammar checking on French academic texts
# Usage: ./check-grammar-french.sh input.md [output.json]
# Example: ./check-grammar-french.sh writing/chapter-01.md
#
# Dependencies:
# - Grammalecte (conda environment: kanna)
# - jq (optional, for statistics)
#
# Created: 2025-10-10
# Part of: KANNA Academic Tools Stack (Tier 1)

INPUT="${1:?Missing input file. Usage: $0 input.md [output.json]}"
OUTPUT="${2:-${INPUT%.md}-grammar-report.json}"

if [ ! -f "$INPUT" ]; then
  echo "❌ Input file not found: $INPUT" >&2
  exit 1
fi

echo "🔍 Checking French grammar: $INPUT"

# Run Grammalecte via conda (ensures correct environment)
conda run -n kanna grammalecte-cli.py \
  -f "$INPUT" \
  -off apos \
  -json > "$OUTPUT" 2>/dev/null

if [ ! -f "$OUTPUT" ]; then
  echo "❌ Grammar check failed - no output generated" >&2
  exit 1
fi

# Display statistics if jq is available
if command -v jq &> /dev/null; then
  ERRORS=$(jq '.data.lGrammarErrors | length' "$OUTPUT" 2>/dev/null || echo "0")
  echo "📊 Found $ERRORS grammar issues"

  # Show top 5 error types
  if [ "$ERRORS" -gt 0 ]; then
    echo "📋 Most common error types:"
    jq -r '.data.lGrammarErrors[] | .sRuleId' "$OUTPUT" | \
      sort | uniq -c | sort -rn | head -5 | \
      awk '{print "   " $1 "× " $2}'
  fi
else
  echo "   (Install jq for detailed statistics: sudo dnf install jq)"
fi

echo "📄 Full report saved: $OUTPUT"

exit 0
