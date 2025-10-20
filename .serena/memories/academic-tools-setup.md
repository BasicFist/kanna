# Academic Tools - Installation & Configuration

## Overview

Academic writing and literature analysis tools for KANNA PhD thesis (142-paper corpus, 120,000 words).

**Installation Date**: October 18, 2025
**Status**: ✅ Core tools installed and validated

## Tool 1: LanguageTool (French Grammar)

### Background
- **Original plan**: Grammalecte (French grammar checker)
- **Problem**: Grammalecte not available via pip, dnf, or GitHub
- **Solution**: Pivoted to LanguageTool (Java-based, actively maintained)

### Installation Details
- **Version**: LanguageTool 6.4 (2024-03-28)
- **Location**: `/home/miko/LAB/academic/KANNA/tools/languagetool/`
- **Size**: ~235 MB
- **Requirement**: Java 17+ ✅ (OpenJDK 17.0.13 installed)

### Scripts Created

**1. Setup Script**: `tools/scripts/setup-languagetool.sh`
- Automated download and extraction
- Java version validation
- Wrapper script generation
- Usage: `bash tools/scripts/setup-languagetool.sh`

**2. Grammar Checking Wrapper**: `tools/scripts/check-grammar-french.sh`
- Usage: `./tools/scripts/check-grammar-french.sh input.md [output.txt]`
- Features:
  - French language checking (`--language fr`)
  - Whitespace rule disabled
  - Issue counting
  - First 20 issues preview
  - Full report saved to file

### Example Usage
```bash
# Check French grammar on thesis chapter
./tools/scripts/check-grammar-french.sh writing/chapter-01.md

# Output:
# 🔍 Checking French grammar: writing/chapter-01.md
# 📊 Found 12 grammar issues
# 📄 Full report saved: writing/chapter-01-grammar-report.txt
```

### VS Code Integration
- **Extension**: davidlday.languagetool-linter
- **Status**: ✅ Installed
- **Configuration**: Ready for `.vscode/settings.json` customization
- **Next steps**:
  - Configure French as default language
  - Add custom dictionary (200+ ethnopharmacology terms)
  - Set up automatic checking on save

### Validation
```bash
java -jar ~/LAB/academic/KANNA/tools/languagetool/LanguageTool-6.4/languagetool-commandline.jar --version
# Output: LanguageTool version 6.4 (2024-03-28 14:05:28 +0100, 0e9362b)
```

## Tool 2: Zotero (Bibliography Management)

### Installation Details
- **Version**: Zotero 115.14.0esr
- **Installation Method**: APT repository
- **Status**: ✅ Installed and verified
- **Location**: `/usr/bin/zotero`

### Validation
```bash
zotero --version
# Output: Zotero Zotero 115.14.0esr, Copyright (c) 2006-2022 Contributors
```

### Next Steps (Not Yet Completed)
1. **Install Better BibTeX plugin**:
   - Download from https://github.com/retorquere/zotero-better-bibtex/releases
   - Install via Zotero → Tools → Add-ons → Install Add-on from File

2. **Configure auto-export**:
   - Right-click KANNA collection → Export Collection
   - Format: Better BibTeX
   - ✅ Check "Keep updated"
   - Save to: `~/LAB/academic/KANNA/literature/zotero-export/kanna.bib`

3. **Import 142-paper corpus**:
   - Import PDFs from `literature/pdfs/BIBLIOGRAPHIE/`
   - Automatic metadata extraction
   - Tag by chapter/theme

4. **Sync script** (to create):
   - Validate BibTeX file integrity
   - Commit to git when updated
   - Location: `tools/scripts/sync-zotero-bib.sh`

### Integration Workflow
```
Elicit (paper discovery) 
  → Zotero (bibliography management + Better BibTeX auto-export)
  → Obsidian (literature notes)
  → Overleaf (LaTeX citations)
```

## Tool 3: Obsidian (Knowledge Vault)

### Installation Details
- **Version**: 1.7.7
- **Format**: AppImage (127 MB)
- **Location**: `/home/miko/LAB/academic/KANNA/tools/Obsidian-1.7.7.AppImage`
- **Status**: ✅ Installed
- **Dependency**: libfuse2 ✅ (installed via apt)

### Validation
- AppImage installed with executable permissions
- libfuse2 dependency resolved
- GUI launch ready (headless testing not applicable for AppImage sandboxing)

### Launch Command
```bash
~/LAB/academic/KANNA/tools/Obsidian-1.7.7.AppImage &
```

### Next Steps (Not Yet Completed)
1. **Create vault**: `writing/obsidian-notes/`

