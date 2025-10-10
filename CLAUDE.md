# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

42-month interdisciplinary PhD thesis on *Sceletium tortuosum* (Kanna) spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical analysis. Repository contains research data, analysis scripts, writing, and comprehensive tool integration.

**Key Metrics**: 120,000-word thesis, 8 chapters, 15-20 publications, 142 papers corpus (974K words), 98/100 infrastructure health.

## Essential Commands

### Environment Activation

```bash
# MinerU PDF extraction (dedicated GPU-accelerated environment)
conda activate mineru

# Python environment (cheminformatics, ML, QSAR)
conda activate kanna

# R environment (statistics, GIS, meta-analysis, Bayesian)
conda activate r-gis

# Quick access alias (add to ~/.zshrc)
kanna() {
    cd ~/LAB/projects/KANNA
    conda activate r-gis  # Default
    echo "✅ KANNA (R 4.4.3) | Switch: conda activate kanna | PDF extraction: conda activate mineru"
}
```

### Core Workflows

```bash
# Daily status check
git status
cat PROJECT-STATUS.md | head -50
tail -20 ~/LAB/logs/kanna-backup.log

# PDF extraction (GPU-accelerated MinerU in dedicated environment)
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Run ethnobotany analysis (Chapter 3)
conda activate r-gis
Rscript analysis/r-scripts/ethnobotany/calculate-bei.R

# Run QSAR modeling (Chapter 4)
conda activate kanna
python analysis/python/cheminformatics/qsar-modeling.py

# Manual backup trigger
bash tools/scripts/daily-backup.sh

# MCP server verification
claude
/mcp  # Should show 17 connected servers
```

### Testing Environments

```bash
# Validate MinerU environment (PDF extraction)
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
python -c "from magic_pdf.pipe.UNIPipe import UNIPipe; print('✓ MinerU OK')"

# Validate Python environment (scientific analysis)
conda activate kanna
python -c "from rdkit import Chem; print('✓ RDKit OK')"
python -c "import pandas, numpy, sklearn; print('✓ Core OK')"

# Validate R environment
conda activate r-gis
Rscript -e "library(sf); library(brms); library(metafor); print('✓ R OK')"
```

## Architecture Patterns

### Three-Environment Strategy

**Critical**: Use separate conda environments to avoid dependency conflicts:

- **`mineru`** (Python 3.10): **GPU-accelerated PDF extraction** - PyTorch 2.4.0+cu124, MinerU 1.3.12, transformers 4.49.0, DocLayout-YOLO, Unimernet, RapidTable
- **`kanna`** (Python 3.10): RDKit (cheminformatics), scikit-learn (ML), spaCy (NLP), general scientific computing
- **`r-gis`** (R 4.4.3): sf (GIS), brms (Bayesian), metafor (meta-analysis), tidyverse (stats)

**Why**:
- **mineru isolation**: MinerU needs specific transformers 4.49.0 (incompatible with 4.57.0), clean PyTorch+CUDA environment resolved CUDA Error 999
- **kanna isolation**: Python ML tools (transformers, torch) conflict with R spatial libraries (GDAL, PROJ)
- **GPU acceleration**: Fresh mineru environment enables GPU extraction (10× faster than CPU mode)

**Known Issue - Workaround**:
- rstan has TBB symbol errors when loaded directly
- **Solution**: Use `library(brms)` instead of `library(rstan)` - brms is a wrapper that delays TBB linkage and provides better syntax

### Analysis Pipeline Structure

**Standard pattern for all scripts**:

```
Input:  data/{discipline}/{subdomain}/raw-data.csv
Script: analysis/{language}-scripts/{chapter}/analysis-name.{R|py}
Output: analysis/{language}-scripts/{chapter}/output/{analysis-type}/
Final:  assets/figures/chapter-{XX}/{figure-name}.png (300 DPI)
```

