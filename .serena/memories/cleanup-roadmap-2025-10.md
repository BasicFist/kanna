# KANNA Cleanup Roadmap - Strategic Technical Debt Resolution

**Type**: Strategic (Long-term Reference)  
**Created**: October 21, 2025  
**Last Updated**: October 21, 2025 (Phase 2 Complete)  
**Lifespan**: Until all items completed (estimated 2 more weeks)  
**Status**: Active Tracking - 38% Complete

---

## Purpose

This memory provides AI context for the comprehensive cleanup and optimization roadmap created October 21, 2025. It serves as persistent reference across sessions until all identified technical debt is resolved.

**Human-Readable Document**: `docs/CLEANUP-ROADMAP-2025-10.md` (detailed tracking)

---

## Current Progress Summary

**Overall**: 3/8 actionable items completed (38%)

### ✅ HIGH PRIORITY - COMPLETE (100%)
- **HP-1**: Build artifacts cleaned (2 min) ✅
- **HP-2**: test-mineru-batch.sh committed (1 min) ✅

### 🔄 MEDIUM PRIORITY - IN PROGRESS (33%)
- **MP-1 Phase 1**: Shared library created (2 hours) ✅
- **MP-1 Phase 2**: Primary scripts refactored (1 hour) ✅
- **MP-1 Phase 3**: Archive redundant scripts (3 hours) ⏳ PENDING
- **MP-2**: Configuration management (3 hours) ⏳ PENDING
- **MP-3**: Documentation consolidation (7-9 hours) ⏳ PENDING

### ⏸️ LOW PRIORITY - DEFERRED
- **LP-1**: Code style standardization (6-8 hours) - Deferred to Month 6
- **LP-2**: Chemistry workflow integration (4-5 hours) - Deferred to Month 15+
- **LP-3**: Data organization (30 min) - Deferred to Month 6

---

## Phase 2 Accomplishments (October 21, 2025)

### Scripts Refactored
1. **extract-pdfs-mineru-production.sh** (161 lines)
   - ✅ All logging migrated to `log()` function
   - ✅ Directory creation via `create_output_dir()`
   - ✅ PDF counting via `count_pdfs()`
   - ✅ Success rate via `calculate_success_rate()`
   - ✅ Duration tracking via `format_duration()`
   - ✅ Path fix: `LAB/projects/KANNA` → `LAB/academic/KANNA`
   - ✅ Enhanced startup log with config and binary info

2. **smart-pdf-extraction.sh** (97 lines)
   - ✅ All logging migrated to `log()` function
   - ✅ Directory creation via `create_output_dir()`
   - ✅ Quality check via `check_output_quality()`
   - ✅ Duration tracking for both stages
   - ✅ Improved error levels (INFO/WARN/ERROR)
   - ✅ Timing for both successful and failed extractions

### Shared Library Usage
**7 Functions Deployed**:
- `log()` - Unified colored, timestamped logging
- `activate_conda()` - Safe environment activation
- `count_pdfs()` - Directory PDF counting
- `check_output_quality()` - Extraction validation
- `format_duration()` - Human-readable time
- `create_output_dir()` - Safe directory creation
- `calculate_success_rate()` - Success percentage

### Validation Results
- ✅ Syntax: Both scripts pass `bash -n` check
- ✅ Library: All 7 functions available and tested
- ✅ count_pdfs(): Verified 142 PDFs in BIBLIOGRAPHIE
- ✅ format_duration(): 3665s → 1h 1m 5s
- ✅ calculate_success_rate(): 85/100 → 85%
- ✅ check_output_quality(): Integrated into smart extraction

---

## Next Actions (Phase 3 - Week 3)

### MP-1 Phase 3: Archive Redundant Scripts (3 hours)
**Target**: Reduce from 6 scripts → 2 active scripts

**Steps**:
1. Create archive directory: `tools/scripts/archive/deprecated-2025-10/`
2. Move to archive:
   - `extract-pdfs-mineru.sh` (superseded by production.sh)
   - `extract-pdfs-hybrid.sh` (experimental, not needed)
   - `extract-pdfs-batch-simple.sh` (simple wrapper)
   - Possibly: `extract-pdfs-simple.sh` (pdfplumber workaround)
3. Keep active:
   - `extract-pdfs-mineru-production.sh` (primary)
   - `smart-pdf-extraction.sh` (auto-fallback)
4. Update documentation references
5. Commit: `git commit -m "refactor: consolidate PDF extraction scripts"`

### MP-2: Configuration Management System (3 hours)
**Target**: Centralize config, enable version control

**Steps**:
1. Create `tools/config/mineru/production.json`
2. Create `tools/config/mineru/baseline-20251009.json`
3. Create `tools/config/mineru/CONFIG-FIELDS.md`
4. Symlink `~/.config/mineru/mineru.json` → production.json
5. Update scripts to use centralized config
6. Commit config to version control

### MP-3: Documentation Consolidation (7-9 hours)
**Target**: 3 comprehensive guides

**Documents to Create**:
1. `docs/pdf-extraction/EXTRACTION-GUIDE.md` (3-4 hours)
   - Decision tree for script selection
   - Performance benchmarks (GPU vs CPU)
   - Cost analysis (MinerU free vs Vision-LLM paid)
   
2. `docs/pdf-extraction/TROUBLESHOOTING.md` (2-3 hours)
   - Migrate Serena memory insights
   - Silent failure detection
   - CUDA initialization issues
   - Model download problems
   
3. `docs/mineru/CONFIGURATION-GUIDE.md` (2 hours)
   - Annotate all JSON config fields
   - Performance tuning recommendations
   - Example configurations

---

## Time Investment Summary

**Committed**: 3.08 hours
- HP-1 + HP-2: 0.05 hours
- MP-1 Phase 1: 2 hours
- MP-1 Phase 2: 1 hour
- Validation: 0.03 hours

**Remaining**: 19.92 hours
- MP-1 Phase 3: 3 hours
- MP-2: 3 hours
- MP-3: 7-9 hours
- Low Priority (deferred): 10.5-13.5 hours

**Expected ROI**: 121-152 hours saved over 42 months (5.0-6.3×)

---

## Success Metrics

### Phase 2 ✅ ACHIEVED
- ✅ 2/6 primary scripts refactored
- ✅ Shared library integrated
- ✅ All library functions validated
- ✅ No functionality regression

### Phase 3 (Next)
- [ ] ≤2 active PDF extraction scripts (from 6)
- [ ] Configuration under version control
- [ ] 3 consolidated documentation guides
- [ ] Troubleshooting time reduced ≥60%

---

## Integration with Session Workflow

**When to Read This Memory**:
- Session initialization (after PROJECT-STATUS.md)
- Before cleanup work
- Weekly review (Monday mornings)
- After discovering new technical debt

**Update Triggers**:
- Phase completion (mark in human doc + this memory)
- New issues discovered (add to roadmap)
- Priority changes (document rationale)

**Archive Condition**: All items completed (100%)

---

## Related Memories

**Reference**: 
- `kanna-conda-environments` - Environment strategy (permanent)
- `session-2025-10-21-crash-recovery-pdf-extraction` - Silent failure discovery
- `session-2025-10-21-mineru-optimization-codex` - Codex troubleshooting

**Update**: This memory updated after Phase 2 completion

---

**Created**: October 21, 2025  
**Status**: Active Tracking (3/8 completed, 38%)  
**Next Phase**: MP-1 Phase 3 (Archive Scripts)  
**Next Review**: October 28, 2025  
**Human Doc**: docs/CLEANUP-ROADMAP-2025-10.md
