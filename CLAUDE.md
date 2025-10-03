# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a 42-month PhD thesis project on *Sceletium tortuosum* (Kanna), an interdisciplinary analysis spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical issues. The repository contains research data, analysis scripts, writing, and a comprehensive tool integration system.

**Thesis Structure**: 8 chapters, ~120,000 words
**Expected Outputs**: 6-8 first-author publications, 50-100 ethnobotanical interviews, QSAR models for 32 alkaloids

## Core Development Commands

### Environment Setup

```bash
# Python environment (cheminformatics via conda recommended)
conda create -n kanna python=3.10
conda activate kanna
conda install -c conda-forge rdkit  # Required for QSAR modeling
pip install -r requirements.txt

# Alternative: venv (without RDKit)
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# R environment (renv for reproducibility)
Rscript analysis/r-scripts/install-packages.R
# Then in R: renv::snapshot() to lock versions

# Quick access alias (add to ~/.zshrc)
alias kanna="cd ~/LAB/projects/KANNA && source venv/bin/activate"
```

### Running Analyses

```bash
# Ethnobotany: Calculate BEI/ICF from survey data
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R
# Outputs: analysis/r-scripts/ethnobotany/output/bei/*.png

# QSAR modeling: Predict IC50 for alkaloids
python analysis/python/cheminformatics/qsar-modeling.py
# Outputs: analysis/python/ml-models/qsar-output/

# Jupyter notebooks (interactive analysis)
jupyter lab
# Navigate to: analysis/jupyter-notebooks/
```

### Testing & Validation

```bash
# Test Python environment
python -c "import pandas, numpy, matplotlib, sklearn; print('✓ Core packages OK')"
python -c "from rdkit import Chem; print('✓ RDKit installed')"

# Test R environment
Rscript -e "library(tidyverse); library(metafor); print('✓ R packages OK')"

# Check spaCy NLP model
python -m spacy download en_core_web_sm  # Download if missing
```

### Daily Workflow

```bash
# 1. Start Claude Code with MCP integration
cd ~/LAB/projects/KANNA
claude
# Use /mcp to verify Context7, Perplexity, GitHub connections

# 2. Check status
git status
cat PROJECT-STATUS.md

# 3. Run daily backup (automated via cron at 2 AM)
~/LAB/projects/KANNA/tools/scripts/daily-backup.sh

# 4. Export all figures to assets/
Rscript tools/scripts/export-all-figures.R

# 5. Commit progress
git add -A
git commit -m "feat: improve QSAR model R² from 0.72 to 0.85"
git push
```

## Architecture & Key Patterns

### Data Flow Architecture

The project follows a **discover → analyze → write** pattern with strict separation of concerns:

```
Literature Discovery (Elicit/Perplexity/MCP)
    ↓
Reference Management (Zotero + Better BibTeX)
    ↓
Knowledge Graph (Obsidian)
    ↓
Data Collection (SurveyCTO for field, LC-MS for chem)
    ↓
Analysis (R for stats/ethnobotany, Python for ML/cheminformatics)
    ↓
Visualization (ggplot2/matplotlib → 300 DPI PNG)
    ↓
Writing (Overleaf LaTeX + Writefull/Trinka)
    ↓
Version Control (Git with nbstripout for notebooks)
```

### Critical Design Patterns

**1. Reproducible Research via renv/requirements.txt**

- R packages locked in `renv.lock` (run `renv::snapshot()` after installing new packages)
- Python packages in `requirements.txt` with version pins
- RDKit MUST be installed via conda (not pip) to avoid compilation issues

**2. Sensitive Data Protection**

The `.gitignore` MUST exclude:
- `fieldwork/interviews-raw/` - Raw interview audio/transcripts
- `data/ethnobotanical/interviews/*.wav` - Audio recordings
- `data/clinical/trials/**/patient-data/` - Identifiable clinical data
- `.env` - API keys and credentials

**3. Analysis Output Structure**

All analysis scripts follow this pattern:
```
Input:  data/{discipline}/{subdomain}/raw-data.csv
Script: analysis/{language}-scripts/{chapter}/analysis-name.{R|py}
Output: analysis/{language}-scripts/{chapter}/output/{analysis-type}/
Final:  assets/figures/chapter-{XX}/{figure-name}.png (300 DPI)
```

