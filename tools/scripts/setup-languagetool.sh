#!/usr/bin/env bash
set -euo pipefail

# Setup LanguageTool for French grammar checking
# Alternative to Grammalecte - more actively maintained, better availability

echo "🔧 Setting up LanguageTool for French grammar checking"

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "❌ Java not found. Install with: sudo dnf install java-11-openjdk"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 8 ]; then
    echo "❌ Java 8 or higher required. Current: $JAVA_VERSION"
    exit 1
fi

# Create tools directory
TOOLS_DIR="$HOME/LAB/academic/KANNA/tools/languagetool"
mkdir -p "$TOOLS_DIR"

# Download LanguageTool
echo "📥 Downloading LanguageTool..."
cd "$TOOLS_DIR"
LANGUAGETOOL_VERSION="6.4"
DOWNLOAD_URL="https://languagetool.org/download/LanguageTool-${LANGUAGETOOL_VERSION}.zip"

if [ ! -f "LanguageTool-${LANGUAGETOOL_VERSION}.zip" ]; then
    curl -L -o "LanguageTool-${LANGUAGETOOL_VERSION}.zip" "$DOWNLOAD_URL"
fi

# Extract
echo "📦 Extracting..."
unzip -q "LanguageTool-${LANGUAGETOOL_VERSION}.zip" 2>/dev/null || true

# Create wrapper script
cat > "$HOME/LAB/academic/KANNA/tools/scripts/check-grammar-french.sh" << 'WRAPPER_EOF'
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
WRAPPER_EOF

chmod +x "$HOME/LAB/academic/KANNA/tools/scripts/check-grammar-french.sh"

echo "✅ LanguageTool setup complete"
echo ""
echo "Usage:"
echo "  ./tools/scripts/check-grammar-french.sh writing/chapter-01.md"
echo ""
echo "VS Code Extension:"
echo "  code --install-extension davidlday.languagetool-linter"
