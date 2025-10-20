# KANNA Project - Conda Environment Configuration

## Three-Environment Strategy

Critical design decision: Three separate conda environments to avoid dependency conflicts.

### Environment 1: `kanna` (Python 3.10)

**Purpose**: Cheminformatics, machine learning, QSAR modeling

**Location**: `/home/miko/miniforge3/envs/kanna/`

**Activation**: `conda activate kanna`

**Critical Packages**:
- **RDKit** - Cheminformatics foundation
  - **MUST install via conda**: `conda install -c conda-forge rdkit`
  - **NEVER via pip** - pip installation unreliable
- NumPy - Numerical computing
- Pandas - Data manipulation
- scikit-learn - Machine learning
- XGBoost - Gradient boosting
- spaCy (+ en_core_web_sm model) - NLP
- sentence-transformers - Embeddings
- BERTopic - Topic modeling
- SHAP - Model interpretation
- Jupyter - Interactive notebooks
- BioPython - Biological sequence analysis
- PubChemPy - Chemical data retrieval
- statsmodels - Statistical modeling

**Installation Source**: `requirements.txt` (100+ packages)

**Validation Command**:
```bash
/home/miko/miniforge3/envs/kanna/bin/python -c "from rdkit import Chem; import numpy as np; import pandas as pd; import sklearn; print('✓ kanna OK')"
```

**Use Cases**:
- Chapter 4: QSAR modeling, molecular fingerprints
- Chapter 6: Machine learning for addiction models
- Data analysis: ChemLLM integration, compound analysis

### Environment 2: `r-gis` (R 4.4.3)

**Purpose**: Statistical analysis, GIS, Bayesian modeling, meta-analysis

**Location**: `/home/miko/miniforge3/envs/r-gis/`

**Activation**: `conda activate r-gis`

**Critical Packages** (installed via conda-forge):
- **brms** 2.23.0 - Bayesian regression modeling
  - Note: Use `library(brms)` instead of `library(rstan)` to avoid TBB symbol errors
- **sf** - Spatial data analysis
  - GEOS 3.14.0, GDAL 3.11.4, PROJ 9.7.0
- **metafor** 4.8-0 - Meta-analysis
- **vegan** - Community ecology statistics
- **igraph** - Network analysis
- **tidyverse** 2.0.0:
  - dplyr 1.1.4
  - ggplot2 4.0.0
  - tidyr 1.3.1
  - readr 2.1.5
  - purrr 1.1.0
  - stringr 1.5.2
  - forcats 1.0.1
  - lubridate 1.9.4
  - tibble 3.3.0

**Installation Method**:
```bash
conda install -n r-gis -c conda-forge r-sf r-brms r-metafor r-vegan r-igraph r-tidyverse -y
```

**Why conda-forge instead of CRAN**: Avoids complex dependency resolution errors

**Validation Command**:
```bash
/home/miko/miniforge3/envs/r-gis/bin/Rscript -e "library(brms); library(sf); library(metafor); library(tidyverse); cat('✓ r-gis OK\n')"
```

**Use Cases**:
- Chapters 2-3: GIS analysis, botanical distribution maps
- Chapter 5: Meta-analysis of clinical trials
- Statistics: Bayesian regression, spatial modeling

### Environment 3: `mineru` (Python 3.10)

**Purpose**: GPU-accelerated PDF extraction for scientific papers

**Location**: `/home/miko/miniforge3/envs/mineru/`

**Activation**: `conda activate mineru`

**Critical Packages**:
- **PyTorch** 2.6.0+cu124 - Deep learning framework
- **CUDA** 12.4 - GPU acceleration
- **MinerU** 2.5.4 - PDF extraction tool
- **uv** - Fast Python package installer

**GPU Status**: ✅ CUDA available (verified October 18, 2025)

**Validation Command**:
```bash
/home/miko/miniforge3/envs/mineru/bin/python -c "import torch; print(f'PyTorch {torch.__version__}'); print(f'CUDA: {torch.cuda.is_available()}'); print(f'CUDA version: {torch.version.cuda}')"
```

**Expected Output**:
```
PyTorch 2.6.0+cu124
CUDA: True
CUDA version: 12.4
```

**Use Cases**:
- PDF extraction from 142-paper corpus
- Chemical structure extraction from papers
- Table and formula extraction
- 10× faster than CPU mode

## Environment Isolation Rationale

**Why Three Separate Environments**:

1. **mineru isolation**: 
   - MinerU needs specific transformers 4.49.0 (incompatible with kanna's 4.57.0)
   - Clean PyTorch+CUDA environment resolved CUDA Error 999
   - GPU acceleration critical for performance

2. **kanna isolation**:
   - Python ML tools (transformers, torch) conflict with R spatial libraries (GDAL, PROJ)
   - RDKit has specific dependency requirements
   - Prevents version conflicts with statistical packages

3. **r-gis isolation**:
   - R spatial packages (sf, GDAL, PROJ) have complex C++ dependencies
   - Bayesian packages (brms, rstan) need specific compiler toolchains
   - Prevents conflicts with Python environments

## Quick Reference

### Environment Selection by Task

| Task | Environment | Key Packages |
|------|-------------|--------------|
| QSAR modeling | kanna | RDKit, scikit-learn, SHAP |
| GIS analysis | r-gis | sf, GEOS, GDAL, PROJ |
| Meta-analysis | r-gis | metafor, brms |
| PDF extraction | mineru | PyTorch, CUDA, MinerU |
| NLP analysis | kanna | spaCy, sentence-transformers |
| Network analysis | r-gis | igraph, tidyverse |
| Bayesian stats | r-gis | brms (not rstan directly!) |

### Common Commands

```bash
# Check active environment
conda info --envs

# Activate specific environment
conda activate kanna
conda activate r-gis
conda activate mineru

# Deactivate environment
conda deactivate

# List packages in environment
conda list -n kanna
conda list -n r-gis
conda list -n mineru

# Update environment
conda update -n kanna --all
```

## Known Issues & Solutions

**Issue**: rstan TBB symbol errors
**Solution**: Use `library(brms)` instead of `library(rstan)` - brms delays TBB linkage

**Issue**: RDKit pip installation fails
**Solution**: Always use `conda install -c conda-forge rdkit`

**Issue**: R CRAN package dependency errors
**Solution**: Use conda-forge channel: `conda install -n r-gis -c conda-forge r-{package}`

**Issue**: CUDA unavailable in mineru
**Solution**: Check NVIDIA driver (needs 550+) and PyTorch CUDA build

## Installation Date

All three environments created and validated: **October 18, 2025**

## Maintenance Notes

- Update conda environments quarterly (or before major analysis phases)
- Test GPU availability monthly (`torch.cuda.is_available()`)
- Keep environment YAML exports for reproducibility
- Document any new package additions in project notes
