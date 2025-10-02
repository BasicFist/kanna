# KANNA Project - Quick Start Guide

> **Get productive in 1 day** - Essential setup for your *Sceletium tortuosum* thesis

---

## ⚡ First Hour: Critical Setup

### 1. Environment Setup (20 minutes)

```bash
# Navigate to KANNA
cd ~/LAB/projects/KANNA

# Set up Python environment
python -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# For RDKit (cheminformatics), use conda instead:
# conda create -n kanna python=3.10
# conda activate kanna
# conda install -c conda-forge rdkit
# pip install -r requirements.txt

# Set up R environment
Rscript analysis/r-scripts/install-packages.R
# This will take 15-20 minutes - let it run

# Create alias for quick access
echo 'alias kanna="cd ~/LAB/projects/KANNA && source venv/bin/activate"' >> ~/.zshrc
source ~/.zshrc
```

### 2. Essential Accounts (20 minutes)

**Free Accounts** (sign up now):
1. **Trinka** (https://www.trinka.ai) - Academic writing checker
2. **Elicit** (https://elicit.org) - AI literature discovery
3. **Overleaf** (https://www.overleaf.com) - LaTeX thesis writing
4. **Obsidian** (https://obsidian.md) - Download desktop app

**Already Have**:
- ✅ Zotero (installed)
- ✅ Git (configured)

### 3. Test Core Tools (20 minutes)

```bash
# Test Python environment
python -c "import pandas, numpy, matplotlib; print('✓ Python working')"

# Test R environment
Rscript -e "library(tidyverse); print('✓ R working')"

# Test Git
git status
git log --oneline -5

# Test Claude Code with MCP
cd ~/LAB/projects/KANNA
claude
# Type: /mcp
# Verify Context7, Perplexity, GitHub MCPs are connected
```

---

## 📚 Second Hour: Import Your Research

### 1. Organize Existing PDFs (15 minutes)

```bash
# Your 8 PDFs are already in literature/pdfs/
ls literature/pdfs/

# Open Zotero
# File → Import → Choose files → Select all PDFs in literature/pdfs/
# Zotero will auto-extract metadata

# Create collection: "KANNA Thesis"
# Tag each paper with chapter number: ch01, ch02, ch03, etc.
```

### 2. Set Up Zotero Better BibTeX (10 minutes)

```bash
# 1. Download Better BibTeX
# https://retorque.re/zotero-better-bibtex/installation/
# Save .xpi file

# 2. Install in Zotero
# Tools → Add-ons → Install Add-on From File → Select .xpi

# 3. Configure auto-export
# Right-click "KANNA Thesis" collection
# Export Collection → Format: Better BibLaTeX
# ✓ Keep updated
# Save to: ~/LAB/projects/KANNA/literature/zotero-export/kanna.bib
```

### 3. Create First Obsidian Notes (35 minutes)

```bash
# 1. Open Obsidian
# Open folder as vault → Select: ~/LAB/projects/KANNA/literature/notes/

# 2. Install plugins
# Settings → Community Plugins → Browse
# Install: Zotero Integration, Dataview, Citations

# 3. Create daily note
# Create file: 2025-10-02-daily.md

## Tasks Today
- [x] Set up KANNA environment
- [x] Import papers to Zotero
- [ ] Read 3 papers on Sceletium pharmacology

## Literature Notes
- Starting with ethnobotany papers
- Need to map San terminology to Western medicine

## Research Journal
- Excited to begin! Focus on Chapter 3 ethnobotany first.

# 4. Create first concept note
# Create file: PDE4-Mechanisms.md

# PDE4 Inhibition Mechanisms

## Summary
PDE4 inhibitors increase cAMP levels, leading to neuroprotective effects.

## Key Papers
- [[Terberg2013]] - fMRI study showing amygdala modulation
- [[Nell2013]] - First RCT of Sceletium extract

## Links
- Related: [[SERT-Inhibition]]
- Chapter: [[Chapter 4 - Pharmacology]]

## Questions
- How selective is mesembrine for PDE4B vs 4D?
- Clinical significance of dual SERT/PDE4 action?
```

---

## 🎯 Third Hour: Run First Analysis

### Test QSAR Pipeline (Chapter 4)

```bash
# 1. Activate environment
kanna  # Uses alias you created

# 2. Open Jupyter
jupyter lab
# Browser opens at http://localhost:8888

# 3. Create new notebook
# analysis/jupyter-notebooks/01-data-exploration/test-qsar.ipynb

# 4. Run simple test
import pandas as pd
import numpy as np
from rdkit import Chem
from rdkit.Chem import Descriptors

# Test with mesembrine
smiles = "CN1CCC2(C3CC(C4=CC=CC=C42)OC3)C1"  # Mesembrine
mol = Chem.MolFromSmiles(smiles)

# Calculate descriptors
mw = Descriptors.MolWt(mol)
logp = Descriptors.MolLogP(mol)
tpsa = Descriptors.TPSA(mol)

print(f"Mesembrine properties:")
print(f"  MW: {mw:.2f} Da")
print(f"  LogP: {logp:.2f}")
print(f"  TPSA: {tpsa:.2f} Ų")

# Expected output:
# MW: 247.33 Da
# LogP: 2.47
# TPSA: 32.26 Ų
```

### Test BEI Calculation (Chapter 3)

```bash
# Create sample data
cat > data/ethnobotanical/surveys/sample-bei-data.csv << EOF
informant_id,community,taxon,use_category,n_uses
INF001,SC01,Sceletium tortuosum,Medicinal,3
INF001,SC01,Aloe vera,Medicinal,2
INF002,SC01,Sceletium tortuosum,Ritual,1
INF002,SC01,Hoodia gordonii,Medicinal,1
INF003,SC02,Sceletium tortuosum,Medicinal,4
EOF

# Run BEI calculation
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# Check output
ls analysis/r-scripts/ethnobotany/output/bei/
# You should see:
# - bei-results.csv
# - icf-results.csv
# - bei-by-community.png
# - icf-by-category.png
```

---

## 📖 Fourth Hour: Start Writing

### Set Up Overleaf Thesis (30 minutes)

```bash
# 1. Go to Overleaf: https://www.overleaf.com
# Log in with Google/ORCID

# 2. Create New Project → Upload Project
# Upload template (or start with blank)

# 3. Create main.tex structure
```

**Copy this template to Overleaf**:

```latex
\documentclass[12pt, oneside, a4paper]{book}

\usepackage[utf8]{inputenc}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{natbib}
\usepackage[margin=2.5cm]{geometry}

\title{Interdisciplinary Analysis of \textit{Sceletium tortuosum}}
\author{Your Name}

\begin{document}
\maketitle
\tableofcontents

\chapter{Introduction}
\section{Background}
This thesis investigates \textit{Sceletium tortuosum}, a medicinal plant
traditionally used by Khoisan peoples of Southern Africa...

\section{Research Questions}
1. What is the ethnobotanical significance of \textit{Sceletium}?
2. What are the pharmacological mechanisms of its alkaloids?
3. What is the clinical evidence for anxiolytic effects?

\bibliographystyle{apalike}
\bibliography{kanna}
\end{document}
```

**Link to Zotero**:
- In Overleaf: New File → From External URL
- URL: File path to `~/LAB/projects/KANNA/literature/zotero-export/kanna.bib`
- Or: Upload `kanna.bib` manually and re-upload when updated

### Write First 500 Words (30 minutes)

```latex
\section{The Promise of Ethnopharmacology}

Ethnopharmacology bridges traditional knowledge and modern science,
offering pathways to novel therapeutic compounds \citep{smith2022}.
\textit{Sceletium tortuosum}, known as "kanna" in Khoekhoe language,
exemplifies this intersection...

[Continue writing...]
```

**Use Writefull/Trinka**:
- Install browser extension for Overleaf
- Highlights academic phrasing improvements
- Suggests paraphrasing for repetitive text

---

## ✅ End of Day 1 Checklist

### Environment ✓
- [x] Python environment working (RDKit, pandas, scikit-learn)
- [x] R environment working (tidyverse, metafor, ethnobotanyR)
- [x] Git repository verified
- [x] MCP servers tested (Context7, Perplexity)

### Accounts ✓
- [x] Trinka account created
- [x] Elicit account created
- [x] Overleaf account created
- [x] Obsidian installed

### Knowledge Management ✓
- [x] Zotero with 8+ papers imported
- [x] Better BibTeX auto-export configured
- [x] Obsidian vault created with first notes
- [x] Daily note template created

### Analysis ✓
- [x] QSAR test run (mesembrine descriptors calculated)
- [x] BEI test run (sample data analyzed)
- [x] Figures generated and exported

### Writing ✓
- [x] Overleaf project created
- [x] LaTeX template set up
- [x] First 500 words written
- [x] Bibliography linked (kanna.bib)

---

## 🚀 Week 1 Goals

### Days 2-3: Literature Deep Dive
- [ ] Use Elicit to discover 50+ Sceletium papers
- [ ] Import all to Zotero, tag by chapter
- [ ] Read 10 key papers, create Obsidian notes
- [ ] Build knowledge graph (30+ concept nodes)

### Days 4-5: Analysis Workflows
- [ ] Run complete QSAR workflow (32 alkaloids)
- [ ] Create publication-ready QSAR figures
- [ ] Test meta-analysis workflow with sample data
- [ ] Export all figures to `assets/figures/`

### Days 6-7: Writing Sprint
- [ ] Draft complete Chapter 1, Section 1.1 (1500 words)
- [ ] Insert 2-3 figures with captions
- [ ] Add 20+ citations from Zotero
- [ ] Trinka grammar check
- [ ] Commit all progress to Git

---

## 📊 Week 1 Success Metrics

**Targets**:
- **Words written**: 2,000-3,000
- **Papers read**: 15-20
- **Obsidian notes**: 30-50
- **Figures created**: 5-10
- **Git commits**: 15-25

**Check Progress**:
```bash
# Word count
cd writing/thesis-chapters
find . -name "*.tex" -exec wc -w {} + | tail -1

# Git activity
git log --oneline --since="7 days ago" | wc -l

# Zotero count
# Open Zotero → KANNA collection → See count in sidebar

# Obsidian count
ls literature/notes/*.md | wc -l
```

---

## 🆘 Help & Resources

### Quick Commands

```bash
# Start working
kanna  # Activates environment, navigates to project

# Daily backup
~/LAB/projects/KANNA/tools/scripts/daily-backup.sh

# Export figures
Rscript tools/scripts/export-all-figures.R

# Check status
git status
cat PROJECT-STATUS.md

# Open Claude Code with MCP
claude
```

### Documentation

**In this repository**:
- `README.md` - Project overview
- `OPTIMIZED-THESIS-WORKFLOW.md` - **Complete daily/weekly workflows**
- `tools/COMPREHENSIVE-RESEARCH-TOOLS-2025.md` - **200+ tool recommendations**
- `PROJECT-STATUS.md` - Track progress
- `tools/scripts/README.md` - Automation scripts

**External resources**:
- Zotero guide: https://www.zotero.org/support/
- Obsidian help: https://help.obsidian.md
- RDKit documentation: https://www.rdkit.org/docs/
- LaTeX tutorial: https://www.overleaf.com/learn

### Troubleshooting

**Python import errors**:
```bash
# Reinstall dependencies
pip install -r requirements.txt --force-reinstall
```

**R package errors**:
```R
# Reinstall packages
source("analysis/r-scripts/install-packages.R")
```

**Git conflicts**:
```bash
# Stash changes, pull, re-apply
git stash
git pull
git stash pop
```

**Jupyter won't start**:
```bash
# Check environment activated
source venv/bin/activate
# Reinstall jupyter
pip install --upgrade jupyter jupyterlab
```

---

## 🎓 Learning Path

**Month 1**: Foundations
- Master Zotero + Obsidian workflow
- Complete Chapter 1 draft
- Learn R basics (if needed)

**Month 2**: Analysis
- QSAR modeling with RDKit
- Statistical analysis with R
- Jupyter notebook best practices

**Month 3**: Writing
- LaTeX proficiency
- Academic writing style (Trinka/Writefull)
- Figure design (ggplot2, matplotlib)

---

## 💡 Pro Tips

1. **Start each day with Obsidian daily note** - Clarifies priorities
2. **Use Pomodoro technique** (25 min work, 5 min break) - Maintains focus
3. **Commit to Git frequently** - "Commit early, commit often"
4. **Read papers in Zotero PDF reader** - Keeps highlights in one place
5. **Use MCP servers** - Ask Claude Code for help via Context7/Perplexity
6. **Back up weekly** - Test restore process monthly
7. **Share progress weekly** - Email supervisor brief updates
8. **Take breaks** - Research is a marathon, not a sprint

---

## ✨ You're Ready!

You now have:
- ✅ Complete research infrastructure
- ✅ 200+ tool recommendations
- ✅ Optimized daily/weekly workflows
- ✅ Automation scripts for backups/figures
- ✅ Analysis templates (QSAR, BEI, meta-analysis)
- ✅ Integration: Zotero → Obsidian → LaTeX → Git

**Next step**: Start your first Pomodoro session and write 500 words! 🚀

---

*Good luck with your thesis! You've got this.* 💪

---

**Questions?**
- Consult `OPTIMIZED-THESIS-WORKFLOW.md` for detailed workflows
- Check `tools/COMPREHENSIVE-RESEARCH-TOOLS-2025.md` for tool alternatives
- Ask in research community forums (r/PhD, Academia StackExchange)

**Last updated**: October 2025
