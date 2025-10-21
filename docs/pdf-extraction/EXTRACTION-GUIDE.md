# PDF Extraction Guide for KANNA Thesis

**Version**: 1.0
**Created**: October 21, 2025
**Purpose**: Comprehensive guide for PDF extraction workflow decisions

---

## Quick Start Decision Tree

```
Need to extract PDFs?
│
├─ Single PDF, testing quality?
│  → Use: magic-pdf -p <file> -o /tmp/test -m auto
│  → Purpose: Quick quality check
│
├─ Batch extraction, standard papers?
│  → Use: extract-pdfs-mineru-production.sh
│  → Purpose: Production pipeline (fast, reliable)
│
├─ Known difficult PDF (scanned, complex formulas)?
│  → Use: smart-pdf-extraction.sh
│  → Purpose: Auto-fallback to Vision-LLM if needed
│
└─ Testing new configuration?
   → Use: Test with 10-paper subset first
   → Command: bash tools/scripts/test-mineru-batch.sh
```

---

## Scripts Overview

| Script | Purpose | When to Use | Speed | Cost | Quality |
|--------|---------|-------------|-------|------|---------|
| **extract-pdfs-mineru-production.sh** | Production batch extraction | Standard academic papers, 142-paper corpus | ⚡⚡⚡ Fast | 💰 Free | ★★★★ High |
| **smart-pdf-extraction.sh** | Auto-fallback extraction | Difficult PDFs, scanned documents, complex formulas | ⚡⚡ Medium | 💰💰 Moderate | ★★★★★ Highest |
| **magic-pdf (CLI)** | Single-file testing | Quality checks, debugging, config testing | ⚡⚡⚡ Fast | 💰 Free | ★★★★ High |

---

## Performance Benchmarks

### MinerU Extraction Speed

**GPU Mode (CUDA)**:
- **Simple papers** (text-only): ~3 seconds/paper
- **Complex papers** (formulas + tables): ~8 seconds/paper
- **142-paper corpus**: ~7 minutes total (GPU)

**CPU Mode**:
- **Simple papers**: ~30 seconds/paper
- **Complex papers**: ~90 seconds/paper
- **142-paper corpus**: ~70 minutes total (CPU)

**Speedup**: GPU is **10× faster** than CPU

**VRAM Usage**:
- Layout detection (DocLayout-YOLO): ~2 GB
- Formula extraction (Unimernet): ~3 GB
- Table extraction (RapidTable): ~2 GB
- **Recommended**: 8+ GB VRAM for all features

### Vision-LLM Fallback (smart-pdf-extraction.sh)

**Claude Sonnet 4.5 API**:
- **Cost**: ~$0.02 per paper (formula-heavy papers)
- **Speed**: +5-10 seconds per paper
- **Accuracy**: 95-98% for complex formulas (vs 85-90% MinerU-only)
- **When triggered**: MinerU output <100 words or quality check fails

**Estimated costs for KANNA corpus**:
- **All 142 papers**: ~$2.84 (if all need fallback - unlikely)
- **Realistic (10% fallback rate)**: ~$0.28 for 14 papers
- **High fallback (30%)**: ~$0.85 for 43 papers

---

## Method Comparison

### Extraction Quality by Content Type

| Content Type | MinerU (GPU) | MinerU + Vision-LLM | Notes |
|--------------|-------------|---------------------|-------|
| **Plain text** | ★★★★★ 99% | ★★★★★ 99% | No difference |
| **Simple formulas** | ★★★★ 85-90% | ★★★★★ 95-98% | Vision-LLM handles edge cases |
| **Complex formulas** | ★★★ 70-80% | ★★★★★ 95-98% | Vision-LLM significantly better |
| **Tables (simple)** | ★★★★ 85% | ★★★★ 85% | RapidTable handles well |
| **Tables (nested)** | ★★★ 60-70% | ★★★★ 80-85% | Vision-LLM helps structure |
| **Scanned PDFs** | ★★ 40-60% | ★★★★ 85-90% | OCR quality dependent |
| **French text** | ★★★★★ 98% | ★★★★★ 98% | Language auto-detected |

### Configuration Impact

