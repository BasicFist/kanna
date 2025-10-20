#!/usr/bin/env bash
# Script de compilation LaTeX pour thèse de doctorat
# Compile Introduction + Chapitre 1 (Épistémologie)
# Auteur: Claude Code
# Date: 2025-10-10

set -euo pipefail

# Couleurs pour output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Répertoires
KANNA_ROOT="${KANNA_ROOT:-$HOME/LAB/projects/KANNA}"
WRITING_DIR="$KANNA_ROOT/writing"
OUTPUT_DIR="$WRITING_DIR/output"

# Fichier LaTeX à compiler
TEX_FILE="THESE_PARTIE_I_INTRODUCTION_CHAP1.tex"
TEX_PATH="$WRITING_DIR/$TEX_FILE"
TEX_BASENAME="${TEX_FILE%.tex}"

# Vérifications préalables
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Compilation Thèse de Doctorat - Partie I${NC}"
echo -e "${BLUE}   Introduction + Chapitre 1 (Épistémologie)${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
echo

# Vérifier existence du fichier
if [ ! -f "$TEX_PATH" ]; then
    echo -e "${RED}❌ Erreur: Fichier LaTeX introuvable${NC}"
    echo -e "   Chemin attendu: $TEX_PATH"
    exit 1
fi

echo -e "${GREEN}✓${NC} Fichier LaTeX trouvé: $TEX_FILE"

# Vérifier existence du fichier BibTeX
BIB_FILE="$KANNA_ROOT/literature/zotero-export/kanna-minimal.bib"
if [ ! -f "$BIB_FILE" ]; then
    echo -e "${RED}❌ Erreur: Fichier BibTeX introuvable${NC}"
    echo -e "   Chemin attendu: $BIB_FILE"
    exit 1
fi

echo -e "${GREEN}✓${NC} Fichier BibTeX trouvé: kanna-minimal.bib"

# Vérifier que pdflatex et biber sont installés
if ! command -v pdflatex &> /dev/null; then
    echo -e "${RED}❌ Erreur: pdflatex n'est pas installé${NC}"
    echo -e "   Installation: ${YELLOW}sudo dnf install texlive-scheme-medium${NC}"
    exit 1
fi

if ! command -v biber &> /dev/null; then
    echo -e "${RED}❌ Erreur: biber n'est pas installé${NC}"
    echo -e "   Installation: ${YELLOW}sudo dnf install texlive-biber${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} pdflatex et biber disponibles"
echo

# Créer répertoire de sortie si nécessaire
mkdir -p "$OUTPUT_DIR"

# Changer vers le répertoire de compilation
cd "$WRITING_DIR" || exit 1

# Fonction pour compiler avec gestion d'erreurs
compile_latex() {
    local pass_name="$1"
    local cmd="$2"

    echo -e "${BLUE}▶${NC} $pass_name..."

    if $cmd > "$OUTPUT_DIR/${TEX_BASENAME}_${pass_name// /_}.log" 2>&1; then
        echo -e "  ${GREEN}✓${NC} $pass_name réussie"
        return 0
    else
        echo -e "  ${RED}✗${NC} $pass_name échouée"
        echo -e "  ${YELLOW}Voir le log:${NC} $OUTPUT_DIR/${TEX_BASENAME}_${pass_name// /_}.log"
        return 1
    fi
}

# Compilation en 4 passes (standard pour documents avec bibliographie)
echo -e "${BLUE}Compilation (4 passes)${NC}"
echo -e "${BLUE}─────────────────────${NC}"

# Passe 1: Génération du document, création des références
compile_latex "Passe 1 (pdflatex)" \
    "pdflatex -interaction=nonstopmode -halt-on-error $TEX_FILE" || exit 1

# Passe 2: Génération de la bibliographie
compile_latex "Passe 2 (biber)" \
    "biber $TEX_BASENAME" || {
        echo -e "${YELLOW}⚠ Avertissement: biber a échoué (bibliographie peut être incomplète)${NC}"
    }

# Passe 3: Intégration de la bibliographie
compile_latex "Passe 3 (pdflatex)" \
    "pdflatex -interaction=nonstopmode -halt-on-error $TEX_FILE" || exit 1

# Passe 4: Finalisation (table des matières, références croisées)
compile_latex "Passe 4 (pdflatex)" \
    "pdflatex -interaction=nonstopmode -halt-on-error $TEX_FILE" || exit 1

echo

# Vérifier que le PDF a été généré
PDF_FILE="${TEX_BASENAME}.pdf"
if [ -f "$PDF_FILE" ]; then
    # Déplacer le PDF vers le répertoire de sortie
    cp "$PDF_FILE" "$OUTPUT_DIR/"

    # Statistiques du PDF
    PDF_SIZE=$(du -h "$PDF_FILE" | cut -f1)
    PDF_PAGES=$(pdfinfo "$PDF_FILE" 2>/dev/null | grep "Pages:" | awk '{print $2}' || echo "?")

    echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}✓ Compilation réussie !${NC}"
    echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
    echo
    echo -e "  Fichier PDF: ${BLUE}$WRITING_DIR/$PDF_FILE${NC}"
    echo -e "  Copie sauvegardée: ${BLUE}$OUTPUT_DIR/$PDF_FILE${NC}"
    echo -e "  Taille: ${GREEN}$PDF_SIZE${NC}"
    echo -e "  Pages: ${GREEN}$PDF_PAGES${NC}"
    echo
    echo -e "${YELLOW}Commandes utiles:${NC}"
    echo -e "  • Ouvrir le PDF: ${BLUE}okular $WRITING_DIR/$PDF_FILE${NC}"
    echo -e "  • Ouvrir le PDF: ${BLUE}evince $WRITING_DIR/$PDF_FILE${NC}"
    echo -e "  • Nettoyer les fichiers temporaires: ${BLUE}$0 clean${NC}"
    echo
else
    echo -e "${RED}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${RED}✗ Échec de la compilation${NC}"
    echo -e "${RED}═══════════════════════════════════════════════════════════${NC}"
    echo
    echo -e "${YELLOW}Diagnostics:${NC}"
    echo -e "  1. Vérifier les logs: ${BLUE}ls -lh $OUTPUT_DIR/*.log${NC}"
    echo -e "  2. Erreurs LaTeX courantes:"
    echo -e "     - Citations manquantes → Vérifier kanna-minimal.bib"
    echo -e "     - Packages manquants → Installer texlive-scheme-medium"
    echo -e "     - Erreurs de syntaxe → Consulter le dernier log"
    echo
    exit 1
fi

# Option de nettoyage
if [ "${1:-}" == "clean" ]; then
    echo -e "${BLUE}Nettoyage des fichiers temporaires...${NC}"
    rm -f "$TEX_BASENAME".{aux,bbl,bcf,blg,log,out,run.xml,toc,fdb_latexmk,fls,synctex.gz}
    echo -e "${GREEN}✓${NC} Fichiers temporaires supprimés"
    echo -e "${BLUE}Fichier PDF conservé:${NC} $WRITING_DIR/$PDF_FILE"
fi
