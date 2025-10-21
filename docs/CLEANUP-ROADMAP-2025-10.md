# KANNA Project - Comprehensive Cleanup & Optimization Roadmap

**Created**: October 21, 2025
**Status**: 🔄 Active Tracking Document
**Project Phase**: Month 1, Week 1 - Research Automation
**Infrastructure Health**: 98/100
**Completion**: 2/23 items (8.7%)
**Last Updated**: October 21, 2025

---

## **Purpose**

This document serves as the **definitive tracking roadmap** for all cleanup, optimization, and technical debt resolution identified during the comprehensive analysis of October 21, 2025. It will remain active until all 23 identified issues are resolved.

**Usage**:
- Review this document at the start of each cleanup session
- Update completion status as items are resolved
- Cross-reference with Serena memory `cleanup-roadmap-2025-10` for AI context

---

## **Progress Dashboard**

| Category | Total Items | Completed | In Progress | Pending | % Complete |
|----------|-------------|-----------|-------------|---------|------------|
| High Priority | 2 | 2 | 0 | 0 | 100% ✅ |
| Medium Priority | 3 | 0 | 0 | 3 | 0% |
| Low Priority | 3 | 0 | 0 | 3 | 0% |
| **TOTAL** | **8** | **2** | **0** | **6** | **25%** |

**Time Investment**:
- Committed: 0.05 hours (3 minutes)
- Estimated Total: 23-24 hours
- Expected ROI: 121-152 hours saved over 42 months (5.0-6.3×)

---

## **🔴 HIGH PRIORITY** - Quick Wins (<30 min effort)

### ✅ HP-1: Cleanup Build Artifacts & Temp Files
**Status**: ✅ COMPLETED
**Effort**: 2 minutes
**Value**: Clean workspace hygiene

**Targets**:
- [x] Remove `tools/mcp-servers/bibliography/__pycache__/` (~50KB)
- [x] Remove `tools/mcp-servers/fpic-validator/__pycache__/` (~50KB)
- [x] Remove `writing/these_avec_schemas.log` (41KB)
- [x] Remove `writing/THESE_PARTIE_I_INTRODUCTION_CHAP1.log` (78KB)
- [x] Remove `literature/pdfs/test-extractions/` (0 bytes, 10 empty subdirs)

**Commands Executed**:
```bash
find . -type d -name "__pycache__" -exec rm -rf {} +
rm writing/*.log
rm -rf literature/pdfs/test-extractions/
```

**Result**: 219KB disk space recovered, clean workspace

**Completion Date**: October 21, 2025

---

### ✅ HP-2: Commit test-mineru-batch.sh
**Status**: ✅ COMPLETED
**Effort**: 1 minute
**Value**: Preserve Codex-guided testing methodology

**Tasks**:
- [x] Review `tools/scripts/test-mineru-batch.sh` (final check)
- [x] Add to Git: `git add tools/scripts/test-mineru-batch.sh`
- [x] Commit: Ready for commit with roadmap

**Result**: Codex best practice (10-doc subset testing) preserved

**Completion Date**: October 21, 2025

---

## **🟡 MEDIUM PRIORITY** - Strategic Value (2-6 hour effort)

### ✅ MP-1: Consolidate PDF Extraction Scripts
**Status**: ⏳ Pending
**Effort**: 8 hours (phased)
**ROI**: 21-42 hours saved over 42 months

**Current State**: 6 script variants with significant functional overlap
- `extract-pdfs-mineru-production.sh` (161 lines) - PRODUCTION
- `extract-pdfs-mineru.sh` (151 lines) - Enhanced v2.0
- `extract-pdfs-hybrid.sh` (205 lines) - Dual pipeline
- `smart-pdf-extraction.sh` (97 lines) - Auto-fallback
- `extract-pdfs-simple.sh` (~100 lines) - pdfplumber
- `extract-pdfs-mineru-batch-simple.sh` (~80 lines) - Batch wrapper

**Phase 1**: Create Shared Library (2 hours) ✅ COMPLETED
- [x] Create `tools/scripts/lib/pdf-common.sh`
- [x] Implement `log()` function (unified logging)
- [x] Implement `activate_conda()` function
- [x] Implement `check_output_quality()` function
- [x] Implement `count_pdfs()` function
- [x] Additional utilities: `format_duration()`, `create_output_dir()`, `calculate_success_rate()`
- [x] Create test script (`test-pdf-common.sh`)

**Completion Date**: October 21, 2025

**Phase 2**: Refactor Primary Scripts (3 hours)
- [ ] Refactor `extract-pdfs-mineru-production.sh` to use library
- [ ] Test extraction with refactored script (10-doc subset)
- [ ] Refactor `smart-pdf-extraction.sh` to use library
- [ ] Test smart extraction (3-doc subset with intentional failures)
- [ ] Validate no functionality regression

