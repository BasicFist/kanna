# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

42-month interdisciplinary PhD thesis on *Sceletium tortuosum* (Kanna) spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical analysis. Repository contains research data, analysis scripts, writing, and comprehensive tool integration.

**Key Metrics**: 120,000-word thesis, 8 chapters, 15-20 publications, 142 papers corpus (974K words), 98/100 infrastructure health.

## Session Initialization

**Every session - 6-step boot sequence**:

1. **Activate** - `mcp__serena__activate_project("KANNA")` (enable workspace)
2. **Context** - Read `PROJECT-STATUS.md` (first 50 lines, understand phase)
3. **Discover** - `mcp__serena__list_memories()` (find available memories)
4. **Load** - Read relevant memories by task type (see Memory Management)
5. **Git** - `git status --porcelain` + `git log --oneline -5` (working state)
6. **Environment** - `conda info --envs` (verify active conda env)

**Success**: Serena shows "Active project: KANNA", ≥1 memory loaded, correct env active

## Three-Environment Strategy

**Critical**: Use separate conda environments to avoid dependency conflicts.

| Environment | When to Use | Activate | Health Check | Key Packages |
|-------------|-------------|----------|--------------|--------------|
| **mineru** | PDF extraction (GPU-accelerated) | `conda activate mineru` | `python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"`<br>`python -c "from magic_pdf.pipe.UNIPipe import UNIPipe; print('✓ MinerU')"` | PyTorch 2.4.0+cu124<br>MinerU 1.3.12<br>transformers 4.49.0<br>DocLayout-YOLO, Unimernet |
| **kanna** | Chemistry, ML, QSAR, NLP | `conda activate kanna` | `python -c "from rdkit import Chem; print('✓ RDKit')"`<br>`python -c "import pandas, numpy, sklearn; print('✓ Core')"` | RDKit (cheminformatics)<br>scikit-learn (ML)<br>spaCy (NLP)<br>150+ packages |
| **r-gis** | Statistics, GIS, Bayesian, Meta-analysis | `conda activate r-gis` | `Rscript -e "library(sf); library(brms); library(metafor); cat('✓ R\n')"` | sf (GIS)<br>brms (Bayesian)<br>metafor (meta)<br>tidyverse, ethnobotanyR |

**Why separate**:
- **mineru isolation**: MinerU needs transformers 4.49.0 (incompatible with 4.57.0), clean PyTorch+CUDA resolved Error 999
- **kanna isolation**: Python ML tools conflict with R spatial libraries (GDAL, PROJ)
- **GPU acceleration**: Fresh mineru environment enables 10× faster extraction

**Known workaround**: R rstan has TBB symbol errors → Use `library(brms)` instead of `library(rstan)` (brms delays linkage)

**Selection logic**:
```
Task Type → Environment
├─ PDF Extraction? → mineru
├─ Chemical Structure Analysis? → kanna (RDKit)
├─ Machine Learning (QSAR, NLP)? → kanna (scikit-learn, spaCy)
├─ GIS / Spatial Analysis? → r-gis (sf, GEOS, GDAL)
├─ Bayesian Statistics? → r-gis (brms)
├─ Meta-Analysis? → r-gis (metafor)
└─ General R Statistics? → r-gis (tidyverse)
```

## Memory Management

### Classification System

| Type | Purpose | Lifespan | When to Read | Examples |
|------|---------|----------|--------------|----------|
| **Strategic** | Long-term plans | 3-6 months | Starting new features | research-automation-strategy |
| **Reference** | Architecture & config | Permanent | Debugging, setup questions | kanna-conda-environments |
| **Historical** | Session records, installations | 3-6 months | Troubleshooting recurring issues | session-2025-10-18-dependency-installation |
| **Configuration** | Tool setup procedures | Until tools change | First-time tool usage | academic-tools-setup |

### Lifecycle Rules

**CREATE** when: Multi-hour setup (>2h) | Strategic plan (affects multiple chapters) | Complex problem (future reference value)

**UPDATE** when: Configuration changes significantly | Strategic plan evolves | New insights discovered

**DELETE** when: Information obsolete (>6mo for Historical) | Converted to permanent docs | Superseded by newer memory

**Naming Convention**:
- Strategic: `{project-area}-strategy` (e.g., research-automation-strategy)
- Reference: `{system-name}-{aspect}` (e.g., kanna-conda-environments)
- Historical: `session-{YYYY-MM-DD}-{topic}` (e.g., session-2025-10-18-dependency-installation)
- Configuration: `{tool}-setup` (e.g., academic-tools-setup)

## Analysis Pipelines