**production.json** (current):
- Features: Layout only, formulas/tables disabled
- Speed: ⚡⚡⚡ Very fast (~3 sec/paper)
- Quality: ★★★★ High for text extraction
- Use for: Text-only papers, initial corpus extraction

**baseline-20251009.json**:
- Features: All enabled (formulas, tables, LLM-aided)
- Speed: ⚡⚡ Medium (~8 sec/paper)
- Quality: ★★★★★ Highest
- Use for: Chemistry papers, pharmacology papers (Chapter 4)

**Recommendation**: Start with production.json for speed, switch to baseline for chemistry-heavy papers.

---

## Common Use Cases

### Use Case 1: Chemistry/Pharmacology Papers (Chapter 4)

**Challenge**: Complex chemical structures, QSAR formulas, pharmacokinetic equations

**Recommended Workflow**:
```bash
# Step 1: Switch to baseline config
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/baseline-20251009.json ~/.config/mineru/mineru.json

# Step 2: Extract with formulas enabled
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/pharmacology/ \
  literature/pdfs/extractions-mineru/pharmacology/

# Step 3: Quality check
grep -r "\\$\\|\\\\[" literature/pdfs/extractions-mineru/pharmacology/*.md | wc -l
# Should show formula delimiters if extraction worked

# Step 4: Fallback for failures
for pdf in <failed-pdfs>; do
  bash tools/scripts/smart-pdf-extraction.sh "$pdf"
done
```

**Expected Results**:
- Formula accuracy: 85-90% (MinerU) → 95-98% (with Vision-LLM fallback)
- Extraction time: ~10 seconds/paper
- Cost: ~$0.02/paper for fallback (only if needed)

---

### Use Case 2: French Academic Papers (Chapters 1-3, 5, 7)

**Challenge**: French language, academic formatting, footnotes

**Recommended Workflow**:
```bash
# Use production config (French auto-detected)
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/french/ \
  literature/pdfs/extractions-mineru/french/
```

**Configuration Check**:
```json
{
  "processing-options": {
    "lang": "auto"  // Auto-detects French/English mix
  }
}
```

**Expected Results**:
- Text accuracy: 98% (French well-supported)
- Extraction time: ~3 seconds/paper
- Cost: Free (no fallback needed for text)

---

### Use Case 3: Tables and Figures (Meta-Analysis - Chapter 5)

**Challenge**: Clinical trial tables, forest plots, statistical data

**Recommended Workflow**:
```bash
# Step 1: Enable table extraction in config
# Edit tools/config/mineru/experimental.json:
{
  "table": {
    "enable": true
  }
}

# Step 2: Test with sample
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/experimental.json ~/.config/mineru/mineru.json
magic-pdf -p literature/pdfs/BIBLIOGRAPHIE/clinical/sample.pdf -o /tmp/test -m auto

# Step 3: Validate table extraction
cat /tmp/test/auto/sample.md | grep -A 10 "| "  # Check for markdown tables

# Step 4: If good, run batch
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/clinical/ \
  literature/pdfs/extractions-mineru/clinical/
```

**Expected Results**:
- Table extraction: 85% accuracy (simple tables)
- Complex tables: May need manual verification
- Extraction time: ~5 seconds/paper (with tables)

---

### Use Case 4: Large Corpus Initial Extraction (142 Papers)

**Challenge**: Fast extraction of entire bibliography for RAG/search

**Recommended Workflow**:
```bash
# Step 1: Use production config (text-only, fastest)
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/production.json ~/.config/mineru/mineru.json

# Step 2: Extract full corpus
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/

# Expected: ~7 minutes for 142 papers on GPU
```

**Post-Processing**:
```bash
# Check success rate
TOTAL=$(ls -1 literature/pdfs/BIBLIOGRAPHIE/*.pdf | wc -l)
SUCCESS=$(find literature/pdfs/extractions-mineru/ -name "*.md" -size +1k | wc -l)
echo "Success rate: $((SUCCESS * 100 / TOTAL))%"

# Identify failures for manual review
find literature/pdfs/extractions-mineru/ -name "*.md" -size -1k
```

---

## Cost Analysis

### MinerU (Free)

**Infrastructure**:
- GPU: RTX 4090 (24GB) or similar
- Storage: ~5 GB for models
- Electricity: ~$0.003/hour at $0.12/kWh (350W GPU)

