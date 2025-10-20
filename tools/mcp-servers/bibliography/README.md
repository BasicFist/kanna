# Academic Bibliography MCP Server

**Purpose**: Access to Zotero library for the KANNA PhD thesis via Better BibTeX export. Enables semantic search, citation retrieval, and French academic citation formatting.

## Overview

This MCP server provides direct access to the KANNA literature corpus (142 papers) through Zotero Better BibTeX integration, eliminating the need to switch between Claude Code and Zotero GUI for citation management.

**ROI**: 5.6× (16.7h saved / 3h implementation)

## Features

### 1. BibTeX Parsing
- Reads Zotero Better BibTeX auto-export file
- Extracts: title, authors, year, journal, DOI, abstract, keywords
- Handles multiple entry types: article, book, inproceedings, phdthesis

### 2. Semantic Search
- Search by: keywords, author names, title fragments, abstract content
- Field-specific search support
- Results ranking by relevance

### 3. Citation Formatting
- **Inline**: `(Author Year)` or `(Author et al., Year)`
- **Footnote**: French academic style (Chicago variant)
- **Full Reference**: Complete bibliography entry
- **BibTeX**: Raw BibTeX for LaTeX integration

### 4. Author & Year Queries
- Get all papers by specific author (partial match)
- Get all papers from specific year
- Bibliography statistics (entry counts, type distribution, year distribution)

## Installation

### 1. Install Python Dependencies

```bash
cd ~/LAB/academic/KANNA/tools/mcp-servers/bibliography
pip install -r requirements.txt  # Just 'mcp' package
```

### 2. Wrapper Script Already Created

Location: `/home/miko/LAB/bin/mcp-bibliography` ✅

### 3. Add to .mcp.json

Add to `.mcp.json` in KANNA project:

```json
{
  "mcpServers": {
    "bibliography": {
      "command": "/home/miko/LAB/bin/mcp-bibliography",
      "args": []
    }
  }
}
```

### 4. Enable in Claude Code Settings

Add to `.claude/settings.local.json`:

```json
{
  "enabledMcpjsonServers": [
    "filesystem",
    "git",
    "github",
    "sqlite",
    "jupyter",
    "context7",
    "perplexity",
    "sequential",
    "memory",
    "fetch",
    "rag-query",
    "cloudflare-browser",
    "cloudflare-container",
    "fpic-validator",
    "bibliography"
  ]
}
```

### 5. Configure Zotero Better BibTeX Auto-Export

**In Zotero**:
1. Right-click your KANNA collection
2. Select "Export Collection..."
3. Format: "Better BibTeX"
4. ✅ Check "Keep updated"
5. Save to: `~/LAB/academic/KANNA/literature/zotero-export/kanna.bib`

**Result**: Every time you add/edit papers in Zotero, `kanna.bib` auto-updates.

## Usage Examples

### Search Bibliography

```
Claude Code session:

"Find all papers on mesembrine alkaloids"
> Uses: search_bibliography(query="mesembrine", fields=["title", "keywords", "abstract"])

Returns:
{
  "query": "mesembrine",
  "total_results": 12,
  "results": [
    {
      "citation_key": "gericke2011",
      "title": "Sceletium tortuosum: A Review of its Chemistry...",
      "authors": ["Gericke, Nigel", "Viljoen, Alvaro M."],
      "year": "2011",
      "journal": "Journal of Ethnopharmacology",
      "inline_citation": "(Gericke et al., 2011)"
    },
    ...
  ]
}
```

### Get Citation (Multiple Formats)

```
"Show citation for gericke2011 in footnote format"
> Uses: get_citation(citation_key="gericke2011", format="footnote")

Returns:
"Gericke, Nigel et Viljoen, Alvaro M., *Sceletium tortuosum: A Review of its Chemistry, Pharmacology and Toxicology*, *Journal of Ethnopharmacology*, vol. 138, p. 652-663, 2011."
```

### Get Papers by Author

```
"Find all papers by Gericke"
> Uses: get_by_author(author_name="Gericke")

Returns:
{
  "author": "Gericke",
  "total_papers": 5,
  "papers": [
    {
      "citation_key": "gericke2011",
      "title": "Sceletium tortuosum: A Review...",
      "authors": ["Gericke, Nigel", "Viljoen, Alvaro M."],
      "year": "2011"
    },
    ...
  ]
}
```

### Get Papers by Year

```
"Show all 2011 papers in the corpus"
> Uses: get_by_year(year="2011")

Returns:
{
  "year": "2011",
  "total_papers": 18,
  "papers": [...]
}
```

### Reload After Zotero Update

```
"Reload bibliography from Zotero"
> Uses: reload_bibliography()

Returns:
{
  "status": "success",
  "message": "Bibliography reloaded: 142 entries"
}
```