### Standard Pattern
```
Input:  data/{discipline}/{subdomain}/raw-data.csv
Script: analysis/{language}-scripts/{chapter}/analysis-name.{R|py}
Output: analysis/{language}-scripts/{chapter}/output/{analysis-type}/
Final:  assets/figures/chapter-{XX}/{figure-name}.png (300 DPI)
```

### Pipeline Overview

| Pipeline | Input | Scripts (Environment) | Output |
|----------|-------|----------------------|--------|
| **Literature → QSAR** | `literature/pdfs/BIBLIOGRAPHIE/` | `extract-pdfs-mineru-production.sh` (mineru)<br>→ `qsar-modeling.py` (kanna)<br>→ `model-performance.R` (r-gis) | Markdown + structures<br>QSAR models + fingerprints<br>300 DPI figures |
| **Ethnobotany** | `data/ethnobotanical/surveys/` | `calculate-bei.R` (r-gis)<br>→ `spatial-distribution.R` (r-gis)<br>→ `hypothesis-testing.R` (r-gis) | BEI indices<br>Distribution maps<br>Publication results |
| **Clinical Meta** | `data/clinical/trials/` | `meta-analysis.R` (r-gis)<br>→ `trial-classification.py` (kanna) | Forest plots<br>Automated classification |

**Full details**: See ARCHITECTURE.md (39KB, definitive reference)

## Core Workflows

### Daily Operations
```bash
# Status check
git status
cat PROJECT-STATUS.md | head -50
tail -20 ~/LAB/logs/kanna-backup.log

# PDF extraction (GPU-accelerated MinerU)
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Ethnobotany analysis (Chapter 3)
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# QSAR modeling (Chapter 4)
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py

# Manual backup
bash tools/scripts/daily-backup.sh

# MCP verification
/mcp  # Should show 13/13 connected
```

### Weekly Progress Update (Every Monday)
```bash
# 1. Update metrics
cat PROJECT-STATUS.md | head -100
echo "Papers: $(ls -1 literature/pdfs/BIBLIOGRAPHIE/*.pdf 2>/dev/null | wc -l)"
echo "Words: $(find writing/thesis-chapters -name "*.tex" -exec wc -w {} + 2>/dev/null | tail -1 | awk '{print $1}')"
echo "Figures: $(find assets/figures -name "*.png" 2>/dev/null | wc -l)"
echo "Commits: $(git rev-list --count HEAD)"

# 2. Backup status
tail -20 ~/LAB/logs/kanna-backup.log

# 3. MCP servers
/mcp  # Should show 13/13

# 4. Environment health (uses environment matrix above for commands)
conda activate mineru && python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
conda activate kanna && python -c "from rdkit import Chem; print('✓ RDKit')"
conda activate r-gis && Rscript -e "library(brms); library(sf); cat('✓ R\n')"
```

### Custom Commands

**`/academic-enhance-fr [document-name]`** - French academic writing enhancement

Features:
- 4-dimension analysis (tone, depth, structure, bibliography)
- French academic conventions (impersonal voice, footnotes)
- Integration with Perplexity (academic mode) and Memory MCP
- Automatic document location (pdfs/, writing/, extractions-mineru/)

See `.claude/commands/academic-enhance-fr.md` for detailed documentation.

### Quick Script Reference

| Script | Purpose | Environment | Command |
|--------|---------|-------------|---------|
| **PDF extraction** | GPU-accelerated MinerU (100% success) | mineru | `bash tools/scripts/extract-pdfs-mineru-production.sh <input> <output>` |
| **Grammar check** | French Grammalecte batch | any | `bash tools/scripts/check-grammar-french.sh writing/chapter-01.md` |
| **Citation network** | VOSviewer analysis | any | `bash tools/scripts/analyze-citation-network.sh` |
| **Backup** | Manual 3-2-1 backup | any | `bash tools/scripts/daily-backup.sh` |
| **ChEMBL query** | SERT, PDE4 target search | kanna | `python tools/scripts/chembl-target-search.py` |
| **COCONUT query** | Natural products | kanna | `python tools/scripts/coconut-query.py` |
| **Bibliography sync** | Zotero validation | any | `bash tools/scripts/sync-zotero-bib.sh` |
| **LaTeX compile** | Full thesis PDF | any | `bash tools/scripts/compile-thesis-pdf.sh` |

## Data Privacy (FPIC Compliance)

### Three-Tier Classification

**🔴 Tier 1: Git-Excluded (SENSITIVE - NEVER commit)**:
```
fieldwork/interviews-raw/**              # Raw audio/transcripts
data/ethnobotanical/interviews/*.wav     # Recordings
data/clinical/trials/**/patient-data/**  # Identifiable data
*.env, credentials.json                  # Secrets
```

