# KANNA Project Tools & Resources

This directory contains tool documentation, templates, and utilities for the KANNA thesis project.

## 📁 Contents

### Documentation

**[COMPREHENSIVE-RESEARCH-TOOLS-2025.md](COMPREHENSIVE-RESEARCH-TOOLS-2025.md)** (★ Main Resource)
- **20,000+ words** covering **200+ specialized tools**
- 18 major categories from thesis writing to cloud computing
- Cost analyses, decision matrices, integration workflows
- Based on **24 web searches** across latest 2025 tools
- Specific recommendations for each thesis chapter

**Categories Covered**:
1. Thesis Writing & Academic Writing Tools
2. Literature Review & Discovery Tools
3. Reference Management Software
4. Knowledge Management & Note-Taking
5. Data Analysis & Statistics
6. Cheminformatics & Molecular Modeling
7. Machine Learning Workflows & MLOps
8. Data Visualization & Scientific Figures
9. Collaboration & Project Management
10. Field Research & Data Collection
11. Specialized Research Databases
12. Productivity & Time Management
13. Data Management & Backup
14. Cost Analysis & Decision Matrices
15. Integration Workflows

### Templates (To Be Added)

- `templates/fpic-protocol.md` - Free, Prior, and Informed Consent template
- `templates/interview-guide.md` - Ethnobotanical interview structure
- `templates/survey-form.csv` - BEI/ICF data collection
- `templates/latex-thesis/` - LaTeX thesis template
- `templates/poster-template.pptx` - Conference poster template

### Scripts (To Be Added)

- `scripts/backup-automation.sh` - Automated backup to external drive
- `scripts/zotero-export.sh` - Export Zotero library to project
- `scripts/figure-export.R` - Batch export publication figures
- `scripts/data-validation.py` - Validate survey data integrity

## 🎯 How to Use This Directory

### For Tool Selection

1. **Read the comprehensive guide** first: `COMPREHENSIVE-RESEARCH-TOOLS-2025.md`
2. **Navigate to your research phase**:
   - Year 1: Sections I-IV (writing, literature, references, knowledge management)
   - Year 2: Sections V, X, XI (data analysis, field research, databases)
   - Year 3: Sections VI-VIII (cheminformatics, ML, visualization)
   - Year 4: Sections I, IX, XII (writing, collaboration, productivity)

3. **Use decision matrices** (Section XIV) to choose based on:
   - Budget constraints
   - Solo vs. team research
   - Specific research tasks
   - Integration with existing tools

### For Workflow Implementation

**Example: Literature Review Workflow**
```
See Section XV "Integration Workflows" → Workflow 1
Tools: Elicit → Zotero → Obsidian → LaTeX → Writefull → Trinka
Cost: $34/month
```

**Example: Field Data → Analysis Workflow**
```
See Section XV → Workflow 2
Tools: SurveyCTO → QGIS → R (ethnobotanyR) → MAXQDA → ggplot2 → LaTeX
Cost: $49/month + $600/year
```

### For Budget Planning

**Quick Reference**:
- **$0 Budget**: Section XVI "By Budget Tier" → Free Open-Source Stack
- **$50/month**: Student Budget recommendations
- **$200/month**: Professional Budget
- **$500+/month**: Full Research Grant

**Total 4-Year Estimate**: ~$2,700 ($64/month average)

See Section XVII "Implementation Roadmap" for phased investment strategy.

## 🔧 Quick Start Recommendations

### Immediate Setup (This Week)

1. **Trinka** (free tier): https://www.trinka.ai
   - Academic writing enhancement
   - Use for Chapters 4-6 (technical writing)

2. **Overleaf** (free): https://www.overleaf.com
   - Set up LaTeX thesis template
   - Import from `writing/thesis-chapters/`

3. **Elicit** (free tier): https://elicit.org
   - Start systematic literature search
   - 125M+ papers, auto data extraction

4. **Google Colab** (free): https://colab.research.google.com
   - Test QSAR modeling pipeline
   - Free T4 GPU (12hr sessions)

### High-Value Investments

**If budget allows**, prioritize:
1. **MAXQDA** ($600/year) - Essential for ethnobotanical interview coding (Chapter 3)
2. **SurveyCTO** ($49/month) - Field data collection during 8 missions
3. **BioRender** ($200/year) - Professional scientific diagrams
4. **Writefull** ($180/year) - Academic language polishing

## 📊 Tool Categories by Thesis Chapter

### Chapter 1 (Introduction)
- **Literature Discovery**: Elicit, Consensus, Research Rabbit
- **Reference Management**: Zotero + Better BibTeX
- **Knowledge Graph**: Obsidian

### Chapter 2 (Botany)
- **GIS**: QGIS, Maxent (species distribution)
- **Phylogenetics**: IQ-TREE 3, MEGA, FigTree
- **Databases**: Dr. Duke's, NAPRALERT

### Chapter 3 (Ethnobotany)
- **Field Surveys**: SurveyCTO, KoBoToolbox
- **QDA**: MAXQDA, ATLAS.ti
- **Analysis**: R (ethnobotanyR), BEI/ICF calculations

### Chapter 4 (Pharmacology)
- **Cheminformatics**: RDKit, PubChem, ChEMBL
- **QSAR**: ADMETlab 3.0, scikit-learn, XGBoost
- **Docking**: AutoDock Vina, PyMOL

### Chapter 5 (Clinical)
- **Meta-Analysis**: Metafor (R), RevMan, Rayyan
- **Statistics**: GraphPad Prism, R (lme4)
- **Figures**: ggplot2, forest plots

