# KANNA Project - Complete Documentation Index

**Last Updated**: October 2025
**Project**: *Sceletium tortuosum* Interdisciplinary PhD Thesis (42 months)
**Status**: Month 1 - Infrastructure Complete

---

## 📖 Quick Navigation

**Getting Started**:
- [README.md](../README.md) - Project overview and thesis structure
- [QUICK-START.md](../QUICK-START.md) - Fast onboarding for new sessions
- [CLAUDE.md](../CLAUDE.md) - Complete instructions for Claude Code (12,000+ words)
- [PROJECT-STATUS.md](../PROJECT-STATUS.md) - Current progress tracker

**Core Documentation**:
- [ARCHITECTURE.md](../ARCHITECTURE.md) - Complete architectural reference (39KB, 1,000+ lines)
- [AGENTS.md](../AGENTS.md) - MCP server and agent configuration
- [OPTIMIZED-THESIS-WORKFLOW.md](../OPTIMIZED-THESIS-WORKFLOW.md) - Research workflow patterns

**Infrastructure**:
- [MCP Configuration](#mcp-server-integration) - 15 servers configured (production-ready)
- [Environment Setup](#conda-environments) - Three-environment strategy (kanna, r-gis, mineru)
- [Academic Tools](#academic-enhancement-stack) - French writing, bibliography, citation analysis

---

## 📂 Project Structure

### Root Directory

```
KANNA/
├── analysis/           # Research analysis scripts (Python, R, Jupyter)
├── assets/             # Figures, tables, supplementary materials
├── collaboration/      # Ethics, partnerships, FPIC protocols
├── config/             # Project configuration files
├── data/               # Research data (de-identified, FPIC-compliant)
├── docs/               # Infrastructure documentation
├── literature/         # 142-paper corpus, PDFs, extractions
├── tools/              # Scripts, guides, academic tools
├── writing/            # Thesis chapters, drafts, references
├── .serena/            # Serena MCP project memories
└── .mcp.json           # MCP server configuration
```

### Key Directories

**Analysis** (`analysis/`):
- `python/` - Cheminformatics (RDKit), ML (scikit-learn), NLP (spaCy)
  - `cheminformatics/qsar-modeling.py` - QSAR modeling (Chapter 4)
  - `ml-models/` - Machine learning models
  - `text-mining/` - Literature analysis
- `r-scripts/` - Statistics, GIS, meta-analysis
  - `ethnobotany/calculate-bei.R` - BEI calculation (Chapter 3)
  - `meta-analysis/` - Clinical trials meta-analysis (Chapter 5)
  - `statistics/` - Bayesian statistics, spatial analysis
- `jupyter-notebooks/` - Interactive analysis and visualization

**Data** (`data/`):
- `botanical/` - GIS maps, specimens, taxonomy data
- `clinical/` - Pharmacokinetics, safety, trials (de-identified)
- `ethnobotanical/` - Surveys, interviews (FPIC-compliant), protocols
- `molecular-modeling/` - ADMET, docking, structures
- `phytochemical/` - LC-MS/MS, alkaloid profiles
- `legal/` - Patents, treaties, benefit-sharing models

**Literature** (`literature/`):
- `pdfs/BIBLIOGRAPHIE/` - 142 papers (2.0 GB)
- `pdfs/extractions-mineru/` - MinerU GPU extractions (markdown + images)
- `pdfs/PILOT-20/` - Core 20 papers (archived)
- `zotero-export/` - Zotero bibliography export

**Tools** (`tools/`):
- `scripts/` - 30+ utility scripts (backup, extraction, analysis)
- `guides/` - 8 comprehensive setup guides (1,670+ lines)
- `languagetool/` - French grammar checking (LanguageTool 6.4)
- `Obsidian-1.7.7.AppImage` - Knowledge vault

**Writing** (`writing/`):
- `thesis-chapters/` - LaTeX chapters (8 chapters)
- `obsidian-notes/` - Personal knowledge graph (planned)
- `references.bib` - Zotero bibliography export
- `plan-these-sceletium-complet.md` - Complete thesis plan

---

## 📚 Documentation Map

### Core Documentation (Root Directory)

| File | Purpose | Size | Last Updated |
|------|---------|------|--------------|
| [CLAUDE.md](../CLAUDE.md) | Complete Claude Code instructions | 12,000+ words | Oct 2025 |
| [ARCHITECTURE.md](../ARCHITECTURE.md) | Comprehensive architectural reference | 39KB (1,000+ lines) | Oct 2025 |
| [README.md](../README.md) | Project overview, thesis structure | 5,000+ words | Oct 2025 |
| [PROJECT-STATUS.md](../PROJECT-STATUS.md) | Current progress tracker | Weekly updates | Oct 2025 |
| [QUICK-START.md](../QUICK-START.md) | Fast onboarding guide | 2,000+ words | Oct 2025 |
| [AGENTS.md](../AGENTS.md) | MCP server and agent configuration | 3,000+ words | Oct 2025 |
| [OPTIMIZED-THESIS-WORKFLOW.md](../OPTIMIZED-THESIS-WORKFLOW.md) | Research workflow patterns | 4,000+ words | Oct 2025 |

### Infrastructure Documentation (`docs/`)

**MCP Configuration**:
- [MCP-CONFIGURATION.md](./MCP-CONFIGURATION.md) - Quick reference
- [MCP-CONFIGURATION-AUDIT.md](./MCP-CONFIGURATION-AUDIT.md) - Comprehensive 13,000-word audit
- [MCP-CONFIGURATION-CHANGELOG.md](./MCP-CONFIGURATION-CHANGELOG.md) - Optimization history

**Academic Tools**:
- [ACADEMIC-TOOLS-IMPLEMENTATION.md](./ACADEMIC-TOOLS-IMPLEMENTATION.md) - 20,000-word complete guide
- [ACADEMIC-PLUGINS-SETUP.md](./ACADEMIC-PLUGINS-SETUP.md) - VoltAgent marketplace plugins
- [INSTALLATION-SUMMARY-2025-10-18.md](./INSTALLATION-SUMMARY-2025-10-18.md) - Recent installation report

**Plugin Integration**:
- [PLUGIN-INTEGRATION-PLAN.md](./PLUGIN-INTEGRATION-PLAN.md) - 63-page comprehensive plan
- [PLUGIN-INTEGRATION-SUMMARY.md](./PLUGIN-INTEGRATION-SUMMARY.md) - Executive summary
- [PLUGIN-VALIDATION-LOG.md](./PLUGIN-VALIDATION-LOG.md) - Security review templates

**Infrastructure Reports**:
- [AUDIT-REPORT-2025-10-10.md](./AUDIT-REPORT-2025-10-10.md) - System audit
- [CLEANUP-REPORT-2025-10-10.md](./CLEANUP-REPORT-2025-10-10.md) - Cleanup summary
- [SECURITY-API-KEY-ROTATION.md](./SECURITY-API-KEY-ROTATION.md) - API key security

**MinerU & PDF Extraction** (`docs/mineru/`):
- [MINERU-CONFIGURATION-ANALYSIS.md](./mineru/MINERU-CONFIGURATION-ANALYSIS.md)
- [MINERU-QUICK-ACTION-GUIDE.md](./mineru/MINERU-QUICK-ACTION-GUIDE.md)
- [MINERU-TEST-EXTRACTION-REPORT.md](./mineru/MINERU-TEST-EXTRACTION-REPORT.md)
- [MINERU-QUALITY-REPORT.md](./mineru/MINERU-QUALITY-REPORT.md)
- [MINERU-ENVIRONMENT.md](./mineru/MINERU-ENVIRONMENT.md)

**Environment Setup** (`docs/infrastructure/`):
- [TWO-ENVIRONMENT-ARCHITECTURE.md](./infrastructure/TWO-ENVIRONMENT-ARCHITECTURE.md)
- [r-environment-setup.md](./infrastructure/r-environment-setup.md)
- [CUDA-FIX-GUIDE.md](./infrastructure/CUDA-FIX-GUIDE.md)
- [CUDA-FIX-STATUS.md](./infrastructure/CUDA-FIX-STATUS.md)

### Setup Guides (`tools/guides/`)

**Complete Setup Guide Series** (1,670+ lines total):

| # | Guide | Purpose | Chapters | Lines |
|---|-------|---------|----------|-------|
| 01 | [literature-workflow-setup.md](../tools/guides/01-literature-workflow-setup.md) | Elicit → Zotero → Obsidian → Overleaf | All | 287 |
| 02 | [field-data-collection-setup.md](../tools/guides/02-field-data-collection-setup.md) | SurveyCTO FPIC surveys | 3 | 239 |
| 03 | [qualitative-analysis-setup.md](../tools/guides/03-qualitative-analysis-setup.md) | MAXQDA coding | 3 | 205 |
| 04 | [qsar-pipeline-setup.md](../tools/guides/04-qsar-pipeline-setup.md) | RDKit → scikit-learn → SHAP | 4 | 276 |
| 05 | [french-writing-setup.md](../tools/guides/05-french-writing-setup.md) | Overleaf + Antidote | All | 193 |
| 06 | [mineru-pdf-extraction-setup.md](../tools/guides/06-mineru-pdf-extraction-setup.md) | MinerU GPU extraction | All | 243 |
| 07 | [mineru-advanced-enhancements.md](../tools/guides/07-mineru-advanced-enhancements.md) | Advanced MinerU config | All | 152 |
| 08 | [latex-ocr-integration.md](../tools/guides/08-latex-ocr-integration.md) | LaTeX-OCR formulas | 4 | 75 |

### Session Handoffs & Legacy Documentation

**Active Handoffs**:
- [SESSION-HANDOFF.md](../SESSION-HANDOFF.md) - Current session handoff
- [HANDOFF-NEXT-SESSION.md](./HANDOFF-NEXT-SESSION.md) - Next session planning

**Historical Status**:
- [IMPLEMENTATION-STATUS-2025-10-03.md](../IMPLEMENTATION-STATUS-2025-10-03.md)
- [EXTRACTION-CONSOLIDATION-REPORT.md](../EXTRACTION-CONSOLIDATION-REPORT.md)
- [LATEX-OCR-CHECKPOINT.md](../LATEX-OCR-CHECKPOINT.md)
- [VLLM-RAG-SUMMARY.md](../VLLM-RAG-SUMMARY.md)

**Archives** (`docs/archives/`):
- Legacy Phase 3 optimization documents (removed October 10, 2025)
- Historical extraction method evaluations
- Deprecated tool configurations

---

## 🛠️ Scripts & Tools Reference

### Utility Scripts (`tools/scripts/`)

**PDF Extraction**:
- `extract-pdfs-mineru-production.sh` - ✅ **Production** (GPU-accelerated, 100% success)
- `extract-pdfs-mineru-batch-simple.sh` - Batch extraction wrapper
- `extract-pdfs-hybrid.sh` - Hybrid fallback approach
- `extract-pdfs-pdfplumber.py` - Legacy pdfplumber method
- `consolidate-pdf-extractions.sh` - Merge multiple extraction outputs

**Academic Writing**:
- `check-grammar-french.sh` - LanguageTool French grammar checking
- `compile-thesis-pdf.sh` - LaTeX compilation
- `analyze-citation-network.sh` - VOSviewer citation analysis

**Data Management**:
- `daily-backup.sh` - ✅ **Automated** (2 AM cron, 3-2-1 backup strategy)
- `encrypt-sensitive-data.sh` - AES-256 encryption for FPIC compliance
- `sync-zotero-bib.sh` - Bibliography validation and git commit

**Data Collection**:
- `chembl-target-search.py` - ChEMBL database queries (SERT, PDE4)
- `coconut-query.py` - COCONUT natural products database

**MinerU Configuration**:
- `configure-mineru-llm.sh` - LLM backend configuration
- `configure-mineru-kilo.sh` - KILO API integration
- `download-mineru-models.sh` - Model downloads

**Installation**:
- `setup-languagetool.sh` - LanguageTool automated setup
- `install-latex-ocr.sh` - LaTeX-OCR installation

### Analysis Scripts

**Python** (`analysis/python/`):
- `cheminformatics/qsar-modeling.py` - QSAR modeling (RDKit + scikit-learn + SHAP)
- `ml-models/` - Machine learning pipelines
- `text-mining/` - NLP analysis (spaCy, BERT)

**R** (`analysis/r-scripts/`):
- `ethnobotany/calculate-bei.R` - BEI calculation (Chapter 3)
- `install-packages.R` - R package installation script
- `meta-analysis/` - Clinical trials meta-analysis (metafor)
- `statistics/` - Bayesian statistics (brms), GIS (sf)

---

## 🧬 Conda Environments

### Three-Environment Strategy

Critical design: Separate environments to avoid dependency conflicts.

#### Environment 1: `kanna` (Python 3.10)

**Purpose**: Cheminformatics, ML, QSAR modeling
**Location**: `/home/miko/miniforge3/envs/kanna/`
**Activation**: `conda activate kanna`

**Critical Packages**:
- RDKit - Cheminformatics (MUST install via conda-forge)
- scikit-learn - Machine learning
- XGBoost - Gradient boosting
- spaCy + en_core_web_sm - NLP
- SHAP - Model interpretation
- BioPython - Sequence analysis
- PubChemPy - Chemical data

**Validation**:
```bash
conda activate kanna
python -c "from rdkit import Chem; import sklearn; print('✓ kanna OK')"
```

**Use Cases**: Chapter 4 (QSAR), Chapter 6 (ML addiction models)

#### Environment 2: `r-gis` (R 4.4.3)

**Purpose**: Statistics, GIS, Bayesian modeling, meta-analysis
**Location**: `/home/miko/miniforge3/envs/r-gis/`
**Activation**: `conda activate r-gis`

**Critical Packages**:
- brms 2.23.0 - Bayesian regression (use `library(brms)`, NOT `library(rstan)`)
- sf - GIS (GEOS 3.14.0, GDAL 3.11.4, PROJ 9.7.0)
- metafor 4.8-0 - Meta-analysis
- tidyverse 2.0.0 - Data science stack
- vegan - Community ecology
- igraph - Network analysis

**Validation**:
```bash
conda activate r-gis
Rscript -e "library(brms); library(sf); print('✓ r-gis OK')"
```

**Use Cases**: Chapters 2-3 (GIS, ethnobotany), Chapter 5 (meta-analysis)

#### Environment 3: `mineru` (Python 3.10)

**Purpose**: GPU-accelerated PDF extraction
**Location**: `/home/miko/miniforge3/envs/mineru/`
**Activation**: `conda activate mineru`

**Critical Packages**:
- PyTorch 2.6.0+cu124 - Deep learning
- CUDA 12.4 - GPU acceleration
- MinerU 2.5.4 - PDF extraction
- transformers 4.49.0 - NLP models

**GPU Status**: ✅ CUDA available (verified October 18, 2025)

**Validation**:
```bash
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
```

**Use Cases**: PDF extraction (10× faster than CPU), 142-paper corpus

### Environment Selection Quick Reference

| Task | Environment | Key Tools |
|------|-------------|-----------|
| QSAR modeling | kanna | RDKit, scikit-learn, SHAP |
| GIS analysis | r-gis | sf, GEOS, GDAL, PROJ |
| Meta-analysis | r-gis | metafor, brms |
| PDF extraction | mineru | PyTorch, CUDA, MinerU |
| NLP analysis | kanna | spaCy, transformers |
| Network analysis | r-gis | igraph, tidyverse |
| Bayesian stats | r-gis | brms (not rstan!) |

**Memory** (`.serena/memories/`):
- [kanna-conda-environments.md](../.serena/memories/kanna-conda-environments.md) - Complete environment documentation
- [academic-tools-setup.md](../.serena/memories/academic-tools-setup.md) - Tool installation details
- [session-2025-10-18-dependency-installation.md](../.serena/memories/session-2025-10-18-dependency-installation.md) - Installation session

---

## 🔌 MCP Server Integration

**Status**: 15 servers configured (production-ready, 98/100 health)
**Configuration**: `.mcp.json` (points to `/home/miko/LAB/bin/mcp-*`)

### Server Categories

**Core Infrastructure (4)**:
- **filesystem** - File operations (read, write, edit)
- **git** - Repository operations (points to KANNA directory)
- **github** - GitHub API integration
- **sqlite** - Database queries (ethnobotanical data, compounds)

**Scientific Computing (1)**:
- **jupyter** - Notebook integration (QSAR, EDA, visualization)

**AI & Research (5)**:
- **context7** - Up-to-date library docs (RDKit, scikit-learn, R packages)
- **perplexity** - AI-powered search (recent Sceletium papers)
- **sequential** - Sequential thinking & problem-solving
- **memory** - Persistent context across sessions
- **rag-query** - Search 142-paper literature corpus

**Web & Data Collection (3)**:
- **fetch** - Download papers, supplementary materials
- **cloudflare-browser** - Web scraping, HTML→markdown
- **cloudflare-container** - Ephemeral sandbox for experiments

**FPIC Compliance (2)**:
- **fpic-validator** - FPIC compliance validation
- **bibliography** - Zotero bibliography integration

**Complete Documentation**:
- [MCP-CONFIGURATION.md](./MCP-CONFIGURATION.md) - Quick reference
- [MCP-CONFIGURATION-AUDIT.md](./MCP-CONFIGURATION-AUDIT.md) - 13,000-word comprehensive audit

---

## 📖 Academic Enhancement Stack

### Tier 1: Critical Gaps (Installed October 18, 2025)

**1. LanguageTool - French Grammar Checking**
- **Version**: 6.4 (2024-03-28)
- **Location**: `tools/languagetool/`
- **Scripts**:
  - `tools/scripts/setup-languagetool.sh` - Automated setup
  - `tools/scripts/check-grammar-french.sh` - Grammar checking wrapper
- **VS Code Integration**: ✅ Extension installed (davidlday.languagetool-linter)
- **ROI**: 30 hours saved (real-time grammar correction)

**2. VOSviewer - Citation Network Analysis**
- **Status**: ⚠️ Manual download required
- **URL**: https://www.vosviewer.com/download
- **Script**: `tools/scripts/analyze-citation-network.sh`
- **Features**: Co-citation analysis, bibliographic coupling, keyword co-occurrence
- **ROI**: 8-10 hours saved (literature structure analysis)

### Tier 2: Bibliography & Knowledge Management (Installed October 18, 2025)

**3. Zotero - Bibliography Management**
- **Version**: 115.14.0esr
- **Installation**: APT repository
- **Workflow**: Elicit → Zotero (Better BibTeX) → Obsidian → Overleaf
- **Export**: `literature/zotero-export/kanna.bib` (auto-updated)
- **ROI**: 15-20 hours saved (bibliography management)

**4. Obsidian - Personal Knowledge Graph**
- **Version**: 1.7.7 (AppImage)
- **Location**: `tools/Obsidian-1.7.7.AppImage`
- **Vault**: `writing/obsidian-notes/` (planned)
- **Features**: Literature notes, graph view, Zotero integration
- **ROI**: 10-15 hours saved (synthesis and knowledge mapping)

### Custom Academic Command

**`/academic-enhance-fr [document]`** - French academic writing enhancement
- **Features**: 4-dimension analysis (tone, depth, structure, bibliography)
- **Integration**: Perplexity (academic mode) + Memory MCP
- **Documentation**: `.claude/commands/academic-enhance-fr.md`

**Complete Guide**: [ACADEMIC-TOOLS-IMPLEMENTATION.md](./ACADEMIC-TOOLS-IMPLEMENTATION.md) (20,000 words)

---

## 🔐 Data Privacy & FPIC Compliance

### Three-Tier Privacy Architecture

**Tier 1: Git-Excluded (SENSITIVE - NEVER commit)**:
```
fieldwork/interviews-raw/**              # Raw audio/transcripts
data/ethnobotanical/interviews/*.wav     # Recordings
data/clinical/trials/**/patient-data/**  # Identifiable data
*.env, credentials.json                  # Secrets
```

**Tier 2: Git LFS (LARGE)**:
```
*.raw, *.wiff, *.d/  # LC-MS data (>100MB)
*.tif                 # High-res images
*.fastq, *.bam        # Genomic data
```

**Tier 3: Git-Tracked (REPRODUCIBLE)**:
```
data/ethnobotanical/surveys/*.csv  # De-identified data
analysis/**/*.{R|py}               # Scripts
assets/figures/**/*.png            # Figures (300 DPI)
writing/thesis-chapters/**/*.tex   # LaTeX
```

### FPIC Protocols

**Data Sovereignty**: Khoisan communities retain IP rights to traditional knowledge

**File Naming Convention**:
```bash
# Ethnobotanical (de-identified from day 1)
INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.txt

# Chemical data
CHEM-{YYYYMMDD}-{BatchID}-{CompoundID}.csv

# GIS field data
FIELD-{YYYYMMDD}-{SiteCode}-{GPSID}.{shp|csv}
```

**Security Tools**:
- `tools/scripts/encrypt-sensitive-data.sh` - AES-256 encryption
- FPIC MCP server - Compliance validation
- `collaboration/ethics-approvals/` - Ethics documentation

**Backup Strategy (3-2-1)**:
1. Working: `~/LAB/academic/KANNA/` (SSD)
2. Local: `/run/media/miko/AYA/KANNA-backup/` (1.4TB HDD, daily 2 AM)
3. Cloud: Tresorit/SpiderOak (AES-256, ready to configure)

---

## 📊 Chapter-Specific Resources

### Chapter 1: Introduction & Contextualization
- **Literature**: `literature/pdfs/BIBLIOGRAPHIE/` (142 papers)
- **Analysis**: VOSviewer citation networks
- **Writing**: `writing/thesis-chapters/chapter-01/`
- **Tools**: Zotero, Obsidian, LanguageTool

### Chapter 2: Botanical Foundations
- **Data**: `data/botanical/` (GIS maps, specimens, taxonomy)
- **Analysis**: `analysis/r-scripts/` (sf, GIS, phylogenetics)
- **Tools**: QGIS → IQ-TREE 3 → R sf → FigTree

### Chapter 3: Khoisan Ethnobotanical Heritage
- **Data**: `data/ethnobotanical/` (surveys, interviews, FPIC)
- **Analysis**: `analysis/r-scripts/ethnobotany/calculate-bei.R`
- **Tools**: SurveyCTO → MAXQDA → ethnobotanyR → ggplot2
- **Ethics**: `collaboration/ethics-approvals/`, `data/ethnobotanical/fpic-protocols/`

### Chapter 4: Pharmacognosy & Neurobiology
- **Data**: `data/phytochemical/` (LC-MS/MS, alkaloid profiles)
- **Analysis**: `analysis/python/cheminformatics/qsar-modeling.py`
- **Tools**: PubChem → RDKit → scikit-learn → SHAP → PyMOL
- **Environment**: `conda activate kanna`

### Chapter 5: Clinical Validation
- **Data**: `data/clinical/` (trials, pharmacokinetics, safety)
- **Analysis**: `analysis/r-scripts/meta-analysis/`
- **Tools**: Rayyan → RevMan → metafor → forest plots
- **Environment**: `conda activate r-gis`

### Chapter 6: Addiction & Neurodependence
- **Analysis**: `analysis/python/ml-models/`
- **Tools**: Machine learning (scikit-learn, XGBoost), SHAP interpretation
- **Environment**: `conda activate kanna`

### Chapter 7: Legal & Ethical Issues
- **Data**: `data/legal/` (patents, treaties, benefit-sharing)
- **Literature**: Biopiracy case studies, WIPO Treaty 2024

### Chapter 8: Synthesis & Perspectives
- **Cross-chapter synthesis**: All previous chapters
- **Writing**: `writing/thesis-chapters/chapter-08/`

---

## 🚀 Quick Command Reference

### Daily Workflow

```bash
# Navigate to project
cd ~/LAB/academic/KANNA

# Check status
git status
cat PROJECT-STATUS.md | head -50

# Activate environment based on task
conda activate kanna      # Python cheminformatics, ML
conda activate r-gis      # R statistics, GIS, meta-analysis
conda activate mineru     # PDF extraction (GPU)

# MCP server verification
claude
/mcp  # Should show 15/15 connected
```

### PDF Extraction

```bash
# Production extraction (GPU-accelerated)
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/
```

### Academic Writing

```bash
# French grammar checking
./tools/scripts/check-grammar-french.sh writing/chapter-01.md

# Academic enhancement (custom command)
/academic-enhance-fr "chapter-03-ethnobotany.pdf"

# LaTeX compilation
bash tools/scripts/compile-thesis-pdf.sh
```

### Data Analysis

```bash
# Ethnobotany analysis (Chapter 3)
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# QSAR modeling (Chapter 4)
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py
```

### Backup & Security

```bash
# Manual backup
bash tools/scripts/daily-backup.sh

# Check backup logs
tail -20 ~/LAB/logs/kanna-backup.log

# Encrypt sensitive data
bash tools/scripts/encrypt-sensitive-data.sh
```

---

## 📈 Project Metrics (October 2025)

**Literature**:
- 142 papers (BIBLIOGRAPHIE/)
- 974K words corpus
- 2.3 GB repository

**Infrastructure**:
- 98/100 health score
- 15 MCP servers configured
- 3 conda environments (350+ packages)

**Documentation**:
- 50+ markdown files
- 80,000+ words documentation
- 8 comprehensive setup guides

**Scripts & Tools**:
- 30+ utility scripts
- 20+ analysis scripts
- 4 academic enhancement tools

**Target Outputs**:
- 120,000-word thesis
- 8 chapters
- 15-20 publications
- 300+ figures (300 DPI)

---

## 🔍 Finding Documentation

### By Topic

**Getting Started**: README.md, QUICK-START.md, CLAUDE.md
**Architecture**: ARCHITECTURE.md, AGENTS.md
**Progress**: PROJECT-STATUS.md, SESSION-HANDOFF.md
**MCP Servers**: MCP-CONFIGURATION.md, MCP-CONFIGURATION-AUDIT.md
**Academic Tools**: ACADEMIC-TOOLS-IMPLEMENTATION.md, ACADEMIC-PLUGINS-SETUP.md
**PDF Extraction**: docs/mineru/, tools/guides/06-mineru-pdf-extraction-setup.md
**Environments**: .serena/memories/kanna-conda-environments.md
**Setup Guides**: tools/guides/ (8 guides, 1,670+ lines)
**Plugin Integration**: PLUGIN-INTEGRATION-PLAN.md (63 pages)

### By Audience

**New User**: README.md → QUICK-START.md → PROJECT-STATUS.md
**Claude Code**: CLAUDE.md (complete instructions)
**Developer**: ARCHITECTURE.md → AGENTS.md → setup guides
**Researcher**: Chapter-specific resources → analysis scripts → data directories
**Administrator**: MCP-CONFIGURATION-AUDIT.md → INSTALLATION-SUMMARY.md → backup scripts

### By Phase

**Phase 1 (Setup)**: Setup guides, INSTALLATION-SUMMARY.md
**Phase 2 (Research)**: Analysis scripts, data directories, chapter resources
**Phase 3 (Writing)**: Academic tools, LanguageTool, Overleaf, references
**Phase 4 (Review)**: Citation networks, Obsidian, knowledge graphs

---

## 📝 Documentation Standards

### Quality Guidelines

**Publication-Ready Figures**:
- Resolution: 300 DPI minimum
- Fonts: ≥10pt at print size
- Colors: Colorblind-friendly (viridis, RColorBrewer)
- Output: `assets/figures/chapter-{XX}/`

**Git Commit Convention**:
```bash
feat:     # New analysis, script, feature
fix:      # Bug fix
docs:     # Documentation or writing
refactor: # Code restructuring
data:     # New de-identified data
```

**File Naming**:
- Descriptive, lowercase, hyphens (not underscores)
- Date prefixes: `YYYYMMDD-description.md`
- Chapter prefixes: `chapter-01-introduction.tex`

### Maintenance

**Weekly Updates**:
- PROJECT-STATUS.md - Progress metrics
- Backup verification - `tail -20 ~/LAB/logs/kanna-backup.log`
- MCP server health - `/mcp` command
- Environment validation - Test imports

**Monthly Reviews**:
- Documentation accuracy
- Dead link cleanup
- Archive old reports
- Update INDEX (this file)

---

## 🆘 Troubleshooting Resources

### Common Issues

**RDKit Import Fails**: See CLAUDE.md → Troubleshooting
**R Package Errors**: Use brms wrapper, not direct rstan
**PDF Extraction**: Check GPU with `torch.cuda.is_available()`
**CUDA Issues**: See docs/infrastructure/CUDA-FIX-GUIDE.md
**Backup Not Running**: Check crontab, logs

### Emergency Recovery

```bash
# Restore from HDD
rsync -avh /run/media/miko/AYA/KANNA-backup/ ~/LAB/academic/KANNA/

# Verify Git integrity
git fsck --full
```

---

## 📞 Contact & Support

**Project Lead**: See collaboration/ directory
**Ethics Approvals**: collaboration/ethics-approvals/
**Community Partnerships**: collaboration/khoisan-partners/

**Technical Support**:
- Claude Code Documentation: https://docs.claude.com/claude-code
- Issue Reporting: GitHub issues (if applicable)

---

**Last Updated**: October 2025 (Month 1 - Infrastructure Complete)
**Next Review**: Weekly PROJECT-STATUS.md updates

**Index Maintained By**: Claude Code with Serena MCP integration
**Purpose**: Complete knowledge base navigation for KANNA PhD thesis project