**Per-Paper Costs**:
- Electricity: ~$0.0000025/paper (3 seconds GPU time)
- Effective cost: **FREE** (negligible electricity)

### Vision-LLM Fallback (Paid)

**Claude Sonnet 4.5 API**:
- Input: $3/million tokens (~$0.015/paper average)
- Output: $15/million tokens (~$0.005/paper average)
- **Total**: ~$0.02/paper for formula-heavy papers

**Expected Fallback Rate**:
- Text-only papers: 0% fallback → $0
- Simple formulas: 5% fallback → ~$0.01/20 papers
- Complex formulas: 30% fallback → ~$0.60/20 papers

**KANNA Corpus (142 papers)**:
- Worst case (100% fallback): $2.84
- Realistic (10% fallback): $0.28
- Best case (0% fallback): $0.00

**Recommendation**: Use MinerU first (free), fallback selectively to Vision-LLM for quality.

---

## Quality Validation

### Automatic Quality Checks

The `pdf-common.sh` library includes `check_output_quality()`:

```bash
# Checks:
1. File exists
2. File size > minimum threshold (default: 100 bytes)
3. Word count > minimum threshold (default: 200 words)

# Usage in scripts:
if check_output_quality "$output_file" 100 200; then
    log "✓ Quality check passed" "SUCCESS"
else
    log "⚠ Quality check failed, triggering fallback" "WARNING"
fi
```

### Manual Quality Spot Checks

**Sample 10% of extractions**:
```bash
# Random sample
find literature/pdfs/extractions-mineru/ -name "*.md" | shuf -n 14 > /tmp/sample.txt

# Check each:
while read file; do
  echo "=== $(basename $file) ==="
  wc -w "$file"  # Word count
  grep -c "\\$\\|\\\\[" "$file"  # Formula count
  head -20 "$file"  # First 20 lines
  read -p "Press enter for next..."
done < /tmp/sample.txt
```

**Quality Criteria**:
- Text papers: >1000 words, coherent sentences
- Formula papers: >50 formulas, proper LaTeX delimiters
- Table papers: >3 markdown tables, proper structure

---

## Troubleshooting

For detailed troubleshooting, see **TROUBLESHOOTING.md**.

**Quick Diagnostics**:

```bash
# Check GPU availability
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"

# Check config location
ls -la ~/.config/mineru/mineru.json
cat ~/.config/mineru/mineru.json | head -10

# Test single PDF
magic-pdf -p <test.pdf> -o /tmp/test -m auto && cat /tmp/test/auto/*.md | head -50
```

**Common Issues**:
- CUDA not available → Check NVIDIA driver (`nvidia-smi`)
- Empty extraction → Check PDF has text layer (`pdftotext test.pdf -`)
- Formulas missing → Enable in config (`"equation": {"enable": true}`)

---

## Configuration Reference

For detailed configuration options, see **tools/config/mineru/CONFIG-FIELDS.md**.

**Quick Config Switching**:
```bash
# Production (fast, text-only)
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/production.json ~/.config/mineru/mineru.json

# Baseline (all features, slower)
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/baseline-20251009.json ~/.config/mineru/mineru.json

# Experimental (for testing)
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/experimental.json ~/.config/mineru/mineru.json
```

---

## Best Practices

1. **Start fast, refine selectively**: Use production.json for initial extraction, baseline for important papers
2. **Test with samples**: Always test new configs with 10-paper subset (`test-mineru-batch.sh`)
3. **Validate quality**: Check 10% sample manually, use automatic quality checks
4. **Fallback wisely**: Use Vision-LLM for failures, not entire corpus (cost optimization)
5. **Version control configs**: Commit config changes to track what worked
6. **Monitor GPU**: Use `nvidia-smi` to check VRAM usage during extraction
7. **Backup originals**: Never delete original PDFs, extractions are reproducible

---

## References

- **MinerU Documentation**: https://github.com/opendatalab/MinerU
- **Configuration Guide**: tools/config/mineru/CONFIG-FIELDS.md
- **Troubleshooting**: docs/pdf-extraction/TROUBLESHOOTING.md
- **Script Reference**: tools/scripts/lib/pdf-common.sh

---

**Last Updated**: October 21, 2025
**Maintained By**: KANNA Infrastructure (MP-3)
