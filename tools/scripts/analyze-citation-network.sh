#!/usr/bin/env bash
set -euo pipefail

# analyze-citation-network.sh - VOSviewer Citation Network Analysis Guide
#
# Purpose: Automated preparation and manual guide for VOSviewer analysis of 142-paper corpus
# Usage: ./analyze-citation-network.sh
#
# Requirements:
# - VOSviewer installed at ~/Applications/VOSviewer/
# - Zotero BibTeX export at literature/zotero-export/kanna.bib
# - Java 11+ installed
#
# Created: 2025-10-10
# Part of: KANNA Academic Tools Stack (Tier 1)

echo "🔬 Citation Network Analysis Guide for KANNA"
echo "============================================="
echo ""

# Configuration
BIBTEX_SOURCE="$HOME/LAB/projects/KANNA/literature/zotero-export/kanna.bib"
BIBTEX_TARGET="$HOME/LAB/projects/KANNA/literature/citation-networks/kanna.bib"
VOSVIEWER_JAR="$HOME/Applications/VOSviewer/VOSviewer.jar"

# Check prerequisites
echo "📋 Checking prerequisites..."
echo ""

# Check Java
if ! command -v java &> /dev/null; then
  echo "❌ Java not found. Install with: sudo dnf install java-latest-openjdk"
  exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 11 ]; then
  echo "❌ Java 11+ required. Current version: $JAVA_VERSION"
  echo "   Update with: sudo dnf install java-latest-openjdk"
  exit 1
fi
echo "✅ Java $JAVA_VERSION found"

# Check VOSviewer
if [ ! -f "$VOSVIEWER_JAR" ]; then
  echo "❌ VOSviewer not found at: $VOSVIEWER_JAR"
  echo "   Install from: https://www.vosviewer.com/download/"
  exit 1
fi
echo "✅ VOSviewer found"

# Check Zotero BibTeX
if [ ! -f "$BIBTEX_SOURCE" ]; then
  echo "❌ Zotero BibTeX not found: $BIBTEX_SOURCE"
  echo "   Please complete Zotero setup (Tier 2) first"
  echo "   See: docs/ACADEMIC-TOOLS-IMPLEMENTATION.md"
  exit 1
fi

ENTRIES=$(grep -c "^@" "$BIBTEX_SOURCE" || echo "0")
echo "✅ Zotero BibTeX found: $ENTRIES entries"
echo ""

# Create citation networks directory if not exists
mkdir -p "$(dirname "$BIBTEX_TARGET")"

# Copy BibTeX to citation networks directory
echo "📚 Preparing BibTeX for analysis..."
cp "$BIBTEX_SOURCE" "$BIBTEX_TARGET"
echo "   Copied to: $BIBTEX_TARGET"
echo ""

# Display analysis instructions
cat << 'EOF'
📋 VOSviewer Analysis Steps (Manual - GUI Required)
====================================================

1. LAUNCH VOSVIEWER:
   ~/Applications/VOSviewer/launch-vosviewer.sh
   (Or: java -jar ~/Applications/VOSviewer/VOSviewer.jar)

2. CREATE MAP:
   - Click "Create" button
   - Select "Create a map based on bibliographic data"
   - Click "Next"

3. DATA SOURCE:
   - Select "Read data from bibliographic database files"
   - Click "Next"
   - Choose format: "BibTeX"
   - Click "Next"

4. INPUT FILE:
   - Browse to: ~/LAB/projects/KANNA/literature/citation-networks/kanna.bib
   - Click "Next"

5. ANALYSIS TYPE:
   Choose one of:
   a) Co-citation (papers cited together) ← RECOMMENDED FIRST
   b) Bibliographic coupling (papers sharing references)
   c) Co-authorship (author collaboration networks)

6. THRESHOLD SETTINGS:
   - For co-citation with 142 papers:
     * Minimum citations: 2 (balanced)
     * Minimum citations: 1 (includes more papers, may be cluttered)
     * Minimum citations: 3+ (only highly cited papers)
   - Click "Next"

7. VERIFICATION:
   - Review list of papers meeting threshold
   - Click "Finish"

8. VISUALIZATION:
   - Network appears with nodes (papers) and edges (relationships)
   - Colors = clusters (thematic groups)
   - Size = citation frequency
   - Interactions:
     * Drag nodes to rearrange
     * Scroll to zoom
     * Click node → See paper details
     * Double-click → Center on node

9. EXPORT VISUALIZATION:
   - File → Save Map → Save as PNG
   - Settings:
     * Resolution: 300 DPI (publication-ready)
     * Size: 3000x2000 pixels
   - Save to: ~/LAB/projects/KANNA/literature/citation-networks/cocitation-map.png

10. EXPORT NETWORK DATA (Optional):
    - File → Export → Network
    - Save to: literature/citation-networks/cocitation-network.txt
    - Use for: Custom analysis in R/Python

11. TRY OTHER ANALYSES:
    Repeat steps 2-10 with different analysis types:
    - Bibliographic coupling → Shows methodological similarity
    - Keyword co-occurrence → Shows thematic connections
    - Co-authorship → Shows author networks

12. COPY TO THESIS FIGURES:
    cp literature/citation-networks/cocitation-map.png \
       assets/figures/chapter-01/literature-network.png

===================================================================

EXPECTED RESULTS (for 142 papers with threshold=2):
- Network with 40-80 papers (those cited by 2+ others)
- 3-5 distinct clusters (e.g., ethnobotany, pharmacology, clinical)
- Papers connecting clusters = interdisciplinary bridges
- Isolated papers = unique contributions or peripheral topics

INTERPRETATION TIPS:
- Large nodes = frequently cited (foundational papers)
- Clusters = research communities or themes
- Bridges between clusters = interdisciplinary work
- Gaps = potential research opportunities

TROUBLESHOOTING:
- No visualization? → Lower threshold (use 1 instead of 2)
- Too cluttered? → Raise threshold (use 3 or 4)
- Out of memory? → Increase Java heap: java -Xmx4g -jar VOSviewer.jar

===================================================================

ALTERNATIVE: CLI Analysis with R bibliometrix
---------------------------------------------
For programmatic/automated analysis:

Rscript -e '
library(bibliometrix)
bib <- convert2df("literature/citation-networks/kanna.bib", dbsource="isi", format="bibtex")
results <- biblioAnalysis(bib)
summary(results, k=10)
NetMatrix <- biblioNetwork(bib, analysis="co-citation", network="references")
networkPlot(NetMatrix, n=50, Title="KANNA Co-citation Network")
'

EOF

echo ""
echo "✅ Preparation complete. Follow manual steps above to run analysis."
echo ""

# Ask if user wants to launch VOSviewer now
read -p "Launch VOSviewer now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "🚀 Launching VOSviewer..."
  java -Xmx4g -jar "$VOSVIEWER_JAR" &
  echo "✅ VOSviewer launched in background"
else
  echo "📝 Launch later with:"
  echo "   ~/Applications/VOSviewer/launch-vosviewer.sh"
fi

exit 0
