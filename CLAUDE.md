# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

42-month interdisciplinary PhD thesis on *Sceletium tortuosum* (Kanna) spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical analysis. Repository contains research data, analysis scripts, writing, and comprehensive tool integration.

**Key Metrics**: 120,000-word thesis, 8 chapters, 15-20 publications, 142 papers corpus (974K words), 98/100 infrastructure health.

## Session Management & Initialization

### Session Start Protocol (Execute on Every Session)

**Mandatory 6-step initialization** for complete context loading:

| Step | Action | Tool/Command | Purpose |
|------|--------|--------------|---------|
| 1 | **Project Activation** | `mcp__serena__activate_project("KANNA")` | Enable Serena MCP workspace |
| 2 | **Phase Context** | Read `PROJECT-STATUS.md` (first 50 lines) | Understand current project phase |
| 3 | **Memory Discovery** | `mcp__serena__list_memories()` | Identify available memories |
| 4 | **Memory Loading** | Read memories by task type (see Memory Management below) | Load relevant context |
| 5 | **Git Verification** | `git status --porcelain` + `git log --oneline -5` | Understand working tree state |
| 6 | **Environment Check** | `conda info --envs` | Verify active environment |

**Estimated Time**: 30-60 seconds
**Success Criteria**: All 6 steps complete, no errors, context loaded

### Post-Initialization Checklist

After completing 6-step protocol, verify:
- ✅ Serena shows "Active project: KANNA"
- ✅ PROJECT-STATUS.md shows infrastructure health score
- ✅ At least 1 memory loaded (relevant to current task)
- ✅ Git status interpreted (see Git Interpretation Guide below)
- ✅ Correct conda environment active for task type

## Essential Commands

### Environment Activation

```bash
# MinerU PDF extraction (dedicated GPU-accelerated environment)
conda activate mineru

# Python environment (cheminformatics, ML, QSAR)
conda activate kanna

# R environment (statistics, GIS, meta-analysis, Bayesian)
conda activate r-gis

# Quick access alias (add to ~/.zshrc)
kanna() {
    cd ~/LAB/academic/KANNA
    conda activate r-gis  # Default
    echo "✅ KANNA (R 4.4.3) | Switch: conda activate kanna | PDF extraction: conda activate mineru"
}
```

### Core Workflows

```bash
# Daily status check
git status
cat PROJECT-STATUS.md | head -50
tail -20 ~/LAB/logs/kanna-backup.log

# PDF extraction (GPU-accelerated MinerU in dedicated environment)
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Run ethnobotany analysis (Chapter 3)
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# Run QSAR modeling (Chapter 4)
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py

# Manual backup trigger
bash tools/scripts/daily-backup.sh

# MCP server verification
claude
/mcp  # Should show 13 connected servers
```

### Custom Commands

**`/academic-enhance-fr [document-name]`** - French academic writing enhancement
```bash
# Analyze and improve French thesis chapters
/academic-enhance-fr "chapter-03-ethnobotany.pdf"

# Features:
# - 4-dimension academic analysis (tone, depth, structure, bibliography)
# - French academic conventions (impersonal voice, footnotes)
# - Integration with Perplexity (academic mode) and Memory MCP
# - Automatic document location (pdfs/, writing/, extractions-mineru/)
```

**See**: `.claude/commands/academic-enhance-fr.md` for detailed documentation.

### Testing Environments

```bash
# Validate MinerU environment (PDF extraction)
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
python -c "from magic_pdf.pipe.UNIPipe import UNIPipe; print('✓ MinerU OK')"

# Validate Python environment (scientific analysis)
conda activate kanna
python -c "from rdkit import Chem; print('✓ RDKit OK')"
python -c "import pandas, numpy, sklearn; print('✓ Core OK')"

# Validate R environment
conda activate r-gis
Rscript -e "library(sf); library(brms); library(metafor); print('✓ R OK')"

# Quick health check (all environments in one command)
conda activate kanna && python -c "from rdkit import Chem; print('✓ RDKit')" && \
conda activate r-gis && Rscript -e "library(brms); library(sf); cat('✓ R\n')" && \
conda activate mineru && python -c "import torch; print(f'✓ CUDA: {torch.cuda.is_available()}')"
```

## Memory Management Strategy

### Memory Classification System

Based on current KANNA memories (research-automation-strategy, kanna-conda-environments, session-2025-10-18-dependency-installation, academic-tools-setup):

| Type | Purpose | Lifespan | When to Read | Examples |
|------|---------|----------|--------------|----------|
| **Strategic** | Long-term implementation plans | 3-6 months | Starting new feature work | research-automation-strategy |
| **Reference** | System architecture & configuration | Permanent | Debugging, setup, architecture questions | kanna-conda-environments |
| **Historical** | Session records, installations | 3-6 months | Troubleshooting recurring issues | session-2025-10-18-dependency-installation |
| **Configuration** | Tool setup procedures | Until tools change | First-time tool usage | academic-tools-setup |

### Task-Based Memory Priority

**Starting New Feature**:
1. Read Strategic (understand long-term plan)
2. Read Reference (understand architecture)
3. Skip Historical (not relevant for new work)

**Debugging Environment Issues**:
1. Read Reference (understand expected state)
2. Read Historical (see what was installed/changed)
3. Skip Strategic (not relevant for debugging)

**Setting Up New Tools**:
1. Read Configuration (follow setup procedures)
2. Read Historical (learn from past installations)
3. Skip Strategic (not relevant for setup)

### Memory Lifecycle Rules

**CREATE** new memory when:
- Completing multi-hour setup (>2 hours work)
- Developing strategic plan (affects multiple chapters)
- Solving complex problem (future reference value)

**UPDATE** existing memory when:
- Configuration changes significantly
- Strategic plan evolves
- New insights discovered

**DELETE** memory when:
- Information becomes obsolete (>6 months for Historical)
- Converted to permanent documentation
- Superseded by newer memory

