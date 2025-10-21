# KANNA Project: *Sceletium tortuosum* Interdisciplinary Thesis

> **PhD Thesis**: Interdisciplinary Analysis of *Sceletium tortuosum* - From Khoisan Traditional Knowledge to Modern Neuropharmacology

**📚 Documentation Navigation**: See [DOCUMENTATION-INDEX.md](./DOCUMENTATION-INDEX.md) for complete documentation index and quick-access decision trees

**🚀 Quick Start**:
- **For Claude Code**: Start with [CLAUDE.md](./CLAUDE.md) (session initialization, environments, workflows)
- **For Architecture**: See [ARCHITECTURE.md](./ARCHITECTURE.md) (39 KB definitive reference)
- **For Current Status**: Check [PROJECT-STATUS.md](./PROJECT-STATUS.md) (updated weekly)

---

## Project Overview

This repository contains all research materials, data, analysis scripts, and writing for a comprehensive interdisciplinary doctoral thesis on *Sceletium tortuosum* (Kanna), covering:

- **Botany & Taxonomy** - Phylogenomics, infraspecific structure, biodiversity
- **Ethnobotany** - Khoisan traditional knowledge, linguistic analysis, cultural transmission
- **Phytochemistry** - 32+ alkaloids, LC-MS/MS characterization, QSAR modeling
- **Pharmacology** - SERT/PDE4 mechanisms, molecular docking, ADMET prediction
- **Clinical Research** - Anxiety, depression, PTSD, addiction applications
- **Legal & Ethics** - Biopiracy analysis, WIPO Treaty 2024, benefit-sharing frameworks
- **Decolonial Studies** - Indigenous rights, epistemic justice, collaborative research

**Thesis Duration**: 42 months (3.5 years)
**Expected Completion**: [Add date]
**Primary Institution**: [Add institution]

---

## 📁 Repository Structure