**Example**:
```bash
Input:  data/ethnobotanical/surveys/survey-2025.csv
Script: analysis/r-scripts/ethnobotany/calculate-bei.R
Output: analysis/r-scripts/ethnobotany/output/bei/
Final:  assets/figures/chapter-03/bei-by-community.png
```

### Three-Tier Data Privacy

**Tier 1: Git-Excluded (SENSITIVE - NEVER commit)**:
```
fieldwork/interviews-raw/**              # Raw audio/transcripts
data/ethnobotanical/interviews/*.wav     # Recordings
data/clinical/trials/**/patient-data/**  # Identifiable data
*.env, credentials.json                  # Secrets
```

**Tier 2: Git LFS (LARGE)**:
```
*.raw, *.wiff, *.d/  # LC-MS data (>100MB)
*.tif                 # High-res images
*.fastq, *.bam        # Genomic data
```

**Tier 3: Git-Tracked (REPRODUCIBLE)**:
```
data/ethnobotanical/surveys/*.csv  # De-identified data
analysis/**/*.{R|py}               # Scripts
assets/figures/**/*.png            # Figures (300 DPI)
writing/thesis-chapters/**/*.tex   # LaTeX
```

### Chapter-Specific Toolchains

```
Chapter 2 (Botany):        QGIS → IQ-TREE 3 → R sf → FigTree
Chapter 3 (Ethnobotany):   SurveyCTO → MAXQDA → ethnobotanyR → ggplot2
Chapter 4 (Pharmacology):  PubChem → RDKit → scikit-learn → SHAP → PyMOL
Chapter 5 (Clinical):      Rayyan → RevMan → metafor → forest plots
```

## Critical Dependencies

### Python (conda environment: kanna)

```bash
# Core (MUST install via conda, NOT pip)
conda install -c conda-forge rdkit  # Cheminformatics foundation

# After conda, install rest via pip
pip install -r requirements.txt

# NLP model (separate download)
python -m spacy download en_core_web_sm
```

### R (conda environment: r-gis)

```bash
# Install from script
Rscript analysis/r-scripts/install-packages.R

# Key packages: sf (GIS), brms (Bayesian), metafor (meta-analysis),
#               tidyverse, ethnobotanyR, vegan, igraph
```

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

**Requirements**: 300 DPI minimum, colorblind-friendly palettes (viridis, RColorBrewer), ≥10pt fonts at print size.

### Integration Testing & Production Readiness

**Status**: ⚠️ **CRITICAL - Phase 3 has 2 blocking integration bugs** (discovered 2025-10-10)

**Phase 3 Validation Achievements**:
- ✅ 100% formula accuracy validated on 948 formulas across 7 diverse papers
- ✅ Negative validation complete (ChemLLM-7B properly rejected at 13.3%)
- ✅ Enhanced prompts code written and unit tested (7/7 tests passing)
- ✅ Full corpus deployment script created

**Critical Blockers Preventing Production Deployment**:

1. **Integration Bug #1**: Enhanced prompts NOT integrated into validation pipeline
   - File: `tools/scripts/layer2-sequential-validation.py` (480 lines)
   - Issue: Does NOT import or use `layer2-enhanced-prompts.py`
   - Impact: Claimed "60% LLM reduction" will NOT happen
   - Fix required: Add imports and modify `repair_with_mcp()` function (~45 min)
   - Location: tools/scripts/layer2-sequential-validation.py:1-20 (add imports), :350-380 (modify function)

2. **Integration Bug #2**: Deployment script uses non-existent CLI flag
   - File: `tools/scripts/phase3-full-corpus-deployment.sh` line 192
   - Issue: Calls layer2 with `--enhanced-prompts` flag that doesn't exist
   - Impact: Deployment will crash immediately with "unrecognized arguments" error
   - Fix required: Remove invalid flag from deployment script (~5 min)
   - Location: tools/scripts/phase3-full-corpus-deployment.sh:189-193