**Memory Naming Convention**:
- Strategic: `{project-area}-strategy` (e.g., research-automation-strategy)
- Reference: `{system-name}-{aspect}` (e.g., kanna-conda-environments)
- Historical: `session-{YYYY-MM-DD}-{topic}` (e.g., session-2025-10-18-dependency-installation)
- Configuration: `{tool-name}-setup` (e.g., academic-tools-setup)

## Architecture Patterns

### Three-Environment Strategy

**Critical**: Use separate conda environments to avoid dependency conflicts:

- **`mineru`** (Python 3.10): **GPU-accelerated PDF extraction** - PyTorch 2.4.0+cu124, MinerU 1.3.12, transformers 4.49.0, DocLayout-YOLO, Unimernet, RapidTable
- **`kanna`** (Python 3.10): RDKit (cheminformatics), scikit-learn (ML), spaCy (NLP), general scientific computing
- **`r-gis`** (R 4.4.3): sf (GIS), brms (Bayesian), metafor (meta-analysis), tidyverse (stats)

**Why**:
- **mineru isolation**: MinerU needs specific transformers 4.49.0 (incompatible with 4.57.0), clean PyTorch+CUDA environment resolved CUDA Error 999
- **kanna isolation**: Python ML tools (transformers, torch) conflict with R spatial libraries (GDAL, PROJ)
- **GPU acceleration**: Fresh mineru environment enables GPU extraction (10× faster than CPU mode)

**Known Issue - Workaround**:
- rstan has TBB symbol errors when loaded directly
- **Solution**: Use `library(brms)` instead of `library(rstan)` - brms is a wrapper that delays TBB linkage and provides better syntax

### Analysis Pipeline Structure

**Standard pattern for all scripts**:

```
Input:  data/{discipline}/{subdomain}/raw-data.csv
Script: analysis/{language}-scripts/{chapter}/analysis-name.{R|py}
Output: analysis/{language}-scripts/{chapter}/output/{analysis-type}/
Final:  assets/figures/chapter-{XX}/{figure-name}.png (300 DPI)
```

**Example**:
```bash
Input:  data/ethnobotanical/surveys/survey-2025.csv
Script: analysis/r-scripts/ethnobotany/calculate-bei.R
Output: analysis/r-scripts/ethnobotany/output/bei/
Final:  assets/figures/chapter-03/bei-by-community.png
```

### Three-Tier Data Privacy

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

### Chapter-Specific Toolchains

```
Chapter 2 (Botany):        QGIS → IQ-TREE 3 → R sf → FigTree
Chapter 3 (Ethnobotany):   SurveyCTO → MAXQDA → ethnobotanyR → ggplot2
Chapter 4 (Pharmacology):  PubChem → RDKit → scikit-learn → SHAP → PyMOL
Chapter 5 (Clinical):      Rayyan → RevMan → metafor → forest plots
```

### Multi-Environment Workflow Patterns

The three conda environments form DATA FLOW pipelines:

#### Pipeline 1: Literature → QSAR Analysis

```
Step 1 (mineru): PDF Extraction
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh literature/pdfs/BIBLIOGRAPHIE/ literature/pdfs/extractions-mineru/
→ Output: Markdown + chemical structures

Step 2 (kanna): Chemical Analysis
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py
→ Output: QSAR models + molecular fingerprints

Step 3 (r-gis): Statistical Validation
conda activate r-gis
Rscript analysis/r-scripts/validation/model-performance.R
→ Output: 300 DPI publication figures
```

#### Pipeline 2: Ethnobotany Field Data → Publication

```
Step 1 (r-gis): Data Collection Analysis
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R
→ Output: Botanical Ethnobotany Index

Step 2 (r-gis): GIS Mapping
Rscript analysis/r-scripts/ethnobotany/spatial-distribution.R
→ Output: Distribution maps (sf package)

Step 3 (r-gis): Statistical Analysis
Rscript analysis/r-scripts/ethnobotany/hypothesis-testing.R
→ Output: Publication-ready results
```

#### Pipeline 3: Clinical Trials → Meta-Analysis

```
Step 1 (r-gis): Data Import
conda activate r-gis
# Import from data/clinical/trials/

Step 2 (r-gis): Meta-Analysis
Rscript analysis/r-scripts/clinical/meta-analysis.R
→ Output: Forest plots (metafor package)

Step 3 (kanna): Supplementary NLP
conda activate kanna
python analysis/python/nlp/trial-classification.py
→ Output: Automated trial classification
```

#### Environment Selection Decision Tree

```
Task Type → Environment
├─ PDF Extraction? → mineru
├─ Chemical Structure Analysis? → kanna (RDKit)
├─ Machine Learning (QSAR, NLP)? → kanna (scikit-learn, spaCy)
├─ GIS / Spatial Analysis? → r-gis (sf, GEOS, GDAL)
├─ Bayesian Statistics? → r-gis (brms)
├─ Meta-Analysis? → r-gis (metafor)
└─ General R Statistics? → r-gis (tidyverse)
```

### Documentation Navigation by Task

**Quick Reference: Which Document for Which Task**

| Task Category | Primary Document | Section | Word Count |
|---------------|------------------|---------|------------|
| Session initialization | CLAUDE.md | Session Management | 500 |
| Environment debugging | CLAUDE.md | Troubleshooting | 800 |
| Analysis pipeline setup | ARCHITECTURE.md | Analysis Pipeline Structure | 1,200 |
| MCP server configuration | docs/MCP-CONFIGURATION-AUDIT.md | Server Details | 13,000 |
| Plugin integration | docs/PLUGIN-INTEGRATION-PLAN.md | Full Guide | 15,000 |
| Literature workflow | tools/guides/01-literature-workflow-setup.md | Full Guide | 1,500 |
| QSAR setup | tools/guides/04-qsar-pipeline-setup.md | Full Guide | 1,200 |
| Field data collection | tools/guides/02-field-data-collection.md | Full Guide | 1,400 |
| French writing tools | docs/ACADEMIC-TOOLS-IMPLEMENTATION.md | Tier 1-2 Tools | 20,000 |
| Project status check | PROJECT-STATUS.md | Metrics (first 100 lines) | 500 |

