# KANNA Project: Interactive Knowledge Base

**Version**: 2.0
**Generated**: October 21, 2025 (Post-Recovery)
**Project Health**: 98/100
**Phase**: Month 1, Week 1 - Research Automation Active

> **Purpose**: This is a dynamic, queryable knowledge base that complements the static PROJECT-INDEX.md. Use this for quick answers, workflow lookup, and cross-session context restoration.

---

## 🚀 Quick Answer Lookup

### "I need to..."

**...start a new session**
→ [Session Initialization Checklist](#session-initialization-checklist)

**...extract PDFs**
→ [PDF Extraction Workflow](#pdf-extraction-workflow-mineru-gpu)

**...run analysis for Chapter X**
→ [Chapter-Specific Workflows](#chapter-specific-analysis-workflows)

**...fix conda environment issues**
→ [Environment Troubleshooting](#environment-troubleshooting)

**...understand the automation strategy**
→ [4-Week Automation Plan](#research-automation-strategy-status)

**...check project status**
→ [Current Status Dashboard](#current-status-dashboard)

**...find a specific script**
→ [Script Inventory](#automation-script-inventory)

**...understand data privacy**
→ [FPIC & Privacy Guide](#fpic-data-privacy-guide)

---

## 📊 Current Status Dashboard

### Infrastructure Health: 98/100

**✅ OPERATIONAL** (100% healthy):
- All 3 conda environments (kanna, r-gis, mineru)
- CUDA GPU acceleration (PyTorch 2.6.0+cu124)
- Git workflow (milestone tagging active)
- Obsidian vault (created Oct 21, 2025)
- Backup system (automated daily)

**🔄 IN PROGRESS** (Week 1 active):
- Literature notes generation (`generate-lit-notes.py` - Days 4-5)
- Concept graph building (`build-concept-graph.py` - Days 6-7)
- Zotero Better BibTeX integration (Day 3 verification)

**📋 PLANNED** (Weeks 2-4):
- Analysis pipeline automation (Week 2)
- French writing workflow (Week 3)
- Integration & documentation (Week 4)

### Recent Activity (Last 48 Hours)

**Oct 21, 2025 - Infrastructure Recovery Session**:
- ✅ Fixed backup system (script path + log directory)
- ✅ Verified all conda environments operational
- ✅ Confirmed CUDA GPU working (resolved Oct 10 blocker)
- ✅ Created Obsidian vault structure
- ✅ Launched Week 1 automation
- ✅ Optimized Git workflow (tagged automation-week1-start)

**Git Commits**:
- `0392ef2` - Infrastructure recovery & automation Week 1 kickoff
- `bf22cfa` - Daily backup auto-commit
- `ca2b8a4` - PDF backup documentation (3-2-1 strategy)

**Memory Updates**:
- Created: `session-2025-10-21-recovery-and-automation-kickoff`
- Intact: `research-automation-strategy`, `kanna-conda-environments`

---

## 🎯 Session Initialization Checklist

**Every Session - 6-Step Boot Sequence**:

```bash
# 1. Activate Project
# (If using Serena MCP in Claude Code)
mcp__serena__activate_project("KANNA")

# 2. Navigate
cd ~/LAB/academic/KANNA

# 3. Check Status
git status
cat PROJECT-STATUS.md | head -50

# 4. Review Recent Activity
git log --oneline -5
tail -20 ~/LAB/logs/kanna-backup.log

# 5. Load Memories (if using Serena)
mcp__serena__list_memories()
# Read relevant memories based on task

# 6. Activate Environment
conda activate kanna      # Chemistry/ML work
conda activate r-gis      # Statistics/GIS work
conda activate mineru     # PDF extraction
```

**Success Indicators**:
- ✓ Serena shows "Active project: KANNA"
- ✓ Correct conda environment active
- ✓ Working tree clean or changes expected
- ✓ At least 1 memory loaded for context

---

## 🧬 Environment Quick Reference

### When to Use Which Environment

```
Your Task → Environment → Activation Command

QSAR modeling           → kanna  → conda activate kanna
GIS spatial analysis    → r-gis  → conda activate r-gis
Meta-analysis (clinical)→ r-gis  → conda activate r-gis
PDF extraction (GPU)    → mineru → conda activate mineru
NLP text mining         → kanna  → conda activate kanna
Bayesian statistics     → r-gis  → conda activate r-gis
Network analysis        → r-gis  → conda activate r-gis
Chemical descriptors    → kanna  → conda activate kanna
```

### Health Check Commands

**kanna**:
```bash
conda activate kanna
python -c "from rdkit import Chem; import pandas, numpy, sklearn; print('✓ OK')"
```

**r-gis**:
```bash
conda activate r-gis
Rscript -e "library(sf); library(brms); library(tidyverse); cat('✓ OK\n')"
```

**mineru**:
```bash
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
# Should print: CUDA: True
```

### Environment Troubleshooting

**Problem**: `conda: command not found`
**Solution**: `source ~/.zshrc && conda activate [env]`

**Problem**: RDKit import fails
**Solution**: `conda install -c conda-forge rdkit` (never pip)

**Problem**: R brms TBB errors
**Solution**: Use `library(brms)` not `library(rstan)`

**Problem**: CUDA unavailable
**Solution**: Check `nvidia-smi` (driver 550+), verify PyTorch CUDA build

---

## 📄 PDF Extraction Workflow (MinerU GPU)

### Quick Start

```bash
# 1. Activate environment
conda activate mineru

# 2. Verify CUDA
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
# Must show: True

# 3. Extract PDFs (production script)
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# 4. Check results
ls literature/pdfs/extractions-mineru/ | wc -l
# Should show: 142 directories
```

### Extraction Pipeline

```
Input:  literature/pdfs/BIBLIOGRAPHIE/*.pdf (142 papers)
  ↓
MinerU GPU Processing (10× faster than CPU)
  ↓
Output: literature/pdfs/extractions-mineru/[paper-name]/
  ├── auto/
  │   ├── [paper-name].md       # Full markdown
  │   ├── images/                # Extracted figures
  │   └── tables/                # Extracted tables
  └── [paper-name]_model.json   # Metadata
```

### Performance

- **GPU Mode**: ~30-60 seconds per paper
- **CPU Mode**: ~5-10 minutes per paper
- **Total (142 papers)**: ~2-3 hours (GPU) vs ~20-30 hours (CPU)

### Success Criteria

- ✓ 100% extraction success rate
- ✓ Markdown files contain text + structure
- ✓ Images extracted to `images/` subdirectory
- ✓ Tables extracted to `tables/` subdirectory
- ✓ Chemical formulas rendered (if ChemLLM available)

---

## 🔬 Chapter-Specific Analysis Workflows

### Chapter 2: Botanical Foundations (r-gis)

**Environment**: `conda activate r-gis`

**Scripts**:
```bash
# Spatial distribution mapping
Rscript analysis/r-scripts/ethnobotany/spatial-distribution.R

# Descriptive statistics
Rscript analysis/r-scripts/statistics/descriptive-stats.R
```

**Inputs**: `data/botanical/gis-maps/`, `data/botanical/specimens/`
**Outputs**: `assets/figures/chapter-02/`

---

### Chapter 3: Khoisan Ethnobotanical Heritage (r-gis)

**Environment**: `conda activate r-gis`

**Scripts**:
```bash
# Botanical Economic Index
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# Informant Consensus Factor
Rscript analysis/r-scripts/ethnobotany/calculate-icf.R

# Hypothesis testing
Rscript analysis/r-scripts/ethnobotany/hypothesis-testing.R
```

**Inputs**: `data/ethnobotanical/surveys/` (de-identified)
**Outputs**: `assets/figures/chapter-03/`, `analysis/r-scripts/ethnobotany/output/bei/`

**FPIC Note**: All interviews de-identified before analysis

---

### Chapter 4: Pharmacognosy & Neurobiology (kanna)

**Environment**: `conda activate kanna`

**Scripts**:
```bash
# QSAR modeling
python analysis/python/cheminformatics/qsar-modeling.py

# Molecular descriptors
python analysis/python/cheminformatics/molecular-descriptors.py

# SHAP interpretation
python analysis/python/ml-models/shap-interpretation.py
```

**Inputs**: `data/phytochemical/qsar-models/`, `data/molecular-modeling/structures/`
**Outputs**: `assets/figures/chapter-04/`, QSAR models with R² ≥ 0.70

**Targets**: 32 alkaloids, PDE4 inhibition, SERT modulation

---

### Chapter 5: Clinical Validation (r-gis)

**Environment**: `conda activate r-gis`

**Scripts**:
```bash
# Meta-analysis
Rscript analysis/r-scripts/meta-analysis/meta-analysis.R

# Forest plots
Rscript analysis/r-scripts/meta-analysis/forest-plots.R

# Publication bias
Rscript analysis/r-scripts/meta-analysis/publication-bias.R
```

**Inputs**: `data/clinical/trials/` (de-identified)
**Outputs**: `assets/figures/chapter-05/`, forest plots, funnel plots

**Success Criteria**: I² < 50%, publication bias assessed

---

### Chapter 6: Addiction & Neurodependence (kanna + r-gis)

**Phase 1 (kanna)**: Literature NLP
```bash
conda activate kanna
python analysis/python/text-mining/literature-nlp.py
```

**Phase 2 (r-gis)**: Meta-analysis
```bash
conda activate r-gis
Rscript analysis/r-scripts/meta-analysis/meta-analysis.R
```

**Inputs**: Literature corpus (RAG), preclinical studies
**Outputs**: PDE4 mechanism synthesis, clinical trial design

---

## 🔍 Research Automation Strategy (Status)

### 4-Week Timeline (Oct 22 - Nov 18, 2025)

| Week | Dates | Status | Progress | Deliverables |
|------|-------|--------|----------|--------------|
| **Week 1** | Oct 22-28 | 🚀 ACTIVE | 20% | Obsidian ✅, Zotero, Lit notes (142) |
| **Week 2** | Oct 29-Nov 4 | Pending | 0% | Analysis pipelines, Cross-validation |
| **Week 3** | Nov 5-11 | Pending | 0% | Writing workflow, French checker |
| **Week 4** | Nov 12-18 | Pending | 0% | Documentation, integration, buffer |

### Week 1 Detailed Status

**Completed (Oct 21)**:
- ✅ Obsidian vault structure (`writing/obsidian-notes/`)
- ✅ Configuration files (`workspace.json`, `app.json`)
- ✅ README documentation (200 lines)
- ✅ Infrastructure recovery (backup, conda, CUDA)

**In Progress**:
- 🔄 Day 3 (Oct 22): Zotero Better BibTeX verification
- 📋 Days 4-5: `generate-lit-notes.py` (MinerU → Obsidian)
- 📋 Days 6-7: `build-concept-graph.py` (Memory MCP entities)
- 📋 Day 8: Week 1 validation (142 notes, semantic search)

### Architecture Overview

```
Knowledge Acquisition
├─ MinerU → Markdown (142 papers) ✅
├─ Zotero Better BibTeX → kanna.bib ⏳
└─ RAG semantic search ✅

Knowledge Organization
├─ Obsidian vault + graph view ✅
├─ Memory MCP entity graph ⏳
└─ Automated tagging ⏳

Data Pipeline
├─ Collection → Analysis → Figure ⏳
├─ Cross-reference validation ⏳
└─ FPIC automated checks ⏳

Writing & Coherence
├─ Obsidian → Overleaf bridge ⏳
├─ French coherence checker ⏳
└─ Cross-chapter consistency ⏳
```

### ROI Projection

- **Investment**: 40 hours (Month 1)
- **Savings**: 200 hours (over 42 months)
- **ROI**: 5× return (160 hours net gain)

**What 160 Extra Hours Means**:
- 4 additional weeks of full-time writing
- 20+ additional papers read and synthesized
- 2 additional publications prepared
- More time for fieldwork and community engagement

---

## 📚 Automation Script Inventory

### Backup & Maintenance

| Script | Location | Purpose | Status |
|--------|----------|---------|--------|
| `daily-backup.sh` | `tools/scripts/` | 3-2-1 backup automation | ✅ Fixed Oct 21 |
| `encrypt-sensitive-data.sh` | `tools/scripts/` | AES-256 encryption (Tier 1) | ✅ Ready |

**Manual Setup Required**: Cron job for daily-backup.sh
```cron
0 2 * * * /home/miko/LAB/academic/KANNA/tools/scripts/daily-backup.sh >> ~/LAB/logs/kanna-backup.log 2>&1
```

### PDF Processing

| Script | Location | Purpose | Status |
|--------|----------|---------|--------|
| `extract-pdfs-mineru-production.sh` | `tools/scripts/` | GPU PDF extraction (MinerU) | ✅ Production |

### Literature Management

| Script | Location | Purpose | Status |
|--------|----------|---------|--------|
| `sync-zotero-bib.sh` | `tools/scripts/` | Bibliography validation | ✅ Ready |
| `generate-lit-notes.py` | `tools/scripts/` | MinerU → Obsidian converter | 📋 Week 1 D4-5 |
| `build-concept-graph.py` | `tools/scripts/` | Memory MCP entity extraction | 📋 Week 1 D6-7 |

### Academic Writing

| Script | Location | Purpose | Status |
|--------|----------|---------|--------|
| `check-grammar-french.sh` | `tools/scripts/` | Grammalecte batch checking | ✅ Ready |
| `analyze-citation-network.sh` | `tools/scripts/` | VOSviewer automation | ✅ Ready |
| `compile-thesis-pdf.sh` | `tools/scripts/` | LaTeX compilation | ✅ Ready |

### Data Query

| Script | Location | Purpose | Status |
|--------|----------|---------|--------|
| `chembl-target-search.py` | `tools/scripts/` | ChEMBL API (SERT, PDE4) | ✅ Ready |
| `coconut-query.py` | `tools/scripts/` | COCONUT natural products | ✅ Ready |

**Total**: 56 automation scripts (15 shell, 25 Python, 16 R)

---

## 🔐 FPIC & Data Privacy Guide

### Three-Tier Classification

**🔴 Tier 1: NEVER COMMIT** (Git-Excluded)
```
fieldwork/interviews-raw/**              # Raw audio + transcripts
data/ethnobotanical/interviews/*.wav     # Interview recordings
data/clinical/trials/**/patient-data/**  # Identifiable clinical data
*.env, credentials.json                  # API keys, credentials
```

**Protection**: `.gitignore` with directory wildcards (`**`)
**Encryption**: `tools/scripts/encrypt-sensitive-data.sh` (AES-256)

**🟡 Tier 2: LARGE FILES** (Git LFS)
```
*.raw, *.wiff, *.d/      # LC-MS data (>100 MB)
*.tif                     # High-res field photos
*.fastq, *.bam            # Genomic sequencing
```

**Storage**: External HDD (`/run/media/miko/AYA/`)

**🟢 Tier 3: VERSION CONTROLLED** (Git-Tracked)
```
data/ethnobotanical/surveys/*.csv        # De-identified surveys
analysis/**/*.{R|py}                     # Analysis scripts
assets/figures/**/*.png                  # Figures (300 DPI)
writing/thesis-chapters/**/*.tex         # LaTeX chapters
```

### FPIC Principles

1. **Data Sovereignty**: Khoisan communities retain IP rights
2. **Anonymization**: All interviews de-identified before analysis
3. **Benefit-Sharing**: Outputs shared with communities before publication
4. **No Commits Without FPIC**: Never commit sensitive data

### File Naming (FPIC-Compliant)

**Ethnobotanical**:
```
INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.txt
Example: INT-20250315-SC01-P007.txt
```

**Chemical Data**:
```
CHEM-{YYYYMMDD}-{BatchID}-{CompoundID}.csv
```

**GIS Field Data**:
```
FIELD-{YYYYMMDD}-{SiteCode}-{GPSID}.{shp|csv}
```

---

## 🎓 Setup Guides (8 Available)

| Guide | Location | Topics | Words |
|-------|----------|--------|-------|
| 01-literature-workflow | `tools/guides/` | Elicit → Zotero → Obsidian | 1,500 |
| 02-field-data-collection | `tools/guides/` | FPIC, GPS, interviews | 1,800 |
| 03-qualitative-analysis | `tools/guides/` | MAXQDA, NVivo | 1,200 |
| 04-qsar-pipeline | `tools/guides/` | RDKit → ML → SHAP | 2,000 |
| 05-french-writing | `tools/guides/` | Grammalecte, coherence | 1,500 |
| 06-mineru-pdf-extraction | `tools/guides/` | MinerU installation | 1,800 |
| 07-mineru-advanced | `tools/guides/` | ChemLLM, GPU tuning | 1,400 |
| 08-latex-ocr-integration | `tools/guides/` | Formula extraction | 900 |

**Total**: 12,100 words of setup documentation

---

## 📊 Quality Standards Quick Reference

### Figures (Publication-Ready)

**Requirements**:
- Resolution: 300 DPI minimum
- Fonts: ≥10pt at print size
- Colors: Colorblind-friendly (viridis, RColorBrewer)
- Location: `assets/figures/chapter-{XX}/`

**R (ggplot2)**:
```r
ggsave("assets/figures/chapter-03/figure.png", width=8, height=6, dpi=300)
```

**Python (matplotlib)**:
```python
plt.savefig("assets/figures/chapter-04/figure.png", dpi=300, bbox_inches='tight')
```

### Git Commits (Semantic)

**Format**: `type: description`

**Types**:
- `feat:` - New analysis, script, feature
- `fix:` - Bug fix
- `docs:` - Documentation or writing
- `refactor:` - Code restructuring
- `data:` - New de-identified data

**Examples**:
```bash
git commit -m "feat: add SHAP interpretation to QSAR model (Chapter 4)"
git commit -m "docs: draft Chapter 3 Section 3.4 (1200 words)"
```

---

## 🔗 External Integrations

### MCP Servers (13 Active)

**Tier 1 - CRITICAL**:
- **serena**: Project memory, symbol operations
- **filesystem**: File operations
- **git**: Version control

**Tier 2 - HIGH VALUE**:
- **sequential**: Complex reasoning
- **context7**: Library docs
- **memory**: Cross-session persistence
- **github**: GitHub API

**Tier 3 - SPECIALIZED**:
- **jupyter**: Notebook integration
- **rag-query**: 142-paper semantic search
- **fetch**: HTTP operations
- **cloudflare-browser**, **cloudflare-container**: Web scraping

**Health Check**: `/mcp` (should show 13/13 connected)

### Academic Tools

**Bibliography**: Zotero + Better BibTeX → Auto-export
**Knowledge Graph**: Obsidian → Graph view
**French Writing**: Grammalecte → Grammar checking
**Citation Network**: VOSviewer → Co-citation analysis

---

## 🆘 Troubleshooting Quick Fixes

### Conda Issues

**Problem**: `conda: command not found`
**Fix**: `source ~/.zshrc && conda activate [env]`

**Problem**: RDKit import fails
**Fix**: `conda install -c conda-forge rdkit` (never pip!)

**Problem**: R brms TBB errors
**Fix**: Use `library(brms)` not `library(rstan)`

### Backup Issues

**Problem**: Backup script fails
**Fix**: Check path in `tools/scripts/daily-backup.sh` (should be `~/LAB/academic/KANNA`)

**Problem**: Log directory missing
**Fix**: `mkdir -p ~/LAB/logs`

### Git Issues

**Problem**: Unclear which branch
**Fix**: `git status` + `git branch -a`

**Problem**: Commits not pushed
**Fix**: `git push origin main`

### CUDA Issues

**Problem**: CUDA unavailable
**Fix 1**: `nvidia-smi` (verify driver 550+)
**Fix 2**: `python -c "import torch; print(torch.version.cuda)"` (verify CUDA build)
**Fix 3**: System reboot (if persistent)

---

## 📖 Memory System Guide

### Memory Types

| Type | Lifespan | When to Read | Examples |
|------|----------|--------------|----------|
| **Strategic** | 3-6 months | Starting new features | research-automation-strategy |
| **Reference** | Permanent | Debugging, setup | kanna-conda-environments |
| **Historical** | 3-6 months | Troubleshooting | session-2025-10-21-recovery |
| **Configuration** | Until tools change | First-time tool usage | academic-tools-setup |

### Current Memories (Oct 21, 2025)

1. `kanna-conda-environments` (Reference) - Environment setup
2. `research-automation-strategy` (Strategic) - 4-week plan
3. `academic-tools-setup` (Configuration) - Tool procedures
4. `session-2025-10-21-recovery-and-automation-kickoff` (Historical) - Infrastructure fixes
5. `session-2025-10-18-dependency-installation` (Historical) - Dependency troubleshooting

### When to Create Memory

- Multi-hour setup (>2h)
- Strategic plan (affects multiple chapters)
- Complex problem (future reference value)

### Memory Access (Serena MCP)

```bash
# List available memories
mcp__serena__list_memories()

# Read specific memory
mcp__serena__read_memory("kanna-conda-environments")

# Create new memory
mcp__serena__write_memory("session-YYYY-MM-DD-topic", "content...")
```

---

## 🏁 Next Actions by Context

### "I'm starting Week 1 Day 3 work"
→ Verify Zotero Better BibTeX has ~142 entries
→ `cat literature/zotero-export/kanna.bib | grep -c "@"`

### "I want to extract more PDFs"
→ Activate mineru: `conda activate mineru`
→ Run production script: `bash tools/scripts/extract-pdfs-mineru-production.sh`

### "I need to run Chapter 3 analysis"
→ Activate r-gis: `conda activate r-gis`
→ Run BEI calculation: `Rscript analysis/r-scripts/ethnobotany/calculate-bei.R`

### "I want to check automation progress"
→ Read: `PROJECT-STATUS.md` (Research Automation section)
→ Week 1 timeline: Oct 22-28, currently Day 2 complete

### "I need to understand the vault structure"
→ Read: `writing/obsidian-notes/README.md`
→ Check directories: `ls -la writing/obsidian-notes/`

---

**Version**: 2.0
**Generated**: October 21, 2025 (Post-Recovery Session)
**Maintained By**: Infrastructure automation + session updates
**Next Update**: Week 1 completion (Oct 28, 2025)