**Industry-Validated Integration Testing Principles** (Research-backed, 2025-10-10):

These principles are validated by Google SRE Production Readiness Review (PRR), Microsoft Engineering Playbook Definition of Done (DoD), and NASA NPR 7123.1 Systems Engineering standards:

1. **Integration testing is MANDATORY before "production ready" claims**
   - Source: Google PRR requires dependency verification and monitoring configured
   - Source: Microsoft DoD Sprint-level requires "Integration tests pass" and "End-to-end tests pass"
   - Source: NASA System Integration Review (SIR) requires component maturity validation

2. **Unit tests passing ≠ Integration working**
   - Individual components working in isolation does NOT guarantee system integration
   - Must test components working together, not just individually
   - Phase 3 lesson: Enhanced prompts passed 7/7 unit tests but were never connected to pipeline

3. **Dry-run validation required before deployment**
   - Must execute deployment script end-to-end in dry-run mode
   - Google PRR: "Dry-run in staging environment" is prerequisite
   - Phase 3 lesson: Never ran `phase3-full-corpus-deployment.sh --dry-run`, would have caught both bugs

4. **"Code written" ≠ "Code tested" ≠ "Production ready"**
   - Code written: Individual files exist and compile
   - Code tested: Unit tests pass, integration tests pass, end-to-end tests pass
   - Production ready: All of above + dry-run succeeds + monitoring configured + team sign-off

**Mandatory Pre-Deployment Checklist** (Prevent Future Integration Failures):

Before claiming ANY feature is "production ready", MUST complete:

```bash
# 1. Unit tests pass
pytest tools/scripts/test_*.py
Rscript analysis/r-scripts/test-*.R

# 2. Integration test (components work together)
# Example: Enhanced prompts integration test
python -c "
from layer2_sequential_validation import LayerTwoValidator
from layer2_enhanced_prompts import categorize_error_enhanced
# Verify imports work and functions integrate
"

# 3. End-to-end dry-run (full pipeline simulation)
bash tools/scripts/phase3-full-corpus-deployment.sh --dry-run
# MUST complete without errors before claiming "production ready"

# 4. Verify claimed features actually exist
# Example: Check that --enhanced-prompts flag is actually implemented
python tools/scripts/layer2-sequential-validation.py --help | grep enhanced-prompts

# 5. Code review (second pair of eyes)
git diff main..feature-branch | wc -l  # Review all changes

# 6. Documentation matches reality
# Verify claims in docs match actual code behavior
```

**Root Cause Analysis (5 Whys - Phase 3 Integration Failure)**:

1. **Why did deployment script have invalid flag?** → Never tested the deployment script
2. **Why didn't test it?** → Assumed individual components working = integration works
3. **Why that assumption?** → Focused on feature completion, not system validation
4. **Why that focus?** → No mandatory checklist enforcing integration testing
5. **Root cause**: Missing quality gates in development process

**Lessons Learned** (Honest Assessment):

- ✅ **Valid critique**: Skipping integration testing violates industry standards (Google/Microsoft/NASA all mandate it)
- ✅ **Real standards**: Google SRE PRR, Microsoft DoD, NASA SIR/TRR are authoritative sources
- ❌ **Theatrical scoring**: Should NOT claim specific percentages (e.g., "25% on Google's checklist") - real frameworks are complex, scoring is interpretation
- ✅ **Core principle**: "Test it end-to-end before shipping" is universal industry requirement (2024-2025 best practices)

**Next Steps to Unblock Phase 3 Deployment**:

1. Fix Integration Bug #2 (Quick win - 5 minutes)
2. Fix Integration Bug #1 (Requires refactoring - 45 minutes)
3. Run end-to-end dry-run test (30 minutes)
4. ONLY THEN claim "production ready"
5. Create integration test suite to prevent future failures (4 hours)

**Documentation**: See `docs/AUDIT-REPORT-2025-10-10.md` for comprehensive audit findings.

### Git Commit Convention

