#!/usr/bin/env bash
# =============================================================================
# MinerU to Obsidian Auto-Import
# =============================================================================
# Purpose: Automatically create Obsidian notes from MinerU extractions
# Usage: ./mineru-to-obsidian-auto.sh
# =============================================================================

set -euo pipefail

EXTRACTED_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"
OBSIDIAN_DIR="$HOME/LAB/projects/KANNA/literature/notes/papers"

# Create Obsidian directory if needed
mkdir -p "$OBSIDIAN_DIR"

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
    if grep -qi "alcaloïde\|pharmacolog\|IC50\|QSAR" "$md_file"; then
        CHAPTER_TAG="#chapter-4"
    elif grep -qi "ethnobotani\|khoisan\|san\|traditional" "$md_file"; then
        CHAPTER_TAG="#chapter-3"
    elif grep -qi "clinical\|meta-analysis\|trial" "$md_file"; then
        CHAPTER_TAG="#chapter-5"
    elif grep -qi "taxonom\|botani\|phylogen" "$md_file"; then
        CHAPTER_TAG="#chapter-2"
    fi

    # Create Obsidian note with metadata
    cat > "$DEST" << EOF
---
title: "$BASENAME"
extracted: $(date +%Y-%m-%d)
tags: [#extracted, #needs-review, $LANG_TAG, $CHAPTER_TAG]
source: literature/pdfs/$BASENAME.pdf
language: $LANG_LABEL
mineru_version: 2.5.4
---

# $BASENAME - Contenu Extrait / Extracted Content

**Source**: \`literature/pdfs/$BASENAME.pdf\`
**Date d'Extraction**: $(date +%Y-%m-%d)
**Outil**: MinerU v2.5.4 (automatic formula + table extraction)

---

## 📝 Notes à Ajouter / Notes to Add

- [ ] Lire et résumer le contenu / Read and summarize
- [ ] Identifier les concepts clés / Identify key concepts
- [ ] Créer des liens vers autres notes / Create links to other notes
- [ ] Ajouter des tags spécifiques / Add specific tags

---

## 📄 Contenu Extrait / Extracted Content

EOF

    # Append extracted content
    cat "$md_file" >> "$DEST"

    echo "✓ Imported: $BASENAME → Obsidian ($CHAPTER_TAG)"
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