```
KANNA/
│
├── literature/                      # Reference management & literature review
│   ├── pdfs/                       # Research papers, books, reports
│   ├── notes/                      # Literature notes, annotations
│   └── zotero-export/              # Exported bibliographies (.bib files)
│
├── data/                           # Research data (organized by discipline)
│   ├── ethnobotanical/
│   │   ├── interviews/             # Interview transcripts (SENSITIVE - gitignored)
│   │   ├── surveys/                # Ethnobotanical survey data
│   │   └── fpic-protocols/         # FPIC documentation (Free, Prior, Informed Consent)
│   │
│   ├── phytochemical/
│   │   ├── lc-ms/                  # LC-MS/MS raw data & processed results
│   │   ├── alkaloid-profiles/      # Chemical characterization data
│   │   └── qsar-models/            # QSAR modeling datasets
│   │
│   ├── clinical/
│   │   ├── trials/                 # Clinical trial data (de-identified)
│   │   ├── safety-data/            # Toxicology, pharmacovigilance
│   │   └── pharmacokinetics/       # PK/PD studies
│   │
│   ├── legal/
│   │   ├── patents/                # Patent analyses (Zembrin®, etc.)
│   │   ├── treaties/               # WIPO, Nagoya Protocol documents
│   │   └── benefit-sharing/        # ABS agreements, CSIR-San model
│   │
│   ├── botanical/
│   │   ├── taxonomy/               # Taxonomic data, phylogenies
│   │   ├── specimens/              # Herbarium records, field collections
│   │   └── gis-maps/               # Geographic distribution data
│   │
│   └── molecular-modeling/
│       ├── docking/                # AutoDock Vina results (PDE4/SERT)
│       ├── admet/                  # ADMET predictions (SwissADME, pkCSM)
│       └── structures/             # 3D molecular structures (.pdb, .mol2)
│
├── analysis/                       # Analysis scripts & computational work
│   ├── r-scripts/
│   │   ├── ethnobotany/           # BEI, ICF, ethnobotanyR analyses
│   │   ├── statistics/            # Meta-analysis, mixed-effects models
│   │   └── meta-analysis/         # Forest plots, clinical trial syntheses
│   │
│   ├── python/
│   │   ├── cheminformatics/       # RDKit, molecular descriptors
│   │   ├── ml-models/             # Random Forest, DeepChem, QSAR
│   │   └── text-mining/           # NLP, spaCy, BERT for literature mining
│   │
│   └── jupyter-notebooks/          # Interactive analyses & visualizations
│
├── writing/                        # Thesis writing & publications
│   ├── thesis-chapters/
│   │   ├── ch01-introduction/     # Chapter 1: Introduction & Context
│   │   ├── ch02-botany/           # Chapter 2: Botanical Foundations
│   │   ├── ch03-ethnobotany/      # Chapter 3: Khoisan Ethnobotanical Heritage
│   │   ├── ch04-pharmacology/     # Chapter 4: Pharmacognosy & Neurobiology
│   │   ├── ch05-clinical/         # Chapter 5: Clinical Validation
│   │   ├── ch06-addiction/        # Chapter 6: Addiction Research
│   │   ├── ch07-legal/            # Chapter 7: Legal & Ethical Issues
│   │   └── ch08-synthesis/        # Chapter 8: Synthesis & Perspectives
│   │
│   ├── publications/              # Journal articles, conference papers
│   └── presentations/             # Conference slides, posters
│
├── fieldwork/                      # Field research materials
│   ├── protocols/                 # Field protocols, SOPs
│   ├── interviews-raw/            # Raw interview data (SENSITIVE - gitignored)
│   ├── photos/                    # Field photos, plant specimens
│   └── gps-data/                  # GPS coordinates, site metadata
│
├── collaboration/                  # Partner collaboration materials
│   ├── khoisan-partners/          # San Council, WIMSA communications
│   ├── academic-partners/         # Co-author collaborations
│   └── ethics-approvals/          # IRB approvals, ethical clearances
│
├── assets/                         # Publication-ready materials
│   ├── figures/                   # Publication figures (ggplot2, matplotlib)
│   ├── tables/                    # Formatted tables
│   └── supplementary/             # Supplementary materials
│
└── tools/                          # Utilities & templates
    ├── scripts/                   # Automation scripts
    └── templates/                 # Document templates (FPIC, protocols)
```

---

## 🎯 Thesis Structure

### Chapter Overview

**Chapter 1: Introduction and Contextualization**
- Biopiracy case study (Zembrin® monopoly)
- WIPO Treaty 2024 implications
- Decolonial methodology framework

**Chapter 2: Botanical Foundations**
- Taxonomic revision (Klak et al., 2025)
- Phylogenomics & biodiversity
- GIS distribution mapping

**Chapter 3: Khoisan Ethnobotanical Heritage**
- Linguistic diversity ("kanna" etymology)
- Traditional uses & ritual practices
- FPIC protocols & community engagement

**Chapter 4: Pharmacognosy & Neurobiology**
- 32 alkaloids (mesembrine, mesembrenone, etc.)
- SERT/PDE4 dual mechanisms
- Molecular docking & ADMET modeling

**Chapter 5: Clinical Validation**
- RCT systematic review
- Safety profiles & drug interactions
- Anxiety, depression, PTSD applications

**Chapter 6: Addiction & Neurodependence**
- PDE4 mechanisms in reward circuits
- Preclinical addiction models
- Clinical trial design recommendations

**Chapter 7: Legal & Ethical Issues**
- Patent analysis (HGH Pharmaceuticals)
- Benefit-sharing models (CSIR-San agreement)
- Decolonial knowledge economies

**Chapter 8: Synthesis & Perspectives**
- Interdisciplinary contributions
- Future research priorities
- Sustainable valorization framework

---

## 🛠️ Technical Stack & Tools

