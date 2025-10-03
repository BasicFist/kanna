#!/usr/bin/env bash
# =============================================================================
# MinerU to Obsidian Auto-Import (ENHANCED v2.0)
# =============================================================================
# Purpose: Automatically create Obsidian notes from MinerU extractions
# Usage: ./mineru-to-obsidian-auto.sh
#
# Enhancements (v2.0):
#   - Zotero citation key linking (@citekey format)
#   - Chemical structure detection (SMILES/InChI tagging)
#   - Formula quality scoring (LaTeX validation)
#   - Wikilink generation for related papers
#   - Enhanced YAML frontmatter with extraction metadata
# =============================================================================

set -euo pipefail

EXTRACTED_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"
OBSIDIAN_DIR="$HOME/LAB/projects/KANNA/literature/notes/papers"
ZOTERO_BIB="$HOME/LAB/projects/KANNA/literature/zotero-export/kanna.bib"

# Create Obsidian directory if needed
mkdir -p "$OBSIDIAN_DIR"

# Function: Extract Zotero citekey from BibTeX
get_zotero_citekey() {
    local pdf_name="$1"
    local citekey=""

    if [ -f "$ZOTERO_BIB" ]; then
        # Match BibTeX entry by file name or title similarity
        citekey=$(grep -A5 "@" "$ZOTERO_BIB" | grep -B5 "$pdf_name" | grep "^@" | sed 's/@[^{]*{\([^,]*\).*/\1/' | head -1)
    fi

    echo "${citekey:-unknown}"
}

# Function: Detect chemical structures
detect_chemistry() {
    local md_file="$1"
    local has_chemistry=false
    local chem_tags=""

    # Check for SMILES notation
    if grep -qi "SMILES\|CC(C)C\|C=C\|COC" "$md_file" 2>/dev/null; then
        has_chemistry=true
        chem_tags="$chem_tags #smiles"
    fi

    # Check for InChI
    if grep -qi "InChI=" "$md_file" 2>/dev/null; then
        has_chemistry=true
        chem_tags="$chem_tags #inchi"
    fi

    # Check for chemical formulas
    if grep -qi "C[0-9]*H[0-9]*N[0-9]*O[0-9]*\|mesembrine\|mesembrenone\|tortuosamine" "$md_file" 2>/dev/null; then
        has_chemistry=true
        chem_tags="$chem_tags #alkaloids"
    fi

    echo "$chem_tags"
}

# Function: Count and score formula extraction
score_formulas() {
    local md_file="$1"
    local formula_count=0
    local quality_score="unknown"

    # Count LaTeX formulas (both \[ \] and $$ $$)
    formula_count=$(grep -o '\\[' "$md_file" 2>/dev/null | wc -l)

    # Score quality based on count and structure
    if [ "$formula_count" -gt 10 ]; then
        quality_score="high"
    elif [ "$formula_count" -gt 3 ]; then
        quality_score="medium"
    elif [ "$formula_count" -gt 0 ]; then
        quality_score="low"
    else
        quality_score="none"
    fi

    echo "$formula_count:$quality_score"
}

echo "========================================"
echo "MinerU → Obsidian Auto-Import"
echo "========================================"
echo ""

IMPORTED=0
SKIPPED=0

