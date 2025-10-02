#!/usr/bin/env Rscript
# =============================================================================
# Botanical Ethnobotanical Index (BEI) Calculator
# =============================================================================
# Purpose: Calculate BEI for Sceletium tortuosum across Khoisan communities
#
# Formula: BEI = (Number of taxa used) / (Total number of informants)
#
# Reference: Graz et al. (2007). Quantitative ethnobotany
#
# Author: [Your name]
# Date: October 2025
# =============================================================================

# Load required packages
library(tidyverse)
library(ethnobotanyR)  # If available, otherwise manual calculation

# =============================================================================
# CONFIGURATION
# =============================================================================

# Input data path
data_path <- "data/ethnobotanical/surveys/survey-2025.csv"

# Output directory
output_dir <- "analysis/r-scripts/ethnobotany/output/bei"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# =============================================================================
# LOAD DATA
# =============================================================================

# Expected columns:
# - informant_id: Unique participant identifier
# - community: Community code (e.g., SC01, SC02)
# - taxon: Plant species mentioned
# - use_category: Medicinal, ritual, food, etc.
# - n_uses: Number of uses mentioned for this taxon

cat("Loading ethnobotanical survey data...\n")
survey_data <- read_csv(data_path, show_col_types = FALSE)

cat(sprintf("Loaded %d records from %d informants\n",
            nrow(survey_data),
            n_distinct(survey_data$informant_id)))

# =============================================================================
# DATA VALIDATION
# =============================================================================

# Check for required columns
required_cols <- c("informant_id", "community", "taxon", "use_category")
missing_cols <- setdiff(required_cols, names(survey_data))

if (length(missing_cols) > 0) {
  stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
}

# Check for missing values
missing_summary <- survey_data %>%
  summarise(across(everything(), ~sum(is.na(.))))

cat("\nMissing values summary:\n")
print(missing_summary)

# =============================================================================
# CALCULATE BEI - Manual Method
# =============================================================================

calculate_bei <- function(data) {
  # Group by community and calculate BEI
  bei_results <- data %>%
    group_by(community) %>%
    summarise(
      n_informants = n_distinct(informant_id),
      n_taxa = n_distinct(taxon),
      bei = n_taxa / n_informants,
      .groups = "drop"
    )

  return(bei_results)
}

cat("\nCalculating BEI by community...\n")
bei_by_community <- calculate_bei(survey_data)

print(bei_by_community)

# =============================================================================
# CALCULATE ICF (Informant Consensus Factor)
# =============================================================================

calculate_icf <- function(data) {
  # ICF = (Nur - Nt) / (Nur - 1)
  # Nur = Number of use reports
  # Nt = Number of taxa used for the category

  icf_results <- data %>%
    group_by(use_category) %>%
    summarise(
      n_use_reports = n(),
      n_taxa = n_distinct(taxon),
      icf = (n_use_reports - n_taxa) / (n_use_reports - 1),
      .groups = "drop"
    ) %>%
    # ICF ranges from 0 to 1 (closer to 1 = higher consensus)
    mutate(icf = ifelse(is.na(icf), 0, icf))

  return(icf_results)
}

cat("\nCalculating ICF by use category...\n")
icf_by_category <- calculate_icf(survey_data)

print(icf_by_category)

# =============================================================================
# STATISTICAL COMPARISON ACROSS COMMUNITIES
# =============================================================================

# Test for significant differences in BEI across communities
cat("\nTesting for BEI differences across communities...\n")

# Prepare data for ANOVA
bei_per_informant <- survey_data %>%
  group_by(community, informant_id) %>%
  summarise(n_taxa_cited = n_distinct(taxon), .groups = "drop")

# One-way ANOVA
anova_result <- aov(n_taxa_cited ~ community, data = bei_per_informant)
cat("\nANOVA Results:\n")
print(summary(anova_result))

# Post-hoc Tukey HSD if significant
if (summary(anova_result)[[1]][["Pr(>F)"]][1] < 0.05) {
  cat("\nPost-hoc Tukey HSD:\n")
  tukey_result <- TukeyHSD(anova_result)
  print(tukey_result)
}

# =============================================================================
# VISUALIZATIONS
# =============================================================================

cat("\nGenerating visualizations...\n")

# 1. BEI by community (bar plot)
p1 <- ggplot(bei_by_community, aes(x = reorder(community, bei), y = bei)) +
  geom_col(fill = "steelblue", alpha = 0.8) +
  geom_text(aes(label = sprintf("%.2f", bei)), vjust = -0.5, size = 3.5) +
  labs(
    title = "Botanical Ethnobotanical Index (BEI) by Community",
    subtitle = "Sceletium tortuosum ethnobotanical survey",
    x = "Community",
    y = "BEI (Taxa per Informant)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(file.path(output_dir, "bei-by-community.png"),
       p1, width = 8, height = 6, dpi = 300)

# 2. ICF by use category (lollipop chart)
p2 <- ggplot(icf_by_category, aes(x = reorder(use_category, icf), y = icf)) +
  geom_segment(aes(x = use_category, xend = use_category,
                   y = 0, yend = icf), color = "gray50") +
  geom_point(size = 4, color = "darkred") +
  geom_text(aes(label = sprintf("%.2f", icf)), hjust = -0.3, size = 3) +
  coord_flip() +
  ylim(0, 1) +
  labs(
    title = "Informant Consensus Factor (ICF) by Use Category",
    subtitle = "Higher ICF = Greater agreement among informants",
    x = "Use Category",
    y = "ICF (0-1 scale)"
  ) +
  theme_minimal()

ggsave(file.path(output_dir, "icf-by-category.png"),
       p2, width = 8, height = 6, dpi = 300)

# 3. Distribution of taxa cited per informant (violin plot)
p3 <- ggplot(bei_per_informant, aes(x = community, y = n_taxa_cited, fill = community)) +
  geom_violin(alpha = 0.6, show.legend = FALSE) +
  geom_boxplot(width = 0.1, alpha = 0.8, show.legend = FALSE) +
  labs(
    title = "Distribution of Plant Taxa Knowledge Across Communities",
    x = "Community",
    y = "Number of Taxa Cited per Informant"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(file.path(output_dir, "taxa-distribution-by-community.png"),
       p3, width = 10, height = 6, dpi = 300)

cat("Figures saved to:", output_dir, "\n")

# =============================================================================
# EXPORT RESULTS
# =============================================================================

# Save BEI results
write_csv(bei_by_community, file.path(output_dir, "bei-results.csv"))

# Save ICF results
write_csv(icf_by_category, file.path(output_dir, "icf-results.csv"))

# Save per-informant data
write_csv(bei_per_informant, file.path(output_dir, "bei-per-informant.csv"))

# Save statistical results
sink(file.path(output_dir, "statistical-tests.txt"))
cat("=== ANOVA: BEI Differences Across Communities ===\n\n")
print(summary(anova_result))
if (exists("tukey_result")) {
  cat("\n=== Post-hoc Tukey HSD ===\n\n")
  print(tukey_result)
}
sink()

cat("\n=== Analysis Complete ===\n")
cat("Results exported to:", output_dir, "\n")
cat("\nNext steps:\n")
cat("1. Review figures for publication quality\n")
cat("2. Interpret ICF values (>0.50 = high consensus)\n")
cat("3. Validate results with community partners\n")
cat("4. Write up methods & results sections\n")
