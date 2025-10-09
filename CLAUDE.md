# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

42-month interdisciplinary PhD thesis on *Sceletium tortuosum* (Kanna) spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical analysis. Repository contains research data, analysis scripts, writing, and comprehensive tool integration.

**Key Metrics**: 120,000-word thesis, 8 chapters, 15-20 publications, 142 papers corpus (974K words), 98/100 infrastructure health.

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
    cd ~/LAB/projects/KANNA
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
/mcp  # Should show 17 connected servers
```

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
```

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
0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1

# Manual trigger
bash tools/scripts/daily-backup.sh
```

**Backups**:
1. Working: `~/LAB/projects/KANNA/` (SSD)
2. Local: `/run/media/miko/AYA/KANNA-backup/` (1.4TB external HDD)
3. Cloud: Tresorit/SpiderOak (AES-256, ready to configure)

### Zotero Integration (Pending Setup)

**Guide**: `tools/guides/01-literature-workflow-setup.md`

**Workflow**: Elicit → Zotero (Better BibTeX) → Obsidian → Overleaf

```bash
# Bibliography auto-export path
literature/zotero-export/kanna.bib  # Real-time sync

# LaTeX citation
\citep{klak2025}
\bibliography{kanna}
```

## MCP Server Integration

**Inherited from `~/LAB/`**: 17 MCP servers available

**Key servers**:
- **Context7**: Up-to-date docs (RDKit, scikit-learn, ggplot2)
- **Perplexity**: AI-powered search for recent Sceletium papers
- **GitHub**: Repository management
- **Cloudflare Browser**: Web scraping, markdown conversion
- **Cloudflare Radar**: Internet intelligence, domain rankings
- **Cloudflare Container**: Ephemeral sandbox for safe experiments

**Usage**: Access via `/mcp` command in Claude Code session.

## Common Workflows

### Weekly Progress Update

```bash
# Update PROJECT-STATUS.md (every Monday)
cat PROJECT-STATUS.md | head -100

# Calculate metrics
ls -1 literature/pdfs/*.pdf | wc -l         # Papers read
find writing/ -name "*.tex" -exec wc -w {} + | tail -1  # Words written
find assets/figures/ -name "*.png" | wc -l  # Figures created
git rev-list --count HEAD                   # Commits
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
rsync -avh /run/media/miko/AYA/KANNA-backup/ ~/LAB/projects/KANNA/

# Restore from cloud (if configured)
rclone sync tresorit:KANNA ~/LAB/projects/KANNA/

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
