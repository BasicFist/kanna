# Research Automation Strategy - PhD Workflow Optimization

**Created**: October 2025 (Month 1)
**Context**: Brainstorming session - Literature review, data collection, academic writing automation
**Timeline**: 4-week implementation (November-December 2025)

## User Needs Analysis

### Literature Review (Q1-Q4)
- **Frequency**: Daily/weekly additions (active discovery)
- **Pain Points**:
  - Reading/extraction: moderate
  - **Synthesis across papers: CRITICAL** (C++++++)
  - Citation management: moderate (D+)
- **Priorities** (ranked):
  1. Cross-paper concept mapping (rank 5)
  2. Automated literature notes (rank 2)
  3. Citation network analysis (rank 1)
  4. Finding extraction (rank 4)
  5. Chapter classification (rank 3)
- **Core Challenge**: Building AI-reachable knowledge base for 142 papers with complex interconnected concepts

### Data Collection Optimization (Q5-Q7)
- **Active Chapters**: ALL (2-7 need data collection)
- **Pain Points**:
  - Cross-chapter data linking: TOP PRIORITY (E)
  - Analysis pipeline: HIGH (C)
  - Data entry: MODERATE (A)
- **Automation Priorities**:
  - Cross-reference validation (rank 5)
  - Automated de-identification (rank 1)

### Academic Writing (Q8-Q11)
- **Status**: Haven't started (Month 1) - perfect timing
- **Challenges**:
  - **Logical flow/argumentation: CRITICAL** (D++++++)
  - Theoretical depth: MODERATE (B++)
  - Citation density: MODERATE (C)
- **Enhancement Priorities**: ALL 4 coherence items
  - Chapter coherence analysis
  - Bibliography completeness
  - Academic tone analysis
  - Cross-chapter consistency
- **Workflow**: Obsidian → Overleaf (A, but unsure)

## Core Architecture: Knowledge Graph Operating System

```
TIER 1: Knowledge Acquisition
├─ MinerU PDF → Markdown ✅
├─ Zotero → BibTeX export ⏳
└─ RAG semantic search ✅

TIER 2: Knowledge Organization
├─ Obsidian vault + graph view ⏳ PRIORITY
├─ Memory MCP entity graph ⏳ CRITICAL
└─ Automated tagging/classification ⏳

TIER 3: Data Pipeline
├─ Collection → Analysis → Figure ⏳
├─ Cross-reference validation ⏳ PRIORITY
└─ FPIC automated checks ⏳ CRITICAL

TIER 4: Writing & Coherence
├─ Obsidian → Overleaf bridge ⏳
├─ French coherence checker ⏳ CRITICAL
└─ Cross-chapter consistency ⏳
```

## Implementation Timeline (4 Weeks)

### Week 1: Knowledge Base Foundation
**Goal**: AI-reachable literature corpus

**Day 1-2**: Obsidian vault structure
```bash
mkdir -p writing/obsidian-notes/{literature,concepts,data,chapters}
```

**Day 3**: Zotero Better BibTeX
- Import 142 PDFs
- Configure auto-export: `literature/zotero-export/kanna.bib`

**Day 4-5**: Generate literature notes (all 142 papers)
```bash
python tools/scripts/generate-lit-notes.py \
  --mineru-dir literature/pdfs/extractions-mineru/ \
  --zotero-bib literature/zotero-export/kanna.bib \
  --output writing/obsidian-notes/literature/
```

**Day 6-7**: Memory MCP concept graph
```bash
python tools/scripts/build-concept-graph.py \
  --corpus literature/pdfs/extractions-mineru/ \
  --chapters 8
```

**Success Metric**: Semantic query "mesembrine AND Khoisan use" returns linked notes

### Week 2: Analysis Pipeline Automation
**Goal**: Data → Figure workflow

**Day 8-9**: Cross-reference validation
```bash
tools/scripts/validate-cross-references.sh
# Validates: figures ↔ chapters, data ↔ FPIC, analysis ↔ outputs
```

**Day 10-12**: Analysis pipeline wrappers
- Chapter 3: BEI calculation
- Chapter 4: QSAR modeling