2. **Install plugins**:
   - Zotero Integration (connect to Zotero library)
   - Citations (BibTeX integration)
   - Graph View enhancements
   - Daily notes

3. **Configure templates**:
   - Literature note template (author, year, key findings, chapter relevance)
   - Chapter outline template
   - Synthesis template

4. **Initial setup**:
   - Import 142 papers as literature notes
   - Create bidirectional links between related papers
   - Tag by chapter/theme
   - Generate knowledge graph

### Integration with Zotero
```markdown
# Example literature note template
---
title: {{title}}
authors: {{authors}}
year: {{year}}
citationKey: {{citationKey}}
tags: [chapter-04, alkaloids, pharmacology]
---

## Summary
{{abstract}}

## Key Findings
- Finding 1
- Finding 2

## Relevance to KANNA
Chapter 4 - QSAR modeling...

## Related Papers
[[paper2025a]] [[paper2023b]]
```

## Tool 4: VOSviewer (Citation Network Analysis)

### Status: ⚠️ Manual Download Required

**Problem**: Automated download failed (wget returned HTML error page instead of ZIP)

**Manual Steps**:
1. Download from: https://www.vosviewer.com/download
2. Choose: VOSviewer 1.6.20
3. Extract to: `~/LAB/academic/KANNA/tools/vosviewer/`
4. Verify Java 17 is installed ✅

### Expected Features
- Co-citation analysis (papers cited together)
- Bibliographic coupling (shared references)
- Keyword co-occurrence (thematic clusters)
- Publication-ready 300 DPI network visualizations

### Workflow (After Installation)
```bash
# Run analysis guide
./tools/scripts/analyze-citation-network.sh

# Launches VOSviewer with:
# - 142-paper corpus
# - Co-citation mapping
# - Keyword clustering
# - Export for thesis figures
```

## Academic Enhancement Command

### Custom Claude Code Command
**Command**: `/academic-enhance-fr [document-name]`

**Purpose**: French academic writing enhancement with 4-dimension analysis

**Features**:
- Tone analysis (impersonal voice, academic formality)
- Depth analysis (theoretical rigor, evidence quality)
- Structure analysis (logical flow, transitions)
- Bibliography analysis (citation density, source diversity)
- Integration with Perplexity (academic mode) and Memory MCP
- Automatic document location (pdfs/, writing/, extractions-mineru/)

**Documentation**: `.claude/commands/academic-enhance-fr.md`

**Example Usage**:
```
/academic-enhance-fr "chapter-03-ethnobotany.pdf"
```

## Expected ROI (From ACADEMIC-TOOLS-IMPLEMENTATION.md)

| Tool | Time Saved | Use Case |
|------|------------|----------|
| LanguageTool | 30 hours | Real-time grammar correction |
| VOSviewer | 8-10 hours | Literature structure analysis |
| Zotero | 15-20 hours | Bibliography management |
| Obsidian | 10-15 hours | Synthesis and knowledge mapping |

**Total**: 63-75 hours saved over 120,000-word thesis
**ROI**: 5.3× to 7.9× return on 9.5-12 hour setup investment

## Compliance & Privacy

✅ **All tools local** (FPIC-compliant):
- LanguageTool: Java-based, runs locally
- Zotero: Local database, optional sync
- Obsidian: Local vault, optional sync
- VOSviewer: Desktop application

❌ **Avoid cloud tools**: Connected Papers, Research Rabbit (privacy risk for indigenous knowledge)

## Next Steps Summary

### Week 1 (Immediate)
1. ✅ LanguageTool installed and validated
2. ⚠️ VOSviewer manual download
3. ⏳ Zotero Better BibTeX setup
4. ⏳ Obsidian vault creation

### Week 2 (Configuration)
1. Custom Grammalecte dictionary (200+ terms)
2. Zotero corpus import (142 papers)
3. Obsidian literature notes (systematic review)
4. VOSviewer citation network analysis

### Week 3 (Integration)
1. Daily writing workflow with LanguageTool
2. Citation network figures for Chapter 1
3. Obsidian knowledge graph for synthesis
4. Bibliography sync automation

## Documentation

- **Complete setup guide**: `docs/ACADEMIC-TOOLS-IMPLEMENTATION.md`
- **Existing workflow guide**: `tools/guides/01-literature-workflow-setup.md`
- **Academic plugin setup**: `docs/ACADEMIC-PLUGINS-SETUP.md`
- **Installation summary**: `docs/INSTALLATION-SUMMARY-2025-10-18.md`