**🟡 Tier 2: Git LFS (LARGE)**:
```
*.raw, *.wiff, *.d/  # LC-MS data (>100MB)
*.tif                 # High-res images
*.fastq, *.bam        # Genomic data
```

**🟢 Tier 3: Git-Tracked (REPRODUCIBLE)**:
```
data/ethnobotanical/surveys/*.csv  # De-identified data
analysis/**/*.{R|py}               # Scripts
assets/figures/**/*.png            # Figures (300 DPI)
writing/thesis-chapters/**/*.tex   # LaTeX
```

### Backup Strategy (3-2-1 Rule)

| Copy | Location | Media | Frequency | Encryption | Status |
|------|----------|-------|-----------|------------|--------|
| **Working** | `~/LAB/academic/KANNA/` | SSD | Real-time | None | ✅ Active |
| **Local** | `/run/media/miko/AYA/KANNA-backup/` | External HDD (1.4TB) | Daily 2 AM | Optional | ✅ Automated |
| **Cloud** | Tresorit/SpiderOak | Cloud | Daily 2 AM | AES-256 | 📋 Ready |

**Automation**: `0 2 * * * /home/miko/LAB/academic/KANNA/tools/scripts/daily-backup.sh >> ~/LAB/logs/kanna-backup.log 2>&1`

### File Naming (FPIC-compliant)

```bash
# Ethnobotanical (de-identified from day 1)
INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.txt
# Example: INT-20250315-SC01-P007.txt

# Chemical data
CHEM-{YYYYMMDD}-{BatchID}-{CompoundID}.csv

# GIS field data
FIELD-{YYYYMMDD}-{SiteCode}-{GPSID}.{shp|csv}

# Clinical trials
TRIAL-{YYYYMMDD}-{StudyID}-{ArmID}.csv
```

## Academic Enhancement Stack

**Status**: ✅ Documentation created (2025-10-10)
**Implementation Guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md` (20,000 words)
**Setup Time**: 9.5-12 hours (Tier 1: 2.5-3h, Tier 2: 7-9h)
**ROI**: 5.3-7.9× (63-75 hours saved over 120,000-word thesis)

### Tier 1: Critical Gaps

**Grammalecte** - French grammar checking:
```bash
# Real-time in VS Code (configured in .vscode/settings.json)
# Batch checking via CLI
./tools/scripts/check-grammar-french.sh writing/chapter-01.md
# Features: 200+ custom ethnopharmacology terms, JSON reports
```

**VOSviewer** - Citation network visualization:
```bash
# Interactive analysis
./tools/scripts/analyze-citation-network.sh
# Co-citation, bibliographic coupling, keyword co-occurrence, 300 DPI outputs
```

### Tier 2: Activate Existing Plans

**Zotero + Better BibTeX** - Bibliography management:
- Workflow: Elicit → Zotero (Better BibTeX) → Obsidian → Overleaf
- Auto-export: `literature/zotero-export/kanna.bib` (real-time sync)
- Guide: `tools/guides/01-literature-workflow-setup.md`

**Obsidian** - Personal knowledge graph:
- Vault: `writing/obsidian-notes/`
- Zotero Integration plugin for literature notes
- Graph view + bidirectional [[wiki-links]]

**Full details**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md` for complete setup instructions

## MCP Server Integration

**Status**: 13 servers configured (98/100 health, Production Ready)
**Check**: `/mcp` (should show 13/13 connected)
**Documentation**: `docs/MCP-CONFIGURATION-AUDIT.md` (13,000+ words)

### Server Tiers

**Tier 1 - CRITICAL** (cannot work without):
- **serena**: Project activation, memory management, symbol operations
- **filesystem**: File read/write/edit operations
- **git**: Version control, commits, status checks

**Tier 2 - HIGH VALUE** (reduced capability):
- **sequential**: Complex reasoning (fallback: native reasoning, lower quality)
- **context7**: Library docs (fallback: web search, less reliable)
- **memory**: Cross-session persistence (fallback: session-only context)
- **github**: GitHub API (fallback: manual gh CLI commands)
- **sqlite**: Database queries (fallback: pandas CSV operations)

**Tier 3 - SPECIALIZED** (task-specific):
- **jupyter**: Notebook integration (fallback: .py scripts)
- **playwright**: Browser testing (fallback: unit tests only)
- **rag-query**: 142-paper corpus search (fallback: grep on extractions)
- **fetch**: HTTP operations (fallback: Bash curl)
- **cloudflare-browser**, **cloudflare-container**: Web scraping/sandbox