**4. Chapter-Specific Workflows**

Each chapter has a dedicated analysis pipeline documented in `OPTIMIZED-THESIS-WORKFLOW.md`:

- **Chapter 2** (Botany): QGIS → IQ-TREE 3 → FigTree → R (PCA) → LaTeX
- **Chapter 3** (Ethnobotany): SurveyCTO → MAXQDA → R (ethnobotanyR) → ggplot2 → LaTeX
- **Chapter 4** (Pharmacology): PubChem → RDKit → scikit-learn → SHAP → PyMOL → LaTeX
- **Chapter 5** (Clinical): Rayyan → RevMan → metafor (R) → forest plots → LaTeX

### QSAR Modeling Pipeline (Chapter 4)

The `analysis/python/cheminformatics/qsar-modeling.py` script implements a complete ML pipeline:

1. **Descriptor Calculation**: 200+ RDKit molecular descriptors
2. **Feature Selection**: SelectKBest (F-test) to reduce to top 50
3. **Preprocessing**: StandardScaler for normalization
4. **Model Training**: Random Forest + XGBoost with GridSearchCV
5. **Interpretation**: SHAP values for explainability
6. **Output**: Trained models saved as `.pkl`, predictions as CSV, figures as 300 DPI PNG

**Key hyperparameters**:
- Random Forest: n_estimators=[100-300], max_depth=[10-30]
- XGBoost: learning_rate=[0.01-0.1], max_depth=[3-7]
- 5-fold cross-validation, R² scoring

**Expected performance**: R² ≥ 0.80 for publication quality

### BEI Calculation (Chapter 3)

The `analysis/r-scripts/ethnobotany/calculate-bei.R` script calculates:

- **BEI** (Botanical Ethnobotanical Index): Taxa per informant
- **ICF** (Informant Consensus Factor): Agreement on use categories
- **Statistical tests**: ANOVA across communities, Tukey HSD post-hoc

**Input format** (`data/ethnobotanical/surveys/survey-2025.csv`):
```csv
informant_id,community,taxon,use_category,n_uses
INF001,SC01,Sceletium tortuosum,Medicinal,3
```

**Output**: 3 publication-ready figures (bei-by-community, icf-by-category, taxa-distribution)

## Integration Points

### Zotero → Obsidian → LaTeX Pipeline

```bash
# 1. Zotero: Import PDFs, auto-extract metadata
# 2. Install Better BibTeX plugin
# 3. Configure auto-export:
#    Right-click "KANNA Thesis" collection → Export → Better BibLaTeX
#    Save to: literature/zotero-export/kanna.bib
#    ✓ Keep updated

# 4. Obsidian: Link Zotero
#    Install plugin: Zotero Integration
#    Import annotations from Zotero library

# 5. LaTeX (Overleaf):
#    Upload kanna.bib (or link if Overleaf Premium)
#    \bibliography{kanna}
#    Cite with: \citep{klak2025}
```

### Git Workflow with nbstripout

Jupyter notebooks are stripped of outputs before commit to reduce repo size:

```bash
# Install nbstripout
pip install nbstripout
nbstripout --install --attributes .gitattributes

# This auto-strips outputs on commit
# To view outputs, run notebooks locally
```

### MCP Server Usage (LAB Integration)

This project inherits MCP capabilities from the parent LAB workspace:

- **Context7**: Fetch up-to-date docs for RDKit, scikit-learn, ggplot2
- **Perplexity**: Search recent Sceletium research papers
- **GitHub**: Manage commits, PRs (if collaborating)
- **Jupyter**: Remote notebook execution (if configured)

Access via Claude Code `/mcp` command in this directory.

## Quality Control & Standards

### Publication-Ready Figures

All figures MUST meet these criteria:
- **Resolution**: 300 DPI minimum
- **Format**: PNG for raster, PDF for vector (phylogenetic trees)
- **Fonts**: Readable at print size (≥10pt)
- **Colors**: Colorblind-friendly palettes (viridis, RColorBrewer)

```R
# R (ggplot2)
ggsave("figure.png", width=8, height=6, dpi=300)

# Python (matplotlib)
plt.savefig("figure.png", dpi=300, bbox_inches='tight')
```

