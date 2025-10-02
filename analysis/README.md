# Analysis Scripts & Computational Workflows

## Directory Purpose

All analysis scripts for the KANNA thesis, organized by programming language and research domain.

## Directory Structure

```
analysis/
├── r-scripts/              # R statistical analyses
│   ├── ethnobotany/       # BEI, ICF, consensus indices
│   ├── statistics/        # General statistics, mixed models
│   └── meta-analysis/     # Clinical trial meta-analyses
│
├── python/                 # Python analyses
│   ├── cheminformatics/   # RDKit, molecular modeling
│   ├── ml-models/         # Machine learning, QSAR
│   └── text-mining/       # NLP, literature mining
│
└── jupyter-notebooks/      # Interactive analyses
```

## R Scripts (`r-scripts/`)

### Ethnobotany
- `calculate-bei.R` - Botanical Ethnobotanical Index
- `calculate-icf.R` - Informant Consensus Factor
- `cultural-diversity-index.R` - CUDI calculations
- `network-analysis.R` - Knowledge transmission networks (NetworkX, Gephi)

**Key packages**:
```r
library(ethnobotanyR)  # Quantitative ethnobotany
library(vegan)         # Diversity indices
library(igraph)        # Network analysis
```

### Statistics
- `mixed-effects-models.R` - Dose-response curves (lme4, nlme)
- `survival-analysis.R` - Time-to-relapse (survival package)
- `bayesian-inference.R` - Stan/brms models
- `power-analysis.R` - Sample size calculations

**Key packages**:
```r
library(lme4)      # Mixed-effects models
library(brms)      # Bayesian regression
library(survival)  # Survival analysis
library(pwr)       # Power calculations
```

### Meta-Analysis
- `clinical-trials-meta.R` - Meta-analysis of anxiety/depression trials
- `forest-plots.R` - Publication-ready forest plots
- `publication-bias.R` - Funnel plots, Egger's test
- `heterogeneity-analysis.R` - I² statistics, subgroup analyses

**Key packages**:
```r
library(metafor)   # Meta-analysis
library(meta)      # Alternative meta-analysis
library(dmetar)    # Meta-analysis utilities
```

## Python Scripts (`python/`)

### Cheminformatics
- `rdkit-descriptors.py` - Calculate molecular descriptors
- `fingerprints.py` - Generate Morgan/MACCS fingerprints
- `similarity-clustering.py` - Chemical similarity analysis
- `admet-predictions.py` - SwissADME API integration

**Key libraries**:
```python
from rdkit import Chem, DataStructs
from rdkit.Chem import Descriptors, AllChem
import chembl_webresource_client  # ChEMBL API
```

### Machine Learning
- `qsar-modeling.py` - QSAR models (Random Forest, XGBoost)
- `deepchem-bbb.py` - BBB permeability (DeepChem)
- `neural-networks.py` - PyTorch/TensorFlow models
- `feature-selection.py` - SHAP, feature importance

**Key libraries**:
```python
import scikit-learn  # Classical ML
import deepchem      # Chemical deep learning
import xgboost       # Gradient boosting
import shap          # Model interpretation
```

### Text Mining
- `literature-scraping.py` - PubMed/Europe PMC scraping
- `nlp-pipeline.py` - spaCy NER for alkaloid names
- `topic-modeling.py` - BERTopic for literature themes
- `semantic-search.py` - BERT embeddings for literature search

**Key libraries**:
```python
import spacy              # NLP
from bertopic import BERTopic  # Topic modeling
from sentence_transformers import SentenceTransformer  # BERT
```

## Jupyter Notebooks (`jupyter-notebooks/`)

Interactive analyses with visualizations, ideal for:
- Exploratory data analysis (EDA)
- Prototyping analysis pipelines
- Creating publication figures
- Interactive reporting

**Organization**:
- `01-data-exploration/` - Initial EDA
- `02-statistical-analyses/` - Statistical testing
- `03-machine-learning/` - ML model development
- `04-visualizations/` - Figure generation

## Analysis Standards

### Code Quality
- ✅ Clear comments explaining logic
- ✅ Modular functions (DRY principle)
- ✅ Version control (Git)
- ✅ Type hints (Python) or documentation (R)