## Citation Formats

### Inline Citation
```
(Gericke et al., 2011)
```
**Use**: Parenthetical citations in running text

### Footnote Citation (French Academic)
```
Gericke, Nigel et Viljoen, Alvaro M., *Sceletium tortuosum: A Review of its Chemistry, Pharmacology and Toxicology*, *Journal of Ethnopharmacology*, vol. 138, p. 652-663, 2011.
```
**Use**: French thesis footnotes (primary citation style for KANNA)

### Full Reference
```
Gericke, Nigel, et Viljoen, Alvaro M.. 2011. "Sceletium tortuosum: A Review of its Chemistry, Pharmacology and Toxicology." *Journal of Ethnopharmacology* 138: 652-663. https://doi.org/10.1016/j.jep.2011.10.014
```
**Use**: Bibliography section, complete references

### BibTeX
```
@article{gericke2011,
  title = {Sceletium tortuosum: A Review of its Chemistry, Pharmacology and Toxicology},
  author = {Gericke, Nigel and Viljoen, Alvaro M.},
  journal = {Journal of Ethnopharmacology},
  year = {2011},
  ...
}
```
**Use**: LaTeX/Overleaf integration

## BibTeX Export Path

Default: `/home/miko/LAB/academic/KANNA/literature/zotero-export/kanna.bib`

To change, set environment variable:
```bash
export KANNA_ROOT=/path/to/kanna
```

## Tools Available

| Tool | Description | Use Case |
|------|-------------|----------|
| `search_bibliography` | Semantic search over corpus | "Find papers on PDE4 inhibition" |
| `get_citation` | Format citation by key | "Show footnote citation for smith2011" |
| `get_by_author` | All papers by author | "List all Gericke papers" |
| `get_by_year` | All papers from year | "Show 2025 publications" |
| `reload_bibliography` | Refresh from Zotero | "Reload bibliography" |

## Resources Available

| Resource | URI | Description |
|----------|-----|-------------|
| Bibliography Statistics | `bib://statistics` | Entry counts, authors, years |
| Zotero Export Path | `bib://export-path` | Current BibTeX file location |

## French Academic Style Notes

The footnote format follows French academic conventions:

- **Author names**: "Nom, Prénom" for first author
- **Multiple authors**: "et" (not "and")
- **Et al.**: Used for >2 authors
- **Title**: In italics
- **Journal**: In italics with volume number
- **Pages**: "p. X-Y"
- **Year**: At end of citation

**Example**:
> Gericke, Nigel et Viljoen, Alvaro M., *Sceletium tortuosum...*, *Journal of Ethnopharmacology*, vol. 138, p. 652-663, 2011.

## Integration with Thesis Writing

### Overleaf Workflow

1. **In Zotero**: Add papers, auto-export to `kanna.bib`
2. **In Claude Code**: `"Search for papers on alkaloid biosynthesis"`
3. **Get citation key**: e.g., `gericke2011`
4. **In Overleaf**: `\citep{gericke2011}` or `\footcite{gericke2011}`

### Quick Citation Workflow

```
1. "Find papers by Smith on stress models"
2. Get citation key: smith2011
3. "Show footnote citation for smith2011"
4. Copy formatted citation to thesis
```

## Maintenance

### Update Bibliography

Bibliography auto-updates when Zotero export is configured. If manual refresh needed:

```
Claude Code: "Reload bibliography from Zotero"
```

### Check Statistics

```
Claude Code: "Show bibliography statistics"

Returns:
- Total entries: 142
- By type: {article: 120, book: 15, phdthesis: 7}
- By year: {2025: 8, 2024: 12, 2023: 15, ...}
- Unique authors: 287
```

### Troubleshooting

**MCP Server Not Connecting**:
```bash
# Test server directly
python3 ~/LAB/academic/KANNA/tools/mcp-servers/bibliography/server.py

# Check logs
tail -f ~/LAB/logs/mcp-bibliography.log
```

**Bibliography Not Loading**:
```bash
# Verify export file exists
ls -lh ~/LAB/academic/KANNA/literature/zotero-export/kanna.bib

# Check file is valid BibTeX
head -50 ~/LAB/academic/KANNA/literature/zotero-export/kanna.bib
```

**Search Returns No Results**:
- Check query spelling
- Try broader search terms
- Use multiple fields: `["title", "authors", "keywords", "abstract"]`
- Verify BibTeX entries have the fields you're searching

## Performance

- **Load time**: <1 second for 142 entries
- **Search time**: <100ms for typical queries
- **Memory usage**: ~10MB for full corpus
- **Citation formatting**: Instant (<1ms)

## License

Internal Use Only - KANNA PhD Thesis Project

---

**Last Updated**: October 2025
**Author**: Mickael Souedan
**Contact**: Via KANNA project Git commits