### Code Style

**Python**: Follow PEP 8 (enforced via black + ruff in pre-commit hook)

```bash
# Format before commit
black analysis/python/
ruff check analysis/python/ --fix
```

**R**: Follow tidyverse style guide

```R
# Use tidyverse conventions
library(tidyverse)
data %>%
  filter(condition) %>%
  mutate(new_col = value)
```

### Commit Message Convention

Use semantic prefixes for clarity:
- `feat:` - New analysis, script, or feature
- `fix:` - Bug fix in code
- `docs:` - Documentation updates (including writing)
- `refactor:` - Code restructuring
- `data:` - New data added (de-identified only)

```bash
# Good examples
git commit -m "feat: add SHAP interpretation to QSAR model"
git commit -m "fix: correct ICF calculation for zero use reports"
git commit -m "docs: draft Chapter 4 Section 4.3 (750 words)"
```

## Common Pitfalls & Solutions

### Problem: RDKit import fails

**Cause**: RDKit cannot be installed via pip reliably
**Solution**: Use conda exclusively for RDKit

```bash
conda create -n kanna python=3.10
conda activate kanna
conda install -c conda-forge rdkit
pip install -r requirements.txt
```

### Problem: R package installation fails (brms, rstan)

**Cause**: Bayesian packages require compilation
**Solution**: Install system dependencies first

```bash
# Ubuntu/Debian
sudo apt-get install build-essential libcurl4-gnutls-dev libssl-dev

# Then in R:
install.packages("rstan", repos = "https://cloud.r-project.org/")
```

### Problem: QSAR model R² < 0.70

**Solutions**:
1. Add more diverse descriptors (3D conformers via `AllChem.EmbedMolecule`)
2. Expand hyperparameter grid (see `OPTIMIZED-THESIS-WORKFLOW.md`)
3. Try ensemble stacking (RF + XGBoost + LightGBM)
4. Check for outliers in training data

### Problem: Git repo becomes too large (> 1 GB)

**Cause**: Large PDFs, raw LC-MS data, audio files committed
**Solution**: Use Git LFS or exclude entirely

```bash
# Install Git LFS
git lfs install

# Track large files
git lfs track "*.pdf"
git lfs track "*.wiff"
git add .gitattributes
git commit -m "chore: configure Git LFS"
```

## Documentation Reference

**In this repository**:
- `README.md` - Project overview, thesis structure, data organization
- `PROJECT-STATUS.md` - Current progress tracker (update weekly)
- `OPTIMIZED-THESIS-WORKFLOW.md` - **Master workflow guide** (200+ pages, daily/weekly/monthly workflows)
- `QUICK-START.md` - Day 1 setup instructions (accounts, tools, first analysis)
- `tools/COMPREHENSIVE-RESEARCH-TOOLS-2025.md` - 200+ tool recommendations for PhDs

**External resources**:
- RDKit documentation: https://www.rdkit.org/docs/
- ethnobotanyR: https://github.com/CWWhitney/ethnobotanyR
- metafor guide: https://www.metafor-project.org/doku.php

## Ethical Considerations

**ALWAYS follow these principles when working with this codebase**:

1. **Free, Prior, Informed Consent (FPIC)**: Never commit interview data without community validation
2. **Data Sovereignty**: Khoisan communities retain IP rights to their traditional knowledge
3. **Anonymization**: All interview transcripts MUST be de-identified before analysis
4. **Benefit-Sharing**: Research outputs should be shared with community partners before publication

**When adding data**:
- Check if it's in `.gitignore` (interviews, clinical patient data, audio)
- If sensitive, use encrypted local storage only
- Document FPIC protocols in `collaboration/ethics-approvals/`

## Key File Locations

**Analysis scripts**:
- R: `analysis/r-scripts/{ethnobotany|statistics|meta-analysis}/`
- Python: `analysis/python/{cheminformatics|ml-models|text-mining}/`
- Jupyter: `analysis/jupyter-notebooks/`

**Data**:
- Ethnobotany: `data/ethnobotanical/surveys/` (CSV from SurveyCTO)
- Chemistry: `data/phytochemical/alkaloid-profiles/` (SMILES, IC50 values)
- Clinical: `data/clinical/trials/` (meta-analysis data)

