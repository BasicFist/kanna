# R Environment Setup for KANNA Project

**Status**: ✅ Production Ready
**Created**: 2025-10-06
**Environment**: `r-gis` (conda)
**R Version**: 4.4.3 (2025-02-28)

## Overview

This document describes the isolated conda R environment (`r-gis`) configured for the KANNA PhD thesis project. The environment provides GIS capabilities, Bayesian modeling, data science tools, and meta-analysis packages.

## Why Conda for R?

**Problem**: System-wide R package installation leads to:
- Version conflicts between packages
- Compiler issues with spatial libraries (GDAL, GEOS, PROJ)
- Difficult-to-reproduce environments across systems

**Solution**: Isolated conda environment with pre-compiled binaries
- All dependencies managed by conda-forge
- No manual compilation required
- Reproducible across Linux, macOS, Windows

## Environment Specifications

### Core Packages

| Package | Version | Purpose | Chapter |
|---------|---------|---------|---------|
| sf | 1.0.21 | Spatial data analysis | 2 (Botany) |
| brms | 2.23.0 | Bayesian modeling | 3 (Ethnobotany) |
| rstan | 2.32.7 | Stan backend (via brms) | 3, 5 |
| tidyverse | 2.0.0 | Data manipulation & viz | All |
| metafor | 4.8.0 | Meta-analysis | 5 (Clinical) |
| renv | 1.0.11 | Dependency management | Infrastructure |

### Spatial Libraries (via sf)

- **GDAL**: 3.11.4 (Geospatial Data Abstraction Library)
- **GEOS**: 3.14.0 (Geometry Engine, Open Source)
- **PROJ**: 9.7.0 (Cartographic Projections Library)

### System Configuration

- **OS**: Fedora 42 (Linux 6.16.9)
- **Compiler**: GCC 15.2.1
- **Conda**: miniforge3 25.7.0
- **TBB**: 2021.13.0 (Intel Threading Building Blocks)

## Installation Instructions

### 1. Create Environment

```bash
conda create -n r-gis \
  -c conda-forge \
  r-base=4.4 \
  r-sf \
  r-brms \
  r-rstan \
  r-tidyverse \
  r-metafor \
  r-renv \
  r-ggplot2 \
  r-dplyr \
  r-readr \
  r-here
```

**Duration**: ~15-20 minutes (downloads 200+ packages)

### 2. Activate Environment

```bash
conda activate r-gis
```

**Verification**:
```bash
which R
# Should show: /home/miko/miniforge3/envs/r-gis/bin/R
```

### 3. Test Installation

```bash
conda run -n r-gis Rscript -e "
library(sf)        # GIS
library(brms)      # Bayesian modeling
library(tidyverse) # Data science
library(metafor)   # Meta-analysis
cat('✅ All packages loaded successfully\n')
"
```

**Expected output**: All libraries load without errors

## Usage Patterns

### Daily Workflow

```bash
# Activate environment
conda activate r-gis

# Run analysis scripts
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R
Rscript analysis/r-scripts/statistics/phylogenetic-pca.R

# Interactive R session
R
```

### From Jupyter

Create R kernel for Jupyter notebooks:

```bash
conda activate r-gis
R -e "install.packages('IRkernel')"
R -e "IRkernel::installspec(name='r-gis', displayname='R (KANNA GIS)')"
```

Then select "R (KANNA GIS)" kernel in Jupyter Lab.

### From RStudio

**Option 1: Use conda R**

In RStudio, set custom R version:
- Tools → Global Options → General
- R version: `/home/miko/miniforge3/envs/r-gis/bin/R`
- Restart RStudio

**Option 2: Launch RStudio from conda**

```bash
conda activate r-gis
rstudio &
```

## Known Issues & Workarounds

### Issue 1: Direct `library(rstan)` Fails with TBB Error

**Error**:
```
unable to load shared object '.../rstan.so':
undefined symbol: _ZN3tbb8internal26task_scheduler_observer_v37observeEb
```

**Cause**: Conda-forge rstan 2.32.7 binary was compiled against TBB 2022 API but environment has TBB 2021.13.0

**Workaround**: ✅ Use `library(brms)` instead
- brms wraps rstan with better error handling
- Delays TBB linkage until model compilation
- Provides ggplot2-like formula syntax (easier than Stan language)

**Example**:
```r
# ❌ Don't do this:
library(rstan)
stan_code <- "..."
model <- stan(model_code = stan_code, ...)

# ✅ Do this instead:
library(brms)
model <- brm(bf(BEI ~ community + (1|informant)),
             data = survey_data,
             family = gaussian())
```

### Issue 2: User Library Conflicts

**Symptom**: Packages installed in `~/R/` interfere with conda environment

**Solution**: Moved user library to backup
```bash
mv ~/R ~/R.backup
```

**Prevention**: Set `R_LIBS_USER=""` in environment-level `.Renviron`:
```bash
echo 'R_LIBS_USER=""' > ~/miniforge3/envs/r-gis/.Renviron
```

This ensures conda environment has priority over user library.

### Issue 3: System R vs Conda R Confusion

**Symptom**: Running `R` loads system R 4.5.1 instead of conda R 4.4.3

**Solution**: Always activate environment first
```bash
conda activate r-gis
which R  # Verify correct R
```

**Auto-activation**: Add to `~/.zshrc`:
```bash
# KANNA project auto-activation
kanna() {
    cd ~/LAB/projects/KANNA
    conda activate r-gis
    echo "✅ KANNA environment activated (R 4.4.3)"
}
```

Then simply run `kanna` to activate.