### Data Analysis
- **R** (≥4.3): `ethnobotanyR`, `metafor`, `lme4`, `ChemoSpec`
- **Python** (≥3.10): `RDKit`, `scikit-learn`, `DeepChem`, `spaCy`
- **Jupyter**: Interactive analysis notebooks

### Molecular Modeling
- **AutoDock Vina**: Molecular docking (PDE4/SERT targets)
- **PyMOL**: Visualization of protein-ligand complexes
- **SwissADME/pkCSM**: ADMET predictions

### Cheminformatics
- **RDKit**: Molecular descriptors, fingerprints, QSAR
- **ChemAxon tools**: logP, TPSA calculations
- **GNPS**: Feature-Based Molecular Networking (FBMN)

### Statistical Analysis
- **R metafor**: Meta-analysis of clinical trials
- **Stan/PyMC3**: Bayesian inference
- **GraphPad Prism**: Publication-ready statistics

### Text Mining & NLP
- **spaCy**: Named entity recognition
- **BERT**: Semantic search & topic modeling
- **Local Llama 70B**: Literature synthesis (privacy-preserving)

### Reference Management
- **Zotero**: 500+ references with Better BibTeX
- **Obsidian**: Knowledge graph & note-taking

### Writing & Collaboration
- **LaTeX**: Thesis typesetting
- **Git**: Version control
- **Claude MAX**: AI-assisted writing (200K context)

---

## 📊 Data Management

### Sensitive Data Protection

**NEVER commit to Git:**
- ✗ Raw interview transcripts (`fieldwork/interviews-raw/`)
- ✗ Identifiable clinical data (`data/clinical/trials/**/patient-data/`)
- ✗ FPIC protocols with personal info
- ✗ API keys and credentials (`.env` files)

**Encrypted storage for:**
- Interview recordings (local encrypted drive)
- Personal contact information
- Unpublished proprietary chemical data

### Data Backup Strategy

1. **Local backup**: External HDD (weekly)
2. **Cloud backup**: Encrypted cloud storage (Tresorit/SpiderOak)
3. **Institutional storage**: University research drive
4. **Git**: Code, scripts, de-identified data only

---

## 🔬 Reproducibility & Open Science

### Version Control
- All analysis scripts tracked in Git
- Semantic versioning for major analyses
- Detailed commit messages with rationale

### Computational Environment
- `requirements.txt` (Python dependencies)
- `renv.lock` (R package snapshots)
- Docker containers for complex workflows

### Data Availability
- De-identified datasets deposited at publication
- Figshare/Zenodo DOIs for reproducibility
- Code released under MIT License (when appropriate)

### FAIR Principles
- **F**indable: DOIs, metadata, clear naming
- **A**ccessible: Open access publications
- **I**nteroperable: Standard formats (CSV, JSON, PDB)
- **R**eusable: Clear licenses, documentation

---

## 👥 Collaboration & Ethics

### Community Engagement
- **South African San Council**: Primary community partner
- **WIMSA**: Regional indigenous coordination
- **Local guides**: Field research collaboration

### Ethical Frameworks
- **FPIC**: Ongoing consent process, not one-time event
- **Benefit-sharing**: Financial + non-financial (capacity building)
- **Cultural sensitivity**: Respect for traditional protocols
- **Data sovereignty**: Communities control their data

### Institutional Approvals
- Ethics Review Board (IRB) approval: [Add number]
- Research permits: [Add details]
- Export permits: CITES, national regulations

---

## 📈 Timeline & Milestones

### Year 1 (Months 1-14): Foundations
- [x] Literature review (ongoing)
- [x] FPIC negotiations & community partnerships
- [ ] Field collections & botanical surveys
- [ ] Initial LC-MS/MS analyses

### Year 2 (Months 15-26): Core Research
- [ ] Complete chemical characterization (32 alkaloids)
- [ ] Molecular docking & ADMET modeling
- [ ] Ethnobotanical surveys & interviews
- [ ] Statistical analyses (BEI, ICF)

