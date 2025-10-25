# Deprecated PDF Extraction Scripts Archive

**Archive Date**: October 21, 2025
**Reason**: Script consolidation (MP-1 Phase 3)
**Cleanup Roadmap**: docs/CLEANUP-ROADMAP-2025-10.md

---

## Purpose

This directory contains deprecated PDF extraction scripts that have been superseded by refactored versions using the shared `lib/pdf-common.sh` library.

## Active Scripts (Post-Consolidation)

**Primary Extraction**:
- `extract-pdfs-mineru-production.sh` - Production script (refactored, uses shared library)
- `smart-pdf-extraction.sh` - Auto-fallback script (MinerU → Vision-LLM)

**Configuration & Utilities** (kept active):
- `configure-mineru-kilo.sh` - Kilo API configuration
- `configure-mineru-llm.sh` - LLM configuration
- `download-mineru-models.sh` - Model download utility
- `mineru-to-obsidian-auto.sh` - Post-processing for Obsidian
- `test-mineru-batch.sh` - Testing utility (10-doc subset)

---

## Archived Scripts

### 1. extract-pdfs-mineru.sh (150 lines)
**Status**: Superseded by `extract-pdfs-mineru-production.sh`
**Reason**: Enhanced v2.0, but not refactored with shared library
**Last Known Good**: October 2025

**Differences from production script**:
- No shared library integration
- Manual logging with echo/tee
- Manual PDF counting and success rate calculation
- Slightly different config search logic

**Restore If**: Need historical reference for extraction methodology

---

### 2. extract-pdfs-hybrid.sh (204 lines)
**Status**: Experimental, not production-ready
**Reason**: Dual pipeline approach (MinerU + pdfplumber) not needed
**Last Known Good**: October 2025

**Features**:
- Runs both MinerU and pdfplumber in parallel
- Compares outputs and selects better result
- Higher complexity, marginal benefit

**Restore If**: Research requires comparing extraction methods

---

### 3. extract-pdfs-simple.sh (108 lines)
**Status**: Workaround, superseded by MinerU
**Reason**: pdfplumber-based extraction, lower quality than MinerU
**Last Known Good**: October 2025

**Use Case**:
- Fallback when MinerU not available
- Simple text extraction without formula/table support

**Restore If**: MinerU unavailable and simple text extraction needed

---

### 4. extract-pdfs-mineru-batch-simple.sh (79 lines)
**Status**: Simple wrapper, functionality integrated
**Reason**: Batch functionality now in production script
**Last Known Good**: October 2025

**Features**:
- Basic batch processing wrapper
- Minimal error handling
- No quality validation

**Restore If**: Need minimal batch wrapper example

---

### 5. extract-pdfs-mineru-test-batch.sh (110 lines)
**Status**: Superseded by `test-mineru-batch.sh`
**Reason**: Newer test script committed in HP-2
**Last Known Good**: October 2025

**Features**:
- Older test batch script
- Similar functionality to newer version

**Restore If**: Need historical test methodology

---

## Restoration Instructions

If you need to restore any archived script:

```bash
# Copy back to scripts directory
cp tools/scripts/archive/deprecated-2025-10/<script-name> tools/scripts/

# Make executable
chmod +x tools/scripts/<script-name>

# Review before use (may need updates)
bash -n tools/scripts/<script-name>
```

**Warning**: Archived scripts are NOT maintained and may not work with current environment configurations.

---

## Migration Notes

**Code Duplication Eliminated**:
- 6 scripts → 2 active scripts (67% reduction)
- Shared library centralizes: logging, conda activation, PDF counting, quality checks, duration formatting
- Maintenance burden reduced from 6× to 1× (shared library)

**ROI**:
- Time Investment: 5 hours (Phase 1 + 2 + 3)
- Time Saved: 21-42 hours over 42 months (maintenance reduction)
- Return: 4.2-8.4× investment

---

**Archived By**: Claude Code (MP-1 Phase 3)
**Reference**: docs/CLEANUP-ROADMAP-2025-10.md
**Shared Library**: tools/scripts/lib/pdf-common.sh
**Active Scripts**: tools/scripts/extract-pdfs-mineru-production.sh, tools/scripts/smart-pdf-extraction.sh