## Package Management with renv

While the conda environment provides base packages, use `renv` for project-specific package versions:

### Initialize renv

```r
# In R session within KANNA directory
setwd("~/LAB/projects/KANNA")
library(renv)
renv::init()
```

### Install Additional Packages

```r
# Install from CRAN
install.packages("ethnobotanyR")
install.packages("ape")  # Phylogenetic analysis

# Lock versions
renv::snapshot()
```

### Restore Environment

```r
# On new system or after git clone
renv::restore()
```

**Important**: `renv.lock` file is tracked in Git, ensuring reproducibility across systems.

## Testing & Verification

### Comprehensive Test Suite

Run this script to verify all functionality:

```bash
conda run -n r-gis Rscript -e "
# Test 1: GIS
library(sf)
nc <- st_read(system.file('shape/nc.shp', package='sf'), quiet=TRUE)
cat('✅ sf:', packageVersion('sf'), '- Loaded', nrow(nc), 'counties\n')

# Test 2: Bayesian
library(brms)
cat('✅ brms:', packageVersion('brms'), '\n')

# Test 3: Data Science
library(tidyverse)
test_data <- tibble(x = 1:5, y = x^2)
cat('✅ tidyverse:', packageVersion('tidyverse'), '\n')

# Test 4: Meta-Analysis
library(metafor)
cat('✅ metafor:', packageVersion('metafor'), '\n')

cat('\n✅ ALL TESTS PASSED\n')
"
```

### Chapter-Specific Tests

**Chapter 2 (Botany)**:
```r
library(sf)
library(tidyverse)

# Test shapefile reading
sites <- st_read("data/gis/field-sites.shp")
plot(sites$geometry)
```

**Chapter 3 (Ethnobotany)**:
```r
library(brms)
library(tidyverse)

# Test Bayesian BEI model
data <- read_csv("data/ethnobotanical/surveys/survey-2025.csv")
model <- brm(bf(n_taxa ~ community + (1|informant_id)),
             data = data,
             family = poisson())
summary(model)
```

**Chapter 5 (Clinical Meta-Analysis)**:
```r
library(metafor)
library(tidyverse)

# Test random-effects meta-analysis
data <- read_csv("data/clinical/trials/meta-analysis-data.csv")
res <- rma(yi = effect_size, sei = std_error, data = data)
forest(res)
```

## Troubleshooting

### Problem: Conda environment activation fails

```bash
# Re-initialize conda
conda init bash  # or zsh
source ~/.bashrc  # or ~/.zshrc
```

### Problem: Packages not found after installation

```r
# Check library paths
.libPaths()

# Should show:
# [1] "/home/miko/miniforge3/envs/r-gis/lib/R/library"
```

If user library appears first:
```bash
mv ~/R ~/R.backup
```

### Problem: GDAL/GEOS/PROJ version errors

```bash
# Reinstall sf with explicit dependencies
conda install -n r-gis -c conda-forge --force-reinstall \
  gdal geos proj r-sf
```

### Problem: Compilation errors during package install

Use conda-forge pre-compiled binaries instead of CRAN:
```bash
# ❌ Don't install from CRAN in R:
# install.packages("sf")

# ✅ Install from conda-forge:
conda install -n r-gis -c conda-forge r-sf
```

## Performance Optimization

### Parallel Processing

Enable multi-core processing for Bayesian models:

```r
library(brms)
options(mc.cores = parallel::detectCores())

# Models will now use all CPU cores
model <- brm(bf(...), cores = 4, chains = 4)
```

### Memory Management

For large datasets (>1 GB):

```r
# Use data.table instead of tibble
library(data.table)
data <- fread("large-file.csv")

# Enable disk caching for brms
options(brms.file_refit = "on_change")
```

## Integration with Git

**What to track**:
- ✅ `renv.lock` - Package versions
- ✅ `.Rprofile` - Environment settings (if needed)
- ✅ Analysis scripts

**What to exclude** (`.gitignore`):
- ❌ `renv/library/` - Installed packages
- ❌ `.RData` - Workspace images
- ❌ `.Rhistory` - Command history

## CI/CD Integration (Future)

For GitHub Actions workflow:

```yaml
name: R Package Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: conda-incubator/setup-miniconda@v3
        with:
          environment-file: environment.yml
          activate-environment: r-gis
      - name: Test R packages
        run: |
          conda run -n r-gis Rscript tests/test-all.R
```

## Resources

**Official Documentation**:
- sf package: https://r-spatial.github.io/sf/
- brms: https://paul-buerkner.github.io/brms/
- rstan: https://mc-stan.org/rstan/
- metafor: https://www.metafor-project.org/

**KANNA-Specific Guides**:
- QSAR Pipeline: `tools/guides/04-qsar-pipeline-setup.md`
- Field Data: `tools/guides/02-field-data-collection-setup.md`
- Thesis Workflow: `OPTIMIZED-THESIS-WORKFLOW.md`

## Changelog

### 2025-10-06 - Initial Setup
- Created r-gis conda environment with R 4.4.3
- Installed sf 1.0.21 (GDAL 3.11.4, GEOS 3.14.0, PROJ 9.7.0)
- Installed brms 2.23.0 as rstan wrapper (workaround for TBB issue)
- Verified all Priority 1 packages operational
- Moved ~/R user library to ~/R.backup to eliminate conflicts
- Downgraded TBB from 2022.2.0 to 2021.13.0 (rstan compatibility)

---

**Maintainer**: PhD Candidate (Sceletium tortuosum research)
**Last Updated**: 2025-10-06
**Status**: Production Ready ✅
