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
# Resolve repository root relative to this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
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

SKIP_RENAME=false
if [ -d "$MINERU_SOURCE" ]; then
    validate_directory "$MINERU_SOURCE" "MinerU extractions" || {
        log "${RED}Consolidation aborted.${NC}"
        exit 1
    }
else
    if [ -d "$MINERU_TARGET" ]; then
        log "${YELLOW}⚠ MinerU source not found, but consolidated target exists. Skipping rename step.${NC}"
        SKIP_RENAME=true
    else
        log "${RED}✗ ERROR: Neither source nor target MinerU directories found.${NC}"
        log "Checked: $MINERU_SOURCE and $MINERU_TARGET"
        exit 1
    fi
fi

if ! validate_directory "$PDFPLUMBER_SOURCE" "pdfplumber extractions"; then
    log "${YELLOW}⚠ Warning: pdfplumber extractions not found, skipping archive step${NC}"
    SKIP_PDFPLUMBER=true
else
    SKIP_PDFPLUMBER=false
fi

# Step 2: Analyze MinerU structure
log_header "Step 2: Analyze MinerU Extraction Structure"

ANALYZE_DIR="$MINERU_SOURCE"
if [ "$SKIP_RENAME" = true ]; then
    ANALYZE_DIR="$MINERU_TARGET"
fi

MINERU_ROOT_COUNT=$(find "$ANALYZE_DIR" -maxdepth 1 -type d -not -name "chapter-*" -not -path "$ANALYZE_DIR" | wc -l)
MINERU_CHAPTER_COUNT=$(find "$ANALYZE_DIR"/chapter-* -name "*.md" -type f 2>/dev/null | wc -l || echo "0")
MINERU_TOTAL_MD=$(find "$ANALYZE_DIR" -name "*.md" -type f | wc -l)
MINERU_IMAGES=$(find "$ANALYZE_DIR" -type d -name "images" | wc -l)
MINERU_TOTAL_IMAGES=$(find "$ANALYZE_DIR" -type d -name "images" -exec find {} -type f \; | wc -l)

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

if [ "$SKIP_RENAME" = false ]; then
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
else
    log "${YELLOW}Skipping rename step${NC}"
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

{
  REPORT_PATH="$PROJECT_ROOT/EXTRACTION-CONSOLIDATION-REPORT.md"
  {
    echo "# PDF Extraction Consolidation Report"
    echo
    echo "**Date**: $(date '+%Y-%m-%d %H:%M:%S')"
    if [ "$SKIP_RENAME" = true ]; then
      echo "**Status**: ✅ Already Consolidated"
    else
      echo "**Status**: ✅ Completed Successfully"
    fi
    echo
    echo "## Actions"
    if [ "$SKIP_RENAME" = true ]; then
      echo "- MinerU extractions already located at \`literature/pdfs/extractions-mineru/\`"
    else
      echo "1. Renamed MinerU extractions"
      echo "   - From: \`literature/pdfs/extractions-baseline-no-formulas/\`"
      echo "   - To:   \`literature/pdfs/extractions-mineru/\`"
    fi
    if [ "$SKIP_PDFPLUMBER" = false ]; then
      echo "2. Archived pdfplumber extractions"
      echo "   - From: \`data/extracted-papers-simple/\`"
      echo "   - To:   \`data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/\`"
    else
      echo "- No pdfplumber directory found; archive step skipped"
    fi
    echo
    echo "## Extraction Statistics"
    echo
    echo "### MinerU (Primary Corpus)"
    echo "- **Location**: \`literature/pdfs/extractions-mineru/\`"
    echo "- **Total Papers**: $MINERU_ROOT_COUNT"
    echo "- **Markdown Files**: $MINERU_TOTAL_MD"
    echo "- **Extracted Images**: $MINERU_TOTAL_IMAGES"
    echo "- **Papers with Images**: $MINERU_IMAGES"
    echo
    echo "## Next Steps"
    echo "- Ensure analysis scripts reference \`literature/pdfs/extractions-mineru\`"
    echo "- Run quality validation if desired: \`tools/scripts/validate-extraction-quality.sh\`"
    echo
    echo "---"
    echo
    echo "*Generated by: \`tools/scripts/consolidate-pdf-extractions.sh\`*"
    echo "*Log file: \`$LOG_FILE\`*"
  } > "$REPORT_PATH"
}

log "Report saved: $PROJECT_ROOT/EXTRACTION-CONSOLIDATION-REPORT.md"

# Final summary
log_header "Consolidation Complete"
log "${GREEN}✓ MinerU extractions:${NC}      literature/pdfs/extractions-mineru/"
if [ "$SKIP_PDFPLUMBER" = false ]; then
  log "${GREEN}✓ pdfplumber backup:${NC}       data/ARCHIVE/extracted-papers-simple-$TIMESTAMP/"
else
  log "${YELLOW}⚠ No pdfplumber backup archived (source not found)${NC}"
fi
log "${GREEN}✓ Report created:${NC}          EXTRACTION-CONSOLIDATION-REPORT.md"
log ""
log "${YELLOW}Next: Update script paths and CLAUDE.md${NC}"
log "See report for detailed next steps."
log ""
log "Consolidation completed: $(date '+%Y-%m-%d %H:%M:%S')"
