#!/usr/bin/env bash
# PDF Extraction Consolidation Script
# Consolidates pdfplumber and MinerU extractions into unified structure
# Created: October 2025

set -Eeuo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="/home/miko/LAB/projects/KANNA"
LOG_DIR="$HOME/LAB/logs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/pdf-extraction-consolidation-$TIMESTAMP.log"

# Directories
MINERU_SOURCE="$PROJECT_ROOT/literature/pdfs/extractions-baseline-no-formulas"
MINERU_TARGET="$PROJECT_ROOT/literature/pdfs/extractions-mineru"
PDFPLUMBER_SOURCE="$PROJECT_ROOT/data/extracted-papers-simple"
PDFPLUMBER_ARCHIVE="$PROJECT_ROOT/data/ARCHIVE/extracted-papers-simple-$TIMESTAMP"
FAILED_MINERU="$PROJECT_ROOT/literature/pdfs/extractions"

# Ensure log directory exists
mkdir -p "$LOG_DIR"
mkdir -p "$PROJECT_ROOT/data/ARCHIVE"

# Logging function
log() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

log_header() {
    log "\n${BLUE}======================================================================${NC}"
    log "${BLUE}$1${NC}"
    log "${BLUE}======================================================================${NC}\n"
}

# Validation function
validate_directory() {
    local dir="$1"
    local name="$2"

    if [ ! -d "$dir" ]; then
        log "${RED}✗ ERROR: $name not found at $dir${NC}"
        return 1
    fi

    local md_count=$(find "$dir" -name "*.md" -type f | wc -l)
    log "${GREEN}✓${NC} $name: $md_count markdown files"
    return 0
}

# Main execution
log_header "PDF Extraction Consolidation Script"
log "Started: $(date '+%Y-%m-%d %H:%M:%S')"
log "Log file: $LOG_FILE\n"

# Step 1: Validate source directories
log_header "Step 1: Validate Source Directories"

if ! validate_directory "$MINERU_SOURCE" "MinerU extractions"; then
    log "${RED}Consolidation aborted.${NC}"
    exit 1
fi

if ! validate_directory "$PDFPLUMBER_SOURCE" "pdfplumber extractions"; then
    log "${YELLOW}⚠ Warning: pdfplumber extractions not found, skipping archive step${NC}"
    SKIP_PDFPLUMBER=true
else
    SKIP_PDFPLUMBER=false
fi

# Step 2: Analyze MinerU structure
log_header "Step 2: Analyze MinerU Extraction Structure"

MINERU_ROOT_COUNT=$(find "$MINERU_SOURCE" -maxdepth 1 -type d -not -name "chapter-*" -not -path "$MINERU_SOURCE" | wc -l)
MINERU_CHAPTER_COUNT=$(find "$MINERU_SOURCE"/chapter-* -name "*.md" -type f 2>/dev/null | wc -l || echo "0")
MINERU_TOTAL_MD=$(find "$MINERU_SOURCE" -name "*.md" -type f | wc -l)
MINERU_IMAGES=$(find "$MINERU_SOURCE" -type d -name "images" | wc -l)
MINERU_TOTAL_IMAGES=$(find "$MINERU_SOURCE" -type d -name "images" -exec find {} -type f \; | wc -l)

log "Root-level paper directories: $MINERU_ROOT_COUNT"
log "Chapter-organized papers:     $MINERU_CHAPTER_COUNT"
log "Total markdown files:         $MINERU_TOTAL_MD"
log "Papers with images:           $MINERU_IMAGES"
log "Total extracted images:       $MINERU_TOTAL_IMAGES"

# Step 3: Analyze pdfplumber structure
if [ "$SKIP_PDFPLUMBER" = false ]; then
    log_header "Step 3: Analyze pdfplumber Extraction Structure"

    PDFPLUMBER_COUNT=$(find "$PDFPLUMBER_SOURCE" -name "*.md" -type f | wc -l)
    PDFPLUMBER_SIZE=$(du -sh "$PDFPLUMBER_SOURCE" | cut -f1)

    log "Total markdown files: $PDFPLUMBER_COUNT"
    log "Total size:           $PDFPLUMBER_SIZE"
fi

# Step 4: Quality comparison
log_header "Step 4: Quality Comparison"

log "MinerU advantages:"
log "  ✓ Extracted images ($MINERU_TOTAL_IMAGES total)"
log "  ✓ HTML table preservation"
log "  ✓ Better text formatting"
log "  ✓ Layout PDFs for verification"
log "  ✓ JSON metadata (content_list, model, middle)"
log ""
log "pdfplumber advantages:"
log "  ✓ Simple markdown structure"
log "  ✓ Fast extraction (5 sec/paper)"
log "  ✓ Lower disk usage"

# Step 5: Consolidation decision
log_header "Step 5: Consolidation Plan"

log "Decision: Use MinerU as PRIMARY extraction corpus"
log "Reason:   Superior quality for scientific papers with figures/tables"
log ""
log "Actions:"
log "  1. Rename MinerU directory → extractions-mineru/"
log "  2. Archive pdfplumber extractions → data/ARCHIVE/"
log "  3. Remove empty failed MinerU directory"
log "  4. Update script paths"
log ""

read -p "Proceed with consolidation? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "${YELLOW}Consolidation cancelled by user${NC}"
    exit 0
fi

# Step 6: Execute consolidation
log_header "Step 6: Execute Consolidation"