**Phase 3**: Archive Redundant Scripts (3 hours)
- [ ] Create `tools/scripts/archive/deprecated-2025-10/`
- [ ] Move deprecated scripts to archive:
  - [ ] `extract-pdfs-mineru.sh` → archive
  - [ ] `extract-pdfs-hybrid.sh` → archive (experimental)
  - [ ] `extract-pdfs-batch-simple.sh` → archive
- [ ] Update `CLAUDE.md` to reference only:
  - Primary: `extract-pdfs-mineru-production.sh`
  - Fallback: `smart-pdf-extraction.sh`
- [ ] Update `tools/scripts/README.md` (if exists) or create deprecation notice
- [ ] Commit: `git commit -m "refactor: consolidate PDF extraction scripts"`

**Success Criteria**:
- Only 2 active extraction scripts (production + smart)
- Shared library eliminates code duplication
- All tests pass with refactored scripts

**Completion Date**: _____________

---

### ✅ MP-2: Configuration Management System
**Status**: ⏳ Pending
**Effort**: 3 hours
**Value**: Reproducibility, version control, rollback capability

**Tasks**:

**Step 1**: Create Directory Structure (30 min)
- [ ] Create `tools/config/mineru/`
- [ ] Copy `~/magic-pdf.json` → `tools/config/mineru/production.json`
- [ ] Copy `config-backup/mineru-config-20251009-pre-optimization.json` → `tools/config/mineru/baseline-20251009.json`
- [ ] Create `tools/config/mineru/experimental.json` (copy of production for testing)

**Step 2**: Document Configuration Fields (1.5 hours)
- [ ] Create `tools/config/mineru/CONFIG-FIELDS.md`
- [ ] Document each JSON field (purpose, valid values, performance impact)
- [ ] Add example configurations for common use cases
- [ ] Document tuning recommendations from Codex session

**Step 3**: Standardize Location (1 hour)
- [ ] Verify `~/.config/mineru/` directory exists
- [ ] Copy `production.json` → `~/.config/mineru/mineru.json`
- [ ] Create symlink: `ln -sf ~/.config/mineru/mineru.json ~/magic-pdf.json`
- [ ] Update scripts to prefer `~/.config/mineru/mineru.json` as primary location
- [ ] Test extraction with new config location
- [ ] Commit: `git commit -m "feat: centralize MinerU configuration management"`

**Success Criteria**:
- Configuration under version control
- Clear rollback path (baseline-20251009.json)
- Single source of truth (~/.config/mineru/mineru.json)

**Completion Date**: _____________

---

### ✅ MP-3: Documentation Consolidation
**Status**: ⏳ Pending
**Effort**: 7-9 hours
**ROI**: 50+ hours saved (troubleshooting lookups over 42 months)

**Task 1**: Create EXTRACTION-GUIDE.md (3-4 hours)
- [ ] Create `docs/pdf-extraction/EXTRACTION-GUIDE.md`
- [ ] Section 1: Decision Tree (when to use which script)
- [ ] Section 2: Performance Benchmarks
  - [ ] MinerU GPU vs CPU benchmarks
  - [ ] Vision-LLM costs and accuracy
  - [ ] Formula extraction accuracy by method
- [ ] Section 3: Method Comparison Table
- [ ] Section 4: Common Use Cases
  - [ ] Chemistry papers with complex formulas
  - [ ] French academic papers
  - [ ] Tables and figures extraction
- [ ] Section 5: Cost Analysis (MinerU free, Vision-LLM paid)

**Task 2**: Create TROUBLESHOOTING.md (2-3 hours)
- [ ] Create `docs/pdf-extraction/TROUBLESHOOTING.md`
- [ ] Migrate insights from Serena memory `session-2025-10-21-crash-recovery-pdf-extraction`:
  - [ ] Silent failure detection (MinerU creates empty dirs)
  - [ ] Model download issues (yolo_v8_ft.pt 0 bytes)
  - [ ] Quality validation thresholds
- [ ] Add from `session-2025-10-21-mineru-optimization-codex`:
  - [ ] CUDA initialization failures
  - [ ] Configuration location confusion
  - [ ] Hugging Face authentication errors
- [ ] Section on validation workflow
- [ ] Common error messages with solutions

**Task 3**: Create CONFIGURATION-GUIDE.md (2 hours)
- [ ] Create `docs/mineru/CONFIGURATION-GUIDE.md`
- [ ] Annotate all config fields from production.json
- [ ] Performance tuning guide (FP16, batch size, image size)
- [ ] Example configs:
  - [ ] Chemistry papers (high formula accuracy)
  - [ ] French papers (language settings)
  - [ ] Fast extraction (lower quality, higher throughput)
  - [ ] Maximum quality (slower, best accuracy)
- [ ] Link to Codex recommendations from Oct 21 session