**Day 13-14**: FPIC de-identification
```bash
python tools/scripts/deidentify-interviews.py \
  --input fieldwork/interviews-raw/ \
  --output data/ethnobotanical/interviews/
```

**Success Metric**: 5-min analysis run (vs 2 hours manual)

### Week 3-4: Writing Workflow
**Goal**: Obsidian → Overleaf + coherence

**Day 15-17**: Pandoc export pipeline
- Template creation
- Test conversion

**Day 18-20**: French academic coherence checker
```bash
python tools/scripts/french-academic-checker.py \
  --chapter writing/thesis-chapters/chapter-01.tex \
  --report writing/coherence-reports/chapter-01-report.md
```

**Day 21**: Cross-chapter consistency validator

**Day 22-28**: Documentation

**Success Metric**: Draft → LaTeX → <5 coherence issues

## Critical Scripts to Create

### Priority 1 (Week 1)
- `generate-lit-notes.py` - MinerU → Obsidian conversion
- `build-concept-graph.py` - Memory MCP entity extraction

### Priority 2 (Week 2)
- `validate-cross-references.sh` - Multi-tier validation
- `deidentify-interviews.py` - FPIC-safe transcription

### Priority 3 (Week 3)
- `french-academic-checker.py` - Coherence analysis
- `check-cross-chapter-consistency.py` - Terminology/flow

## Key Insights

### Multi-Layer Knowledge Indexing
1. **RAG MCP**: Semantic keyword search ✅
2. **Memory MCP**: Entity relationship graph ⏳ NEW
3. **Obsidian**: Bidirectional concept links ⏳ NEW

### FPIC Automation
- Pre-commit validation (already exists, enhance)
- Automated de-identification (NEW, CRITICAL)
- Cross-reference safety checks (NEW)

### French Academic Coherence (Q9 D++++++)
- Problématique identification
- Argumentation structure (plan dialectique)
- Logical connectors (ainsi, toutefois, en effet)
- Evidence-citation proximity validation

## ROI Projection (6 months)

| Automation | Time Saved | Implementation | ROI |
|------------|------------|----------------|-----|
| Literature notes | 40h | 6h | 6.7× |
| Cross-reference | 20h | 4h | 5× |
| Analysis pipeline | 60h | 12h | 5× |
| FPIC deidentify | 30h | 8h | 3.75× |
| Coherence check | 50h | 10h | 5× |
| **TOTAL** | **200h** | **40h** | **5×** |

## Next Immediate Actions

**Today**:
1. Create Obsidian vault structure
2. Download VOSviewer manually
3. Start Zotero Better BibTeX setup

**Tomorrow**:
1. Bulk import 142 PDFs to Zotero
2. Configure auto-export
3. Test lit note generation (5 papers)

**This Week**:
1. Complete Week 1 tasks
2. Validate approach with 10-paper subset
3. Document in setup guides

## Dependencies

**Must Install**:
- Obsidian vault ✅ (AppImage ready)
- Zotero Better BibTeX ⏳
- VOSviewer ⏳ (manual download)

**Must Create**:
- 6 Python automation scripts
- 2 validation shell scripts
- Pandoc LaTeX template

**Must Configure**:
- Memory MCP entity schema
- Obsidian graph view settings
- FPIC pre-commit hooks (enhance existing)

## Success Metrics

**Week 1**: Query corpus semantically via Obsidian + Memory MCP
**Week 2**: Run Chapter 3 analysis → auto-generate figure in 5 min
**Week 3**: Export Obsidian draft → LaTeX with <5 coherence issues
**Month 2**: Full pipeline operational for active writing

## Notes

- User is in Month 1, no writing started yet - PERFECT timing
- Biggest pain is synthesis (C++++++) - solved by multi-layer indexing
- Critical for FPIC: automated de-identification before data collection ramps up
- French coherence (D++++++) requires custom checker - no off-the-shelf tool

**Strategy**: Build knowledge infrastructure FIRST (Month 1-2), then use it for writing (Month 3+)