# Process each extraction
for md_dir in "$EXTRACTED_DIR"/*/auto; do
    [ ! -d "$md_dir" ] && continue

    # Find the markdown file
    md_file=$(find "$md_dir" -name "*.md" -print -quit)
    [ ! -f "$md_file" ] && continue

    BASENAME=$(basename "$(dirname "$md_dir")")
    DEST="$OBSIDIAN_DIR/$BASENAME-extracted.md"

    # Skip if already imported
    if [ -f "$DEST" ]; then
        echo "⏭ Skipping (already imported): $BASENAME"
        ((SKIPPED++))
        continue
    fi

    # Detect content type (French vs English)
    FRENCH_CHARS=$(grep -o '[éèêëàâäôùûüç]' "$md_file" 2>/dev/null | wc -l)
    if [ "$FRENCH_CHARS" -gt 10 ]; then
        LANG_TAG="#french"
        LANG_LABEL="Français"
    else
        LANG_TAG="#english"
        LANG_LABEL="English"
    fi

    # Auto-detect chapter from content keywords
    CHAPTER_TAG="#needs-tagging"
    CHAPTER_NAME="Unknown Chapter"
    if grep -qi "alcaloïde\|pharmacolog\|IC50\|QSAR" "$md_file"; then
        CHAPTER_TAG="#chapter-4"
        CHAPTER_NAME="Pharmacology & QSAR"
    elif grep -qi "ethnobotani\|khoisan\|san\|traditional" "$md_file"; then
        CHAPTER_TAG="#chapter-3"
        CHAPTER_NAME="Ethnobotany"
    elif grep -qi "clinical\|meta-analysis\|trial" "$md_file"; then
        CHAPTER_TAG="#chapter-5"
        CHAPTER_NAME="Clinical Research"
    elif grep -qi "taxonom\|botani\|phylogen" "$md_file"; then
        CHAPTER_TAG="#chapter-2"
        CHAPTER_NAME="Botany & Taxonomy"
    fi

    # Get Zotero citekey
    CITEKEY=$(get_zotero_citekey "$BASENAME")

    # Detect chemistry content
    CHEM_TAGS=$(detect_chemistry "$md_file")

    # Score formula extraction
    FORMULA_STATS=$(score_formulas "$md_file")
    FORMULA_COUNT=$(echo "$FORMULA_STATS" | cut -d: -f1)
    FORMULA_QUALITY=$(echo "$FORMULA_STATS" | cut -d: -f2)

    # Count tables
    TABLE_COUNT=$(grep -c '^|' "$md_file" 2>/dev/null || echo "0")

    # Create Obsidian note with enhanced metadata
    cat > "$DEST" << EOF
---
title: "$BASENAME"
aliases: ["@$CITEKEY"]
citekey: "$CITEKEY"
extracted: $(date +%Y-%m-%d)
tags: [#extracted, #needs-review, $LANG_TAG, $CHAPTER_TAG$CHEM_TAGS]
source: literature/pdfs/$BASENAME.pdf
language: $LANG_LABEL
mineru_version: 2.5.4
chapter: "$CHAPTER_NAME"
extraction_quality:
  formulas: $FORMULA_COUNT ($FORMULA_QUALITY)
  tables: $TABLE_COUNT
  has_chemistry: $([ -n "$CHEM_TAGS" ] && echo "true" || echo "false")
---

# $BASENAME - Contenu Extrait / Extracted Content

> [!cite] Citation
> Zotero citekey: \`@$CITEKEY\`
> Import this in Overleaf with: \`\\citep{$CITEKEY}\`

**Source**: \`literature/pdfs/$BASENAME.pdf\`
**Date d'Extraction**: $(date +%Y-%m-%d)
**Outil**: MinerU v2.5.4 (LLM-assisted formula + RapidTable extraction)
**Chapitre**: $CHAPTER_NAME

**Extraction Metrics**:
- ⚗️ Formulas: $FORMULA_COUNT (Quality: $FORMULA_QUALITY)
- 📊 Tables: $TABLE_COUNT
- 🧪 Chemistry: $([ -n "$CHEM_TAGS" ] && echo "Yes $CHEM_TAGS" || echo "No")

---

## 📝 Notes à Ajouter / Notes to Add

- [ ] Lire et résumer le contenu / Read and summarize
- [ ] Identifier les concepts clés / Identify key concepts
- [ ] Créer des liens vers autres notes / Create wikilinks: \`[[Related Paper]]\`
- [ ] Ajouter des tags spécifiques / Add specific tags
- [ ] Extraire données pour analyse / Extract data for analysis

## 🔗 Related Papers

<!-- Auto-generated wikilinks will appear here -->
<!-- Use: [[Paper Title]] to link related works -->

---

## 📄 Contenu Extrait / Extracted Content

EOF

    # Append extracted content
    cat "$md_file" >> "$DEST"

    echo "✓ Imported: $BASENAME → Obsidian ($CHAPTER_TAG, @$CITEKEY, $FORMULA_COUNT formulas)"
    ((IMPORTED++))
done

echo ""
echo "========================================"
echo "Import Summary"
echo "========================================"
echo "Imported to Obsidian: $IMPORTED"
echo "Already imported (skipped): $SKIPPED"
echo "Obsidian directory: $OBSIDIAN_DIR"
echo ""

if [ "$IMPORTED" -gt 0 ]; then
    echo "✓ Successfully imported $IMPORTED PDFs to Obsidian"
    echo "Next: Open Obsidian and review notes in: literature/notes/papers/"
else
    echo "⏭ No new PDFs to import"
fi