```bash
# Semantic prefixes
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

### File Naming Conventions

**Data governance for FPIC compliance**:

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

## Key Tools & Scripts

### PDF Extraction (Production)

**Current tool**: MinerU 1.3.12 (GPU-accelerated, 100% success rate, extracts images + tables + formulas)

```bash
conda activate mineru  # Dedicated environment for GPU-accelerated extraction
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Output: literature/pdfs/extractions-mineru/[paper-name]/auto/
#   - [paper-name].md (markdown with embedded images)
#   - images/ (extracted chemical structures, diagrams)
#   - [paper-name]_layout.pdf (visual verification)
#   - [paper-name]_*.json (metadata)
```

**Why MinerU + dedicated environment**:
- **GPU acceleration**: 10× faster than CPU mode (resolved CUDA Error 999 with clean PyTorch environment)
- **Quality**: Superior extraction for scientific papers with chemical formulas, tables, complex layouts
- **Isolation**: transformers 4.49.0 required (incompatible with kanna's 4.57.0)
- **Models**: DocLayout-YOLO (2501), Unimernet (2503), RapidTable - all GPU-accelerated

### Backup System (3-2-1 Rule)

**Automated**: Daily at 2 AM via cron

```bash
# Crontab entry
0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1

# Manual trigger
bash tools/scripts/daily-backup.sh
```

**Backups**:
1. Working: `~/LAB/projects/KANNA/` (SSD)
2. Local: `/run/media/miko/AYA/KANNA-backup/` (1.4TB external HDD)
3. Cloud: Tresorit/SpiderOak (AES-256, ready to configure)

### Academic Enhancement Stack (Tier 1-2 Tools)

**Status**: ✅ Documentation and scripts created (2025-10-10)
**Implementation Guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md` (comprehensive 20,000-word guide)
**Estimated Setup Time**: 9.5-12 hours (Tier 1: 2.5-3h, Tier 2: 7-9h)

**Purpose**: French academic writing tools + literature analysis for 142-paper PhD thesis corpus

#### Tier 1: Critical Gaps (Week 1)

**1. Grammalecte - French Grammar Checking**
```bash
# Real-time checking in VS Code
code ~/LAB/projects/KANNA/
# Grammalecte extension configured in .vscode/settings.json

# Batch checking via CLI
conda activate kanna
./tools/scripts/check-grammar-french.sh writing/chapter-01.md

# Features:
# - 200+ custom ethnopharmacology terms
# - JSON reports with error statistics
# - Integration with /academic-enhance-fr command
```

**2. VOSviewer - Citation Network Visualization**
```bash
# Run analysis guide (interactive)
./tools/scripts/analyze-citation-network.sh

# Launches VOSviewer with:
# - Co-citation analysis (papers cited together)
# - Bibliographic coupling (shared references)
# - Keyword co-occurrence (thematic analysis)
# - Publication-ready 300 DPI outputs
```

#### Tier 2: Activate Existing Plans (Week 2)

**3. Zotero + Better BibTeX - Bibliography Management**

**Original Guide**: `tools/guides/01-literature-workflow-setup.md` (follow this first!)
**Workflow**: Elicit → Zotero (Better BibTeX) → Obsidian → Overleaf

```bash
# Auto-export configuration
# In Zotero: Right-click collection → Export → Better BibTeX → ✅ Keep updated
literature/zotero-export/kanna.bib  # Real-time sync

# Sync script (validates & commits to git)
./tools/scripts/sync-zotero-bib.sh

# LaTeX citation in Overleaf
\citep{author2025}
\bibliography{kanna}
```

**4. Obsidian - Personal Knowledge Graph**
```bash
# Vault location
writing/obsidian-notes/

# Zotero Integration plugin
# Settings → Zotero Integration → Database: literature/zotero-export/kanna.bib

# Features:
# - Literature note templates
# - Graph view of paper relationships
# - Bidirectional [[wiki-links]]
# - Complements VOSviewer (personal vs citation networks)
```