**Writing**:
- Thesis chapters: `writing/thesis-chapters/ch0{1-8}-{name}/`
- Publications: `writing/publications/`
- LaTeX bibliography: `literature/zotero-export/kanna.bib`

**Outputs**:
- Figures: `assets/figures/chapter-{XX}/` (final, 300 DPI)
- Tables: `assets/tables/`
- Models: `analysis/python/ml-models/qsar-output/*.pkl`

## When to Use Which Tool

**Literature Discovery**: Elicit (AI-powered), Perplexity MCP (recent papers), Rayyan (systematic reviews)
**Reference Management**: Zotero + Better BibTeX (auto-export to LaTeX)
**Knowledge Graph**: Obsidian (daily notes, concept linking)
**Statistical Analysis**: R (ethnobotanyR, metafor, lme4)
**Cheminformatics**: Python + RDKit (QSAR, descriptors)
**Machine Learning**: scikit-learn (Random Forest), XGBoost (gradient boosting), SHAP (interpretation)
**Molecular Docking**: AutoDock Vina (PDE4/SERT), PyMOL (visualization)
**Writing**: Overleaf (LaTeX), Writefull/Trinka (grammar/style)
**Version Control**: Git (code/analysis), Overleaf Git sync (writing)

## Success Metrics

Track progress in `PROJECT-STATUS.md` weekly:
- **Words written**: Target 120,000 total (check with `find writing/ -name "*.tex" -exec wc -w {} + | tail -1`)
- **Papers read**: Target 500 (check Zotero collection count)
- **Figures created**: Target 50 publication-ready (check `assets/figures/`)
- **Git commits**: ~200/year for reproducibility
- **Publications**: 6-8 first-author papers

## File Naming Conventions

The project uses standardized naming patterns for traceability and data governance:

**Ethnobotanical Interviews**:
```
INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.{ext}
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

**Clinical Trials**:
```
TRIAL-{YYYYMMDD}-{StudyID}-{ArmID}.csv
```

These conventions ensure FPIC compliance (de-identified from day 1) and enable automated data pipelines.

## Data Privacy Architecture

The repository implements a **three-tier data classification system**:

**Tier 1: Git-Excluded Sensitive Data** (never commit)
- Raw interviews: `fieldwork/interviews-raw/**`
- Identifiable clinical data: `data/clinical/trials/**/patient-data/**`
- Personal info: `collaboration/khoisan-partners/**/contact-info/**`
- API keys: `*.env`, `credentials.json`

**Tier 2: Git LFS Large Files** (external storage)
- Raw LC-MS: `*.raw`, `*.wiff`, `*.d/`
- High-res images: `*.tif`, fieldwork RAW photos
- Genomic data: `*.fastq`, `*.bam`
- Molecular libraries: `*.sdf`, `*.mol2`

**Tier 3: Git-Tracked Reproducible Assets**
- De-identified survey data: `data/ethnobotanical/surveys/*.csv`
- Analysis scripts: `analysis/**/*.{R|py}`
- Publication figures: `assets/figures/**/*.png`
- Thesis chapters: `writing/thesis-chapters/**/*.tex`

**Enforcement**: The `.gitignore` uses directory wildcards (`**`) to prevent accidental commits of entire sensitive subdirectories, not just file extensions.

## Claude Code Integration

This repository has pre-approved tool permissions in `.claude/settings.local.json`:

```json
{
  "permissions": {
    "allow": ["mcp__playwright__browser_navigate", "WebSearch"]
  }
}
```

This enables autonomous web-based research workflows (documentation scraping, literature discovery) without requiring user approval for each action.

**MCP Inheritance**: This project inherits all MCP servers from the parent LAB workspace (`~/LAB/CLAUDE.md`), including:
- Context7 (library documentation)
- Perplexity (AI-powered search)
- GitHub (version control)
- Jupyter (remote notebooks)
- Cloudflare servers (browser automation, intelligence gathering)

## Backup Strategy (3-2-1 Rule)

The `tools/scripts/daily-backup.sh` implements professional backup automation:

**3 Copies**:
1. Working directory: `~/LAB/projects/KANNA/`
2. External HDD: `/media/backup/KANNA/` (rsync)
3. Encrypted cloud: `tresorit:KANNA` (rclone)

**2 Media Types**:
- Local storage (SSD/HDD)
- Cloud storage (Tresorit/SpiderOak)

**1 Off-Site**:
- Cloud backup auto-encrypted

**Automation**:
```bash
# Add to crontab for daily 2 AM execution
crontab -e
# Add: 0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1
```

**Features**:
- Auto-commit uncommitted changes to Git (WIP snapshots)
- Excludes large files (`*.raw`, `*.wiff`, `venv/`)
- Backup verification (size checks)
- Log rotation (keeps last 30 days)

## Template-Driven Development

The repository uses **documentation-first development**—READMEs document planned scripts before implementation:

**Planned Scripts** (from `analysis/README.md`):
- `calculate-icf.R` - Informant Consensus Factor
- `cultural-diversity-index.R` - CUDI calculations
- `network-analysis.R` - Knowledge transmission networks
- `deepchem-bbb.py` - Blood-brain barrier permeability
- `literature-scraping.py` - PubMed/PMC scraping

**Currently Implemented**:
- `calculate-bei.R` - Botanical Ethnobotanical Index ✅
- `qsar-modeling.py` - QSAR ML pipeline ✅
- `daily-backup.sh` - Automated backups ✅
- `export-all-figures.R` - Batch figure export ✅

This pattern allows thesis planning without premature implementation. New scripts should follow existing templates in `analysis/{language}-scripts/`.

## Setup Guides (Workflows Complets)

**NEW**: Comprehensive step-by-step integration guides created October 2025.

### Quick Access

1. **[Literature Workflow](tools/guides/01-literature-workflow-setup.md)** - Elicit → Zotero → Obsidian → Overleaf
   - 400+ lines, bilingual (French/English)
   - Includes Obsidian templates, troubleshooting, daily workflow
   - Target: 500+ papers in Zotero, 200+ notes in Obsidian

2. **[Field Data Collection](tools/guides/02-field-data-collection-setup.md)** - SurveyCTO FPIC-compliant surveys
   - XLSForm design for BEI/ICF data
   - Offline GPS + audio consent workflow
   - Integration with R ethnobotanyR package

3. **[Qualitative Analysis](tools/guides/03-qualitative-analysis-setup.md)** - MAXQDA ethnographic coding
   - Code system for traditional knowledge
   - Inter-rater reliability (κ ≥ 0.70)
   - Mixed methods integration

4. **[QSAR Pipeline](tools/guides/04-qsar-pipeline-setup.md)** - RDKit → scikit-learn → SHAP
   - 200+ descriptor calculation
   - Hyperparameter tuning for R² ≥ 0.80
   - Publication-ready SHAP plots

5. **[French Writing](tools/guides/05-french-writing-setup.md)** - Overleaf + Paperpal + Antidote
   - LaTeX thesis template for Université de Paris
   - Free Paperpal + paid Antidote grammar checking
   - Bilingual workflow, 120,000-word target

**Implementation Timeline**:
- Week 1: Guides 1 + 5 (literature + writing)
- Week 2: Guide 2 (field data before first mission)
- As needed: Guides 3-4 (when data arrives)

See `tools/README.md` for complete guide index.

---

## Getting Help

1. **Setup workflows**: See `tools/guides/` for 5 comprehensive step-by-step guides
2. **Tool-specific issues**: Consult `OPTIMIZED-THESIS-WORKFLOW.md` Section VII (Troubleshooting)
3. **Workflow questions**: See `QUICK-START.md` for daily/weekly patterns
4. **MCP servers**: Use Claude Code `/mcp` command, or check `~/LAB/CLAUDE.md` (parent workspace)
5. **Research methods**: Refer to `tools/COMPREHENSIVE-RESEARCH-TOOLS-2025.md`
6. **Data organization**: Check subdirectory READMEs (e.g., `data/ethnobotanical/README.md`)

---

**Last Updated**: October 2025
**Maintainer**: PhD Candidate researching *Sceletium tortuosum*
**Thesis Duration**: 42 months (2025-2028)
**Data Classification**: Three-tier privacy architecture (sensitive/large/reproducible)
**Backup Schedule**: Daily 2 AM via cron (3-2-1 rule)
