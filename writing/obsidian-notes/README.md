# KANNA Research Vault

Knowledge graph for 42-month PhD thesis on *Sceletium tortuosum* (Kanna).

## Structure

- **`literature/`** - Notes on 142-paper corpus
  - Individual paper notes with metadata from Zotero
  - Cross-referenced concepts and findings
  - Automated generation via `generate-lit-notes.py`

- **`concepts/`** - Cross-cutting themes and entities
  - Alkaloids (mesembrine, mesembrenone, etc.)
  - Mechanisms (SERT, PDE4, neurobiology)
  - Methods (QSAR, meta-analysis, ethnobotany)
  - Theoretical frameworks (decolonial, FPIC)

- **`data/`** - Data collection notes and field observations
  - Ethnobotanical survey planning
  - Field site notes
  - Interview protocols
  - Analysis workflow documentation

- **`chapters/`** - Chapter drafts and outlines
  - Chapter-specific notes
  - Integration points
  - Writing progress tracking

## Integration

### Knowledge Acquisition
- **MinerU** → PDF extraction to markdown (142 papers)
- **Zotero** → Better BibTeX auto-export (`literature/zotero-export/kanna.bib`)
- **RAG MCP** → Semantic search across full corpus

### Knowledge Organization
- **Memory MCP** → Entity relationship graph
- **Obsidian Graph** → Bidirectional concept linking via `[[wiki-links]]`
- **Tags** → `#alkaloid`, `#ethnobotany`, `#clinical`, `#chapter-XX`

### Writing Workflow
- **Obsidian** → Draft notes with graph-based exploration
- **Pandoc** → Export to LaTeX for Overleaf
- **French Coherence Checker** → Academic writing validation

## Automation Scripts

- `tools/scripts/generate-lit-notes.py` - Literature notes from MinerU extractions
- `tools/scripts/build-concept-graph.py` - Memory MCP entity extraction
- `tools/scripts/french-academic-checker.py` - Writing coherence analysis

## Usage

### Adding Literature Notes
```bash
# Generate notes from MinerU extractions
python tools/scripts/generate-lit-notes.py \
  --mineru-dir literature/pdfs/extractions-mineru/ \
  --zotero-bib literature/zotero-export/kanna.bib \
  --output writing/obsidian-notes/literature/
```

### Semantic Search
```bash
# Query the corpus via RAG MCP
# Example: "mesembrine AND Khoisan traditional use"
```

### Building Concept Graph
```bash
# Extract entities for Memory MCP
python tools/scripts/build-concept-graph.py \
  --corpus literature/pdfs/extractions-mineru/ \
  --chapters 8
```

## Quick Reference

### Wiki-Link Syntax
- `[[Paper Title]]` - Link to literature note
- `[[mesembrine]]` - Link to concept note
- `[[Chapter 4 QSAR]]` - Link to chapter note

### Tagging Convention
- `#chapter-01` through `#chapter-08` - Chapter association
- `#alkaloid` - Chemical compounds
- `#ethnobotany` - Traditional knowledge
- `#clinical` - Clinical trials and efficacy
- `#legal` - Patents and benefit-sharing
- `#methodology` - Research methods

### Graph View
- Purple nodes: Literature (papers)
- Green nodes: Concepts (alkaloids, mechanisms)
- Blue nodes: Chapters (thesis structure)
- Orange nodes: Data (field notes, surveys)

## Timeline

- **Week 1** (Oct 22-28): Vault setup + literature notes generation
- **Week 2** (Oct 29-Nov 4): Concept graph + cross-references
- **Week 3** (Nov 5-11): Writing workflow integration
- **Week 4** (Nov 12-18): Documentation + optimization

## Success Metrics

✅ 142 literature notes generated with metadata
✅ Concept graph queryable via Memory MCP
✅ Semantic search: "mesembrine AND Khoisan" returns linked notes
✅ Graph view shows 500+ bidirectional links
✅ Export to LaTeX with <5 coherence issues

---

**Created**: October 21, 2025 (Month 1, Week 1)
**Research Automation Strategy**: 4-week knowledge graph construction
**Project**: KANNA - Interdisciplinary Analysis of *Sceletium tortuosum*