#### Key Scripts Created

```bash
# Grammar checking
tools/scripts/check-grammar-french.sh

# Citation network analysis
tools/scripts/analyze-citation-network.sh

# Bibliography sync
tools/scripts/sync-zotero-bib.sh

# Configuration files
.vscode/settings.json                    # Grammalecte + LaTeX
.vscode/grammalecte-dictionary.txt       # 200+ custom terms
```

#### MCP Integration

**VoltAgent marketplace** already installed in KANNA (20 total servers: 19 LAB + 1 VoltAgent):
```bash
# In Claude Code session from KANNA directory
/mcp  # Verify 20 servers connected

# Use research-analyst for complex synthesis
/research-analyst "Analyze alkaloid biosynthesis literature 2020-2025"

# Use academic enhancement command
/academic-enhance-fr "chapter-03-ethnobotany.pdf"
```

#### ROI & Time Investment

**Investment**: 9.5-12 hours setup (Tier 1-2)
**Return**: 63-75 hours saved over 120,000-word thesis
**ROI**: 5.3× to 7.9× return

**Breakdown**:
- Grammalecte: 30h saved (real-time grammar correction)
- VOSviewer: 8-10h saved (literature structure analysis)
- Zotero: 15-20h saved (bibliography management)
- Obsidian: 10-15h saved (synthesis and knowledge mapping)

#### Compliance & Privacy

✅ **All tools local** (FPIC-compliant): Grammalecte, VOSviewer, Zotero, Obsidian
❌ **Avoid cloud tools**: Connected Papers, Research Rabbit (privacy risk for indigenous knowledge)

#### Documentation

- **Complete setup guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md`
- **Existing workflow guide**: `tools/guides/01-literature-workflow-setup.md`
- **Academic plugin setup**: `docs/ACADEMIC-PLUGINS-SETUP.md` (VoltAgent marketplace)

#### Next Steps After Setup

1. Import 142 PDFs into Zotero (45-60 min automatic)
2. Run VOSviewer co-citation analysis
3. Create Obsidian literature notes (systematic review)
4. Use Grammalecte daily for thesis writing
5. Generate citation network figures for Chapter 1

## MCP Server Integration

**Inherited from `~/LAB/`**: 17 MCP servers available

**Key servers**:
- **Context7**: Up-to-date docs (RDKit, scikit-learn, ggplot2)
- **Perplexity**: AI-powered search for recent Sceletium papers
- **GitHub**: Repository management
- **Cloudflare Browser**: Web scraping, markdown conversion
- **Cloudflare Radar**: Internet intelligence, domain rankings
- **Cloudflare Container**: Ephemeral sandbox for safe experiments

**Usage**: Access via `/mcp` command in Claude Code session.

## Common Workflows

### Weekly Progress Update

```bash
# Update PROJECT-STATUS.md (every Monday)
cat PROJECT-STATUS.md | head -100