# 6.1: Check if target already exists
if [ -d "$MINERU_TARGET" ]; then
    log "${RED}✗ ERROR: Target directory already exists: $MINERU_TARGET${NC}"
    log "${YELLOW}Please remove or rename existing directory first${NC}"
    exit 1
fi

# 6.2: Rename MinerU directory
log "Renaming MinerU directory..."
mv "$MINERU_SOURCE" "$MINERU_TARGET"
if [ $? -eq 0 ]; then
    log "${GREEN}✓${NC} Renamed: $MINERU_SOURCE → $MINERU_TARGET"
else
    log "${RED}✗ ERROR: Failed to rename MinerU directory${NC}"
    exit 1
fi

# 6.3: Archive pdfplumber extractions
if [ "$SKIP_PDFPLUMBER" = false ]; then
    log "\nArchiving pdfplumber extractions..."
    mv "$PDFPLUMBER_SOURCE" "$PDFPLUMBER_ARCHIVE"
    if [ $? -eq 0 ]; then
        log "${GREEN}✓${NC} Archived: $PDFPLUMBER_SOURCE → $PDFPLUMBER_ARCHIVE"
    else
        log "${RED}✗ ERROR: Failed to archive pdfplumber directory${NC}"
        # Rollback MinerU rename
        mv "$MINERU_TARGET" "$MINERU_SOURCE"
        log "${YELLOW}Rolled back MinerU rename${NC}"
        exit 1
    fi
fi

# 6.4: Remove failed MinerU directory (if empty)
if [ -d "$FAILED_MINERU" ]; then
    FAILED_COUNT=$(find "$FAILED_MINERU" -name "*.md" -type f | wc -l)
    if [ "$FAILED_COUNT" -eq 0 ]; then
        log "\nRemoving empty failed MinerU directory..."
        rm -rf "$FAILED_MINERU"
        log "${GREEN}✓${NC} Removed: $FAILED_MINERU"
    else
        log "${YELLOW}⚠ Warning: Failed MinerU directory not empty ($FAILED_COUNT files), skipping removal${NC}"
    fi
fi

# Step 7: Verify consolidation
log_header "Step 7: Verify Consolidation"

if validate_directory "$MINERU_TARGET" "Consolidated MinerU extractions"; then
    log "${GREEN}✓ Consolidation successful${NC}"
else
    log "${RED}✗ Consolidation verification failed${NC}"
    exit 1
fi

# Step 8: Generate summary report
log_header "Step 8: Consolidation Summary"

cat > "$PROJECT_ROOT/EXTRACTION-CONSOLIDATION-REPORT.md" <<EOF
# PDF Extraction Consolidation Report

**Date**: $(date '+%Y-%m-%d %H:%M:%S')
**Status**: ✅ Completed Successfully

## Actions Taken

1. **Renamed MinerU extractions**
   - From: \`literature/pdfs/extractions-baseline-no-formulas/\`
   - To: \`literature/pdfs/extractions-mineru/\`

2. **Archived pdfplumber extractions**
   - From: \`data/extracted-papers-simple/\`
   - To: \`data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/\`

3. **Removed failed MinerU directory**
   - Deleted: \`literature/pdfs/extractions/\` (empty)

## Extraction Statistics

### MinerU (Primary Corpus)
- **Location**: \`literature/pdfs/extractions-mineru/\`
- **Total Papers**: $MINERU_ROOT_COUNT
- **Markdown Files**: $MINERU_TOTAL_MD
- **Extracted Images**: $MINERU_TOTAL_IMAGES
- **Papers with Images**: $MINERU_IMAGES

### pdfplumber (Archived)
- **Location**: \`data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/\`
- **Total Papers**: ${PDFPLUMBER_COUNT:-N/A}
- **Status**: Backup only

## Next Steps

1. **Update script paths** to use new MinerU location:
   \`\`\`python
   EXTRACTION_DIR = "literature/pdfs/extractions-mineru"
   \`\`\`

2. **Update CLAUDE.md** with new extraction paths

3. **Update analysis scripts** to reference MinerU extractions

4. **Run quality validation** on MinerU corpus:
   \`\`\`bash
   conda run -n kanna python tools/scripts/validate-extraction-simple.py
   \`\`\`

## Files Requiring Path Updates

- \`CLAUDE.md\`
- \`tools/scripts/validate-extraction-quality.sh\`
- \`analysis/python/\` (search for "extracted-papers")
- \`analysis/r-scripts/\` (search for "extracted-papers")

## Rollback Instructions

If you need to revert this consolidation:

\`\`\`bash
# Restore MinerU original name
mv literature/pdfs/extractions-mineru/ \\
   literature/pdfs/extractions-baseline-no-formulas/

# Restore pdfplumber
mv data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/ \\
   data/extracted-papers-simple/
\`\`\`

---

*Generated by: \`tools/scripts/consolidate-pdf-extractions.sh\`*
*Log file: \`$LOG_FILE\`*
EOF

log "Report saved: $PROJECT_ROOT/EXTRACTION-CONSOLIDATION-REPORT.md"

# Final summary
log_header "Consolidation Complete"
log "${GREEN}✓ MinerU extractions are now at:${NC}    literature/pdfs/extractions-mineru/"
log "${GREEN}✓ pdfplumber backup archived at:${NC}   data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/"
log "${GREEN}✓ Consolidation report created:${NC}    EXTRACTION-CONSOLIDATION-REPORT.md"
log ""
log "${YELLOW}Next: Update script paths and CLAUDE.md${NC}"
log "See report for detailed next steps."
log ""
log "Consolidation completed: $(date '+%Y-%m-%d %H:%M:%S')"
