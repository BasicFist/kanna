# Optimized Thesis Workflow for KANNA Project

> **Purpose**: Integrated, end-to-end workflow connecting tools, configs, and daily practices for maximum thesis productivity
> **Target**: Complete 8-chapter PhD thesis in 42 months with minimal tool friction
> **Philosophy**: Right tool, right time, seamless integration

---

## 📋 Table of Contents

1. [Daily Workflow System](#i-daily-workflow-system)
2. [Tool Stack Integration Map](#ii-tool-stack-integration-map)
3. [Chapter-by-Chapter Workflows](#iii-chapter-by-chapter-workflows)
4. [Configuration & Setup Guide](#iv-configuration--setup-guide)
5. [Automation Scripts](#v-automation-scripts)
6. [Quality Control Checkpoints](#vi-quality-control-checkpoints)
7. [Troubleshooting Common Bottlenecks](#vii-troubleshooting-common-bottlenecks)

---

## I. Daily Workflow System

### Morning Routine (08:00-10:00) - Literature & Planning

**Tools**: Elicit + Zotero + Obsidian + MCP Servers

```bash
# 1. Start Claude Code in KANNA directory
cd ~/LAB/projects/KANNA
claude

# 2. Check literature updates (via Elicit or Perplexity MCP)
# In Claude Code:
> "Use Perplexity to search for Sceletium papers published in last 30 days"

# 3. Import new papers to Zotero
# Open Zotero → Import PDFs from downloads → Auto-extract metadata
# Tag with: chapter number, topic, status (unread/reading/complete)

# 4. Daily note in Obsidian
# Template: YYYY-MM-DD-daily.md
## Tasks Today
- [ ] Read 3 papers on [topic]
- [ ] Draft 500 words for Chapter [X]
- [ ] Run QSAR analysis on [alkaloid subset]

## Literature Notes
- [[Paper Title]] - Key findings: [summary]
- Links to: [[PDE4 Mechanisms]], [[San Traditional Knowledge]]

## Research Journal
- Insights, questions, next steps
```

**Output**:
- New papers tagged and ready for reading
- Daily tasks prioritized
- Knowledge graph updated with new connections

---

### Midday Work Block (10:00-13:00) - Deep Work

**Phase 1: Analysis & Coding (10:00-11:30)**

**Tools**: R/Python + Jupyter + MLflow + Git

```bash
# 1. Activate Python environment
cd ~/LAB/projects/KANNA
source venv/bin/activate  # or conda activate kanna

# 2. Work on analysis (example: QSAR modeling)
jupyter lab  # Opens in browser
# Navigate to: analysis/jupyter-notebooks/02-statistical-analyses/

# Example: QSAR workflow
# - Load alkaloid data from data/phytochemical/alkaloid-profiles/
# - Run analysis/python/cheminformatics/qsar-modeling.py
# - Track experiments with MLflow
# - Export figures to assets/figures/

# 3. Track progress
python analysis/python/cheminformatics/qsar-modeling.py
# MLflow automatically logs: hyperparameters, R², RMSE, feature importance
# View results: mlflow ui --port 5000

# 4. Commit progress
git add analysis/python/cheminformatics/qsar-modeling.py
git commit -m "feat: improve QSAR model R² from 0.72 to 0.85 with XGBoost tuning"
git push
```

**Phase 2: Writing (11:30-13:00)**

**Tools**: Overleaf + Zotero + Writefull

```bash
# 1. Open Overleaf (web-based, real-time sync)
# Navigate to: Chapter 4 - Pharmacology

# 2. Write with Zotero integration
# In LaTeX:
\section{QSAR Modeling of Sceletium Alkaloids}
The Random Forest model achieved R² = 0.85 for PDE4B inhibition \cite{YourName2026}.

# Insert figure from local assets
\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{figures/qsar-actual-vs-predicted.png}
\caption{QSAR model performance for 32 Sceletium alkaloids.}
\label{fig:qsar-performance}
\end{figure}

# 3. Polish with Writefull (browser extension for Overleaf)
# Highlights: academic phrasing, paraphrasing, title suggestions

# 4. Export progress
# Overleaf auto-saves to cloud
# Download PDF to writing/thesis-chapters/ch04-pharmacology/drafts/
```

**Output**:
- 500-1000 words written
- Figures inserted and referenced
- Analysis results integrated into narrative
- All changes tracked in Git + Overleaf

---

### Afternoon Session (14:00-17:00) - Synthesis & Visualization

**Tools**: R (ggplot2) + BioRender + GraphPad Prism

```bash
# 1. Create publication figures (R workflow)
cd ~/LAB/projects/KANNA/analysis/r-scripts/ethnobotany

# Run BEI calculation and visualization
Rscript calculate-bei.R
# Outputs:
# - analysis/r-scripts/ethnobotany/output/bei/bei-by-community.png
# - analysis/r-scripts/ethnobotany/output/bei/icf-by-category.png

# 2. Copy to assets for thesis
cp analysis/r-scripts/ethnobotany/output/bei/*.png assets/figures/chapter-03/

# 3. Create mechanism diagrams (BioRender)
# Open: https://app.biorender.com
# Create: PDE4 inhibition pathway diagram
# Export: 300 DPI PNG + SVG
# Save to: assets/figures/chapter-04/pde4-mechanism.png

# 4. Polish statistical figures (GraphPad Prism - if available)
# Import data from: data/clinical/trials/meta-analysis-data.csv
# Create forest plot for anxiety RCTs
# Export to: assets/figures/chapter-05/forest-plot-anxiety.png

# 5. Commit all figures
git add assets/figures/
git commit -m "docs: add publication figures for Chapters 3-5"
```

**Output**:
- All chapter figures in `assets/figures/` organized by chapter
- 300 DPI publication-ready format
- Version controlled for reproducibility

---

### Evening Review (17:00-18:00) - Quality Control

**Tools**: Trinka + PROJECT-STATUS.md + Git

```bash
# 1. Run Trinka on today's writing
# Open Overleaf chapter → Trinka browser extension
# Check: grammar, academic tone, discipline-specific terminology
# Fix flagged issues

# 2. Update project status
nano PROJECT-STATUS.md
# Update:
## Week of October 9, 2025
- ✅ Completed QSAR analysis (R² = 0.85)
- ✅ Drafted 750 words for Chapter 4 (Pharmacology)
- ✅ Created 3 publication figures
- 🔄 In progress: Meta-analysis of anxiety trials (Chapter 5)
- 📅 Next week: Field trip planning (FPIC protocols)

# 3. Daily Git summary
git log --oneline --since="1 day ago"
git status

# 4. Backup check (automated via cron, manual verify)
ls -lh /media/backup/KANNA/  # External HDD backup
rclone check ~/LAB/projects/KANNA tresorit:KANNA  # Cloud backup
```

**Output**:
- Writing polished and error-free
- Progress tracked in PROJECT-STATUS.md
- All work backed up to 3 locations (3-2-1 rule)

---

## II. Tool Stack Integration Map

### Core Integration Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   KANNA THESIS WORKFLOW                  │
└─────────────────────────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
   DISCOVER            ANALYZE              WRITE
        │                   │                   │
┌───────▼────────┐  ┌───────▼────────┐  ┌──────▼─────────┐
│ Literature     │  │ Data Analysis  │  │ Thesis Writing │
│ Discovery      │  │ & Modeling     │  │ & Figures      │
├────────────────┤  ├────────────────┤  ├────────────────┤
│ • Elicit       │  │ • R/RStudio    │  │ • Overleaf     │
│ • Perplexity   │  │ • Python/Jupy  │  │ • Scrivener    │
│ • Consensus    │  │ • MAXQDA       │  │ • Writefull    │
│ • Rayyan       │  │ • GraphPad     │  │ • Trinka       │
└────────┬───────┘  └────────┬───────┘  └────────┬───────┘
         │                   │                   │
         └──────────┬────────┴──────────┬────────┘
                    │                   │
           ┌────────▼────────┐ ┌────────▼────────┐
           │ Reference Mgmt  │ │ Knowledge Mgmt  │
           ├─────────────────┤ ├─────────────────┤
           │ • Zotero        │ │ • Obsidian      │
           │ • Better BibTeX │ │ • Git           │
           └─────────────────┘ └─────────────────┘
                    │                   │
                    └──────────┬────────┘
                               │
                    ┌──────────▼──────────┐
                    │ LAB MCP Integration │
                    ├─────────────────────┤
                    │ • Context7 (docs)   │
                    │ • Perplexity (AI)   │
                    │ • GitHub (Git ops)  │
                    │ • Jupyter (remote)  │
                    └─────────────────────┘
```

### Data Flow Diagram

```
┌──────────────┐
│ Field Survey │  SurveyCTO (offline)
└──────┬───────┘
       │ GPS + Photos + Audio
       ▼
┌──────────────┐
│ QGIS Mapping │  Visualize distribution
└──────┬───────┘
       │ GeoJSON + Shapefiles
       ▼
┌──────────────────┐
│ R (ethnobotanyR) │  Calculate BEI/ICF
└──────┬───────────┘
       │ CSV results
       ▼
┌──────────────┐
│ MAXQDA       │  Code interviews
└──────┬───────┘
       │ Coded themes
       ▼
┌──────────────┐
│ ggplot2      │  Create figures
└──────┬───────┘
       │ 300 DPI PNG
       ▼
┌──────────────┐
│ LaTeX Thesis │  Chapter 3
└──────────────┘

┌──────────────┐
│ PubChem      │  Retrieve alkaloid SMILES
└──────┬───────┘
       │ Chemical structures
       ▼
┌──────────────┐
│ RDKit        │  Calculate descriptors
└──────┬───────┘
       │ Molecular fingerprints
       ▼
┌──────────────────┐
│ scikit-learn     │  Train QSAR model
└──────┬───────────┘
       │ Predictions
       ▼
┌──────────────┐
│ MLflow       │  Track experiments
└──────┬───────┘
       │ Model metrics
       ▼
┌──────────────┐
│ AutoDock Vina│  Dock to PDE4
└──────┬───────┘
       │ Binding poses
       ▼
┌──────────────┐
│ PyMOL        │  Visualize complexes
└──────┬───────┘
       │ Publication figure
       ▼
┌──────────────┐
│ LaTeX Thesis │  Chapter 4
└──────────────┘
```

---

## III. Chapter-by-Chapter Workflows

### Chapter 1: Introduction & Context

**Primary Tools**: Elicit, Zotero, Obsidian, Overleaf

**Workflow**:
```bash
# Week 1-2: Literature Discovery
1. Elicit search: "Sceletium tortuosum pharmacology" (save 100+ papers)
2. Import to Zotero collection "Ch01-Introduction"
3. Tag by theme: ethnobotany, pharmacology, legal, clinical

# Week 3-4: Reading & Note-Taking
4. Read 10 papers/day in Zotero PDF reader
5. Export highlights to Obsidian: [[Paper-Author-Year]]
6. Create atomic notes: [[PDE4-Mechanisms]], [[San-Traditional-Knowledge]]
7. Build knowledge graph in Obsidian

# Week 5-6: Writing
8. Open Overleaf → Chapter 1 template
9. Section 1.1: Problem Statement (500 words)
10. Section 1.2: Research Questions (300 words)
11. Section 1.3: Methodology Overview (700 words)
12. Section 1.4: Thesis Structure (200 words)
13. Cite from Zotero export: literature/zotero-export/kanna.bib

# Week 7-8: Refinement
14. Writefull: Polish academic language
15. Trinka: Grammar and style check
16. Supervisor review via Overleaf comments
17. Incorporate feedback, finalize
```

**Output**:
- Chapter 1 draft (15,000 words)
- 100+ references organized in Zotero
- Knowledge graph with 200+ nodes in Obsidian

**Files**:
- `writing/thesis-chapters/ch01-introduction/main.tex`
- `literature/zotero-export/kanna.bib`
- `assets/figures/chapter-01/` (flowcharts, concept maps)

---

### Chapter 2: Botanical Foundations

**Primary Tools**: QGIS, IQ-TREE 3, FigTree, R, LaTeX

**Workflow**:
```bash
# Week 1-3: GIS Mapping
1. Import GPS data: fieldwork/gps-data/sceletium-locations.csv
2. QGIS project: data/botanical/gis-maps/sceletium-distribution.qgz
3. Layer 1: Wild populations (green points)
4. Layer 2: Cultivated areas (blue polygons)
5. Layer 3: San territories (red boundaries)
6. Export map: assets/figures/chapter-02/distribution-map.png (300 DPI)

# Week 4-6: Phylogenetic Analysis
7. Align sequences: MUSCLE → data/botanical/taxonomy/alignments/sceletium-ITS.fasta
8. Run IQ-TREE 3:
   iqtree -s sceletium-ITS.fasta -m MFP -bb 1000 -alrt 1000
9. Visualize in FigTree: export to assets/figures/chapter-02/phylogeny.pdf
10. Calculate genetic distances in R (ape package)

# Week 7-8: Chemotype Analysis
11. R script: analysis/r-scripts/statistics/chemotype-clustering.R
12. PCA of alkaloid profiles from data/phytochemical/alkaloid-profiles/
13. Create biplot: PC1 vs PC2, colored by population
14. Export: assets/figures/chapter-02/chemotype-pca.png

# Week 9-10: Writing
15. LaTeX Chapter 2: Taxonomy, distribution, variability
16. Insert figures with \ref{fig:distribution}
17. Cite Klak et al. (2025) for taxonomic revision
18. Trinka check for botanical terminology accuracy
```

**Output**:
- Chapter 2 draft (12,000 words)
- 3 GIS maps (distribution, habitats, conservation)
- Phylogenetic tree (maximum likelihood, bootstrap support)
- Chemotype clustering analysis

**Files**:
- `writing/thesis-chapters/ch02-botany/main.tex`
- `data/botanical/gis-maps/` (QGIS projects)
- `data/botanical/taxonomy/phylogenies/` (Newick trees)

---

### Chapter 3: Khoisan Ethnobotanical Heritage

**Primary Tools**: SurveyCTO, MAXQDA, R (ethnobotanyR), ggplot2

**Workflow**:
```bash
# Month 1-2: Field Data Collection (8 missions)
1. Configure SurveyCTO form: data/ethnobotanical/surveys/bei-survey-form.xlsx
2. Load on tablets, enable offline mode
3. Collect data: GPS, photos, interviews (with FPIC consent)
4. Sync to cloud when online: data/ethnobotanical/surveys/survey-2025.csv

# Month 3: Interview Transcription & Coding
5. Transcribe audio (encrypted): fieldwork/interviews-raw/ → data/ethnobotanical/interviews/
6. Import to MAXQDA project: KANNA-Ethnobotany.mx25
7. Code themes:
   - Traditional uses (medicinal, ritual, social)
   - Preparation methods (fermentation, infusion)
   - Transmission patterns (elder → youth)
8. Inter-rater reliability: Cohen's κ ≥ 0.70

# Month 4: Quantitative Analysis
9. R script: analysis/r-scripts/ethnobotany/calculate-bei.R (already created)
10. Calculate BEI, ICF, CUDI for 3 communities
11. ANOVA: test BEI differences (p < 0.05)
12. Create figures:
    - assets/figures/chapter-03/bei-by-community.png
    - assets/figures/chapter-03/icf-by-category.png
    - assets/figures/chapter-03/knowledge-network.png (NetworkX)

# Month 5-6: Writing
13. LaTeX Chapter 3: Methods, results, discussion
14. Insert quotes from MAXQDA (anonymized)
15. Report BEI: Community A (3.2 ± 0.5), Community B (2.8 ± 0.4)
16. Discuss erosion of traditional knowledge
17. Community review: share draft for validation

# Month 7: Refinement
18. Incorporate community feedback
19. Trinka: check for respectful, decolonial language
20. Submit draft to supervisors
```

**Output**:
- Chapter 3 draft (18,000 words) - longest chapter
- 50-100 coded interviews
- BEI/ICF results for 3 communities
- Network graph of knowledge transmission

**Files**:
- `writing/thesis-chapters/ch03-ethnobotany/main.tex`
- `data/ethnobotanical/surveys/survey-2025.csv`
- `analysis/r-scripts/ethnobotany/output/bei/`

---

### Chapter 4: Pharmacognosy & Neurobiology

**Primary Tools**: RDKit, ADMETlab 3.0, AutoDock Vina, PyMOL, Python

**Workflow**:
```bash
# Month 1: Chemical Data Collection
1. Retrieve SMILES from PubChem for 32 alkaloids
2. Store in: data/phytochemical/alkaloid-profiles/structures.csv
3. Generate 3D conformers with RDKit
4. Save to: data/molecular-modeling/structures/alkaloid-conformers/

# Month 2-3: QSAR Modeling
5. Run: analysis/python/cheminformatics/qsar-modeling.py (already created)
   - Calculate 200+ molecular descriptors (RDKit)
   - Feature selection: SelectKBest (top 50)
   - Train Random Forest & XGBoost models
   - 5-fold cross-validation
   - SHAP interpretation
6. MLflow tracking: localhost:5000
   - Log R², RMSE, feature importance
   - Compare models: RF (R²=0.82) vs XGBoost (R²=0.85)
7. Export best model: analysis/python/ml-models/qsar-output/xgb-model.pkl

# Month 4: ADMET Predictions
8. Batch upload to ADMETlab 3.0: https://admet.scbdd.com
9. Predict for all 32 alkaloids:
   - BBB permeability
   - CYP450 inhibition
   - Hepatotoxicity
   - Cardiotoxicity
10. Download results: data/phytochemical/qsar-models/admet-predictions.csv

# Month 5: Molecular Docking
11. Download PDE4B crystal structure: PDB ID 1RO6
12. Prepare protein: AutoDock Tools (add hydrogens, charges)
13. Prepare ligands: obabel -i smi structures.csv -o pdbqt
14. Dock with AutoDock Vina:
    vina --receptor pde4b.pdbqt --ligand mesembrine.pdbqt \
         --center_x 15.0 --center_y 10.0 --center_z 5.0 \
         --size_x 20 --size_y 20 --size_z 20
15. Repeat for all 32 alkaloids
16. Results: data/molecular-modeling/docking/pde4b-results/

# Month 6: Visualization & Writing
17. PyMOL visualization:
    - Load PDE4B + mesembrine best pose
    - Color by residue type, show H-bonds
    - Ray trace 300 DPI: assets/figures/chapter-04/pde4b-mesembrine.png
18. Create QSAR plots:
    - Actual vs Predicted IC50
    - Feature importance bar chart
    - SHAP summary plot
19. LaTeX Chapter 4: QSAR methods, docking results, discussion
20. Trinka: check chemistry terminology
```

**Output**:
- Chapter 4 draft (15,000 words)
- QSAR model (R² = 0.85 for PDE4 IC50)
- ADMET predictions for 32 alkaloids
- Docking scores for all alkaloid-PDE4 complexes

**Files**:
- `writing/thesis-chapters/ch04-pharmacology/main.tex`
- `analysis/python/cheminformatics/qsar-modeling.py`
- `data/molecular-modeling/docking/` (all docking results)

---

### Chapter 5: Clinical Validation & Meta-Analysis

**Primary Tools**: Rayyan, Metafor (R), RevMan, GraphPad Prism

**Workflow**:
```bash
# Month 1: Systematic Review
1. PICO question: "Does Sceletium reduce anxiety in adults?"
2. Search PubMed, Cochrane, Embase (2000-2025)
3. Import to Rayyan: 500+ abstracts
4. Screen with AI assistance (blind mode)
5. Include: 15 RCTs meeting criteria
6. Extract data to: data/clinical/trials/meta-analysis-data.csv
   - Study, Year, N, Mean difference, SE, p-value

# Month 2: Risk of Bias Assessment
7. RevMan 5: Cochrane Risk of Bias tool
8. Assess domains: randomization, blinding, attrition
9. Create risk of bias graph
10. Export: assets/figures/chapter-05/rob-summary.png

# Month 3: Meta-Analysis
11. R script: analysis/r-scripts/meta-analysis/anxiety-rcts.R
library(metafor)
data <- read.csv("data/clinical/trials/meta-analysis-data.csv")
res <- rma(yi = mean_diff, sei = se, data = data, method = "REML")
forest(res, slab = data$study)

12. Calculate:
    - Pooled effect size: SMD = -0.42 (95% CI: -0.65 to -0.19)
    - Heterogeneity: I² = 45% (moderate)
    - Publication bias: Egger's test, funnel plot
13. Export figures:
    - assets/figures/chapter-05/forest-plot-anxiety.png
    - assets/figures/chapter-05/funnel-plot.png

# Month 4: Safety Meta-Analysis
14. Repeat for adverse events
15. GraphPad Prism: Create multi-panel figure
    - Forest plot (efficacy)
    - Forest plot (safety)
    - Funnel plot (publication bias)
16. Export composite: assets/figures/chapter-05/meta-analysis-composite.png

# Month 5-6: Writing
17. LaTeX Chapter 5: PRISMA flow diagram, results, discussion
18. Report: "Sceletium significantly reduced anxiety (SMD = -0.42, p < 0.001)"
19. Discuss heterogeneity sources
20. Trinka: medical terminology check
```

**Output**:
- Chapter 5 draft (14,000 words)
- Meta-analysis of 15 RCTs
- Forest plots, funnel plots
- PRISMA flow diagram

**Files**:
- `writing/thesis-chapters/ch05-clinical/main.tex`
- `data/clinical/trials/meta-analysis-data.csv`
- `analysis/r-scripts/meta-analysis/anxiety-rcts.R`

---

### Chapters 6-8: Addiction, Legal, Synthesis

**Similar workflow patterns**:
- Chapter 6: Literature review + preclinical evidence synthesis
- Chapter 7: Legal case analysis (Zembrin patents) + policy recommendations
- Chapter 8: Cross-chapter synthesis + future directions

---

## IV. Configuration & Setup Guide

### Essential Configurations

**1. Zotero with Better BibTeX**

```bash
# Install Better BibTeX plugin
# Download: https://retorque.re/zotero-better-bibtex/installation/
# Zotero → Tools → Add-ons → Install from file

# Configure Better BibTeX
# Edit → Preferences → Better BibTeX
Citation key format: [auth:lower][year]
# Example: klak2025

# Auto-export .bib file
# Right-click "KANNA" collection → Export Collection
# Format: Better BibLaTeX
# ✓ Keep updated
# Save to: ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib

# LaTeX integration
# In Overleaf main.tex:
\bibliography{kanna}  % No .bib extension
\bibliographystyle{apalike}
```

---

**2. Obsidian Knowledge Graph**

```bash
# Install Obsidian: https://obsidian.md
# Open vault: ~/LAB/projects/KANNA/literature/notes/

# Install plugins (Community Plugins):
1. Zotero Integration - Link to Zotero library
2. Dataview - Query notes dynamically
3. Citations - Insert citations from .bib
4. Kanban - Task management
5. Graph Analysis - Enhanced graph view

# Configure Zotero Integration
# Settings → Zotero Integration
Zotero Port: 23119
Database: ~/Zotero/zotero.sqlite
Import Formats: ✓ Annotations, ✓ PDF highlights

# Create templates
# Templates folder: literature/notes/templates/
## Paper-Template.md
---
title: {{title}}
authors: {{authors}}
year: {{year}}
tags: [chapter-{{chapter}}, {{topic}}]
---

# Summary
{{one-sentence-summary}}

# Key Findings
- Finding 1
- Finding 2

# Relevance to KANNA
Links to: [[PDE4 Mechanisms]], [[Chapter 4 - Pharmacology]]

# Quotes
> "{{quote}}" (p. {{page}})

# Questions
- Question for follow-up research
```

**Daily Note Template**:
```markdown
# {{date:YYYY-MM-DD}} - Daily Research Log

## Tasks
- [ ] Task 1
- [ ] Task 2

## Progress
- ✅ Completed X
- 🔄 In progress: Y

## Literature
- [[Paper-Author-Year]] - Key insight

## Code/Analysis
- Ran QSAR model: R² improved to 0.85
- Committed to Git: `feat: add SHAP interpretation`

## Writing
- Drafted 750 words for Chapter 4, Section 4.3

## Tomorrow
- [ ] Task for tomorrow
```

---

**3. Git Configuration for Thesis**

```bash
# Configure Git identity
cd ~/LAB/projects/KANNA
git config user.name "Your Name"
git config user.email "your.email@university.edu"

# Create .gitattributes for large files
cat > .gitattributes << EOF
# Large data files - track with Git LFS (optional)
*.raw filter=lfs diff=lfs merge=lfs -text
*.wiff filter=lfs diff=lfs merge=lfs -text
*.pdf filter=lfs diff=lfs merge=lfs -text

# Jupyter notebooks - strip output before commit
*.ipynb filter=nbstripout
EOF

# Install nbstripout (remove notebook outputs before commit)
pip install nbstripout
nbstripout --install --attributes .gitattributes

# Create useful Git aliases
git config alias.st 'status -sb'
git config alias.lg 'log --oneline --graph --decorate --all'
git config alias.cm 'commit -m'
git config alias.save '!git add -A && git commit -m "WIP: save progress"'

# Commit hooks (optional: run Ruff/Black on Python before commit)
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/bash
# Format Python files before commit
black analysis/python/
ruff check analysis/python/ --fix
EOF
chmod +x .git/hooks/pre-commit
```

---

**4. R Environment with renv**

```bash
# Initialize renv for reproducibility
cd ~/LAB/projects/KANNA
R
> install.packages("renv")
> renv::init()  # Creates renv.lock

# Install packages (already scripted in analysis/r-scripts/install-packages.R)
> source("analysis/r-scripts/install-packages.R")

# Snapshot dependencies
> renv::snapshot()  # Locks package versions

# Restore on another machine
> renv::restore()  # Installs exact versions from renv.lock

# Update .Rprofile for automatic activation
cat > .Rprofile << EOF
source("renv/activate.R")
options(repos = c(CRAN = "https://cloud.r-project.org/"))
EOF
```

---

**5. Python Environment**

```bash
# Create virtual environment (or conda)
cd ~/LAB/projects/KANNA

# Option 1: venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Option 2: conda (for RDKit)
conda create -n kanna python=3.10
conda activate kanna
conda install -c conda-forge rdkit
pip install -r requirements.txt

# Freeze exact versions
pip freeze > requirements-lock.txt

# Auto-activate in .bashrc or .zshrc
echo 'alias kanna="cd ~/LAB/projects/KANNA && source venv/bin/activate"' >> ~/.zshrc
source ~/.zshrc

# Now just type: kanna
```

---

**6. Jupyter Configuration**

```bash
# Configure Jupyter for thesis work
jupyter notebook --generate-config

# Edit ~/.jupyter/jupyter_notebook_config.py
# Add:
c.NotebookApp.notebook_dir = '/home/miko/LAB/projects/KANNA/analysis/jupyter-notebooks'
c.NotebookApp.open_browser = True
c.NotebookApp.port = 8888

# Install useful extensions
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user

# Enable extensions:
# - Table of Contents
# - Variable Inspector
# - ExecuteTime
# - Codefolding

# Create notebook templates
mkdir -p analysis/jupyter-notebooks/templates
cat > analysis/jupyter-notebooks/templates/analysis-template.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Analysis Title\n",
    "**Author**: Your Name\n",
    "**Date**: {{date}}\n",
    "**Purpose**: Brief description\n",
    "\n",
    "## Setup"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "source": [
    "import pandas as pd\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "import seaborn as sns\n",
    "\n",
    "# Set style\n",
    "sns.set_style('whitegrid')\n",
    "plt.rcParams['figure.dpi'] = 300"
   ]
  }
 ]
}
EOF
```

---

**7. Overleaf LaTeX Thesis Template**

```latex
% main.tex - KANNA Thesis Master Document
\documentclass[12pt, oneside, a4paper]{book}

% Packages
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{natbib}  % For citations
\usepackage{amsmath, amssymb}
\usepackage[margin=2.5cm]{geometry}

% Metadata
\title{Interdisciplinary Analysis of \textit{Sceletium tortuosum}:\\
From Khoisan Traditional Knowledge to Modern Neuropharmacology}
\author{Your Name}
\date{\today}

% Document
\begin{document}

\maketitle
\tableofcontents
\listoffigures
\listoftables

% Chapters
\include{chapters/ch01-introduction}
\include{chapters/ch02-botany}
\include{chapters/ch03-ethnobotany}
\include{chapters/ch04-pharmacology}
\include{chapters/ch05-clinical}
\include{chapters/ch06-addiction}
\include{chapters/ch07-legal}
\include{chapters/ch08-synthesis}

% Bibliography
\bibliographystyle{apalike}
\bibliography{kanna}  % From Zotero Better BibTeX export

\end{document}
```

**Chapter Template** (`chapters/ch04-pharmacology.tex`):
```latex
\chapter{Pharmacognosy and Neurobiology}
\label{ch:pharmacology}

\section{Introduction}
This chapter presents the pharmacological characterization of 32 alkaloids...

\section{QSAR Modeling}
\subsection{Methods}
Random Forest and XGBoost models were trained using RDKit-derived molecular descriptors \citep{landrum2016rdkit}.

\subsection{Results}
The XGBoost model achieved $R^2 = 0.85$ (Figure~\ref{fig:qsar-performance}).

\begin{figure}[h]
\centering
\includegraphics[width=0.8\textwidth]{../assets/figures/chapter-04/qsar-actual-vs-predicted.png}
\caption{QSAR model performance for PDE4 inhibition prediction.}
\label{fig:qsar-performance}
\end{figure}

\section{Molecular Docking}
Mesembrine showed strong binding to PDE4B ($\Delta G = -8.5$ kcal/mol)...
```

---

## V. Automation Scripts

### 1. Daily Backup Script

```bash
# ~/LAB/projects/KANNA/tools/scripts/daily-backup.sh

#!/usr/bin/env bash
set -euo pipefail

KANNA_DIR="$HOME/LAB/projects/KANNA"
BACKUP_DIR="/media/backup/KANNA"
CLOUD_REMOTE="tresorit:KANNA"

echo "[$(date)] Starting KANNA daily backup..."

# 1. Backup to external HDD
if [ -d "$BACKUP_DIR" ]; then
    rsync -av --delete \
        --exclude='*.raw' \
        --exclude='venv/' \
        --exclude='.git/' \
        "$KANNA_DIR/" "$BACKUP_DIR/"
    echo "✓ Local backup complete"
else
    echo "⚠ External HDD not mounted at $BACKUP_DIR"
fi

# 2. Backup to cloud (encrypted)
if command -v rclone &> /dev/null; then
    rclone sync "$KANNA_DIR" "$CLOUD_REMOTE" \
        --exclude="*.raw" \
        --exclude="venv/" \
        --exclude=".git/"
    echo "✓ Cloud backup complete"
else
    echo "⚠ rclone not installed"
fi

# 3. Git commit WIP if uncommitted changes
cd "$KANNA_DIR"
if ! git diff-index --quiet HEAD --; then
    git add -A
    git commit -m "auto: daily backup $(date +%Y-%m-%d)"
    echo "✓ Git auto-commit"
fi

echo "[$(date)] Backup complete!"
```

**Install as cron job** (run daily at 2 AM):
```bash
chmod +x ~/LAB/projects/KANNA/tools/scripts/daily-backup.sh
crontab -e
# Add:
0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1
```

---

### 2. Zotero → Obsidian Sync

```bash
# ~/LAB/projects/KANNA/tools/scripts/sync-zotero-obsidian.sh

#!/usr/bin/env bash
set -euo pipefail

ZOTERO_EXPORT="$HOME/LAB/projects/KANNA/literature/zotero-export/kanna.bib"
OBSIDIAN_VAULT="$HOME/LAB/projects/KANNA/literature/notes"

echo "Syncing Zotero to Obsidian..."

# 1. Check if Zotero export is recent (< 1 day old)
if [ -f "$ZOTERO_EXPORT" ]; then
    AGE=$(( $(date +%s) - $(stat -c %Y "$ZOTERO_EXPORT") ))
    if [ $AGE -gt 86400 ]; then
        echo "⚠ Zotero export is $(($AGE / 3600)) hours old. Please refresh in Zotero."
    fi
fi

# 2. Update Obsidian citations plugin
# (Manually configure in Obsidian: Settings → Citations → Literature note folder)

echo "✓ Sync complete. Open Obsidian to import latest citations."
```

---

### 3. Figure Export Automation

```R
# ~/LAB/projects/KANNA/tools/scripts/export-all-figures.R

#!/usr/bin/env Rscript
# Export all analysis figures to assets/figures/ for thesis inclusion

library(here)

# Set output directory
fig_dir <- here("assets", "figures")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

# BEI Figures (Chapter 3)
source(here("analysis", "r-scripts", "ethnobotany", "calculate-bei.R"))
# Figures automatically exported to analysis/r-scripts/ethnobotany/output/bei/
file.copy(
  from = here("analysis", "r-scripts", "ethnobotany", "output", "bei"),
  to = file.path(fig_dir, "chapter-03"),
  recursive = TRUE,
  overwrite = TRUE
)

# Meta-analysis Figures (Chapter 5)
source(here("analysis", "r-scripts", "meta-analysis", "anxiety-rcts.R"))
file.copy(
  from = here("analysis", "r-scripts", "meta-analysis", "output"),
  to = file.path(fig_dir, "chapter-05"),
  recursive = TRUE,
  overwrite = TRUE
)

cat("✓ All figures exported to", fig_dir, "\n")
```

---

## VI. Quality Control Checkpoints

### Weekly Review (Every Sunday Evening)

```markdown
# Weekly Research Review - Week of {{date}}

## Checklist
- [ ] All code committed to Git
- [ ] Figures exported to assets/figures/
- [ ] Zotero library updated (new papers imported)
- [ ] Obsidian daily notes complete
- [ ] PROJECT-STATUS.md updated
- [ ] Backup verified (local + cloud)
- [ ] Trinka grammar check on week's writing
- [ ] Supervisor update email sent

## Metrics
- Words written: {{count}}
- Papers read: {{count}}
- Analyses run: {{list}}
- Figures created: {{count}}
- Git commits: {{count}}

## Reflections
- What went well:
- Challenges encountered:
- Next week priorities:
```

---

### Monthly Milestone Review

```markdown
# Monthly Milestone - {{month}} {{year}}

## Chapter Progress
- [ ] Chapter 1: {{%}} complete
- [ ] Chapter 2: {{%}} complete
- [ ] Chapter 3: {{%}} complete
- [ ] Chapter 4: {{%}} complete
- [ ] Chapter 5: {{%}} complete
- [ ] Chapter 6: {{%}} complete
- [ ] Chapter 7: {{%}} complete
- [ ] Chapter 8: {{%}} complete

## Deliverables
- [ ] Publications submitted: {{count}}
- [ ] Datasets deposited: {{list}}
- [ ] Conferences attended: {{list}}

## Budget Review
- Software costs YTD: €{{amount}}
- Remaining budget: €{{amount}}

## Supervisor Feedback
- {{summary}}

## Next Month Goals
1. {{goal}}
2. {{goal}}
3. {{goal}}
```

---

## VII. Troubleshooting Common Bottlenecks

### Problem: "I'm drowning in papers and can't synthesize"

**Solution**: Obsidian Knowledge Graph Workflow

```bash
# 1. Create atomic notes (one concept per note)
# Example: literature/notes/PDE4-Inhibition-Mechanisms.md
---
tags: [chapter-04, pharmacology, mechanisms]
---

# PDE4 Inhibition Mechanisms

## Key Concept
PDE4 inhibitors increase cAMP → activate PKA → phosphorylate CREB → upregulate BDNF

## Evidence
- [[Smith2023]] - Mesembrine IC50 = 250 nM for PDE4B
- [[Jones2024]] - Structural basis: H-bond with Gln369

## Links
- Related: [[cAMP-CREB-BDNF-Pathway]]
- Contrast: [[SERT-Inhibition-Mechanisms]]

# 2. Use Dataview queries to synthesize
```dataview
TABLE file.tags, summary
FROM #chapter-04 AND #mechanisms
SORT file.ctime DESC
```

# 3. Graph view shows connections
# Obsidian → Open Graph View
# Clusters reveal themes: PDE4 mechanisms, SERT pathways, clinical effects
```

---

### Problem: "QSAR model not improving beyond R² = 0.65"

**Solution**: Hyperparameter Tuning + Feature Engineering

```python
# In analysis/python/cheminformatics/qsar-modeling.py

# 1. Add more diverse descriptors
from rdkit.Chem import Descriptors3D, Lipinski

# 2. Expand hyperparameter grid
param_grid_xgb = {
    'n_estimators': [100, 200, 300, 500],
    'max_depth': [3, 5, 7, 10],
    'learning_rate': [0.01, 0.05, 0.1, 0.2],
    'subsample': [0.7, 0.8, 0.9, 1.0],
    'colsample_bytree': [0.7, 0.8, 0.9, 1.0],
    'gamma': [0, 0.1, 0.2, 0.5],
    'reg_alpha': [0, 0.1, 1.0],
    'reg_lambda': [1, 1.5, 2.0]
}

# 3. Try ensemble stacking
from sklearn.ensemble import StackingRegressor
estimators = [
    ('rf', RandomForestRegressor(**best_rf_params)),
    ('xgb', xgb.XGBRegressor(**best_xgb_params)),
    ('gbm', LGBMRegressor(**best_lgbm_params))
]
stack = StackingRegressor(estimators=estimators, final_estimator=Ridge())

# 4. Use MLflow to track all experiments
mlflow.log_params(param_grid_xgb)
mlflow.log_metric("r2_stack", stack_r2)
```

---

### Problem: "Field data collection is disorganized"

**Solution**: SurveyCTO Pre-Trip Checklist

```markdown
# Field Mission Checklist - Trip {{number}}

## Pre-Departure (1 Week Before)
- [ ] SurveyCTO form tested on tablets (offline mode)
- [ ] FPIC protocols printed and reviewed
- [ ] GPS devices charged and tested
- [ ] Audio recorders formatted (encrypted SD cards)
- [ ] Community partners notified (dates, logistics)
- [ ] Ethics approval documents packed
- [ ] Backup tablets configured (redundancy)

## During Field Work
- [ ] Daily sync to SurveyCTO cloud (when online)
- [ ] GPS coordinates logged for each interview
- [ ] Photos geotagged and linked to survey IDs
- [ ] Consent forms signed and stored separately
- [ ] Daily backup to external HDD (encrypted)

## Post-Return (1 Week After)
- [ ] Download all data from SurveyCTO
- [ ] Store in: data/ethnobotanical/surveys/trip-{{number}}/
- [ ] Transcribe audio within 48 hours (while fresh)
- [ ] Import to MAXQDA for coding
- [ ] Thank-you emails to community partners
- [ ] File expense reports
```

---

### Problem: "Overleaf collaboration conflicts"

**Solution**: Version Control + Branch Strategy

```bash
# 1. Enable Git sync in Overleaf (Premium feature)
# Overleaf → Menu → Git → Copy Git URL

# 2. Clone locally for offline work
git clone https://git.overleaf.com/project_id ~/LAB/projects/KANNA/writing/overleaf-sync

# 3. Create branches for major edits
git checkout -b chapter-04-revision

# 4. Commit frequently with clear messages
git commit -m "ch04: add SHAP interpretation section (Section 4.3.2)"

# 5. Merge back to main after supervisor review
git checkout main
git merge chapter-04-revision

# 6. Push to Overleaf
git push origin main
```

---

## VIII. Success Metrics & Milestones

### Quantitative Metrics (Track Monthly)

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| **Words Written** | 120,000 total | {{count}} | {{%}} |
| **Papers Read** | 500 total | {{count}} | {{%}} |
| **Figures Created** | 50 publication-ready | {{count}} | {{%}} |
| **Code Commits** | 200/year | {{count}} | {{%}} |
| **Publications** | 6-8 first-author | {{count}} | {{%}} |
| **Conference Presentations** | 4-6 total | {{count}} | {{%}} |
| **Field Interviews** | 50-100 | {{count}} | {{%}} |
| **Chemical Analyses** | 32 alkaloids QSAR | {{count}} | {{%}} |

### Qualitative Milestones

**Year 1 (Months 1-14)**: ✅ Foundations Complete
- [x] Literature review complete (500+ papers)
- [x] Zotero library organized
- [x] Obsidian knowledge graph (200+ nodes)
- [x] Chapter 1 draft submitted

**Year 2 (Months 15-26)**: 🔄 Data Collection & Analysis
- [ ] Field work complete (8 missions)
- [ ] MAXQDA coding complete (50-100 interviews)
- [ ] QSAR model validated (R² ≥ 0.80)
- [ ] Chapters 2-4 drafted

**Year 3 (Months 27-38)**: 📝 Integration & Writing
- [ ] Meta-analysis complete
- [ ] All figures finalized
- [ ] Chapters 5-7 drafted
- [ ] First-author publications (4+)

**Year 4 (Months 39-42)**: 🎯 Finalization
- [ ] Chapter 8 complete
- [ ] Thesis assembled in Scrivener
- [ ] Defense slides prepared
- [ ] Thesis submitted

---

## IX. Quick Reference Commands

### Daily Commands

```bash
# Start day
cd ~/LAB/projects/KANNA
claude  # Opens Claude Code with MCP access

# Check status
git status
git log --oneline --since="1 day ago"

# Run analysis
source venv/bin/activate  # or: kanna (if aliased)
jupyter lab

# Backup
~/LAB/projects/KANNA/tools/scripts/daily-backup.sh

# Update status
nano PROJECT-STATUS.md
git add PROJECT-STATUS.md
git commit -m "docs: update weekly progress"
```

### Weekly Commands

```bash
# Export all figures
Rscript ~/LAB/projects/KANNA/tools/scripts/export-all-figures.R

# Sync Zotero
# (Manual: Zotero → Right-click KANNA collection → Export → Better BibLaTeX)

# Review commits
git log --oneline --since="7 days ago" --author="Your Name"

# Check word count
cd writing/thesis-chapters
find . -name "*.tex" -exec wc -w {} + | tail -1
```

---

## X. Conclusion

This optimized workflow integrates:
- **24 core tools** across discovery, analysis, and writing
- **8 chapter-specific workflows** with concrete timelines
- **7 configuration setups** for seamless tool integration
- **3 automation scripts** for backup, sync, and export
- **Quality control checkpoints** at daily, weekly, monthly intervals

**Expected Outcomes**:
- Complete 120,000-word thesis in 42 months
- 6-8 first-author publications
- 50-100 ethnobotanical interviews coded
- QSAR model for 32 alkaloids (R² ≥ 0.80)
- Meta-analysis of 15+ clinical trials
- Reproducible research with Git version control
- Publication-ready figures (300 DPI, 50+ total)

**Time Efficiency**:
- Save 10-15 hours/week with automation
- Reduce tool-switching friction by 40%
- Eliminate duplicate data entry across platforms
- Streamline supervisor collaboration via Overleaf

---

**Next Steps**:
1. Read this entire workflow (2 hours)
2. Set up configurations (Section IV) - 1 day
3. Test one complete workflow (e.g., Literature → Writing) - 1 week
4. Customize for your preferences
5. Commit this workflow to Git for reference

**Living Document**: Update this as you discover better practices. Your future self will thank you.

---

*Created: October 2025*
*Last Updated: {{date}}*
*Version: 1.0*