**Degradation modes**: Tier 1 missing → Alert user | Tier 2/3 missing → Note limitations, proceed with fallbacks

**Common failures**: Serena disconnected → Restart session | filesystem disconnected → Check .mcp.json | Multiple down → System restart

## Plugin Integration (Planned - Week 1-3)

**Status**: 📋 Planning Complete
**Documentation**: `docs/PLUGIN-INTEGRATION-PLAN.md` (63 pages)
**Timeline**: 3 weeks (5 + 7 + 8 hours)
**Expected ROI**: 85× (1,968 hours saved over 41 months)

### Phase Overview

**Phase 1 (Week 1)**: Experimental worktree - lyra + update-claude-md validation
**Phase 2 (Week 2)**: Dev worktree - security-auditor + code-reviewer
**Phase 3 (Week 3)**: Main worktree - ai-engineer + documentation-generator

### Security Framework (FPIC-First)

**Hook execution order**: `security-gate.sh` (KANNA) **RUNS FIRST** → Plugin hooks (cannot bypass) → Tool execution

**Protected data**: ⛔ `fieldwork/interviews-raw/`, `data/clinical/trials/**/patient-data/`, `.env` files

**Validation tests** (every plugin):
1. Attempt read `~/.config/codex/secrets.env` → MUST BE BLOCKED
2. Attempt read `fieldwork/interviews-raw/INT-*.txt` → MUST BE BLOCKED
3. Audit logs for sensitive data exposure → MUST BE CLEAN

**Success criteria**: Zero security incidents, ROI breakeven <2 weeks, startup <15s, >10h/week saved

## Quality Standards

### Publication-Ready Figures

```r
# R (ggplot2)
library(ggplot2)
library(viridis)
ggsave("assets/figures/chapter-03/figure.png",
       width=8, height=6, dpi=300)  # 300 DPI required
```

```python
# Python (matplotlib)
import matplotlib.pyplot as plt
plt.savefig("assets/figures/chapter-04/figure.png",
            dpi=300, bbox_inches='tight')  # 300 DPI required
```

**Requirements**: 300 DPI minimum, colorblind-friendly palettes (viridis, RColorBrewer), ≥10pt fonts at print size

### Git Commit Convention

```bash
feat:     # New analysis, script, feature
fix:      # Bug fix
docs:     # Documentation or writing
refactor: # Code restructuring
data:     # New de-identified data

# Examples
git commit -m "feat: add SHAP interpretation to QSAR model (Chapter 4)"
git commit -m "fix: correct ICF calculation for zero use reports"
git commit -m "docs: draft Chapter 3 Section 3.4 (1200 words)"
```

## Troubleshooting

### RDKit Import Fails

**Cause**: RDKit cannot be installed via pip reliably.

**Solution**:
```bash
conda activate kanna
conda install -c conda-forge rdkit
# Test: python -c "from rdkit import Chem; print('✓ OK')"
```

### R Package Errors (brms, rstan)

**Known issue**: rstan has TBB symbol errors.

**Solution**: Use brms wrapper instead of direct rstan:
```r
library(brms)  # NOT library(rstan)
# brms delays TBB linkage and provides better syntax
```

### PDF Extraction Failures

**First check**: Is mineru environment active and GPU working?
```bash
conda activate mineru
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
magic-pdf -p literature/pdfs/test.pdf -o /tmp/test-extraction -m auto
```

**If CUDA unavailable**: Check NVIDIA driver (needs 550+) and PyTorch CUDA build
```bash
nvidia-smi  # Should show driver 580.82.09+
python -c "import torch; print(torch.version.cuda)"  # Should show 12.4
```

### CUDA Initialization Persistent Failure (2025-10-10)

**Status**: ⚠️ **CRITICAL BLOCKER** - PyTorch CUDA initialization fails, blocking MinerU GPU mode and vLLM

**Impact**:
- ❌ MinerU forced to CPU mode (10× slower extraction)
- ❌ vLLM cannot start (ChemLLM-7B-Chat blocked)
- ⚠️ Ollama qwen2-math:7b workaround (configured in magic-pdf.json)

**Root cause**: System-level CUDA/driver state corruption (multiple PyTorch versions tested: 2.8.0, 2.5.1, 2.4.1)

**Workaround (current)**:
```bash
# Ollama serving qwen2-math:7b for formula extraction
# Configured in magic-pdf.json lines 51-71
# Works but not chemistry-specialized
```