**Navigation Rule**: Read ONLY the specified section, not the entire document, to minimize token usage.

**Example**:
- Task: "Set up QSAR analysis"
- Read: `tools/guides/04-qsar-pipeline-setup.md` (1,200 words)
- Don't read: ARCHITECTURE.md (39KB) or entire documentation corpus

## Critical Dependencies

### Python (conda environment: kanna)

```bash
# Core (MUST install via conda, NOT pip)
conda install -c conda-forge rdkit  # Cheminformatics foundation

# After conda, install rest via pip
pip install -r requirements.txt

# NLP model (separate download)
python -m spacy download en_core_web_sm
```

### R (conda environment: r-gis)

```bash
# Install from script
Rscript analysis/r-scripts/install-packages.R

# Key packages: sf (GIS), brms (Bayesian), metafor (meta-analysis),
#               tidyverse, ethnobotanyR, vegan, igraph
```

## Quality Standards

### Publication-Ready Figures

```r
# R (ggplot2)
library(ggplot2)
library(viridis)

ggsave("assets/figures/chapter-03/figure.png",
       width=8, height=6, dpi=300)  # 300 DPI required
```

```python
# Python (matplotlib)
import matplotlib.pyplot as plt

plt.savefig("assets/figures/chapter-04/figure.png",
            dpi=300, bbox_inches='tight')  # 300 DPI required
```

**Requirements**: 300 DPI minimum, colorblind-friendly palettes (viridis, RColorBrewer), ≥10pt fonts at print size.

### Git Commit Convention

```bash
# Semantic prefixes
feat:     # New analysis, script, feature
fix:      # Bug fix
docs:     # Documentation or writing
refactor: # Code restructuring
data:     # New de-identified data

# Examples
git commit -m "feat: add SHAP interpretation to QSAR model (Chapter 4)"
git commit -m "fix: correct ICF calculation for zero use reports"
git commit -m "docs: draft Chapter 3 Section 3.4 (1200 words)"
```

### Git Working Tree Interpretation Patterns

**Use this guide BEFORE committing to ensure FPIC compliance and data safety**

#### 🟢 SAFE to Commit (Green Light)

**Modified Files**:
- Scripts: `*.py`, `*.R`, `*.sh`, `*.bash`
- Documentation: `*.md`, `*.txt` (excluding FPIC-protected paths)
- Configs: `*.json`, `*.yml`, `*.yaml`, `.vscode/settings.json`

**Untracked Directories**:
- New docs: `docs/{new-category}/`
- New tools: `tools/{scripts|mcp-servers}/{new-tool}/`
- New writing: `writing/{chapters|notes}/`
- Analysis outputs: `analysis/*/output/`

**Deleted Files**:
- Temporary: `*.log`, `*.tmp`, `__pycache__/`, `.pytest_cache/`
- Build artifacts: `*.pyc`, `*.o`, `.Rhistory`

#### 🟡 INVESTIGATE First (Yellow Light)

**Deleted Files in Bulk** (>5 files):
- Data files: `*.csv`, `*.pdf`, `*.xlsx` in bulk
- Example: 14 PDFs deleted from `literature/pdfs/PILOT-20/`
- **Action**: Ask user if reorganization was intentional
- **Reason**: Could be accidental deletion or intentional cleanup

**Modified Critical Dependencies**:
- `requirements.txt`, `environment.yml`
- `.gitignore`, `.gitattributes`
- **Action**: Review changes, ensure compatibility

**Deleted Configuration**:
- `.vscode/` directory files
- `config/` directory files
- **Action**: Verify intentional removal

#### 🔴 CRITICAL - Never Commit Without Explicit Permission (Red Light)

**FPIC-Protected Paths** (Data Sovereignty):
- `fieldwork/interviews-raw/**` (raw participant data)
- `data/ethnobotanical/interviews/*.wav` (audio recordings)
- `data/clinical/trials/**/patient-data/**` (identifiable data)

**Security-Sensitive**:
- `*.env`, `credentials.json`, `secrets.yml`
- `.ssh/`, `.gnupg/`, API keys

**Core Project Documentation**:
- `CLAUDE.md`, `ARCHITECTURE.md`, `README.md`
- **Action**: If deleted, investigate immediately - likely accident

**If CRITICAL files appear in git status**:
1. ⛔ **STOP** - Do not commit
2. Alert user immediately
3. Investigate cause (accidental vs intentional)
4. If accidental: `git restore {file}`
5. If intentional: Require explicit user confirmation

### File Naming Conventions

**Data governance for FPIC compliance**:

```bash
# Ethnobotanical (de-identified from day 1)
INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.txt
# Example: INT-20250315-SC01-P007.txt

# Chemical data
CHEM-{YYYYMMDD}-{BatchID}-{CompoundID}.csv

# GIS field data
FIELD-{YYYYMMDD}-{SiteCode}-{GPSID}.{shp|csv}

# Clinical trials
TRIAL-{YYYYMMDD}-{StudyID}-{ArmID}.csv
```

## Key Tools & Scripts

### PDF Extraction (Production)

**Current tool**: MinerU 1.3.12 (GPU-accelerated, 100% success rate, extracts images + tables + formulas)

```bash
conda activate mineru  # Dedicated environment for GPU-accelerated extraction
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Output: literature/pdfs/extractions-mineru/[paper-name]/auto/
#   - [paper-name].md (markdown with embedded images)
#   - images/ (extracted chemical structures, diagrams)
#   - [paper-name]_layout.pdf (visual verification)
#   - [paper-name]_*.json (metadata)
```

