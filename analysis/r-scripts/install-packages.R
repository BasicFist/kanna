#!/usr/bin/env Rscript
# =============================================================================
# KANNA Project - R Package Installation Script
# =============================================================================
# Purpose: Install all required R packages for the thesis
#
# Usage: Rscript install-packages.R
#
# Note: This uses renv for reproducible package management
# =============================================================================

# Install renv if not already installed
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}

# Initialize renv (creates renv.lock file)
# Uncomment to initialize:
# renv::init()

# =============================================================================
# CORE PACKAGES
# =============================================================================

# Data manipulation & visualization
core_packages <- c(
  "tidyverse",      # dplyr, ggplot2, tidyr, readr, purrr, tibble
  "data.table",     # Fast data manipulation
  "lubridate",      # Date/time handling
  "stringr",        # String manipulation
  "forcats"         # Factor handling
)

# =============================================================================
# STATISTICAL ANALYSIS
# =============================================================================

stats_packages <- c(
  "lme4",           # Mixed-effects models
  "nlme",           # Alternative mixed models
  "brms",           # Bayesian regression (requires Stan)
  "rstan",          # Stan interface
  "survival",       # Survival analysis
  "survminer",      # Survival visualization
  "pwr",            # Power analysis
  "psych",          # Psychometric analyses
  "car"             # ANOVA, regression diagnostics
)

# =============================================================================
# META-ANALYSIS
# =============================================================================

meta_packages <- c(
  "metafor",        # Meta-analysis framework
  "meta",           # Alternative meta-analysis
  "dmetar",         # Meta-analysis utilities
  "forestplot"      # Forest plot visualization
)

# =============================================================================
# ETHNOBOTANY & ECOLOGY
# =============================================================================

ethno_packages <- c(
  "vegan",          # Ecological diversity indices
  "BiodiversityR",  # Biodiversity analysis
  "igraph",         # Network analysis
  "ape",            # Phylogenetics
  "phytools"        # Phylogenetic tools
)

# Try to install ethnobotanyR from GitHub (not on CRAN)
# Uncomment if needed:
# if (!requireNamespace("remotes", quietly = TRUE)) {
#   install.packages("remotes")
# }
# remotes::install_github("CWWhitney/ethnobotanyR")

# =============================================================================
# CHEMINFORMATICS & CHEMISTRY
# =============================================================================

chem_packages <- c(
  "ChemoSpec",      # Spectroscopic data analysis
  "rcdk",           # Chemistry Development Kit interface
  "webchem"         # Chemical data from web sources
)

# =============================================================================
# VISUALIZATION
# =============================================================================

viz_packages <- c(
  "ggplot2",        # Core plotting (in tidyverse)
  "patchwork",      # Combine plots
  "cowplot",        # Publication-ready plots
  "ggpubr",         # Publication-ready themes
  "ggsignif",       # Significance brackets
  "scales",         # Scale functions for ggplot2
  "RColorBrewer",   # Color palettes
  "viridis"         # Perceptually uniform colors
)

# =============================================================================
# GEOSPATIAL ANALYSIS
# =============================================================================

geo_packages <- c(
  "sf",             # Simple features (modern GIS)
  "raster",         # Raster data
  "terra",          # Modern raster (replaces raster)
  "leaflet",        # Interactive maps
  "mapview"         # Quick interactive maps
)

# =============================================================================
# REPORTING & DOCUMENTATION
# =============================================================================

report_packages <- c(
  "rmarkdown",      # R Markdown documents
  "knitr",          # Dynamic report generation
  "bookdown",       # Long-form documents
  "kableExtra",     # Enhanced tables
  "gt",             # Grammar of tables
  "flextable",      # Flexible tables
  "officer"         # PowerPoint/Word export
)

# =============================================================================
# UTILITIES
# =============================================================================

util_packages <- c(
  "here",           # Project-relative paths
  "fs",             # File system operations
  "readxl",         # Read Excel files
  "writexl",        # Write Excel files
  "jsonlite",       # JSON parsing
  "xml2",           # XML parsing
  "httr",           # HTTP requests
  "rvest"           # Web scraping
)

# =============================================================================
# INSTALL ALL PACKAGES
# =============================================================================

all_packages <- c(
  core_packages,
  stats_packages,
  meta_packages,
  ethno_packages,
  chem_packages,
  viz_packages,
  geo_packages,
  report_packages,
  util_packages
)

cat("Installing", length(all_packages), "R packages...\n\n")

# Function to install if not already installed
install_if_missing <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat("Installing:", pkg, "\n")
    install.packages(pkg, dependencies = TRUE, repos = "https://cloud.r-project.org/")
  } else {
    cat("Already installed:", pkg, "\n")
  }
}

# Install all packages
invisible(sapply(all_packages, install_if_missing))

# =============================================================================
# VERIFY INSTALLATION
# =============================================================================

cat("\n=== Verifying Installation ===\n")

missing_packages <- c()
for (pkg in all_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    missing_packages <- c(missing_packages, pkg)
  }
}

if (length(missing_packages) > 0) {
  cat("\nWARNING: Failed to install the following packages:\n")
  cat(paste("  -", missing_packages, collapse = "\n"), "\n")
  cat("\nPlease install manually:\n")
  cat(sprintf("install.packages(c('%s'))\n", paste(missing_packages, collapse = "', '")))
} else {
  cat("\n✓ All packages installed successfully!\n")
}

# =============================================================================
# CREATE RENV SNAPSHOT
# =============================================================================

cat("\n=== Creating renv snapshot ===\n")
cat("Run this to create a reproducible environment:\n")
cat("  renv::snapshot()\n")
cat("\nTo restore this environment on another machine:\n")
cat("  renv::restore()\n")

cat("\n=== Installation Complete ===\n")