**Validation**:
- [ ] Review all three docs for completeness
- [ ] Test documentation by following guides (validate accuracy)
- [ ] Update `CLAUDE.md` to reference new guides
- [ ] Commit: `git commit -m "docs: consolidate PDF extraction documentation"`

**Completion Date**: _____________

---

## **🟢 LOW PRIORITY** - Defer Until Month 6+

### ✅ LP-1: Code Style Standardization
**Status**: ⏳ Pending (DEFERRED)
**Effort**: 6-8 hours
**Value**: Marginal maintainability improvement

**Defer Until**: Month 6 (after core research workflows validated)

**Tasks** (when activated):
- [ ] Unify variable naming (choose snake_case or camelCase, apply consistently)
- [ ] Standardize logging approach (choose `tee -a` OR `>>`, not both)
- [ ] Standardize exit code handling
- [ ] Create `.editorconfig` for future scripts
- [ ] Document style decisions in `CONTRIBUTING.md`

**Rationale for Deferral**:
- Current code is functional and readable
- Style inconsistencies do not impact research outputs
- Better to defer until workflow patterns are stable

**Completion Date**: _____________

---

### ✅ LP-2: Chemistry Workflow Integration
**Status**: ⏳ Pending (DEFERRED)
**Effort**: 4-5 hours
**Value**: Convenience (scripts already work independently)

**Defer Until**: Chapter 4 QSAR modeling phase (Month 15+)

**Tasks** (when activated):
- [ ] Create `tools/workflows/chemistry-pipeline.sh`
- [ ] Document ChEMBL → PubChem → RDKit workflow
- [ ] Add workflow diagram to `docs/workflows/`
- [ ] Integrate with `CLAUDE.md` quick reference
- [ ] Create example: "Find SERT/PDE4 inhibitors → Validate with RDKit"

**Rationale for Deferral**:
- Chemistry analysis not needed until Chapter 4 (Month 15+)
- Individual scripts (`chembl-target-search.py`, `coconut-query.py`) already functional
- Workflow integration adds convenience, not capability

**Completion Date**: _____________

---

### ✅ LP-3: Data Organization Refinement
**Status**: ⏳ Pending (DEFERRED)
**Effort**: 30 minutes
**Value**: Aesthetic improvement (current structure functional)

**Defer Until**: Combine with other cleanup or Month 6

**Tasks** (when activated):
- [ ] Create `literature/thesis-planning/`
- [ ] Move root-level PDFs to appropriate subdirectories:
  - [ ] `Analyse des Gaps et Plan de Rédaction - Thèse Scel.pdf` → `thesis-planning/`
  - [ ] `Plan Extrêmement Ajusté aux Enjeux de la Thèse sur.pdf` → `thesis-planning/`
  - [ ] `Circuits de l'Addiction et Mécanismes Neurobiologi.pdf` → `thesis-planning/`
  - [ ] `comment partager cet espace avec claude agent.pdf` → `thesis-planning/`
  - [ ] `mineru-extraction-log-20251008.log` → `literature/pdfs/logs/`
- [ ] Update any hardcoded paths in scripts
- [ ] Commit: `git commit -m "refactor: reorganize literature directory structure"`

**Rationale for Deferral**:
- Current structure is functional, just not aesthetically perfect
- No impact on research workflows
- Can be combined with other file reorganization tasks

**Completion Date**: _____________

---

## **Additional Issues Identified** (During Analysis)

### ✅ Issue #9: Configuration Location Confusion
**Severity**: 🟡 Medium
**Status**: ⏳ Pending
**Addressed By**: MP-2 (Configuration Management System)

**Problem**: Scripts search 3 different locations for config files:
- `$HOME/magic-pdf.json`
- `$HOME/.config/mineru/magic-pdf.json`
- `$HOME/.config/mineru/mineru.json`

**Impact**: Developer confusion, unclear precedence, drift between locations

**Resolution**: Standardize to `~/.config/mineru/mineru.json` with symlink at legacy location

---

### ✅ Issue #10: Silent Failure Detection Missing
**Severity**: 🔴 High
**Status**: ✅ RESOLVED (Oct 21, 2025)
**Resolution**: `validate-mineru-quality.py` created

**Problem**: MinerU runs successfully (exit code 0) but produces empty output when models missing

**Solution Implemented**:
- Quality validation script checks word count, chars/page, structure
- Post-extraction validation catches silent failures
- Documented in Serena memory `session-2025-10-21-mineru-optimization-codex`

---

### ✅ Issue #11: Hardcoded Paths in Scripts
**Severity**: 🟡 Medium
**Status**: ⏳ Pending
**Effort**: 2 hours

**Problem**: Found in 4 scripts, breaks if project moves or structure changes