### Reproducibility
- 📦 `requirements.txt` (Python) or `renv.lock` (R)
- 🐳 Docker containers for complex workflows
- 📝 README in each subdirectory
- 🔢 Set random seeds for reproducibility

### Output Organization
```
analysis/{script-name}/
  ├── code.{R|py}           # Analysis script
  ├── output/               # Generated results
  │   ├── figures/         # Plots (PNG, PDF)
  │   ├── tables/          # CSV, Excel
  │   └── models/          # Saved models (.rds, .pkl)
  └── README.md            # Analysis documentation
```

## AI-Assisted Analysis Workflow

Based on the LAB workspace AI/ML tools (see `~/LAB/CLAUDE.md`):

### Local AI Tools (Privacy-Preserving)
- **Ollama + Llama 3.1 70B**: Literature synthesis, paraphrasing sensitive ethnobotanical data
- **Local R/Python**: All statistical analyses run locally

### Cloud AI Tools (Non-Sensitive Data)
- **Claude MAX**: Draft methods sections, explain complex statistics
- **ChatGPT Pro**: Quick R/Python debugging
- **Perplexity AI**: Research latest QSAR techniques

### MCP Server Integration
- **Context7**: Get up-to-date documentation for `RDKit`, `metafor`, `DeepChem`
- **GitHub MCP**: Version control operations
- **Jupyter MCP**: Remote notebook execution

## Common Analysis Workflows

### 1. Ethnobotanical Survey Analysis
```r
# R workflow
source("analysis/r-scripts/ethnobotany/calculate-bei.R")
source("analysis/r-scripts/ethnobotany/calculate-icf.R")

# Load survey data
data <- read.csv("data/ethnobotanical/surveys/survey-2025.csv")

# Calculate indices
bei <- calculate_bei(data)
icf <- calculate_icf(data)

# Visualize
ggplot(bei, aes(x = community, y = index)) + geom_boxplot()
```

### 2. QSAR Modeling
```python
# Python workflow
import pandas as pd
from rdkit_descriptors import calculate_descriptors
from qsar_modeling import train_random_forest

# Load chemical data
df = pd.read_csv("data/phytochemical/alkaloid-profiles/sert-ic50.csv")

# Calculate descriptors
descriptors = calculate_descriptors(df['smiles'])

# Train QSAR model
model, metrics = train_random_forest(descriptors, df['ic50'])
print(f"R² = {metrics['r2']:.3f}, RMSE = {metrics['rmse']:.3f}")
```

### 3. Clinical Meta-Analysis
```r
# R workflow
library(metafor)

# Load clinical trial data
trials <- read.csv("data/clinical/trials/anxiety-rcts.csv")

# Random-effects meta-analysis
meta <- rma(yi = mean_diff, sei = se, data = trials, method = "REML")

# Forest plot
forest(meta, slab = trials$study, header = "Study")
```

## Performance Optimization

### R Performance
- Use `data.table` for large datasets (>1M rows)
- Parallelize with `parallel`, `foreach`
- Profile code with `profvis`

### Python Performance
- Use `numpy` for numerical operations
- Vectorize with `pandas`
- Parallelize with `multiprocessing`, `joblib`
- GPU acceleration with `cupy`, `PyTorch`

### Memory Management
- Process data in chunks for large files
- Use `gc()` (R) or `del` (Python) to free memory
- Monitor with `pryr::mem_used()` or `psutil`

## Troubleshooting

### Common R Issues
- **Error: package not found** → `install.packages("package")`
- **Error: object not found** → Check data loading, object names
- **Memory issues** → Increase R memory: `options(java.parameters = "-Xmx8g")`

### Common Python Issues
- **ModuleNotFoundError** → `pip install module`
- **Version conflicts** → Use virtual environments (`venv`)
- **RDKit import error** → Install via conda: `conda install -c conda-forge rdkit`

## Related Resources

- Thesis methodology: `writing/thesis-chapters/ch01-introduction/methods.md`
- Software setup: `tools/installation-guides/`
- Example data: `data/**/examples/`
- Templates: `tools/templates/`

---
*Last updated: October 2025*
