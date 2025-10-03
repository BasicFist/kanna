# KANNA Project Status Tracker

## Project Information

**Title**: Interdisciplinary Analysis of *Sceletium tortuosum*
**Duration**: 42 months
**Started**: October 2025
**Expected Completion**: [Add date]

---

## Overall Progress

- [ ] Year 1: Foundations & Partnerships (Months 1-14)
- [ ] Year 2: Core Research & Analysis (Months 15-26)
- [ ] Year 3: Integration & Writing (Months 27-38)
- [ ] Year 4: Finalization & Defense (Months 39-42)

**Current Status**: Project Setup Complete ✅

---

## Chapter Progress

### Chapter 1: Introduction and Contextualization
- [ ] Literature review complete
- [ ] Methodology section drafted
- [ ] Decolonial framework established
- [ ] FPIC protocols developed

### Chapter 2: Botanical Foundations
- [ ] Taxonomic review complete
- [ ] Field collections completed
- [ ] GIS mapping done
- [ ] Phylogenetic analysis complete

### Chapter 3: Khoisan Ethnobotanical Heritage
- [ ] Community partnerships established
- [ ] FPIC agreements signed
- [ ] Interviews conducted (Target: 50-100)
- [ ] BEI/ICF analyses complete
- [ ] Community validation received

### Chapter 4: Pharmacognosy & Neurobiology
- [ ] LC-MS/MS characterization complete (32 alkaloids)
- [ ] Molecular docking complete (PDE4/SERT)
- [ ] QSAR models validated (R² ≥ 0.70)
- [ ] ADMET predictions complete

### Chapter 5: Clinical Validation
- [ ] Systematic review complete
- [ ] Meta-analysis complete
- [ ] Safety profile documented
- [ ] Clinical recommendations drafted

### Chapter 6: Addiction & Neurodependence
- [ ] Literature review complete
- [ ] Preclinical evidence synthesized
- [ ] Clinical trial design proposed
- [ ] Mechanisms chapter drafted

### Chapter 7: Legal & Ethical Issues
- [ ] Patent analysis complete (Zembrin®)
- [ ] WIPO Treaty 2024 analysis complete
- [ ] Benefit-sharing models reviewed
- [ ] Policy recommendations drafted

### Chapter 8: Synthesis & Perspectives
- [ ] Cross-chapter synthesis complete
- [ ] Future research priorities identified
- [ ] Sustainable valorization framework drafted
- [ ] Implications for justice discussed

---

## Research Outputs

### Publications (Target: 15-20)

**Published**:
- [ ] None yet

**In Preparation**:
- [ ] Chapter 2: Taxonomic revision paper
- [ ] Chapter 3: Ethnobotanical survey results
- [ ] Chapter 4: QSAR modeling of alkaloids
- [ ] Chapter 5: Meta-analysis of clinical trials
- [ ] Chapter 6: PDE4 mechanisms in addiction
- [ ] Chapter 7: Biopiracy case study

### Presentations
- [ ] Conference 1: [Add details]
- [ ] Conference 2: [Add details]

### Datasets
- [ ] Ethnobotanical survey data (de-identified)
- [ ] LC-MS/MS alkaloid profiles
- [ ] QSAR model datasets
- [ ] GIS distribution maps

---

## Community Engagement

### Partnerships
- [ ] South African San Council - Agreement signed
- [ ] WIMSA - Partnership established
- [ ] Local communities - FPIC completed

### Benefit-Sharing
- [ ] Financial arrangements finalized
- [ ] Capacity building programs initiated
- [ ] Community validation processes established

### Ethical Approvals
- [ ] IRB approval received (Number: _______)
- [ ] Research permits obtained
- [ ] Export permits secured

---

## Technical Infrastructure

### Data Collection
- [x] Directory structure created
- [x] Git repository initialized
- [ ] Backup systems configured
- [ ] Encrypted storage for sensitive data

### Analysis Environment
- [ ] R environment set up (`renv.lock` created) - **REQUIRES MANUAL**: `sudo dnf install -y R R-devel`
- [x] Python environment set up (`requirements.txt` installed) - **COMPLETE** (conda env: kanna)
- [x] RDKit installed (via conda) - **COMPLETE** (v2025.9.1, tested with mesembrine)
- [ ] AutoDock Vina configured
- [ ] PyMOL installed

### AI/ML Tools Integration
- [x] Claude Code active (running in KANNA project)
- [x] Perplexity API configured (inherited from ~/LAB/)
- [x] Context7 API configured (inherited from ~/LAB/)
- [ ] Local Llama 70B running (Ollama)
- [x] MCP servers connected (17 servers: Context7, Perplexity, GitHub, Cloudflare suite, etc.)

---

## Current Priorities

### This Week (October 3, 2025 - Updated)
1. [x] Complete Python environment setup (conda env 'kanna' with RDKit)
2. [ ] Install R manually: `sudo dnf install -y R R-devel` (requires password)
2. [ ] Organize existing literature PDFs with Zotero
3. [ ] Draft FPIC protocols for community engagement
4. [ ] Begin systematic literature review

### This Month
1. [ ] Finalize community partnership agreements
2. [ ] Develop interview protocols
3. [ ] Set up LC-MS/MS analysis pipeline
4. [ ] Create GIS basemap for species distribution

