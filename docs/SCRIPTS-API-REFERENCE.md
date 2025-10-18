# KANNA Project - Scripts & API Reference

**Last Updated**: October 2025
**Purpose**: Complete reference for all scripts, analysis tools, and reproducible workflows

---

## 📖 Table of Contents

1. [Utility Scripts](#utility-scripts) - Backup, extraction, compilation
2. [Analysis Scripts](#analysis-scripts) - Python (QSAR, ML) and R (stats, GIS)
3. [Environment Management](#environment-management) - Conda activation and validation
4. [MCP Server APIs](#mcp-server-apis) - Integration points and usage
5. [Custom Commands](#custom-commands) - Claude Code enhancements
6. [Reproducibility Patterns](#reproducibility-patterns) - Standard workflows

---

## 🛠️ Utility Scripts

### PDF Extraction

#### **`extract-pdfs-mineru-production.sh`** ⭐ Production

**Purpose**: GPU-accelerated PDF extraction for scientific papers (100% success rate)

**Requirements**:
- Conda environment: `mineru`
- GPU: CUDA 12.4 (verify with `torch.cuda.is_available()`)
- MinerU 2.5.4

**Usage**:
```bash
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  <input-directory> \
  <output-directory>
```

**Example**:
```bash
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/
```

**Output Structure**:
```
extractions-mineru/[paper-name]/
├── auto/
│   ├── [paper-name].md          # Markdown with embedded images
│   ├── images/                  # Extracted chemical structures, diagrams
│   ├── [paper-name]_layout.pdf  # Visual verification
│   └── [paper-name]_*.json      # Metadata
```

**Performance**:
- GPU mode: 10× faster than CPU
- Quality: Superior for chemical formulas, tables, complex layouts
- Models: DocLayout-YOLO (2501), Unimernet (2503), RapidTable

**Troubleshooting**:
- Check GPU: `python -c "import torch; print(torch.cuda.is_available())"`
- CPU fallback: Edit `magic-pdf.json` line 15 to `"device-mode": "cpu"`

---

#### **`consolidate-pdf-extractions.sh`**

**Purpose**: Merge multiple extraction outputs into single consolidated directory

**Usage**:
```bash
bash tools/scripts/consolidate-pdf-extractions.sh
```

**Output**: Consolidates all `extractions-*/` directories

---

#### **`extract-pdfs-hybrid.sh`** (Legacy)

**Purpose**: Hybrid extraction with fallback strategies
**Status**: Replaced by MinerU production script

---

### Backup & Security

#### **`daily-backup.sh`** ⭐ Automated

**Purpose**: 3-2-1 backup strategy (SSD → HDD → Cloud)

**Automated**:
```bash
# Crontab entry (runs daily at 2 AM)
0 2 * * * /home/miko/LAB/academic/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1
```

**Manual**:
```bash
bash tools/scripts/daily-backup.sh
```

**Backup Locations**:
1. Working: `~/LAB/academic/KANNA/` (SSD)
2. Local: `/run/media/miko/AYA/KANNA-backup/` (1.4TB HDD)
3. Cloud: Tresorit/SpiderOak (ready to configure)

**Verification**:
```bash
tail -20 ~/LAB/logs/kanna-backup.log
```

---

#### **`encrypt-sensitive-data.sh`**

**Purpose**: AES-256 encryption for FPIC-compliant sensitive data

**Usage**:
```bash
bash tools/scripts/encrypt-sensitive-data.sh <input-directory>
```

**Protected Data**:
- `fieldwork/interviews-raw/` - Raw participant data
- `data/clinical/trials/**/patient-data/` - Identifiable clinical data
- `.env` files - Secrets and API keys

**Output**: Encrypted archives with `.enc` extension

---

### Academic Writing

#### **`check-grammar-french.sh`** ⭐ French Grammar

**Purpose**: LanguageTool French grammar checking for thesis chapters

**Requirements**:
- LanguageTool 6.4 (installed in `tools/languagetool/`)
- Java 17+ (OpenJDK 17.0.13)

**Usage**:
```bash
./tools/scripts/check-grammar-french.sh <input.md> [output.txt]
```

**Example**:
```bash
./tools/scripts/check-grammar-french.sh writing/chapter-01.md
```

**Output**:
- Console: First 20 issues preview
- File: `writing/chapter-01-grammar-report.txt` (full report)

**Features**:
- French language checking (`--language fr`)
- Whitespace rule disabled
- Issue counting and severity classification
- Integration with `/academic-enhance-fr` command

---

#### **`compile-thesis-pdf.sh`**

**Purpose**: LaTeX compilation for complete thesis PDF

**Requirements**:
- LaTeX distribution (TeX Live, MacTeX, MiKTeX)
- Bibliography file: `writing/references.bib`

**Usage**:
```bash
bash tools/scripts/compile-thesis-pdf.sh
```

**Output**: `writing/thesis.pdf` (complete thesis with all chapters)

**Compilation Steps**:
1. LaTeX → PDF (first pass)
2. BibTeX → bibliography processing
3. LaTeX → PDF (resolve references)
4. LaTeX → PDF (final formatting)

---

#### **`analyze-citation-network.sh`**

**Purpose**: VOSviewer citation network analysis for literature review

**Requirements**:
- VOSviewer 1.6.20 (manual download required)
- Java 17+
- 142-paper corpus metadata

**Usage**:
```bash
bash tools/scripts/analyze-citation-network.sh
```

**Features**:
- Co-citation analysis (papers cited together)
- Bibliographic coupling (shared references)
- Keyword co-occurrence (thematic clusters)
- Publication-ready 300 DPI network visualizations

**Output**: `assets/figures/chapter-01/citation-network-*.png`

---

### Data Collection

#### **`chembl-target-search.py`**

**Purpose**: ChEMBL database queries for target proteins (SERT, PDE4)

**Requirements**:
- Conda environment: `kanna`
- ChEMBL web services API

**Usage**:
```bash
conda activate kanna
python tools/scripts/chembl-target-search.py --target SERT
```

**Parameters**:
- `--target` - Target protein (SERT, PDE4A, PDE4B, PDE4D)
- `--output` - Output CSV file

**Output**: CSV with bioactivity data (IC50, Ki, EC50)

---

#### **`coconut-query.py`**

**Purpose**: COCONUT natural products database queries

**Requirements**:
- Conda environment: `kanna`
- COCONUT API access

**Usage**:
```bash
conda activate kanna
python tools/scripts/coconut-query.py --compound mesembrine
```

**Output**: Natural product data (structure, source, bioactivity)

---

### Installation & Configuration

#### **`setup-languagetool.sh`**

**Purpose**: Automated LanguageTool installation and configuration

**Usage**:
```bash
bash tools/scripts/setup-languagetool.sh
```

**Actions**:
1. Download LanguageTool 6.4
2. Extract to `tools/languagetool/`
3. Validate Java version
4. Generate wrapper script

---

#### **`sync-zotero-bib.sh`** (To be created)

**Purpose**: Zotero bibliography validation and git commit

**Planned Usage**:
```bash
bash tools/scripts/sync-zotero-bib.sh
```

**Actions**:
1. Validate `literature/zotero-export/kanna.bib`
2. Check BibTeX syntax
3. Commit to git if changed

---

## 🧬 Analysis Scripts

### Python Analysis (`analysis/python/`)

#### **`cheminformatics/qsar-modeling.py`** ⭐ Chapter 4

**Purpose**: QSAR modeling for alkaloid activity prediction

**Requirements**:
- Conda environment: `kanna`
- RDKit, scikit-learn, SHAP, XGBoost

**Usage**:
```bash
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py \
  --input data/phytochemical/alkaloid-profiles.csv \
  --target SERT_IC50 \
  --output analysis/python/cheminformatics/output/qsar/
```

**Parameters**:
- `--input` - Compound data CSV (SMILES, activity)
- `--target` - Activity column (SERT_IC50, PDE4_IC50)
- `--fingerprint` - Fingerprint type (Morgan, MACCS, RDKit)
- `--model` - ML model (RandomForest, XGBoost, SVM)
- `--output` - Output directory

**Pipeline**:
1. **Data Loading**: Load compound SMILES and activity data
2. **Fingerprint Generation**: RDKit molecular fingerprints (Morgan, radius=2)
3. **Train-Test Split**: 80/20 stratified split
4. **Model Training**: Random Forest / XGBoost / SVM
5. **Cross-Validation**: 5-fold CV with MAE/RMSE/R²
6. **SHAP Interpretation**: Feature importance analysis
7. **Visualization**: Performance plots, SHAP plots

**Output**:
```
output/qsar/
├── model.pkl                  # Trained model
├── performance-metrics.csv    # MAE, RMSE, R²
├── feature-importance.png     # SHAP summary plot
├── predicted-vs-actual.png    # Regression plot
└── cv-results.csv             # Cross-validation results
```

**Expected Performance**: R² ≥ 0.70 (target for publication)

---

### R Analysis (`analysis/r-scripts/`)

#### **`ethnobotany/calculate-bei.R`** ⭐ Chapter 3

**Purpose**: Botanical Economic Index (BEI) calculation for ethnobotanical surveys

**Requirements**:
- Conda environment: `r-gis`
- tidyverse, ethnobotanyR, ggplot2

**Usage**:
```bash
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R \
  --input data/ethnobotanical/surveys/survey-2025.csv \
  --output analysis/r-scripts/ethnobotany/output/bei/
```

**Input Data Format**:
```csv
respondent_id,plant_species,use_category,frequency
P001,Sceletium tortuosum,medicinal,frequent
P001,Sceletium tortuosum,ceremonial,occasional
P002,Sceletium tortuosum,medicinal,frequent
```

**Calculations**:
1. **BEI (Botanical Economic Index)**: Total use frequency per species
2. **ICF (Informant Consensus Factor)**: Agreement on medicinal uses
3. **FL (Fidelity Level)**: Specificity for particular ailments
4. **UV (Use Value)**: Overall cultural importance

**Output**:
```
output/bei/
├── bei-by-community.csv       # BEI scores
├── icf-by-category.csv        # ICF scores
├── bei-by-community.png       # Visualization (300 DPI)
└── statistical-summary.txt    # Descriptive stats
```

**Bootstrap Confidence Intervals**: 1,000 iterations for robust estimation

---

#### **`install-packages.R`**

**Purpose**: Automated R package installation for r-gis environment

**Requirements**:
- Conda environment: `r-gis`
- conda-forge channel

**Usage**:
```bash
conda activate r-gis
Rscript analysis/r-scripts/install-packages.R
```

**Packages Installed**:
- **Bayesian**: brms, rstan (via brms wrapper)
- **GIS**: sf, GEOS, GDAL, PROJ
- **Meta-analysis**: metafor
- **Data Science**: tidyverse (dplyr, ggplot2, tidyr, etc.)
- **Ecology**: vegan
- **Networks**: igraph

**Why conda-forge**: Avoids complex dependency errors from CRAN

---

#### **`meta-analysis/clinical-trials.R`** (Planned)

**Purpose**: Meta-analysis of clinical trials (Chapter 5)

**Requirements**:
- Conda environment: `r-gis`
- metafor, brms, tidyverse

**Planned Usage**:
```bash
conda activate r-gis
Rscript analysis/r-scripts/meta-analysis/clinical-trials.R \
  --input data/clinical/trials/trials-data.csv \
  --output analysis/r-scripts/meta-analysis/output/
```

**Methods**:
- Random-effects meta-analysis
- Forest plots
- Heterogeneity analysis (I², τ²)
- Publication bias assessment (funnel plots, Egger's test)

---

## 🐍 Environment Management

### Conda Activation Patterns

**Standard Activation**:
```bash
# Check available environments
/home/miko/miniforge3/bin/conda info --envs

# Activate specific environment
conda activate kanna      # Python cheminformatics, ML
conda activate r-gis      # R statistics, GIS
conda activate mineru     # PDF extraction (GPU)

# Deactivate
conda deactivate
```

**Quick Access Alias** (add to `~/.zshrc`):
```bash
kanna() {
    cd ~/LAB/academic/KANNA
    conda activate r-gis  # Default
    echo "✅ KANNA (R 4.4.3) | Switch: conda activate kanna | PDF: conda activate mineru"
}
```

### Validation Commands

**kanna environment**:
```bash
conda activate kanna
python -c "from rdkit import Chem; import sklearn; import pandas; import numpy; print('✓ kanna OK')"
```

**r-gis environment**:
```bash
conda activate r-gis
Rscript -e "library(brms); library(sf); library(metafor); library(tidyverse); cat('✓ r-gis OK\n')"
```

**mineru environment**:
```bash
conda activate mineru
python -c "import torch; print(f'PyTorch {torch.__version__}'); print(f'CUDA: {torch.cuda.is_available()}'); print(f'CUDA version: {torch.version.cuda}')"
```

**Expected Output (mineru)**:
```
PyTorch 2.6.0+cu124
CUDA: True
CUDA version: 12.4
```

### Environment Selection Guide

| Task | Environment | Reason |
|------|-------------|--------|
| QSAR modeling | `kanna` | RDKit (conda-only), scikit-learn |
| GIS analysis | `r-gis` | sf, GEOS, GDAL, PROJ |
| Meta-analysis | `r-gis` | metafor, brms (Bayesian) |
| PDF extraction | `mineru` | PyTorch CUDA, MinerU |
| NLP analysis | `kanna` | spaCy, transformers |
| Network analysis | `r-gis` | igraph, tidyverse |
| Bayesian stats | `r-gis` | brms (NOT rstan directly!) |

**Critical Note**: Use `library(brms)` instead of `library(rstan)` to avoid TBB symbol errors.

---

## 🔌 MCP Server APIs

### Core MCP Servers

**Filesystem MCP**:
```bash
# Read file
mcp__filesystem__read_text_file(path="/path/to/file.txt")

# Write file
mcp__filesystem__write_file(path="/path/to/file.txt", content="...")

# List directory
mcp__filesystem__list_directory(path="/path/to/dir")
```

**Git MCP**:
```bash
# Status
mcp__github__git-status(directory="/home/miko/LAB/academic/KANNA")

# Add all
mcp__github__git-add-all(directory="/home/miko/LAB/academic/KANNA")

# Commit
mcp__github__git-commit(message="feat: ...", directory="/home/miko/LAB/academic/KANNA")

# Push
mcp__github__git-push(directory="/home/miko/LAB/academic/KANNA")
```

**Context7 MCP**:
```bash
# Resolve library ID
mcp__context7__resolve-library-id(libraryName="rdkit")

# Get library docs
mcp__context7__get-library-docs(context7CompatibleLibraryID="/rdkit/rdkit", topic="fingerprints")
```

**Perplexity MCP**:
```bash
# AI-powered search (recent papers)
# Use for: "Latest Sceletium tortuosum research 2024"
```

**Sequential MCP**:
```bash
# Structured multi-step reasoning
mcp__sequential-thinking__sequentialthinking(
  thought="Step 1: Analyze problem...",
  thoughtNumber=1,
  totalThoughts=5,
  nextThoughtNeeded=true
)
```

**Memory MCP**:
```bash
# Create entity
mcp__memory__create_entities(entities=[{
  name: "QSAR Model",
  entityType: "analysis",
  observations: ["Trained on 50 alkaloids", "R² = 0.85"]
}])

# Read graph
mcp__memory__read_graph()

# Search nodes
mcp__memory__search_nodes(query="alkaloid")
```

**RAG Query MCP**:
```bash
# Search literature corpus (142 papers)
# Use for: "Search corpus for alkaloid biosynthesis studies"
```

**FPIC Validator MCP**:
```bash
# Validate file for FPIC compliance
mcp__fpic-validator__validate_file(file_path="data/ethnobotanical/interviews/INT-20250315-SC01-P007.txt")

# Check protected path
mcp__fpic-validator__check_protected_path(path="fieldwork/interviews-raw/")
```

**Bibliography MCP**:
```bash
# Search bibliography
mcp__bibliography__search_bibliography(query="mesembrine pharmacology", max_results=10)

# Get citation
mcp__bibliography__get_citation(citation_key="gericke2021", format="inline")

# Get by author
mcp__bibliography__get_by_author(author_name="Gericke")
```

---

## 🎨 Custom Commands

### `/academic-enhance-fr [document]`

**Purpose**: French academic writing enhancement with 4-dimension analysis

**Usage**:
```
/academic-enhance-fr "chapter-03-ethnobotany.pdf"
```

**Features**:
- **Tone Analysis**: Impersonal voice, academic formality
- **Depth Analysis**: Theoretical rigor, evidence quality
- **Structure Analysis**: Logical flow, transitions
- **Bibliography Analysis**: Citation density, source diversity

**Integration**:
- Perplexity MCP (academic mode)
- Memory MCP (persistent context)
- Automatic document location (pdfs/, writing/, extractions-mineru/)

**Output**: Detailed report with improvement suggestions

**Documentation**: `.claude/commands/academic-enhance-fr.md`

---

## 📊 Reproducibility Patterns

### Standard Analysis Pipeline

**Pattern**: Input → Script → Output → Figure

**Example (QSAR)**:
```bash
# 1. Input data
data/phytochemical/alkaloid-profiles.csv

# 2. Analysis script
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py \
  --input data/phytochemical/alkaloid-profiles.csv \
  --target SERT_IC50 \
  --output analysis/python/cheminformatics/output/qsar/

# 3. Output results
analysis/python/cheminformatics/output/qsar/performance-metrics.csv

# 4. Publication figure
assets/figures/chapter-04/qsar-performance.png (300 DPI)
```

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
git commit -m "data: add 20 new de-identified ethnobotanical surveys"
git commit -m "docs: draft Chapter 3 Section 3.4 (1200 words)"
```

### Quality Standards

**Publication-Ready Figures**:
```r
# R (ggplot2)
ggsave("assets/figures/chapter-03/bei-by-community.png",
       width=8, height=6, dpi=300)
```

```python
# Python (matplotlib)
plt.savefig("assets/figures/chapter-04/qsar-performance.png",
            dpi=300, bbox_inches='tight')
```

**Requirements**:
- Resolution: 300 DPI minimum
- Fonts: ≥10pt at print size
- Colors: Colorblind-friendly (viridis, RColorBrewer)
- Output: `assets/figures/chapter-{XX}/`

---

## 🔧 Troubleshooting

### Common Script Issues

**RDKit Import Fails**:
```bash
# Problem: RDKit not installed or wrong environment
# Solution:
conda activate kanna
conda install -c conda-forge rdkit
python -c "from rdkit import Chem; print('✓ OK')"
```

**R brms/rstan Errors**:
```bash
# Problem: TBB symbol errors with direct rstan
# Solution: Use brms wrapper
library(brms)  # NOT library(rstan)
```

**GPU Unavailable (mineru)**:
```bash
# Problem: CUDA initialization failed
# Check:
conda activate mineru
python -c "import torch; print(torch.cuda.is_available())"

# If False, check:
nvidia-smi  # Driver should show 580+
python -c "import torch; print(torch.version.cuda)"  # Should show 12.4

# Temporary fix: CPU mode
# Edit magic-pdf.json line 15: "device-mode": "cpu"
```

**Script Not Executable**:
```bash
# Problem: Permission denied
# Solution:
chmod +x tools/scripts/script-name.sh
```

### Environment Debugging

**List All Packages**:
```bash
conda list -n kanna      # Python environment
conda list -n r-gis      # R environment
conda list -n mineru     # MinerU environment
```

**Check Active Environment**:
```bash
conda info --envs        # Shows active environment with *
echo $CONDA_DEFAULT_ENV  # Print current environment name
```

**Reinstall Environment** (if corrupted):
```bash
# Backup package list first
conda list -n kanna --export > kanna-packages.txt

# Remove and recreate
conda env remove -n kanna
conda create -n kanna python=3.10
conda activate kanna
conda install -c conda-forge rdkit
pip install -r requirements.txt
```

---

## 📚 Quick Reference Tables

### Script Summary by Category

| Category | Script | Environment | Status |
|----------|--------|-------------|--------|
| **PDF Extraction** | extract-pdfs-mineru-production.sh | mineru | ✅ Production |
| **Backup** | daily-backup.sh | None | ✅ Automated |
| **Security** | encrypt-sensitive-data.sh | None | ✅ Ready |
| **Grammar** | check-grammar-french.sh | None | ✅ Ready |
| **Citation** | analyze-citation-network.sh | None | ⚠️ VOSviewer download |
| **LaTeX** | compile-thesis-pdf.sh | None | ✅ Ready |
| **QSAR** | qsar-modeling.py | kanna | ✅ Ready |
| **BEI** | calculate-bei.R | r-gis | ✅ Ready |
| **ChEMBL** | chembl-target-search.py | kanna | ✅ Ready |

### Analysis Script Outputs

| Script | Input | Output | Figure |
|--------|-------|--------|--------|
| qsar-modeling.py | alkaloid-profiles.csv | performance-metrics.csv, model.pkl | qsar-performance.png |
| calculate-bei.R | survey-2025.csv | bei-by-community.csv | bei-by-community.png |
| chembl-target-search.py | Target name | bioactivity-data.csv | - |
| coconut-query.py | Compound name | natural-product-data.csv | - |

### MCP Server Capabilities

| Server | Primary Use | Chapter Relevance |
|--------|-------------|-------------------|
| filesystem | File operations | All |
| git | Version control | All |
| context7 | Library docs (RDKit, sf) | 4, 2-3 |
| perplexity | Recent papers | 1, All |
| sequential | Complex reasoning | 4, 6 |
| memory | Cross-session context | All |
| rag-query | Corpus search | 1, Literature |
| fpic-validator | Ethics compliance | 3, 7 |
| bibliography | Citation management | All |

---

**Last Updated**: October 2025 (Month 1 - Infrastructure Complete)

**Next Updates**:
- Add meta-analysis script documentation (Chapter 5)
- Document Obsidian knowledge graph workflows
- Add Zotero sync script when created

**Maintained By**: Claude Code with comprehensive script analysis
**Purpose**: Reproducible research workflows for KANNA PhD thesis
