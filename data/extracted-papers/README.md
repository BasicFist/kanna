# Extracted Papers Directory

This directory contains structured data extracted from PDF papers using **MinerU**.

## Purpose

Store machine-readable outputs (markdown, JSON) from scientific PDFs for:
- Data extraction (IC50 values, clinical outcomes)
- Formula preservation (LaTeX format)
- Table conversion (HTML → CSV)
- Text corpus building for RAG/LLM analysis

## Usage

### Extract Single PDF
```bash
magic-pdf -p literature/pdfs/paper.pdf -o data/extracted-papers/
```

### Batch Extraction
```bash
for pdf in literature/pdfs/*.pdf; do
    magic-pdf -p "$pdf" -o data/extracted-papers/
done
```

### Expected Output Structure
```
data/extracted-papers/
├── paper-1/
│   ├── paper-1.md          # Full text in markdown
│   ├── paper-1.json        # Structured metadata
│   ├── images/             # Extracted figures
│   └── tables/             # Extracted tables (HTML)
├── paper-2/
│   └── ...
```

## Integration

**Link to Thesis Chapters**:
- Chapter 2 (Taxonomy): Extract nomenclature tables
- Chapter 4 (Pharmacology): Extract IC50/EC50 data, receptor binding tables
- Chapter 5 (Clinical): Extract patient demographics, outcome measures

**Workflow**:
1. Elicit → Download PDFs to `literature/pdfs/`
2. MinerU → Extract to `data/extracted-papers/`
3. Python/R → Parse JSON/markdown for analysis
4. Obsidian → Link extracted concepts to knowledge graph
5. Zotero → Cite original sources

## Notes

- **Git Status**: Directory contents are gitignored (large files)
- **Backup**: Included in daily backup script (`tools/scripts/daily-backup.sh`)
- **Citation**: Remember to cite original papers, not extracted data
- **Quality**: Always verify extracted formulas/tables against original PDFs

## MinerU Documentation

- GitHub: https://github.com/opendatalab/MinerU
- Paper: Wang, B., et al. (2024). MinerU: An Open-Source Solution for Precise Document Content Extraction. arXiv:2409.18839
- Install: `pip install magic-pdf[full]`