### This Quarter
1. [ ] Complete first round of community interviews
2. [ ] Analyze first batch of chemical samples
3. [ ] Submit first publication (taxonomic review)
4. [ ] Present at first conference

---

## Metrics & KPIs

### Scientific Output
- Publications (peer-reviewed): 0 / 18-22
- Conference presentations: 0 / 6+
- Datasets published: 0 / 3+

### Community Impact
- FPIC agreements: 0 / 3-5
- Training sessions delivered: 0 / 8-12
- Community members trained: 0 / 50-100

### Academic Impact
- Students mentored: 0 / 6-10
- Collaborations established: 0 / 5+
- Citations (3 years post-defense): 0 / 500+

---

## Risk Management

### Identified Risks
- [ ] **Community access issues**: Mitigated by establishing partnerships early
- [ ] **Sample collection restrictions**: Obtain all permits before fieldwork
- [ ] **Chemical analysis delays**: Build buffer time into schedule
- [ ] **Funding gaps**: Apply for multiple grants

### Contingency Plans
- [ ] Alternative communities identified if access denied
- [ ] Backup analytical facilities identified
- [ ] Alternative research questions if data unavailable

---

## Funding Status

**Current Funding**:
- Source 1: [Add details] - €_______
- Source 2: [Add details] - €_______

**Pending Applications**:
- Grant 1: [Add details] - €_______
- Grant 2: [Add details] - €_______

**Total Budget**: €_______ (target based on Chapter 1 plan: ~€850K)

---

## Notes & Reflections

### Week of October 2, 2025
- ✅ Project infrastructure setup completed
- ✅ Repository structure finalized
- ✅ Analysis templates created
- ✅ 5 comprehensive setup guides created (1,670+ lines, tools/guides/)
- ✅ Exhaustive 42-month implementation plan developed
- Next: Begin literature organization with Zotero

### October 3, 2025 - Python Environment Complete
- ✅ Created conda environment 'kanna' with Python 3.10
- ✅ Installed RDKit via conda-forge (cheminformatics cornerstone)
- ✅ Installed all Python dependencies from requirements.txt (150+ packages)
- ✅ Downloaded spaCy English model (en_core_web_sm) for NLP
- ✅ Validated RDKit with mesembrine alkaloid (MW: 231.34 g/mol, LogP: 2.36)
- **Ready for**: QSAR modeling (Chapter 4), text mining, ML workflows
- **Remaining**: Install R manually (`sudo dnf install -y R R-devel`)
- **Next**: Zotero setup (Guide 1), Obsidian vault (Guide 1), Overleaf project (Guide 5)

### October 3, 2025 - MinerU PDF Extraction Integration
- ✅ Researched MinerU documentation (Context7 + WebSearch)
- ✅ Created **Guide 6**: MinerU PDF Extraction Setup (comprehensive 600+ lines)
- ✅ Updated requirements.txt (magic-pdf → mineru migration notes)
- ✅ Created batch processing script: `tools/scripts/extract-pdfs-mineru.sh`
- ✅ Updated tools/README.md with Guide 6 integration
- **Capabilities**: Extract formulas (LaTeX), tables (markdown), images from 500+ papers
- **Integration**: Elicit → Zotero → MinerU → Obsidian → Overleaf workflow
- **Critical for**: Chapter 4 (pharmacology IC₅₀ tables), Chapter 5 (meta-analysis data)

### October 3, 2025 - MinerU Installation & Enhancements COMPLETE ✅
- ✅ Installed uv package manager (v0.8.22)
- ✅ Installed mineru[core] v2.5.4 (latest, with VL-utils enhancements)
- ✅ Model weights auto-downloaded on first run (~2GB from HuggingFace)
  - layoutlmv3 (layout detection), yolo_v8_mfd (formula detection)
  - unimernet_small (formula LaTeX), rapid_table (table structure)
- ✅ Tested extraction with French PDF "Processus de fermentation du kanna" (5 pages, 392KB)
  - ✓ French accents perfectly preserved
  - ✓ 2 formulas extracted as LaTeX
  - ✓ 13 citations with URLs extracted
  - ✓ Processing time: ~3 minutes (CPU mode)
- ✅ **Batch processing**: Currently extracting all 8 French PDFs (running in background)
- ✅ **Enhancement 3**: Smart caching added (skip re-processing existing extractions)
- ✅ **Enhancement 4**: Quality validation script created (`validate-extraction-quality.sh`)
- ✅ **Enhancement 5**: Obsidian auto-import script created (`mineru-to-obsidian-auto.sh`)
- **Ready for**: 500+ papers over 42 months, ~5 min/PDF (CPU), ~1-2 min/PDF (GPU if needed)
- **Next**: Wait for batch completion (~30-40 min), run quality validation, import to Obsidian (Week 2)

### [Add more weekly reflections here]

---

## Quick Links

- Main README: [README.md](README.md)
- Thesis Plan: [writing/plan-these-sceletium-complet.md](writing/plan-these-sceletium-complet.md)
- Literature: [literature/](literature/)
- Data: [data/](data/)
- Analysis: [analysis/](analysis/)

---

*Last updated: October 2, 2025*