**Why MinerU + dedicated environment**:
- **GPU acceleration**: 10× faster than CPU mode (resolved CUDA Error 999 with clean PyTorch environment)
- **Quality**: Superior extraction for scientific papers with chemical formulas, tables, complex layouts
- **Isolation**: transformers 4.49.0 required (incompatible with kanna's 4.57.0)
- **Models**: DocLayout-YOLO (2501), Unimernet (2503), RapidTable - all GPU-accelerated

### Backup System (3-2-1 Rule)

**Automated**: Daily at 2 AM via cron

```bash
# Crontab entry
0 2 * * * /home/miko/LAB/academic/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1

# Manual trigger
bash tools/scripts/daily-backup.sh
```

**Backups**:
1. Working: `~/LAB/academic/KANNA/` (SSD)
2. Local: `/run/media/miko/AYA/KANNA-backup/` (1.4TB external HDD)
3. Cloud: Tresorit/SpiderOak (AES-256, ready to configure)

### Quick Script Reference

**PDF & Literature**:
```bash
# Production PDF extraction (GPU-accelerated)
bash tools/scripts/extract-pdfs-mineru-production.sh literature/pdfs/BIBLIOGRAPHIE/ literature/pdfs/extractions-mineru/

# Consolidate multiple extraction outputs
bash tools/scripts/consolidate-pdf-extractions.sh

# Citation network visualization (VOSviewer)
bash tools/scripts/analyze-citation-network.sh
```

**Data Collection**:
```bash
# ChEMBL target search (SERT, PDE4)
python tools/scripts/chembl-target-search.py

# COCONUT natural products query
python tools/scripts/coconut-query.py
```

**LaTeX Compilation**:
```bash
# Compile full thesis PDF
bash tools/scripts/compile-thesis-pdf.sh
```

**French Academic Writing**:
```bash
# Grammar check with Grammalecte
bash tools/scripts/check-grammar-french.sh writing/chapter-01.md
```

### Academic Enhancement Stack (Tier 1-2 Tools)

**Status**: ✅ Documentation and scripts created (2025-10-10)
**Implementation Guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md` (comprehensive 20,000-word guide)
**Estimated Setup Time**: 9.5-12 hours (Tier 1: 2.5-3h, Tier 2: 7-9h)

**Purpose**: French academic writing tools + literature analysis for 142-paper PhD thesis corpus

#### Tier 1: Critical Gaps (Week 1)

**1. Grammalecte - French Grammar Checking**
```bash
# Real-time checking in VS Code
code ~/LAB/academic/KANNA/
# Grammalecte extension configured in .vscode/settings.json

# Batch checking via CLI
conda activate kanna
./tools/scripts/check-grammar-french.sh writing/chapter-01.md

# Features:
# - 200+ custom ethnopharmacology terms
# - JSON reports with error statistics
# - Integration with /academic-enhance-fr command
```

**2. VOSviewer - Citation Network Visualization**
```bash
# Run analysis guide (interactive)
./tools/scripts/analyze-citation-network.sh

# Launches VOSviewer with:
# - Co-citation analysis (papers cited together)
# - Bibliographic coupling (shared references)
# - Keyword co-occurrence (thematic analysis)
# - Publication-ready 300 DPI outputs
```

#### Tier 2: Activate Existing Plans (Week 2)

**3. Zotero + Better BibTeX - Bibliography Management**

**Original Guide**: `tools/guides/01-literature-workflow-setup.md` (follow this first!)
**Workflow**: Elicit → Zotero (Better BibTeX) → Obsidian → Overleaf

```bash
# Auto-export configuration
# In Zotero: Right-click collection → Export → Better BibTeX → ✅ Keep updated
literature/zotero-export/kanna.bib  # Real-time sync

# Sync script (validates & commits to git)
./tools/scripts/sync-zotero-bib.sh

# LaTeX citation in Overleaf
\citep{author2025}
\bibliography{kanna}
```

**4. Obsidian - Personal Knowledge Graph**
```bash
# Vault location
writing/obsidian-notes/

# Zotero Integration plugin
# Settings → Zotero Integration → Database: literature/zotero-export/kanna.bib

# Features:
# - Literature note templates
# - Graph view of paper relationships
# - Bidirectional [[wiki-links]]
# - Complements VOSviewer (personal vs citation networks)
```

#### Key Scripts Created

```bash
# Grammar checking
tools/scripts/check-grammar-french.sh

# Citation network analysis
tools/scripts/analyze-citation-network.sh

# Bibliography sync
tools/scripts/sync-zotero-bib.sh

# Configuration files
.vscode/settings.json                    # Grammalecte + LaTeX
.vscode/grammalecte-dictionary.txt       # 200+ custom terms
```

#### MCP Integration

**KANNA-specific MCP servers** configured (13 servers):
```bash
# In Claude Code session from KANNA directory
/mcp  # Verify 13/13 servers connected

# Use custom academic enhancement command
/academic-enhance-fr "chapter-03-ethnobotany.pdf"

# Query literature corpus with RAG
"Search corpus for alkaloid biosynthesis studies"

# Get up-to-date library docs
"Check RDKit fingerprint documentation"
```

#### ROI & Time Investment

**Investment**: 9.5-12 hours setup (Tier 1-2)
**Return**: 63-75 hours saved over 120,000-word thesis
**ROI**: 5.3× to 7.9× return

**Breakdown**:
- Grammalecte: 30h saved (real-time grammar correction)
- VOSviewer: 8-10h saved (literature structure analysis)
- Zotero: 15-20h saved (bibliography management)
- Obsidian: 10-15h saved (synthesis and knowledge mapping)

#### Compliance & Privacy

✅ **All tools local** (FPIC-compliant): Grammalecte, VOSviewer, Zotero, Obsidian
❌ **Avoid cloud tools**: Connected Papers, Research Rabbit (privacy risk for indigenous knowledge)

#### Documentation

- **Complete setup guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md`
- **Existing workflow guide**: `tools/guides/01-literature-workflow-setup.md`
- **Academic plugin setup**: `docs/ACADEMIC-PLUGINS-SETUP.md` (VoltAgent marketplace)

#### Next Steps After Setup

1. Import 142 PDFs into Zotero (45-60 min automatic)
2. Run VOSviewer co-citation analysis
3. Create Obsidian literature notes (systematic review)
4. Use Grammalecte daily for thesis writing
5. Generate citation network figures for Chapter 1

## MCP Server Integration

**Status**: 13 servers configured (optimized for PhD research)
**Configuration Health**: ✅ 98/100 (Production Ready - Audited 2025-10-10)
**Documentation**:
- **Configuration Audit**: `docs/MCP-CONFIGURATION-AUDIT.md` (13,000+ words, comprehensive analysis)
- **Changelog**: `docs/MCP-CONFIGURATION-CHANGELOG.md` (optimization history)
- **Quick Reference**: `docs/MCP-CONFIGURATION.md` (if exists)

### Server Categories

**Core Infrastructure (4)**:
- **filesystem**: File operations (read, write, edit)
- **git**: Repository operations (points to KANNA)
- **github**: GitHub API integration
- **sqlite**: Database queries (ethnobotanical data, chemical compounds)

**Scientific Computing (1)**:
- **jupyter**: Notebook integration (QSAR, EDA, visualization)

**AI & Research (5)**:
- **context7**: Up-to-date library docs (RDKit, scikit-learn, R packages)
- **perplexity**: AI-powered search (recent Sceletium papers)
- **sequential**: Sequential thinking & problem-solving
- **memory**: Persistent context across sessions
- **rag-query**: Search 142-paper literature corpus

**Web & Data Collection (3)**:
- **fetch**: Download papers, supplementary materials
- **cloudflare-browser**: Web scraping, HTML→markdown conversion
- **cloudflare-container**: Ephemeral sandbox for safe experiments

### Quick Start

**Verify connection**:
```bash
cd ~/LAB/academic/KANNA
claude
/mcp  # Should show 13/13 connected
```

**Example workflows**:
```bash
# Literature search
"Search corpus for alkaloid biosynthesis studies"

# QSAR analysis
"Run QSAR model, check RDKit fingerprint docs"

# Data collection
"Download this PubChem supplementary data"
```

**Complete guide**: See `docs/MCP-CONFIGURATION.md` for server details, health monitoring, troubleshooting, and usage examples.

### MCP Server Health & Degradation Modes

**Target**: 13/13 servers connected (production optimal)
**Minimum**: 3/13 servers connected (Tier 1 only)

#### Server Criticality Tiers

**Tier 1 - CRITICAL** (Cannot work effectively without these):
- **serena**: Project activation, memory management, symbol operations
- **filesystem**: File read/write/edit operations
- **git**: Version control, commits, status checks

**Degradation**: If ANY Tier 1 missing → Notify user, request troubleshooting

**Tier 2 - HIGH VALUE** (Reduced capability, work continues):
- **sequential**: Complex reasoning (fallback: native reasoning, lower quality)
- **context7**: Library docs (fallback: web search, less reliable)
- **memory**: Cross-session persistence (fallback: session-only context)
- **github**: GitHub API (fallback: manual gh CLI commands)
- **sqlite**: Database queries (fallback: pandas CSV operations)

**Degradation**: Notify user of reduced capability, suggest alternatives

**Tier 3 - SPECIALIZED** (Task-specific features):
- **jupyter**: Notebook integration (fallback: .py scripts)
- **playwright**: Browser testing (fallback: unit tests only)
- **rag-query**: 142-paper corpus search (fallback: grep on extractions)
- **fetch**: HTTP operations (fallback: Bash curl)
- **cloudflare-browser**: Web scraping (fallback: native WebFetch)
- **cloudflare-container**: Sandboxed experiments (fallback: local execution)

**Degradation**: Specific features unavailable, work continues with alternatives

#### Health Check Procedure

**Quick Check** (every session):
```bash
# In Claude Code
/mcp
# Should show: 13/13 connected
```

**If <13 servers connected**:
1. Identify missing servers from output
2. Determine tier (consult table above)
3. If Tier 1 missing: Alert user, request troubleshooting
4. If Tier 2/3 missing: Note limitations, proceed with fallbacks
5. Log issue in session memory for investigation

**Common Failure Modes**:
- **Serena disconnected**: Restart Claude Code session
- **filesystem disconnected**: Check .mcp.json configuration
- **sequential disconnected**: Check MCP server installation
- **Multiple servers down**: System-level issue, restart recommended

## Plugin Integration (Planned - Week 1-3)

**Status**: 📋 Planning Complete | **Documentation**: `docs/PLUGIN-INTEGRATION-PLAN.md` (63 pages)
**Timeline**: 3 weeks (5 + 7 + 8 hours) | **Expected ROI**: 85× (1,968 hours saved over 41 months)

### Overview

Comprehensive plan to integrate Claude Code plugins into KANNA infrastructure, prioritizing **FPIC compliance** and **security-first architecture**. Progressive 3-phase rollout (experimental → dev → main worktrees) with rigorous validation at each stage.

### Prioritized Plugins (5 High-Value)

1. **`lyra@claude-code-marketplace`** ⭐ UNIVERSAL
   - AI prompt optimization for 142-paper corpus
   - Token savings: 40-47% on specialized queries
   - Time saved: 3-5 hours/week

2. **`update-claude-md@claude-code-marketplace`** ⭐ HIGH-VALUE
   - Auto-maintain 12,338+ word CLAUDE.md
   - Manual: 45-60 min → Automated: 2-5 min
   - Time saved: 2-4 hours/week

3. **`security-auditor@agents`** ⭐ CRITICAL
   - FPIC compliance validation across 19 MCP servers
   - Prevent security incidents (1 incident = 20+ hours)
   - Essential for indigenous knowledge protection

4. **`ai-engineer@agents`** ⭐ POST-CUDA FIX
   - RAG pipeline optimization (vLLM + ChromaDB)
   - ChemLLM-7B-Chat integration guidance
   - Blocked until CUDA restoration

5. **`documentation-generator@claude-code-marketplace`** ⭐ WRITING PHASE
   - Chapter summaries (3-4 hours → 30-45 min)
   - Time saved: 5-8 hours/week during active writing

### 3-Phase Rollout

**Phase 1 (Week 1)**: Experimental worktree validation
- Add 3 marketplaces (ananddtyagi, wshobson, Every)
- Install & validate lyra + update-claude-md
- Security integration testing (FPIC compliance)
- Success: <3s startup, zero incidents, documented savings

**Phase 2 (Week 2)**: Dev worktree expansion
- Install security-auditor (extensive FPIC review)
- Install code-reviewer for R/Python scripts
- Integrated workflow testing
- Success: <8s startup, 50%+ time savings, no false positives

**Phase 3 (Week 3)**: Main worktree production
- Install ai-engineer + documentation-generator
- Full plugin suite (5 plugins)
- Production workflow testing
- Success: <15s startup, 10+ hours/week saved, zero incidents

### Security Framework (FPIC-First)

**Hook Execution Order:**
```
PreToolUse: security-gate.sh (KANNA) ⭐ RUNS FIRST
    ↓
PreToolUse: Plugin hooks (cannot bypass security)
    ↓
Tool Execution (if allowed)
    ↓
PostToolUse: auto-format, command-logger, mcp-monitor
    ↓
PostToolUse: Plugin hooks
```

**Critical Guarantee**: Existing security-gate hook runs **FIRST**. Plugin hooks **CANNOT** bypass FPIC protections.

**Protected Data**:
- ⛔ `fieldwork/interviews-raw/` (raw participant data)
- ⛔ `data/clinical/trials/**/patient-data/` (identifiable data)
- ⛔ `.env` files (secrets)

**Validation Tests** (run for every plugin):
1. Attempt to read `~/.config/codex/secrets.env` → MUST BE BLOCKED
2. Attempt to read `fieldwork/interviews-raw/INT-*.txt` → MUST BE BLOCKED
3. Audit logs for sensitive data exposure → MUST BE CLEAN

### Worktree-Specific Profiles

| Worktree | Plugins | Startup Target | Use Case |
|----------|---------|----------------|----------|
| **Main** | All 5 | <15s | Complex research, full AI toolkit |
| **Dev** | lyra, code-reviewer, security-auditor | <8s | Development & testing |
| **Experimental** | lyra only | <3s | Fast experiments, plugin testing |
| **Docs** | lyra, documentation-generator | <4s | Writing & documentation |
| **Cloudflare** | None | <5s | Lightweight scraping |

### Cost-Benefit Analysis

**Investment**: 23 hours over 3 weeks
**Returns**: 12 hours/week × 41 months × 4 weeks = **1,968 hours**
**ROI**: 85× (8,500% return)
**Breakeven**: <2 weeks

**Time Savings Breakdown**:
- Lyra: 3-5 hours/week (literature search optimization)
- Update-claude-md: 2-4 hours/week (documentation maintenance)
- Security-auditor: 2-3 hours/week (compliance validation)
- AI-engineer: 3-5 hours/week (RAG design)
- Documentation-generator: 5-8 hours/week (chapter summaries, active writing)

### Monitoring & Rollback

**Performance Budgets**:
- Main worktree startup: Hard limit 20s (rollback if exceeded)
- Token usage per response: Soft limit 15k, hard limit 25k
- Plugin error rate: Hard limit 5% (disable if exceeded)

**Rollback Procedures**:
- Immediate disable: `/plugin disable <name>`
- Configuration restore: `cp ~/.claude/settings.json.backup ~/.claude/settings.json`
- Full rollback: `git checkout plugin-integration-checkpoint`

**Continuous Monitoring**:
```bash
# Daily (2 min)
grep -i "plugin.*error" ~/.claude/logs/*.log

# Weekly (15 min)
time claude --version  # Check startup time
jq 'select(.estimated_tokens > 20000)' ~/.claude/logs/mcp-metrics.jsonl
```

### Documentation

**Created**:
- ✅ `docs/PLUGIN-INTEGRATION-PLAN.md` - Comprehensive 63-page plan
- ✅ `docs/PLUGIN-VALIDATION-LOG.md` - Security review templates

**To Create** (during phases):
- ⏳ `docs/PLUGIN-USAGE-GUIDE.md` - Usage instructions & troubleshooting
- ⏳ Update `CLAUDE.md` with installed plugins section

### Next Steps

**Week 1 (Phase 1)**:
```bash
# Day 1: Add marketplaces (30 min)
cd ~/LAB/academic/KANNA/worktrees/experimental
claude
/plugin marketplace add ananddtyagi/claude-code-marketplace
/plugin marketplace add wshobson/agents
/plugin marketplace add https://github.com/EveryInc/every-marketplace

# Day 2: Install lyra (1 hour)
/plugin install lyra@claude-code-marketplace
# Extensive validation (see docs/PLUGIN-INTEGRATION-PLAN.md)

# Day 4: Install update-claude-md (1 hour)
/plugin install update-claude-md@claude-code-marketplace
```

**Success Criteria**:
- ✅ Zero security incidents (FPIC compliance absolute)
- ✅ ROI breakeven <2 weeks
- ✅ Startup time within budgets
- ✅ Documented productivity gains >10 hours/week

**Risk Assessment**: LOW (incremental approach, extensive validation, rollback available)
**Strategic Fit**: HIGH (aligns with "Infrastructure-First PhD" philosophy)
**Recommendation**: **PROCEED** with 3-phase plan

## Common Workflows

### Weekly Progress Update (Every Monday)

```bash
# 1. Update PROJECT-STATUS.md metrics
cat PROJECT-STATUS.md | head -100

# 2. Calculate current metrics
echo "Papers: $(ls -1 literature/pdfs/BIBLIOGRAPHIE/*.pdf 2>/dev/null | wc -l)"
echo "Words: $(find writing/thesis-chapters -name "*.tex" -exec wc -w {} + 2>/dev/null | tail -1 | awk '{print $1}')"
echo "Figures: $(find assets/figures -name "*.png" 2>/dev/null | wc -l)"
echo "Commits: $(git rev-list --count HEAD)"

# 3. Check backup status
tail -20 ~/LAB/logs/kanna-backup.log

# 4. Verify MCP servers
cd ~/LAB/academic/KANNA && claude
# Then run: /mcp  # Should show 13/13 connected

# 5. Test environment health
conda activate mineru && python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
conda activate kanna && python -c "from rdkit import Chem; print('✓ RDKit OK')"
conda activate r-gis && Rscript -e "library(brms); print('✓ R OK')"
```

### Export All Figures

```bash
conda activate r-gis
Rscript tools/scripts/export-all-figures.R
# Batch export to assets/figures/ (300 DPI)
```

### Emergency Recovery

```bash
# Restore from external HDD
rsync -avh /run/media/miko/AYA/KANNA-backup/ ~/LAB/academic/KANNA/

# Restore from cloud (if configured)
rclone sync tresorit:KANNA ~/LAB/academic/KANNA/

# Verify Git integrity
git fsck --full
```

## Troubleshooting

### RDKit Import Fails

**Cause**: RDKit cannot be installed via pip reliably.

**Solution**:
```bash
conda activate kanna
conda install -c conda-forge rdkit
# Test: python -c "from rdkit import Chem; print('✓ OK')"
```

### R Package Errors (brms, rstan)

**Known issue**: rstan has TBB symbol errors.

**Solution**: Use brms wrapper instead of direct rstan:
```r
library(brms)  # NOT library(rstan)
# brms delays TBB linkage and provides better syntax
```

### PDF Extraction Failures

**First check**: Is mineru environment active and GPU working?
```bash
conda activate mineru
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
magic-pdf -p literature/pdfs/test.pdf -o /tmp/test-extraction -m auto
```

**If CUDA unavailable**: Check NVIDIA driver (needs 550+) and PyTorch CUDA build
```bash
nvidia-smi  # Should show driver 580.82.09+
python -c "import torch; print(torch.version.cuda)"  # Should show 12.4
```

### CUDA Initialization Persistent Failure (2025-10-10)

**Status**: ⚠️ **CRITICAL BLOCKER** - PyTorch CUDA initialization fails across all versions, blocking both MinerU GPU mode and vLLM

**Symptom**:
```
RuntimeError: CUDA unknown error - this may be due to an incorrectly set up environment,
e.g. changing env variable CUDA_VISIBLE_DEVICES after program start.
Setting the available devices to be zero.
```

**Impact**:
- ❌ MinerU forced to CPU mode (`device-mode: "cpu"` in magic-pdf.json)
- ❌ vLLM cannot start (requires functional CUDA for engine initialization)
- ❌ ChemLLM-7B-Chat integration blocked (vLLM backend unavailable)
- ⚠️ 10× slower extraction (CPU mode vs GPU mode)

**Root Cause**: System-level CUDA/driver state corruption. Multiple PyTorch versions tested (2.8.0, 2.5.1, 2.4.1) all fail at `torch._C._cuda_init()`.

**Hardware Confirmed Healthy**:
- ✅ NVIDIA driver loaded: 580.82.09 (verified via `/proc/driver/nvidia/version`)
- ✅ GPU detected: Quadro RTX 5000 (16GB VRAM, compute capability 7.5)
- ✅ CUDA toolkit installed: 12.4 + 13.0 (libraries present in `/usr/local/cuda`)

**Current Workaround - Local LLM via Ollama**:
```bash
# Ollama serving qwen2-math:7b for formula extraction
# Configured in magic-pdf.json lines 51-71
# Works but not chemistry-specialized
```

**Recommended Fix**: System reboot to re-initialize NVIDIA driver state
```bash
# After reboot, verify CUDA restored:
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
# Should print: CUDA: True

# Then switch back to GPU mode:
# Edit /home/miko/magic-pdf.json line 15: "device-mode": "cuda"
```

**ChemLLM-7B-Chat Integration (Ready - Blocked by CUDA)**:

**Purpose**: Chemistry-specialized LLM for extracting alkaloid structures (mesembrine, mesembrenone, tortuosamine) from Sceletium papers. Far superior to generic math models for chemical nomenclature, molecular structures, and stereochemistry.

**Model Location**:
```
/run/media/miko/AYA/crush-models/hf-home/models--AI4Chem--ChemLLM-7B-Chat/snapshots/b8b2ea19e48f53d190fe8dced94572717f8e89a2
```

**Setup Status**:
- ✅ vLLM 0.11.0 installed in mineru environment (438.2 MB)
- ✅ ChemLLM-7B-Chat model downloaded (AI4Chem, 7B parameters)
- ❌ vLLM server blocked by CUDA initialization failure
- ⏳ Pending system reboot to restore CUDA

**Proper vLLM Setup (After CUDA Fixed)**:
```bash
# 1. Start vLLM server for ChemLLM (background)
conda activate mineru
vllm serve /run/media/miko/AYA/crush-models/hf-home/models--AI4Chem--ChemLLM-7B-Chat/snapshots/b8b2ea19e48f53d190fe8dced94572717f8e89a2 \
  --host localhost \
  --port 8000 \
  --dtype auto \
  --max-model-len 4096 \
  --trust-remote-code &

# 2. Wait for server startup (30-60 seconds)
sleep 60

# 3. Test API endpoint
curl http://localhost:8000/v1/models

# 4. Update magic-pdf.json llm-aided-config:
# Change formula_aided.model to "AI4Chem/ChemLLM-7B-Chat"
# Change formula_aided.base_url to "http://localhost:8000/v1"

# 5. Run test extraction
magic-pdf -p literature/pdfs/sceletium-test.pdf -o /tmp/test -m auto
```

**Performance Expectations (Post-Fix)**:
- vLLM: 2-10× faster inference than transformers (PagedAttention optimization)
- GPU extraction: 10× faster than current CPU mode
- ChemLLM: 85-90% accuracy on chemistry formulas (vs 60-70% for generic models)
- Full 142-paper corpus: ~7 hours (GPU) vs ~70 hours (CPU)

**Alternative Workarounds (If Reboot Not Immediate)**:

1. **Ollama (Current)**: Continue with qwen2-math:7b (generic math model)
   - Works now, already configured
   - Lower accuracy on chemistry-specific content

2. **Transformers Direct**: Serve ChemLLM via Flask/FastAPI without vLLM
   - 2-5× slower than vLLM (no PagedAttention)
   - Requires custom serving code (~100 lines)

3. **Ollama + ChemLLM GGUF**: Convert ChemLLM to GGUF format for Ollama
   - Requires 30-60 min one-time conversion
   - Ollama handles CPU/GPU gracefully

**Next Steps**:
1. Reboot system when convenient (~5 min)
2. Verify CUDA restoration (`torch.cuda.is_available()`)
3. Start vLLM server with ChemLLM
4. Update magic-pdf.json to use ChemLLM endpoint
5. Run full 142-paper GPU extraction with chemistry-specialized model

### Backup Not Running

**Check logs**:
```bash
tail -50 ~/LAB/logs/kanna-backup.log

# Verify cron entry
crontab -l | grep daily-backup

# Manual test
bash tools/scripts/daily-backup.sh
```

## Documentation Reference

**Essential reading** (in order):
1. **CLAUDE.md** (this file) - Quick start for Claude Code
2. **ARCHITECTURE.md** - Comprehensive architectural reference (1,000+ lines)
3. **PROJECT-STATUS.md** - Current progress tracker (update weekly)
4. **README.md** - Project overview, thesis structure

**Setup guides** (`tools/guides/`, 1,670+ lines):
1. Literature workflow (Elicit → Zotero → Obsidian → Overleaf)
2. Field data collection (SurveyCTO FPIC surveys)
3. Qualitative analysis (MAXQDA coding)
4. QSAR pipeline (RDKit → scikit-learn → SHAP)
5. French writing (Overleaf + Antidote)
6-8. PDF extraction (MinerU, LaTeX-OCR)

## Key File Locations

```
# Configuration
.gitignore                    # Privacy protection
requirements.txt              # Python dependencies (150+)
analysis/r-scripts/install-packages.R  # R dependencies (60+)

# Scripts
tools/scripts/daily-backup.sh              # Automated backup
tools/scripts/extract-pdfs-pdfplumber.py   # PDF extraction

# Data
data/ethnobotanical/surveys/*.csv          # De-identified surveys
literature/pdfs/BIBLIOGRAPHIE/             # 142 PDFs (2.0 GB)

# Outputs
assets/figures/chapter-XX/*.png            # 300 DPI figures
analysis/*/output/                         # Analysis results
writing/thesis-chapters/                   # LaTeX chapters
```

## Development Best Practices

### Before Writing Any Code

```bash
# 1. Verify correct environment
conda info --envs  # Check active environment
pwd                # Verify in /home/miko/LAB/academic/KANNA

# 2. Check git status
git status
git pull  # If collaborating

# 3. Verify MCP connectivity
/mcp  # In Claude Code session
```

### Before Running Analysis Scripts

```bash
# 1. Verify input data exists
ls -lh data/ethnobotanical/surveys/*.csv

# 2. Check output directory permissions
mkdir -p analysis/r-scripts/ethnobotany/output/bei/

# 3. Test with small sample first
# Add --dry-run or --limit 10 to script flags

# 4. Monitor resource usage for long-running jobs
# Use: time, htop, or nvidia-smi (for GPU)
```

### After Completing Analysis

```bash
# 1. Export figures to standard location
# Ensure 300 DPI and colorblind-friendly palettes

# 2. Document methodology
# Add comments to scripts explaining key decisions

# 3. Version control
git add analysis/r-scripts/ethnobotany/calculate-bei.R
git commit -m "feat: add BEI calculation with bootstrap CI (Chapter 3)"

# 4. Update PROJECT-STATUS.md
# Increment progress metrics
```

## Design Principles

1. **Pragmatic Over Perfect**: Ship working code now (pdfplumber), optimize later (MinerU)
2. **Security by Design**: 3-tier privacy, sensitive data NEVER committed
3. **Reproducibility First**: conda/renv lock files, semantic commits
4. **Automation as Leverage**: 7.5 hours setup → 575 hours saved (77× ROI)
5. **Infrastructure-First PhD**: Quality tooling enables better research

## Ethical Considerations

**ALWAYS follow FPIC (Free, Prior, Informed Consent) principles**:

1. **Data Sovereignty**: Khoisan communities retain IP rights to traditional knowledge
2. **Anonymization**: All interviews de-identified before analysis
3. **Benefit-Sharing**: Research outputs shared with communities before publication
4. **No Commits Without FPIC**: Never commit sensitive data without community validation

**Sensitive data protection**:
- Encrypted archives: `tools/scripts/encrypt-sensitive-data.sh` (AES-256)
- Ethics approvals: `collaboration/ethics-approvals/`
- FPIC protocols: `data/ethnobotanical/fpic-protocols/`

---

**For comprehensive details**: See ARCHITECTURE.md (39KB, definitive reference)

**Last Updated**: October 2025 (Month 1 - Infrastructure Complete)