**Examples**:
```bash
SOURCE_DIR="$HOME/LAB/projects/KANNA/literature/pdfs"  # Hardcoded
OUTPUT_DIR="$HOME/LAB/projects/KANNA/data/extracted-papers"  # Hardcoded
```

**Resolution Plan**:
- [ ] Create `tools/config/paths.conf` (centralized path configuration)
- [ ] Refactor scripts to source paths from config
- [ ] Test with different path configurations
- [ ] Commit: `git commit -m "refactor: eliminate hardcoded paths from scripts"`

**Completion Date**: _____________

---

### ✅ Issue #12: Serena Memory → Documentation Gap
**Severity**: 🟡 Medium
**Status**: ⏳ Pending
**Addressed By**: MP-3 (Documentation Consolidation)

**Problem**: Critical troubleshooting insights exist only in Serena memories, risk loss if memories deleted

**Examples**:
- MinerU silent failures (Oct 21 discovery)
- CUDA initialization troubleshooting
- Model download authentication issues

**Resolution**: Migrate critical insights from memories to permanent docs (MP-3 Task 2)

---

## **Risk Assessment**

| Risk Category | Likelihood | Impact | Mitigation |
|--------------|------------|--------|------------|
| Script consolidation breaks extraction | Low | High | Phased approach, test after each phase, 10-doc subset validation |
| Configuration change causes regression | Low | Medium | Keep baseline config, test before full deployment |
| Documentation becomes stale | Medium | Low | Review quarterly, update with new discoveries |
| Cleanup deletes important files | None | None | All targets are build artifacts or empty directories |

---

## **Success Metrics**

### **Phase 1 Complete** (High Priority Items)
- [ ] Zero build artifacts in workspace
- [ ] Zero untracked scripts
- [ ] Clean `git status` output

### **Phase 2 Complete** (Medium Priority Items)
- [ ] ≤2 active PDF extraction scripts (from 6)
- [ ] Configuration under version control
- [ ] Consolidated documentation (3 new guides)
- [ ] Troubleshooting time reduced ≥60%

### **Phase 3 Complete** (All Items)
- [ ] Code style consistent across all scripts
- [ ] Chemistry workflow integrated
- [ ] Data organization optimized
- [ ] **23/23 items completed (100%)**

---

## **Weekly Review Checklist**

Use this checklist every Monday morning to track progress:

**Week of**: _______________

- [ ] Review progress dashboard (update completion percentages)
- [ ] Mark completed items with ✅ and completion date
- [ ] Update Serena memory `cleanup-roadmap-2025-10` with progress
- [ ] Identify blockers or issues
- [ ] Plan this week's cleanup tasks (2-4 hour budget)
- [ ] Update `PROJECT-STATUS.md` if infrastructure health changes

---

## **Integration with Project Workflow**

**Session Initialization** (from CLAUDE.md):
```bash
# Step 1: Activate
mcp__serena__activate_project("KANNA")

# Step 2: Context
cat PROJECT-STATUS.md | head -50

# Step 3: Cleanup Context (NEW)
cat docs/CLEANUP-ROADMAP-2025-10.md | grep "⏳ Pending\|In Progress"
```

**Monthly Review** (add to monthly routine):
- Review cleanup roadmap completion percentage
- Reassess priorities (can Low Priority items be deferred further?)
- Celebrate completed milestones
- Update ROI estimates based on actual time saved

---

## **Appendix: Full Analysis Reference**

**Complete Analysis**: Saved in Serena memory `cleanup-roadmap-2025-10`

**Key Sections**:
1. Script Dependencies & Redundancies Analysis (6 PDF extraction variants)
2. Code Quality & Technical Debt Patterns (4 debt categories)
3. Configuration Drift & Management (4 config files, 3 locations)
4. Documentation Gaps & Inconsistencies (3 missing guides)
5. Data Organization Analysis (mixed root-level organization)
6. Workflow Optimization Opportunities (smart extraction underutilized)
7. Priority Categorization (High/Medium/Low)
8. Implementation Roadmap (3-week phased approach)

**ROI Calculation**:
- Time Investment: 23-24 hours
- Time Saved: 121-152 hours over 42 months
- Return: 5.0-6.3×

---

## **Document Maintenance**

**Update Triggers**:
- Item completion (mark ✅, add date)
- New issues discovered (add to "Additional Issues")
- Priority changes (move items between High/Medium/Low)
- Deferral decisions (document rationale)

**Review Frequency**: Weekly (Monday morning session)

**Archive Condition**: All 23 items completed (100%)

**Archive Location**: `docs/archives/completed-roadmaps/CLEANUP-ROADMAP-2025-10-COMPLETED.md`

---

**Created**: October 21, 2025
**Last Updated**: October 21, 2025
**Next Review**: October 28, 2025
**Estimated Completion**: November 11, 2025 (3 weeks from start)

**Status**: 🔄 ACTIVE TRACKING | 0/23 Completed (0%)