### Chapter 6 (Addiction)
- **ML**: DeepChem, MLflow, Google Colab
- **Survival Analysis**: R (survival package)
- **Visualization**: Plotly (3D plots)

### Chapter 7 (Legal/Ethics)
- **Document Analysis**: Notion, Obsidian
- **Case Law**: Zotero, legal databases
- **Concept Mapping**: Mind mapping tools

### Chapter 8 (Synthesis)
- **Writing**: Scrivener (compile thesis)
- **Final Editing**: Trinka Pro, Writefull
- **Graphics**: BioRender (graphical abstract)

## 🔗 Integration with LAB MCP Servers

The KANNA project integrates with existing LAB MCP servers:

**Available MCPs** (from `~/LAB/CLAUDE.md`):
- **Context7**: Get latest docs for RDKit, metafor, ethnobotanyR
- **Perplexity**: Research QSAR techniques, meta-analysis best practices
- **GitHub MCP**: Version control operations
- **Cloudflare Browser**: Scrape documentation for tools
- **Jupyter MCP**: Remote notebook execution

**Example Workflow**:
```bash
cd ~/LAB/projects/KANNA
claude  # Start Claude Code in KANNA directory

# Use Context7 to get tool documentation
> "Show me RDKit Morgan fingerprint examples"

# Use Perplexity for research
> "What are 2025 best practices for QSAR validation?"

# Use GitHub MCP for version control
> "Commit analysis scripts with descriptive message"
```

## 📚 Additional Resources

**Tutorial Sites**:
- **Software Carpentry**: R, Python, Git basics
- **QGIS Tutorials**: GIS for researchers
- **RDKit Cookbook**: Cheminformatics examples
- **MetaLab**: Meta-analysis tutorials

**Community Forums**:
- **r/PhD** (Reddit): Tool recommendations
- **Academia Stack Exchange**: Workflow questions
- **ResearchGate**: Discipline-specific tool discussions

**Comparison Sites**:
- **AlternativeTo.net**: Find tool alternatives
- **Capterra**: Compare academic software
- **G2**: User reviews of research platforms

## 🔄 Keeping This Updated

**Quarterly Reviews** (suggested):
- January 2026: Review new AI tools, update costs
- April 2026: Evaluate Year 2 field tools
- July 2026: Check for new cheminformatics platforms
- October 2026: Annual comprehensive update

**When to Add Tools**:
- New research phase begins (e.g., starting fieldwork)
- Supervisor recommends specific software
- Discover workflow bottlenecks
- Budget/funding changes

**How to Contribute**:
1. Test new tool for 1-2 weeks
2. Document pros/cons in `COMPREHENSIVE-RESEARCH-TOOLS-2025.md`
3. Update cost analysis if relevant
4. Commit changes with clear message
5. Share findings with research community

## 📝 Tool Evaluation Checklist

Before adopting a new tool, consider:

- [ ] **Cost**: Fits within budget? Student discounts available?
- [ ] **Learning Curve**: Time to proficiency vs. benefit?
- [ ] **Integration**: Works with existing stack (R, Python, Zotero)?
- [ ] **Data Security**: Meets FPIC/GDPR requirements for sensitive data?
- [ ] **Collaboration**: Team-compatible? Supervisor approval?
- [ ] **Support**: Documentation quality? Active community?
- [ ] **Longevity**: Will it exist in 4 years (thesis duration)?
- [ ] **Export Options**: Can migrate data if needed?
- [ ] **Offline Capability**: Critical for field research?
- [ ] **Platform**: Linux/Windows/Mac compatible?

## 🎓 Educational Philosophy

**Tool Selection Principles**:
1. **Free/Open-Source First**: Maximize budget, ensure reproducibility
2. **Integration Over Features**: Tools that work together > isolated powerhouses
3. **Learn Core Skills**: Don't let tools become crutches
4. **Document Everything**: Methods sections require tool citations
5. **Plan for Scale**: Small dataset today → 10,000 records tomorrow

**Avoid Tool Proliferation**:
- Limit to 10-15 core tools across all categories
- Master a few tools deeply vs. superficial use of many
- Regularly audit: Are you actually using this tool?
- Consolidate when possible (e.g., Notion for notes + tasks)

## 💡 Pro Tips

1. **Institutional Licenses**: Check university subscriptions before purchasing (MAXQDA, SPSS, GraphPad Prism often available)

2. **Student Discounts**: Most commercial tools offer 50-75% off for students (always ask!)

3. **Free Trials**: Test premium features before committing (MAXQDA, Dedoose offer trials)

4. **Academic Bundles**: Some publishers offer tool bundles (e.g., Springer Nature Protocols + tools)

5. **Grant Budgets**: Include software costs in research grant applications

6. **Open-Source Contributions**: Cite and acknowledge FOSS tools in publications

7. **Backup Everything**: Use 3-2-1 rule (3 copies, 2 media types, 1 off-site)

8. **Version Control**: Not just for code - use Git for thesis, data dictionaries, protocols

9. **Documentation**: Write READMEs for custom scripts, future-you will thank you

10. **Community Sharing**: Share custom templates/workflows on OSF, GitHub

---

**Questions?** Consult the comprehensive guide or reach out to research community forums.

**Contributing?** Submit tool recommendations via Git pull request or add to `COMPREHENSIVE-RESEARCH-TOOLS-2025.md`.

---

*Last updated: October 2025*
*Next review: January 2026*