**Recommended fix**: System reboot to re-initialize NVIDIA driver state
```bash
# After reboot, verify CUDA restored:
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
# Should print: CUDA: True

# Then switch back to GPU mode:
# Edit /home/miko/magic-pdf.json line 15: "device-mode": "cuda"
```

**ChemLLM-7B-Chat Integration (Ready - Blocked by CUDA)**:
- Model: `/run/media/miko/AYA/crush-models/hf-home/models--AI4Chem--ChemLLM-7B-Chat/.../b8b2ea19...`
- vLLM 0.11.0 installed in mineru environment
- Post-fix command: `vllm serve <model-path> --host localhost --port 8000 --dtype auto --max-model-len 4096 --trust-remote-code &`
- Expected performance: GPU 10× faster, ChemLLM 85-90% accuracy on chemistry (vs 60-70% generic), full 142-paper corpus ~7h (GPU) vs ~70h (CPU)

### Backup Not Running

**Check logs**:
```bash
tail -50 ~/LAB/logs/kanna-backup.log
crontab -l | grep daily-backup
bash tools/scripts/daily-backup.sh  # Manual test
```

## Operational Guardrails

### FPIC Principles (ALWAYS follow)

1. **Data Sovereignty**: Khoisan communities retain IP rights to traditional knowledge
2. **Anonymization**: All interviews de-identified before analysis
3. **Benefit-Sharing**: Research outputs shared with communities before publication
4. **No Commits Without FPIC**: Never commit sensitive data without community validation

**Protected data**:
- ⛔ `fieldwork/interviews-raw/**` (raw participant data)
- ⛔ `data/ethnobotanical/interviews/*.wav` (audio recordings)
- ⛔ `data/clinical/trials/**/patient-data/**` (identifiable data)

**Encryption**: `tools/scripts/encrypt-sensitive-data.sh` (AES-256), `collaboration/ethics-approvals/`, `data/ethnobotanical/fpic-protocols/`

### Development Best Practices

**Before writing code**:
1. Verify correct environment (`conda info --envs`, `pwd`)
2. Check git status (`git status`, `git pull` if collaborating)
3. Verify MCP connectivity (`/mcp`)

**Before running analysis**:
1. Verify input data exists (`ls -lh data/ethnobotanical/surveys/*.csv`)
2. Check output directory permissions (`mkdir -p analysis/r-scripts/ethnobotany/output/bei/`)
3. Test with small sample (`--dry-run` or `--limit 10`)
4. Monitor resource usage (`time`, `htop`, `nvidia-smi`)

**After completing analysis**:
1. Export figures (300 DPI, colorblind-friendly palettes)
2. Document methodology (script comments explaining key decisions)
3. Version control (semantic commits: `git add ... && git commit -m "feat: ..."`)
4. Update PROJECT-STATUS.md (increment progress metrics)

### Design Principles

1. **Pragmatic Over Perfect**: Ship working code now, optimize later
2. **Security by Design**: 3-tier privacy, sensitive data NEVER committed
3. **Reproducibility First**: conda/renv lock files, semantic commits
4. **Automation as Leverage**: 7.5 hours setup → 575 hours saved (77× ROI)
5. **Infrastructure-First PhD**: Quality tooling enables better research

## Documentation Navigation

**Task-based quick reference**:

| Task Category | Primary Document | Section |
|---------------|------------------|---------|
| Session initialization | CLAUDE.md | Session Initialization |
| Environment debugging | CLAUDE.md | Troubleshooting |
| Analysis pipeline setup | ARCHITECTURE.md | Analysis Pipeline Structure |
| MCP server configuration | docs/MCP-CONFIGURATION-AUDIT.md | Server Details |
| Plugin integration | docs/PLUGIN-INTEGRATION-PLAN.md | Full Guide |
| Literature workflow | tools/guides/01-literature-workflow-setup.md | Full Guide |
| QSAR setup | tools/guides/04-qsar-pipeline-setup.md | Full Guide |
| French writing tools | docs/ACADEMIC-TOOLS-IMPLEMENTATION.md | Tier 1-2 Tools |
| Project status check | PROJECT-STATUS.md | Metrics (first 100 lines) |

**Essential reading** (in order):
1. **CLAUDE.md** (this file) - Quick start for Claude Code
2. **ARCHITECTURE.md** - Comprehensive architectural reference (39KB)
3. **PROJECT-STATUS.md** - Current progress tracker (update weekly)
4. **README.md** - Project overview, thesis structure

---

**For comprehensive details**: See ARCHITECTURE.md (39KB, definitive reference)

**Last Updated**: October 2025 (Month 1 - Infrastructure Complete)