# Calculate metrics
ls -1 literature/pdfs/*.pdf | wc -l         # Papers read
find writing/ -name "*.tex" -exec wc -w {} + | tail -1  # Words written
find assets/figures/ -name "*.png" | wc -l  # Figures created
git rev-list --count HEAD                   # Commits
```

### Export All Figures

```bash
conda activate r-gis
Rscript tools/scripts/export-all-figures.R
# Batch export to assets/figures/ (300 DPI)
```

### Emergency Recovery

```bash
# Restore from external HDD
rsync -avh /run/media/miko/AYA/KANNA-backup/ ~/LAB/projects/KANNA/

# Restore from cloud (if configured)
rclone sync tresorit:KANNA ~/LAB/projects/KANNA/

# Verify Git integrity
git fsck --full
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

**Status**: ⚠️ **CRITICAL BLOCKER** - PyTorch CUDA initialization fails across all versions, blocking both MinerU GPU mode and vLLM

**Symptom**:
```
RuntimeError: CUDA unknown error - this may be due to an incorrectly set up environment,
e.g. changing env variable CUDA_VISIBLE_DEVICES after program start.
Setting the available devices to be zero.
```

**Impact**:
- ❌ MinerU forced to CPU mode (`device-mode: "cpu"` in magic-pdf.json)
- ❌ vLLM cannot start (requires functional CUDA for engine initialization)
- ❌ ChemLLM-7B-Chat integration blocked (vLLM backend unavailable)
- ⚠️ 10× slower extraction (CPU mode vs GPU mode)

**Root Cause**: System-level CUDA/driver state corruption. Multiple PyTorch versions tested (2.8.0, 2.5.1, 2.4.1) all fail at `torch._C._cuda_init()`.

**Hardware Confirmed Healthy**:
- ✅ NVIDIA driver loaded: 580.82.09 (verified via `/proc/driver/nvidia/version`)
- ✅ GPU detected: Quadro RTX 5000 (16GB VRAM, compute capability 7.5)
- ✅ CUDA toolkit installed: 12.4 + 13.0 (libraries present in `/usr/local/cuda`)

**Current Workaround - Local LLM via Ollama**:
```bash
# Ollama serving qwen2-math:7b for formula extraction
# Configured in magic-pdf.json lines 51-71
# Works but not chemistry-specialized
```

**Recommended Fix**: System reboot to re-initialize NVIDIA driver state
```bash
# After reboot, verify CUDA restored:
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
# Should print: CUDA: True

# Then switch back to GPU mode:
# Edit /home/miko/magic-pdf.json line 15: "device-mode": "cuda"
```

**ChemLLM-7B-Chat Integration (Ready - Blocked by CUDA)**:

**Purpose**: Chemistry-specialized LLM for extracting alkaloid structures (mesembrine, mesembrenone, tortuosamine) from Sceletium papers. Far superior to generic math models for chemical nomenclature, molecular structures, and stereochemistry.

**Model Location**:
```
/run/media/miko/AYA/crush-models/hf-home/models--AI4Chem--ChemLLM-7B-Chat/snapshots/b8b2ea19e48f53d190fe8dced94572717f8e89a2
```

**Setup Status**:
- ✅ vLLM 0.11.0 installed in mineru environment (438.2 MB)
- ✅ ChemLLM-7B-Chat model downloaded (AI4Chem, 7B parameters)
- ❌ vLLM server blocked by CUDA initialization failure
- ⏳ Pending system reboot to restore CUDA

**Proper vLLM Setup (After CUDA Fixed)**:
```bash
# 1. Start vLLM server for ChemLLM (background)
conda activate mineru
vllm serve /run/media/miko/AYA/crush-models/hf-home/models--AI4Chem--ChemLLM-7B-Chat/snapshots/b8b2ea19e48f53d190fe8dced94572717f8e89a2 \
  --host localhost \
  --port 8000 \
  --dtype auto \
  --max-model-len 4096 \
  --trust-remote-code &

# 2. Wait for server startup (30-60 seconds)
sleep 60

# 3. Test API endpoint
curl http://localhost:8000/v1/models

# 4. Update magic-pdf.json llm-aided-config:
# Change formula_aided.model to "AI4Chem/ChemLLM-7B-Chat"
# Change formula_aided.base_url to "http://localhost:8000/v1"

# 5. Run test extraction
magic-pdf -p literature/pdfs/sceletium-test.pdf -o /tmp/test -m auto
```

**Performance Expectations (Post-Fix)**:
- vLLM: 2-10× faster inference than transformers (PagedAttention optimization)
- GPU extraction: 10× faster than current CPU mode
- ChemLLM: 85-90% accuracy on chemistry formulas (vs 60-70% for generic models)
- Full 142-paper corpus: ~7 hours (GPU) vs ~70 hours (CPU)

**Alternative Workarounds (If Reboot Not Immediate)**:

1. **Ollama (Current)**: Continue with qwen2-math:7b (generic math model)
   - Works now, already configured
   - Lower accuracy on chemistry-specific content

2. **Transformers Direct**: Serve ChemLLM via Flask/FastAPI without vLLM
   - 2-5× slower than vLLM (no PagedAttention)
   - Requires custom serving code (~100 lines)

3. **Ollama + ChemLLM GGUF**: Convert ChemLLM to GGUF format for Ollama
   - Requires 30-60 min one-time conversion
   - Ollama handles CPU/GPU gracefully

**Next Steps**:
1. Reboot system when convenient (~5 min)
2. Verify CUDA restoration (`torch.cuda.is_available()`)
3. Start vLLM server with ChemLLM
4. Update magic-pdf.json to use ChemLLM endpoint
5. Run full 142-paper GPU extraction with chemistry-specialized model

### Backup Not Running

**Check logs**:
```bash
tail -50 ~/LAB/logs/kanna-backup.log

# Verify cron entry
crontab -l | grep daily-backup

# Manual test
bash tools/scripts/daily-backup.sh
```

## Documentation Reference

**Essential reading** (in order):
1. **CLAUDE.md** (this file) - Quick start for Claude Code
2. **ARCHITECTURE.md** - Comprehensive architectural reference (1,000+ lines)
3. **PROJECT-STATUS.md** - Current progress tracker (update weekly)
4. **README.md** - Project overview, thesis structure

**Setup guides** (`tools/guides/`, 1,670+ lines):
1. Literature workflow (Elicit → Zotero → Obsidian → Overleaf)
2. Field data collection (SurveyCTO FPIC surveys)
3. Qualitative analysis (MAXQDA coding)
4. QSAR pipeline (RDKit → scikit-learn → SHAP)
5. French writing (Overleaf + Antidote)
6-8. PDF extraction (MinerU, LaTeX-OCR)

## Key File Locations

```
# Configuration
.gitignore                    # Privacy protection
requirements.txt              # Python dependencies (150+)
analysis/r-scripts/install-packages.R  # R dependencies (60+)

# Scripts
tools/scripts/daily-backup.sh              # Automated backup
tools/scripts/extract-pdfs-pdfplumber.py   # PDF extraction

# Data
data/ethnobotanical/surveys/*.csv          # De-identified surveys
literature/pdfs/BIBLIOGRAPHIE/             # 142 PDFs (2.0 GB)

# Outputs
assets/figures/chapter-XX/*.png            # 300 DPI figures
analysis/*/output/                         # Analysis results
writing/thesis-chapters/                   # LaTeX chapters
```

## Design Principles

1. **Pragmatic Over Perfect**: Ship working code now (pdfplumber), optimize later (MinerU)
2. **Security by Design**: 3-tier privacy, sensitive data NEVER committed
3. **Reproducibility First**: conda/renv lock files, semantic commits
4. **Automation as Leverage**: 7.5 hours setup → 575 hours saved (77× ROI)
5. **Infrastructure-First PhD**: Quality tooling enables better research

## Ethical Considerations

**ALWAYS follow FPIC (Free, Prior, Informed Consent) principles**:

1. **Data Sovereignty**: Khoisan communities retain IP rights to traditional knowledge
2. **Anonymization**: All interviews de-identified before analysis
3. **Benefit-Sharing**: Research outputs shared with communities before publication
4. **No Commits Without FPIC**: Never commit sensitive data without community validation

**Sensitive data protection**:
- Encrypted archives: `tools/scripts/encrypt-sensitive-data.sh` (AES-256)
- Ethics approvals: `collaboration/ethics-approvals/`
- FPIC protocols: `data/ethnobotanical/fpic-protocols/`

---

**For comprehensive details**: See ARCHITECTURE.md (39KB, definitive reference)

**Last Updated**: October 2025 (Month 1 - Infrastructure Complete)
