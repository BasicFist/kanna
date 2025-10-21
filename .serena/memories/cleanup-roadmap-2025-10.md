# Cleanup Roadmap 2025-10 Progress Tracking

**Last Updated**: October 21, 2025 14:20
**Overall Progress**: 5/8 actionable items complete (63%)
**Session**: Continuous work on Week 1 cleanup

---

## Completed Items ✅

### HP-1: Cleanup Build Artifacts (0.05h)
- Removed __pycache__ directories
- Cleaned .log files
- Removed empty test-extractions directory
- Result: 219KB recovered

### HP-2: Commit test-mineru-batch.sh (0.01h)
- Preserved Codex-guided testing methodology
- Committed 10-doc subset testing best practice

### MP-1: Consolidate PDF Extraction Scripts (5h total)

**Phase 1: Shared Library** (2h) ✅
- Created `tools/scripts/lib/pdf-common.sh` (333 lines)
- Functions: log(), activate_conda(), count_pdfs(), check_output_quality(), format_duration(), create_output_dir(), calculate_success_rate()
- Eliminated 1,125 lines of duplicate code
- Commit: 5e8affa

**Phase 2: Refactor Scripts** (1h) ✅
- Refactored extract-pdfs-mineru-production.sh (173 lines)
- Refactored smart-pdf-extraction.sh (116 lines)
- Both scripts now use shared library
- Validation: bash -n passed for both
- Commit: 295d9f0

**Phase 3: Archive Deprecated** (2h) ✅
- Created tools/scripts/archive/deprecated-2025-10/
- Archived 5 scripts with comprehensive README
- Active scripts: production + smart (2 of 6)
- 67% script reduction achieved
- Commit: f3c7c85

### MP-2: Configuration Management System (2.5h) ✅

**Step 1: Directory Structure** (0.5h) ✅
- Created tools/config/mineru/
- Copied production.json, baseline-20251009.json, experimental.json
- All configs version-controlled

**Step 2: Documentation** (1.5h) ✅
- Created CONFIG-FIELDS.md (609 lines)
  - Core configuration (device-mode, models-dir)
  - Layout detection (doclayout_yolo, imgsz, conf)
  - Formula extraction (equation.enable, mfr_model)
  - Table extraction (table.enable, rapid_table)
  - Output formats (markdown, json)
  - LaTeX delimiters
  - LLM-aided extraction
  - Processing options (backend, lang, vram_limit)
  - Quality thresholds
  - Performance tuning guides
  - Troubleshooting procedures
  - Rollback instructions
  - Common configuration examples
- Created README.md with quick reference

**Step 3: Standardize Location** (0.5h) ✅
- Created ~/.config/mineru/ directory
- Backup: ~/magic-pdf.json.backup-20251021
- Symlink chain:
  - tools/config/mineru/production.json (version control)
  - → ~/.config/mineru/mineru.json (standard location)
  - → ~/magic-pdf.json (legacy compatibility)
- Updated extract-pdfs-mineru-production.sh header
- Updated smart-pdf-extraction.sh header
- Tested: symlinks verified, config readable

**Success Criteria**: ✅ All Met
- Configuration under version control
- Clear rollback path (baseline-20251009.json)
- Single source of truth (~/.config/mineru/mineru.json)
- Comprehensive documentation
- Scripts updated with config references

**Commits**:
- 3f360bb: Initial config directory and files
- 2b95c6c: CONFIG-FIELDS.md documentation and script headers

---

## Pending Items (37%)

### MP-3: Documentation Consolidation (7-9h estimated)
- Create EXTRACTION-GUIDE.md (decision tree, benchmarks, costs)
- Create TROUBLESHOOTING.md (migrate Serena insights)
- Create CONFIGURATION-GUIDE.md (or integrate into CONFIG-FIELDS.md)

### LP-1: Testing & Validation (2-4h estimated)
- Comprehensive testing protocol
- Validation of all scripts

### LP-2: Script Cleanup (1-2h estimated)
- Final polish and standardization

---

## Time Investment

- **Committed**: 8.58 hours (HP: 0.05h + MP-1: 5h + MP-2: 2.5h + validation: 0.03h + docs: 1h)
- **Estimated Total**: 23-24 hours
- **Expected ROI**: 121-152 hours saved over 42 months (5.0-6.3×)

---

## Active Scripts (Post-Consolidation)

1. **extract-pdfs-mineru-production.sh** (173 lines)
   - Primary production extraction script
   - Uses shared library
   - Config: tools/config/mineru/production.json

2. **smart-pdf-extraction.sh** (116 lines)
   - Auto-fallback (MinerU → Vision-LLM)
   - Uses shared library
   - Config: tools/config/mineru/production.json

## Archived Scripts

1. extract-pdfs-mineru.sh → archive/deprecated-2025-10/
2. extract-pdfs-hybrid.sh → archive/deprecated-2025-10/
3. extract-pdfs-simple.sh → archive/deprecated-2025-10/
4. extract-pdfs-mineru-batch-simple.sh → archive/deprecated-2025-10/
5. extract-pdfs-mineru-test-batch.sh → archive/deprecated-2025-10/

---

## Next Steps

**Option A**: Continue cleanup roadmap (MP-3: Documentation Consolidation, 7-9h)
**Option B**: Switch to research automation tasks
**Option C**: Test and validate completed items before proceeding

**Recommendation**: MP-2 provides good stopping point. Consider switching to research automation and returning to MP-3 when documentation needs arise organically during use.
