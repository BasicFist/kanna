#!/usr/bin/env Rscript
# =============================================================================
# KANNA Figure Export Script
# =============================================================================
# Purpose: Export all analysis figures to assets/figures/ for thesis inclusion
# Usage: Rscript tools/scripts/export-all-figures.R
# =============================================================================

suppressPackageStartupMessages({
  library(here)
  library(fs)
})

cat("====================================\n")
cat("KANNA Figure Export Script\n")
cat("====================================\n\n")

# =============================================================================
# CONFIGURATION
# =============================================================================

ASSETS_DIR <- here("assets", "figures")
ANALYSIS_DIR <- here("analysis")

# Create output directories
dir_create(ASSETS_DIR, recurse = TRUE)
dir_create(path(ASSETS_DIR, paste0("chapter-", sprintf("%02d", 1:8))), recurse = TRUE)

cat("Output directory:", ASSETS_DIR, "\n\n")

# =============================================================================
# CHAPTER 3: ETHNOBOTANY FIGURES
# =============================================================================

cat("Exporting Chapter 3 figures (Ethnobotany)...\n")

BEI_OUTPUT <- here("analysis", "r-scripts", "ethnobotany", "output", "bei")

if (dir_exists(BEI_OUTPUT)) {
  # Find all PNG files
  bei_figures <- dir_ls(BEI_OUTPUT, glob = "*.png")

  if (length(bei_figures) > 0) {
    # Copy to assets
    file_copy(
      bei_figures,
      path(ASSETS_DIR, "chapter-03", path_file(bei_figures)),
      overwrite = TRUE
    )
    cat("  ✓ Copied", length(bei_figures), "BEI figures\n")
  } else {
    cat("  ⚠ No BEI figures found. Run calculate-bei.R first.\n")
  }
} else {
  cat("  ⚠ BEI output directory not found. Run calculate-bei.R first.\n")
}

# =============================================================================
# CHAPTER 4: PHARMACOLOGY FIGURES (Python outputs)
# =============================================================================

cat("\nExporting Chapter 4 figures (Pharmacology)...\n")

QSAR_OUTPUT <- here("analysis", "python", "ml-models", "qsar-output")

if (dir_exists(QSAR_OUTPUT)) {
  # Find all PNG files from QSAR modeling
  qsar_figures <- dir_ls(QSAR_OUTPUT, glob = "*.png")

  if (length(qsar_figures) > 0) {
    file_copy(
      qsar_figures,
      path(ASSETS_DIR, "chapter-04", path_file(qsar_figures)),
      overwrite = TRUE
    )
    cat("  ✓ Copied", length(qsar_figures), "QSAR figures\n")
  } else {
    cat("  ⚠ No QSAR figures found. Run qsar-modeling.py first.\n")
  }
} else {
  cat("  ⚠ QSAR output directory not found. Run qsar-modeling.py first.\n")
}

# =============================================================================
# CHAPTER 5: META-ANALYSIS FIGURES
# =============================================================================

cat("\nExporting Chapter 5 figures (Clinical Meta-Analysis)...\n")

META_OUTPUT <- here("analysis", "r-scripts", "meta-analysis", "output")

if (dir_exists(META_OUTPUT)) {
  meta_figures <- dir_ls(META_OUTPUT, glob = "*.png")

  if (length(meta_figures) > 0) {
    file_copy(
      meta_figures,
      path(ASSETS_DIR, "chapter-05", path_file(meta_figures)),
      overwrite = TRUE
    )
    cat("  ✓ Copied", length(meta_figures), "meta-analysis figures\n")
  } else {
    cat("  ⚠ No meta-analysis figures found.\n")
  }
} else {
  cat("  ⚠ Meta-analysis output directory not found.\n")
}

# =============================================================================
# JUPYTER NOTEBOOK FIGURES
# =============================================================================

cat("\nExporting Jupyter notebook figures...\n")

JUPYTER_DIR <- here("analysis", "jupyter-notebooks")

if (dir_exists(JUPYTER_DIR)) {
  # Find all PNG/PDF in notebook directories
  notebook_figures <- dir_ls(JUPYTER_DIR, recurse = TRUE, glob = "*output*.png")

  if (length(notebook_figures) > 0) {
    # Organize by chapter based on directory structure
    for (fig in notebook_figures) {
      # Try to infer chapter from path
      if (grepl("ethnobotany", fig)) {
        file_copy(fig, path(ASSETS_DIR, "chapter-03", path_file(fig)), overwrite = TRUE)
      } else if (grepl("pharmacology|qsar|cheminformatics", fig)) {
        file_copy(fig, path(ASSETS_DIR, "chapter-04", path_file(fig)), overwrite = TRUE)
      } else if (grepl("clinical|meta", fig)) {
        file_copy(fig, path(ASSETS_DIR, "chapter-05", path_file(fig)), overwrite = TRUE)
      } else {
        # Default: copy to general figures directory
        file_copy(fig, path(ASSETS_DIR, path_file(fig)), overwrite = TRUE)
      }
    }
    cat("  ✓ Copied", length(notebook_figures), "notebook figures\n")
  } else {
    cat("  ⚠ No Jupyter notebook figures found.\n")
  }
}

# =============================================================================
# SUMMARY
# =============================================================================

cat("\n====================================\n")
cat("Summary\n")
cat("====================================\n")

# Count total figures
total_figures <- 0
for (ch in 1:8) {
  chapter_dir <- path(ASSETS_DIR, paste0("chapter-", sprintf("%02d", ch)))
  if (dir_exists(chapter_dir)) {
    fig_count <- length(dir_ls(chapter_dir, glob = "*.png"))
    if (fig_count > 0) {
      cat(sprintf("Chapter %d: %d figures\n", ch, fig_count))
      total_figures <- total_figures + fig_count
    }
  }
}

cat(sprintf("\n✓ Total: %d figures exported to %s\n", total_figures, ASSETS_DIR))
cat("\n====================================\n")
cat("Next steps:\n")
cat("1. Review figures in assets/figures/\n")
cat("2. Insert in LaTeX with \\includegraphics{}\n")
cat("3. Commit to Git: git add assets/figures/\n")
cat("====================================\n\n")
