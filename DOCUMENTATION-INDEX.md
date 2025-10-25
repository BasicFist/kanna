# KANNA Project Documentation Index

**Version**: 2.0
**Last Updated**: October 21, 2025
**Purpose**: Central navigation hub for all KANNA project documentation

> **Quick Start**: New to KANNA? Start with [CLAUDE.md](./CLAUDE.md) → [ARCHITECTURE.md](./ARCHITECTURE.md) → [PROJECT-STATUS.md](./PROJECT-STATUS.md)

---

## 📖 Table of Contents

1. [Documentation by Task Type](#documentation-by-task-type)
2. [Documentation Tiers](#documentation-tiers)
3. [Quick Decision Trees](#quick-decision-trees)
4. [File Organization](#file-organization)
5. [Documentation Maintenance](#documentation-maintenance)

---

## Documentation by Task Type

### Session Initialization

**Primary**: [CLAUDE.md](./CLAUDE.md) - Section: "Session Initialization"

**6-Step Boot Sequence**:
1. Activate project via Serena MCP
2. Read PROJECT-STATUS.md (first 50 lines)
3. List available memories
4. Load task-relevant memories
5. Check git status
6. Verify conda environment

**Checklists**:
- [ ] Serena shows "Active project: KANNA"
- [ ] ≥1 memory loaded
- [ ] Correct conda environment active
- [ ] Git status clean or changes understood

---

### Environment & Setup

| Task | Primary Document | Quick Command |
|------|------------------|---------------|
| **Verify environments** | [CLAUDE.md](./CLAUDE.md) - Section: "Three-Environment Strategy" | `conda info --envs` |
| **R environment troubleshooting** | [docs/infrastructure/r-environment-setup.md](./docs/infrastructure/r-environment-setup.md) | `conda activate r-gis && Rscript -e "library(brms); library(sf)"` |
| **Python environment (kanna)** | [.serena/memories/kanna-conda-environments.md](./.serena/memories/kanna-conda-environments.md) | `conda activate kanna && python -c "from rdkit import Chem; print('✓')"` |
| **MinerU environment (PDF)** | [docs/mineru/MINERU-ENVIRONMENT.md](./docs/mineru/MINERU-ENVIRONMENT.md) | `conda activate mineru && python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')` |
| **CUDA troubleshooting** | [docs/infrastructure/CUDA-FIX-STATUS.md](./docs/infrastructure/CUDA-FIX-STATUS.md) | See "CUDA Initialization Persistent Failure" |
| **MCP server check** | [docs/MCP-CONFIGURATION-AUDIT.md](./docs/MCP-CONFIGURATION-AUDIT.md) | `/mcp` (should show 13/13) |

**Environment Decision Tree**:
```
What are you doing?
├─ PDF Extraction? → mineru
├─ Chemical/QSAR Analysis? → kanna (RDKit)
├─ Machine Learning? → kanna (scikit-learn, spaCy)
├─ GIS/Spatial Analysis? → r-gis (sf, GEOS)
├─ Bayesian Statistics? → r-gis (brms)
├─ Meta-Analysis? → r-gis (metafor)
└─ General R Stats? → r-gis (tidyverse)
```

---

### PDF Extraction (MinerU)

**⚠️ CRITICAL**: Read [docs/pdf-extraction/EXTRACTION-GUIDE.md](./docs/pdf-extraction/EXTRACTION-GUIDE.md) first!

| Task | Document | Key Section |
|------|----------|-------------|
| **Philosophy & principles** | [CLAUDE.md](./CLAUDE.md) | "PDF Extraction Philosophy" |
| **Complete extraction guide** | [docs/pdf-extraction/EXTRACTION-GUIDE.md](./docs/pdf-extraction/EXTRACTION-GUIDE.md) | Full workflow |
| **Troubleshooting errors** | [docs/pdf-extraction/TROUBLESHOOTING.md](./docs/pdf-extraction/TROUBLESHOOTING.md) | Error codes & solutions |
| **Testing protocol** | [docs/pdf-extraction/TESTING-PROTOCOL.md](./docs/pdf-extraction/TESTING-PROTOCOL.md) | Before extraction |
| **Latest test results** | [docs/pdf-extraction/TEST-RESULTS-2025-10-21.md](./docs/pdf-extraction/TEST-RESULTS-2025-10-21.md) | Performance data |
| **Official best practices** | [docs/pdf-extraction/OFFICIAL-BEST-PRACTICES.md](./docs/pdf-extraction/OFFICIAL-BEST-PRACTICES.md) | MinerU docs (2025) |
| **Configuration fields** | [tools/config/mineru/CONFIG-FIELDS.md](./tools/config/mineru/CONFIG-FIELDS.md) | All config options |
| **MinerU setup** | [tools/guides/06-mineru-pdf-extraction-setup.md](./tools/guides/06-mineru-pdf-extraction-setup.md) | Initial setup |
| **Advanced enhancements** | [tools/guides/07-mineru-advanced-enhancements.md](./tools/guides/07-mineru-advanced-enhancements.md) | ChemLLM, vLLM |

**Critical Principles** (from CLAUDE.md):
- Quality over quantity in extraction testing
- ONE quality extraction > 100 rushed attempts
- Methodically investigate config before extracting
- Understand extraction modes (auto, ocr, txt) first
- Test config changes one at a time with clear hypothesis

**Quick Commands**:
```bash
# Production extraction (GPU-accelerated)
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Test single file
magic-pdf -p literature/pdfs/test.pdf -o /tmp/test-extraction -m auto

# Check CUDA status
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
```

---

### Analysis Pipelines

| Pipeline | Script Location | Environment | Output | Guide |
|----------|----------------|-------------|--------|-------|
| **Ethnobotany (BEI/ICF)** | `analysis/r-scripts/ethnobotany/` | r-gis | BEI indices, maps | [ARCHITECTURE.md](./ARCHITECTURE.md) §4.2 |
| **QSAR Modeling** | `analysis/python/cheminformatics/` | kanna | Models, fingerprints | [tools/guides/04-qsar-pipeline-setup.md](./tools/guides/04-qsar-pipeline-setup.md) |
| **Clinical Meta-Analysis** | `analysis/r-scripts/meta-analysis/` | r-gis | Forest plots | [ARCHITECTURE.md](./ARCHITECTURE.md) §4.3 |
| **GIS Spatial Analysis** | `analysis/r-scripts/gis/` | r-gis | Distribution maps | [ARCHITECTURE.md](./ARCHITECTURE.md) §4.4 |
| **NLP/Text Mining** | `analysis/python/text-mining/` | kanna | Extraction, classification | [ARCHITECTURE.md](./ARCHITECTURE.md) §4.5 |

**Standard Pipeline Pattern** (from CLAUDE.md):
```
Input:  data/{discipline}/{subdomain}/raw-data.csv
Script: analysis/{language}-scripts/{chapter}/analysis-name.{R|py}
Output: analysis/{language}-scripts/{chapter}/output/{analysis-type}/
Final:  assets/figures/chapter-{XX}/{figure-name}.png (300 DPI)
```

---

### Literature Management

| Task | Document | Tool |
|------|----------|------|
| **Complete workflow** | [tools/guides/01-literature-workflow-setup.md](./tools/guides/01-literature-workflow-setup.md) | Elicit → Zotero → Obsidian |
| **PDF extraction** | [docs/pdf-extraction/EXTRACTION-GUIDE.md](./docs/pdf-extraction/EXTRACTION-GUIDE.md) | MinerU |
| **Bibliography management** | [ARCHITECTURE.md](./ARCHITECTURE.md) §5 | Zotero + Better BibTeX |
| **Citation network analysis** | [CLAUDE.md](./CLAUDE.md) - Section: "Quick Script Reference" | VOSviewer |
| **French grammar checking** | [docs/ACADEMIC-TOOLS-IMPLEMENTATION.md](./docs/ACADEMIC-TOOLS-IMPLEMENTATION.md) | Grammalecte |

**Quick Commands**:
```bash
# Grammar check (French)
bash tools/scripts/check-grammar-french.sh writing/chapter-01.md

# Citation network
bash tools/scripts/analyze-citation-network.sh

# Bibliography sync
bash tools/scripts/sync-zotero-bib.sh
```

---

### Academic Writing

| Task | Document | Tool/Location |
|------|----------|---------------|
| **French academic enhancement** | [.claude/commands/academic-enhance-fr.md](./.claude/commands/academic-enhance-fr.md) | `/academic-enhance-fr [doc]` |
| **Academic tools setup** | [docs/ACADEMIC-TOOLS-IMPLEMENTATION.md](./docs/ACADEMIC-TOOLS-IMPLEMENTATION.md) | Tier 1-2 tools |
| **Grammar checking** | [docs/ACADEMIC-TOOLS-IMPLEMENTATION.md](./docs/ACADEMIC-TOOLS-IMPLEMENTATION.md) §2.1 | Grammalecte |
| **Writing setup (French)** | [tools/guides/05-french-writing-setup.md](./tools/guides/05-french-writing-setup.md) | Full guide |
| **Quality standards** | [ARCHITECTURE.md](./ARCHITECTURE.md) §7 | Publication requirements |

**4-Dimension Enhancement** (`/academic-enhance-fr`):
1. Academic tone (impersonal voice, formal register)
2. Analytical depth (argumentation, critical analysis)
3. Structure (logical progression, transitions)
4. Bibliography (citations, footnotes, French conventions)

---

### Data Privacy & FPIC Compliance

| Topic | Primary Document | Section |
|-------|------------------|---------|
| **Three-tier classification** | [ARCHITECTURE.md](./ARCHITECTURE.md) | §2.1 |
| **FPIC principles** | [CLAUDE.md](./CLAUDE.md) | "Operational Guardrails" |
| **Backup strategy (3-2-1)** | [ARCHITECTURE.md](./ARCHITECTURE.md) | §2.2 |
| **File naming conventions** | [CLAUDE.md](./CLAUDE.md) | "Data Privacy (FPIC Compliance)" |
| **Protected data** | [CLAUDE.md](./CLAUDE.md) | "Operational Guardrails" |

**Three-Tier Classification**:
- 🔴 **Tier 1**: Git-excluded (SENSITIVE) - fieldwork/interviews-raw/**, patient data, credentials
- 🟡 **Tier 2**: Git LFS (LARGE) - LC-MS data (>100MB), genomic data, high-res images
- 🟢 **Tier 3**: Git-tracked (REPRODUCIBLE) - de-identified data, scripts, figures, LaTeX

**Protected Data** (⛔ NEVER commit):
- `fieldwork/interviews-raw/**`
- `data/ethnobotanical/interviews/*.wav`
- `data/clinical/trials/**/patient-data/**`
- `*.env`, `credentials.json`

---

### MCP Server Management

| Task | Document | Key Information |
|------|----------|-----------------|
| **Full audit** | [docs/MCP-CONFIGURATION-AUDIT.md](./docs/MCP-CONFIGURATION-AUDIT.md) | 13,000+ words |
| **Configuration** | [docs/MCP-CONFIGURATION.md](./docs/MCP-CONFIGURATION.md) | Active config |
| **Changelog** | [docs/MCP-CONFIGURATION-CHANGELOG.md](./docs/MCP-CONFIGURATION-CHANGELOG.md) | Version history |
| **Server status check** | [CLAUDE.md](./CLAUDE.md) | `/mcp` command |

**Server Tiers**:
- **Tier 1 - CRITICAL**: serena, filesystem, git (cannot work without)
- **Tier 2 - HIGH VALUE**: sequential, context7, memory, github, sqlite
- **Tier 3 - SPECIALIZED**: jupyter, playwright, rag-query, fetch, cloudflare

**Degradation Modes**:
- Tier 1 missing → Alert user, halt operations
- Tier 2/3 missing → Note limitations, proceed with fallbacks

---

### Scripts & Tools

| Script | Purpose | Environment | Guide |
|--------|---------|-------------|-------|
| **PDF extraction** | GPU-accelerated MinerU | mineru | [tools/guides/06-mineru-pdf-extraction-setup.md](./tools/guides/06-mineru-pdf-extraction-setup.md) |
| **Grammar check** | French Grammalecte | any | [docs/ACADEMIC-TOOLS-IMPLEMENTATION.md](./docs/ACADEMIC-TOOLS-IMPLEMENTATION.md) |
| **Citation network** | VOSviewer analysis | any | [CLAUDE.md](./CLAUDE.md) - Quick Script Reference |
| **Backup** | 3-2-1 backup | any | [ARCHITECTURE.md](./ARCHITECTURE.md) §2.2 |
| **ChEMBL query** | SERT, PDE4 targets | kanna | [ARCHITECTURE.md](./ARCHITECTURE.md) §6.5 |
| **COCONUT query** | Natural products | kanna | [ARCHITECTURE.md](./ARCHITECTURE.md) §6.5 |
| **Bibliography sync** | Zotero validation | any | [tools/guides/01-literature-workflow-setup.md](./tools/guides/01-literature-workflow-setup.md) |
| **LaTeX compile** | Full thesis PDF | any | [ARCHITECTURE.md](./ARCHITECTURE.md) §8.2 |

**Full API Reference**: [docs/SCRIPTS-API-REFERENCE.md](./docs/SCRIPTS-API-REFERENCE.md)

---

### Troubleshooting

| Issue Category | Document | Section |
|----------------|----------|---------|
| **RDKit import fails** | [CLAUDE.md](./CLAUDE.md) | "Troubleshooting" |
| **R package errors (brms/rstan)** | [CLAUDE.md](./CLAUDE.md) | "Troubleshooting" |
| **PDF extraction failures** | [docs/pdf-extraction/TROUBLESHOOTING.md](./docs/pdf-extraction/TROUBLESHOOTING.md) | Full guide |
| **CUDA initialization persistent failure** | [docs/infrastructure/CUDA-FIX-STATUS.md](./docs/infrastructure/CUDA-FIX-STATUS.md) | Critical blocker |
| **Backup not running** | [CLAUDE.md](./CLAUDE.md) | "Troubleshooting" |
| **MCP server failures** | [docs/MCP-CONFIGURATION-AUDIT.md](./docs/MCP-CONFIGURATION-AUDIT.md) | "Common failures" |

**Known Issues (Active)**:
- ⚠️ **CUDA Initialization** (2025-10-10): PyTorch CUDA fails, MinerU in CPU mode (10× slower)
  - **Workaround**: Ollama qwen2-math:7b for formula extraction
  - **Recommended fix**: System reboot to re-initialize NVIDIA driver
  - **Status**: ChemLLM-7B-Chat ready but blocked by CUDA

---

### Plugin Integration (Planned)

| Phase | Document | Timeline | ROI |
|-------|----------|----------|-----|
| **Full plan** | [docs/PLUGIN-INTEGRATION-PLAN.md](./docs/PLUGIN-INTEGRATION-PLAN.md) | 3 weeks | 85× (1,968h saved) |
| **Setup summary** | [docs/PLUGIN-INTEGRATION-SUMMARY.md](./docs/PLUGIN-INTEGRATION-SUMMARY.md) | Quick overview | - |
| **Validation log** | [docs/PLUGIN-VALIDATION-LOG.md](./docs/PLUGIN-VALIDATION-LOG.md) | Testing results | - |
| **Academic plugins** | [docs/ACADEMIC-PLUGINS-SETUP.md](./docs/ACADEMIC-PLUGINS-SETUP.md) | Custom plugins | - |

**Phase Overview**:
- **Week 1**: lyra + update-claude-md (experimental worktree)
- **Week 2**: security-auditor + code-reviewer (dev worktree)
- **Week 3**: ai-engineer + documentation-generator (main worktree)

**Security Framework**: FPIC-first, `security-gate.sh` runs before all plugin hooks

---

### Project Status & Planning

| Document | Purpose | Update Frequency |
|----------|---------|------------------|
| [PROJECT-STATUS.md](./PROJECT-STATUS.md) | Current progress tracker | Weekly (Mondays) |
| [README.md](./README.md) | Project overview | Quarterly |
| [ARCHITECTURE.md](./ARCHITECTURE.md) | Architectural reference | As needed |
| [CLAUDE.md](./CLAUDE.md) | Claude Code instructions | Monthly |
| [docs/CLEANUP-ROADMAP-2025-10.md](./docs/CLEANUP-ROADMAP-2025-10.md) | Cleanup & optimization plan | Weekly |

**Weekly Progress Update** (Every Monday):
1. Update PROJECT-STATUS.md metrics
2. Check backup status (`tail -20 ~/LAB/logs/kanna-backup.log`)
3. Verify MCP servers (`/mcp` - should show 13/13)
4. Test environment health (see [CLAUDE.md](./CLAUDE.md) - "Weekly Progress Update")

---

## Documentation Tiers

### Tier 1: Essential (Read First)

**Must-read** for all KANNA work:

1. **[CLAUDE.md](./CLAUDE.md)** (12,000 words) - Claude Code quick start, session initialization, environments, workflows
2. **[ARCHITECTURE.md](./ARCHITECTURE.md)** (39 KB) - Definitive architectural reference, data architecture, pipelines
3. **[PROJECT-STATUS.md](./PROJECT-STATUS.md)** - Current progress, chapter status, infrastructure health

**Time Investment**: 45-60 minutes
**ROI**: 10× (prevents common mistakes, accelerates onboarding)

### Tier 2: Task-Specific

**Read when starting specific tasks**:

- **PDF Extraction**: [docs/pdf-extraction/EXTRACTION-GUIDE.md](./docs/pdf-extraction/EXTRACTION-GUIDE.md)
- **Analysis Setup**: [tools/guides/04-qsar-pipeline-setup.md](./tools/guides/04-qsar-pipeline-setup.md) (or relevant guide)
- **Academic Writing**: [docs/ACADEMIC-TOOLS-IMPLEMENTATION.md](./docs/ACADEMIC-TOOLS-IMPLEMENTATION.md)
- **MCP Troubleshooting**: [docs/MCP-CONFIGURATION-AUDIT.md](./docs/MCP-CONFIGURATION-AUDIT.md)

**Time Investment**: 15-30 minutes per document
**ROI**: 5-8× (prevents task-specific errors)

### Tier 3: Reference

**Consult when debugging or exploring**:

- **Scripts API**: [docs/SCRIPTS-API-REFERENCE.md](./docs/SCRIPTS-API-REFERENCE.md)
- **MinerU Config**: [tools/config/mineru/CONFIG-FIELDS.md](./tools/config/mineru/CONFIG-FIELDS.md)
- **Session Handoffs**: [docs/sessions/](./docs/sessions/)
- **Infrastructure Guides**: [docs/infrastructure/](./docs/infrastructure/)

**Time Investment**: 5-10 minutes per lookup
**ROI**: 3-5× (faster debugging, fewer support requests)

---

## Quick Decision Trees

### "I need to work on..."

#### PDF Extraction
```
Start here:
├─ First time? → Read docs/pdf-extraction/EXTRACTION-GUIDE.md
├─ Error occurred? → docs/pdf-extraction/TROUBLESHOOTING.md
├─ Testing new config? → docs/pdf-extraction/TESTING-PROTOCOL.md
├─ Understanding config? → tools/config/mineru/CONFIG-FIELDS.md
└─ Performance issues? → docs/infrastructure/CUDA-FIX-STATUS.md
```

#### Analysis (QSAR, Ethnobotany, Clinical)
```
Start here:
├─ QSAR modeling? → tools/guides/04-qsar-pipeline-setup.md + conda activate kanna
├─ Ethnobotany (BEI/ICF)? → ARCHITECTURE.md §4.2 + conda activate r-gis
├─ Clinical meta-analysis? → ARCHITECTURE.md §4.3 + conda activate r-gis
├─ GIS spatial analysis? → ARCHITECTURE.md §4.4 + conda activate r-gis
└─ NLP/text mining? → ARCHITECTURE.md §4.5 + conda activate kanna
```

#### Writing (French Academic)
```
Start here:
├─ Enhancement request? → /academic-enhance-fr [document-name]
├─ Grammar checking? → bash tools/scripts/check-grammar-french.sh [file]
├─ Setup tools? → docs/ACADEMIC-TOOLS-IMPLEMENTATION.md
└─ French conventions? → tools/guides/05-french-writing-setup.md
```

#### Environment Issues
```
What's broken?
├─ RDKit import fails? → CLAUDE.md "Troubleshooting" (conda install rdkit)
├─ R package errors? → CLAUDE.md "Troubleshooting" (use brms not rstan)
├─ CUDA not working? → docs/infrastructure/CUDA-FIX-STATUS.md
├─ MCP servers down? → /mcp + docs/MCP-CONFIGURATION-AUDIT.md
└─ Wrong conda env? → conda info --envs + CLAUDE.md "Three-Environment Strategy"
```

#### Literature Management
```
What do you need?
├─ Full workflow? → tools/guides/01-literature-workflow-setup.md
├─ Extract PDFs? → docs/pdf-extraction/EXTRACTION-GUIDE.md
├─ Bibliography sync? → bash tools/scripts/sync-zotero-bib.sh
├─ Citation network? → bash tools/scripts/analyze-citation-network.sh
└─ Zotero setup? → tools/guides/01-literature-workflow-setup.md §2
```

---

## File Organization

### Root Directory Structure

```
KANNA/
├── 📄 CLAUDE.md                      # Claude Code instructions (12K words)
├── 📄 ARCHITECTURE.md                # Architectural reference (39 KB)
├── 📄 PROJECT-STATUS.md              # Progress tracker (update weekly)
├── 📄 README.md                      # Project overview
├── 📄 DOCUMENTATION-INDEX.md         # This file
│
├── 📁 docs/                          # All documentation
│   ├── 📁 pdf-extraction/           # PDF extraction guides (6 files)
│   ├── 📁 infrastructure/           # Environment & CUDA (4 files)
│   ├── 📁 mineru/                   # MinerU-specific (6 files)
│   ├── 📁 sessions/                 # Session handoffs (1 file)
│   ├── 📁 archives/                 # Deprecated docs (15 files)
│   ├── 📄 MCP-CONFIGURATION-AUDIT.md
│   ├── 📄 ACADEMIC-TOOLS-IMPLEMENTATION.md
│   ├── 📄 PLUGIN-INTEGRATION-PLAN.md
│   └── ... (12 more files)
│
├── 📁 tools/
│   ├── 📁 guides/                   # Setup guides (8 files)
│   │   ├── 01-literature-workflow-setup.md
│   │   ├── 04-qsar-pipeline-setup.md
│   │   ├── 06-mineru-pdf-extraction-setup.md
│   │   └── ...
│   ├── 📁 scripts/                  # Bash/Python scripts
│   └── 📁 config/mineru/            # MinerU configurations
│
├── 📁 .serena/memories/             # Serena MCP memories (8 files)
│   ├── kanna-conda-environments.md
│   ├── research-automation-strategy.md
│   └── ...
│
└── 📁 .claude/commands/             # Custom Claude Code commands
    └── academic-enhance-fr.md
```

### Documentation Categories

| Category | Location | Count | Purpose |
|----------|----------|-------|---------|
| **Core** | Root (5 .md files) | 5 | CLAUDE.md, ARCHITECTURE.md, etc. |
| **PDF Extraction** | docs/pdf-extraction/ | 6 | MinerU guides, troubleshooting |
| **Infrastructure** | docs/infrastructure/ | 4 | Environments, CUDA, R setup |
| **MinerU** | docs/mineru/ | 6 | Configuration, quality reports |
| **Guides** | tools/guides/ | 8 | Task-specific setup guides |
| **Sessions** | docs/sessions/ | 1 | Session handoffs |
| **Archives** | docs/archives/ | 15 | Deprecated/historical docs |
| **MCP** | docs/ (root) | 3 | MCP configuration & audit |
| **Academic Tools** | docs/ (root) | 2 | Academic writing & plugins |
| **Project Management** | docs/ (root) | 4 | Cleanup, audits, summaries |

**Total**: 54 documentation files (excluding archives)

---

## Documentation Maintenance

### Update Frequency

| Document Type | Frequency | Trigger |
|---------------|-----------|---------|
| **PROJECT-STATUS.md** | Weekly | Every Monday |
| **CLAUDE.md** | Monthly | Environment changes, new workflows |
| **ARCHITECTURE.md** | As needed | Major architectural changes |
| **Guides (tools/guides/)** | Quarterly | Tool version updates |
| **MCP Config** | As needed | MCP server changes |
| **Cleanup Roadmap** | Weekly | Progress updates |

### Quality Checklist

**Before updating documentation**:
- [ ] Read existing content first
- [ ] Verify all cross-references are valid
- [ ] Update "Last Updated" date
- [ ] Test all commands/scripts mentioned
- [ ] Check for outdated version numbers
- [ ] Validate file paths
- [ ] Update DOCUMENTATION-INDEX.md if structure changed

### Cross-Reference Validation

**Run this check monthly**:
```bash
# Find all markdown links
find /home/miko/LAB/academic/KANNA -name "*.md" -exec grep -H "\[.*\](\..*\.md)" {} \;

# Check for broken links (manual verification)
```

**Common cross-reference patterns**:
- `[CLAUDE.md](./CLAUDE.md)` - Root-level docs
- `[docs/pdf-extraction/EXTRACTION-GUIDE.md](./docs/pdf-extraction/EXTRACTION-GUIDE.md)` - Subdirectory docs
- `[ARCHITECTURE.md §4.2](#4-analysis-pipelines)` - Same-document sections

### Documentation Debt

**Track documentation debt** in [docs/CLEANUP-ROADMAP-2025-10.md](./docs/CLEANUP-ROADMAP-2025-10.md):

| Debt Type | Example | Priority | Remediation |
|-----------|---------|----------|-------------|
| **Outdated** | MinerU version numbers | Medium | Quarterly review |
| **Missing** | Advanced QSAR workflows | Low | As needed |
| **Redundant** | Multiple extraction guides | High | Consolidate |
| **Broken Links** | Old file paths | High | Monthly check |

**Current Status** (2025-10-21):
- ✅ MP-1 Phase 2 Complete (38% overall cleanup roadmap)
- 🔄 MP-2 in progress (documentation consolidation)
- 📋 MP-3 planned (workflow automation)

---

## See Also

- **[Knowledge Base](./docs/KNOWLEDGE-BASE.md)** - Comprehensive project knowledge base
- **[Cleanup Roadmap](./docs/CLEANUP-ROADMAP-2025-10.md)** - Ongoing optimization plan
- **[Cleanup Summary (2025-10-21)](./docs/CLEANUP-SUMMARY-2025-10-21.md)** - Latest cleanup report
- **[MCP Configuration Audit](./docs/MCP-CONFIGURATION-AUDIT.md)** - Full MCP server documentation (13K words)
- **[Plugin Integration Plan](./docs/PLUGIN-INTEGRATION-PLAN.md)** - 3-week plugin roadmap (63 pages)

---

**Navigation Tips**:

1. **Start with tiers**: Tier 1 (essential) → Tier 2 (task-specific) → Tier 3 (reference)
2. **Use decision trees**: "I need to work on..." → specific document path
3. **Check update frequency**: Know which docs to re-read vs one-time read
4. **Validate cross-references**: Links work when docs move
5. **Track documentation debt**: Use cleanup roadmap for missing/outdated docs

**Feedback**: Documentation issues? Update [docs/CLEANUP-ROADMAP-2025-10.md](./docs/CLEANUP-ROADMAP-2025-10.md) §Documentation Debt

---

**Last Updated**: October 21, 2025
**Maintained By**: KANNA Project Infrastructure Team
**Version**: 2.0 (comprehensive reorganization)