### Year 3 (Months 27-38): Integration
- [ ] Meta-analysis of clinical trials
- [ ] Legal case studies (patent analysis)
- [ ] Synthesis & manuscript writing
- [ ] First-author publications (target: 6)

### Year 4 (Months 39-42): Finalization
- [ ] Thesis writing & revision
- [ ] Community review & validation
- [ ] Defense preparation
- [ ] Final publications

---

## 📚 Key References

**Recent Major Sources:**
- Klak et al. (2025). "Resolving infrageneric structure Mesembryanthemum." *Taxon* 74:101-118
- Hammer et al. (2023). "Mesembryanthemum realignments: chloroplast phylogenomics." *Taxon* 73:562-578
- Terberg et al. (2013). "Acute effects of Sceletium tortuosum (Zembrin)." *Neuropsychopharmacology* 38:2708-2716
- WIPO Treaty (2024). "Treaty on Intellectual Property, Genetic Resources and Associated Traditional Knowledge"

**Full bibliography:** See `literature/zotero-export/kanna-complete.bib`

---

## 📝 Usage Instructions

### Getting Started

1. **Clone the repository** (if working remotely):
   ```bash
   git clone [repository-url]
   cd KANNA
   ```

2. **Set up Python environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/Mac
   pip install -r requirements.txt
   ```

3. **Set up R environment**:
   ```R
   install.packages("renv")
   renv::restore()
   ```

4. **Configure sensitive data locations**:
   - Edit `.env.example` → `.env` (gitignored)
   - Set paths for encrypted interview storage
   - Configure API keys (Perplexity, Context7, etc.)

### Daily Workflow

**Morning**: Literature review & data collection
```bash
# Import new papers to Zotero
# Export annotations to literature/notes/
# Update Obsidian knowledge graph
```

**Midday**: Analysis & modeling
```bash
# Run R scripts: analysis/r-scripts/ethnobotany/
# Update Python models: analysis/python/ml-models/
# Document results in Jupyter notebooks
```

**Afternoon**: Writing & synthesis
```bash
# Draft thesis chapters: writing/thesis-chapters/
# Update figures: assets/figures/
# Commit progress to Git
```

---

## 🚨 Important Reminders

### Research Ethics
- ✅ Always obtain FPIC before collecting data
- ✅ Anonymize all interview transcripts
- ✅ Share findings with communities before publication
- ✅ Credit traditional knowledge appropriately

### Data Security
- 🔒 Encrypt interview recordings immediately
- 🔒 Never commit sensitive data to Git
- 🔒 Use secure channels for community communications
- 🔒 Back up data weekly (3-2-1 rule)

### Legal Compliance
- ⚖️ Respect CITES regulations for plant exports
- ⚖️ Follow ABS (Access & Benefit Sharing) protocols
- ⚖️ Document all research permits
- ⚖️ Acknowledge funding sources & conflicts of interest

---

## 📞 Contact & Support

**Primary Researcher**: [Your name]
**Email**: [Your email]
**Institution**: [Your institution]
**ORCID**: [Your ORCID]

**Community Partners**:
- South African San Council: [Contact info]
- WIMSA: [Contact info]

---

## 📄 License

- **Code**: MIT License (see `LICENSE-CODE`)
- **Data**: Restricted - Community data sovereignty applies
- **Writing**: Copyright [Your name], [Year]

**Traditional Knowledge**: Intellectual property rights remain with Khoisan communities. Commercial use requires separate agreements.

---

## 🙏 Acknowledgments

This research is conducted in partnership with Khoisan communities and with deep respect for their traditional knowledge systems. We acknowledge the historical injustices of biopiracy and commit to decolonial research practices.

**Funding**: [Add funding sources]
**Institutional Support**: [Add institutions]
**Community Partners**: South African San Council, WIMSA

---

*Last updated: October 2025*
