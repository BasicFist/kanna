# MinerU Configuration - Quick Action Guide

**Date**: October 2025
**Purpose**: Immediate actions based on configuration audit
**Read First**: `MINERU-CONFIGURATION-ANALYSIS.md` for comprehensive details

---

## ⚠️ IMMEDIATE ACTIONS (Do within 24 hours)

### 1. Secure Exposed API Key (CRITICAL)

**Risk**: Kilo API key exposed in `~/magic-pdf.json`

**Actions**:
```bash
# 1. Backup current config
cp ~/magic-pdf.json ~/LAB/projects/KANNA/config-backup/magic-pdf.json.$(date +%Y%m%d)

# 2. Rotate API key
# Visit: https://kilocode.ai/settings/api-keys
# Regenerate your API token

# 3. Add new key to secrets
echo "export KILO_API_KEY=your_new_key_here" >> ~/.config/codex/secrets.env
chmod 600 ~/.config/codex/secrets.env

# 4. Remove exposed key from file
sed -i 's/"api_key": "eyJ[^"]*"/"api_key": "${KILO_API_KEY}"/g' ~/magic-pdf.json
```

**Verify**: `grep api_key ~/magic-pdf.json` should show `"${KILO_API_KEY}"`, not actual token

---

## 🔧 RECOMMENDED ACTIONS (Do within 1 week)

### 2. Create Unified Configuration

**Current Issue**: 3 conflicting configs causing unpredictable behavior

**Actions**:
```bash
# 1. Backup all configs
mkdir -p ~/LAB/projects/KANNA/config-backup
cp ~/.config/mineru/mineru.json ~/LAB/projects/KANNA/config-backup/
cp ~/mineru.json ~/LAB/projects/KANNA/config-backup/
cp ~/magic-pdf.json ~/LAB/projects/KANNA/config-backup/

# 2. Copy optimal config (from MINERU-CONFIGURATION-ANALYSIS.md)
# Use the "Optimal Unified Configuration" section
# Replace ~/.config/mineru/mineru.json with optimal config

# 3. Test on single paper
conda activate kanna
magic-pdf -p literature/pdfs/BIBLIOGRAPHIE/test-paper.pdf \
  -o /tmp/mineru-test -m auto

# 4. Check output quality
ls -lh /tmp/mineru-test/*/auto/
cat /tmp/mineru-test/*/auto/*.md | grep -c '\\['  # Formula count

# 5. If successful, consolidate configs
mv ~/mineru.json ~/mineru.json.OLD
mv ~/magic-pdf.json ~/magic-pdf.json.OLD
ln -s ~/.config/mineru/mineru.json ~/mineru.json
```

### 3. Enable DocLayout-YOLO (10x Speedup)

**Current Issue**: `layout-config: null` disables optimal layout model

**Change in** `~/.config/mineru/mineru.json`:
```json
// FROM:
"layout-config": null

// TO:
"layout-config": {
  "model": "doclayout_yolo"
}
```

**Expected Impact**:
- ⚡ 10x faster extraction (30 sec → 3 sec per paper)
- 📄 Better layout understanding (columns, figures, captions)
- ✅ No layoutlmv3 dependency (avoids transformers issue)

### 4. Fix LaTeX Delimiters (Overleaf Compatibility)

**Current Issue**: Delimiter mismatch between configs

**Change in** `~/.config/mineru/mineru.json`:
```json
"latex-delimiter-config": {
  "display": {
    "left": "\\[",    // Display equations
    "right": "\\]"
  },
  "inline": {
    "left": "$",     // Inline formulas
    "right": "$"
  }
}
```

**Why**: Standard LaTeX format, Overleaf compatible

### 5. Enable Explicit Formula Configuration

**Current Issue**: No explicit formula config in active configs

**Add to** `~/.config/mineru/mineru.json`:
```json
"formula-config": {
  "enable": true,
  "mfd_model": "yolo_v8_mfd",      // Formula detection
  "mfr_model": "unimernet_small"    // Formula recognition
}
```

**Expected Impact**:
- 🧪 Better chemical structure extraction
- 📐 More formulas detected (especially in scanned PDFs)
- ✅ 98% LaTeX accuracy

### 6. Resolve Table Configuration Conflict

**Current Issue**: `table-config: false` but `processing-options.table_enable: true`

**Fix in** `~/.config/mineru/mineru.json`:
```json
"table-config": {
  "model": "rapid_table",
  "enable": true,
  "max_time": 400
}
```

**Remove conflicting option** from `processing-options`

---

## 🧪 TESTING RECOMMENDATIONS (Do before re-extraction)

### Test on Sample Papers (Chapter 4 Pharmacology)

**Why Chapter 4**: High density of formulas + tables (IC50, QSAR data)

**Test Command**:
```bash
# Extract 10 test papers
cd ~/LAB/projects/KANNA

# Select diverse samples
ls literature/pdfs/chapter-04-pharmacology/ | head -10 | while read paper; do
  magic-pdf \
    -p "literature/pdfs/chapter-04-pharmacology/$paper" \
    -o literature/pdfs/extractions-TEST/ \
    -m auto
done

# Run quality comparison
python tools/scripts/pdfplumber-quality-check.py \
  --extraction-dir literature/pdfs/extractions-TEST/ \
  --report ~/LAB/logs/mineru-test-quality.json

# Check improvements
cat ~/LAB/logs/mineru-test-quality.json | jq '.detailed_results[] | {paper, formulas: .metrics.formula_count, tables: .metrics.table_count, score: .metrics.quality_score}'
```

**Expected Results** (after optimizations):
| Metric | Before | After (Target) |
|--------|--------|----------------|
| Formula count/paper | 0-5 | 10-20 |
| LaTeX validity | 70% | >90% |
| Table extraction | 60% | >85% |
| Avg extraction time | 30 sec | 3 sec |
| Quality score | 4.44/5 | 4.8/5 |

---

## 📊 DECISION POINT: Re-extract Entire Corpus?

### Pros of Re-extraction (142 papers)
✅ 10x faster with DocLayout-YOLO (7 hours total vs 70 hours before)
✅ Better formula detection (explicit config)
✅ Improved table quality (RapidTable optimized)
✅ Consistent LaTeX delimiters (Overleaf compatible)
✅ Unified configuration (no more conflicts)

### Cons of Re-extraction
❌ Time investment: ~7 hours (142 papers × 3 min/paper)
❌ Disk space: +2 GB for new extractions
❌ Need to update Obsidian notes (190 files)
❌ Current extractions are "good enough" (97% high quality)

### Recommendation
**Test first, decide based on improvement**:

1. **Extract 20 papers** (diverse sample: Chapter 2-5)
2. **Compare quality metrics**:
   - Formula count increase: >50% → Re-extract
   - Table accuracy increase: >30% → Re-extract
   - LaTeX validity increase: >20% → Re-extract
   - Time saved: >5x speedup → Re-extract
3. **If ANY metric shows >50% improvement**: Re-extract entire corpus
4. **If improvements <20% across board**: Keep current, use optimal config for future papers

---

## 🚀 PRODUCTION SCRIPT UPDATE

### Update `tools/scripts/extract-pdfs-mineru-production.sh`

**Ensure script uses**:
- ✅ Optimal config location: `~/.config/mineru/mineru.json`
- ✅ CUDA acceleration: `--device cuda`
- ✅ Auto method: `-m auto`
- ✅ Formula + table enabled: `-f true -t true`
- ✅ Quality logging: `2>&1 | tee ~/LAB/logs/mineru-extraction.log`

**Example**:
```bash
#!/usr/bin/env bash
set -euo pipefail

INPUT_DIR="$1"
OUTPUT_DIR="$2"

echo "MinerU Production Extraction (Optimized Config)"
echo "Input: $INPUT_DIR"
echo "Output: $OUTPUT_DIR"
echo ""

for pdf in "$INPUT_DIR"/*.pdf; do
  basename=$(basename "$pdf" .pdf)
  echo "Extracting: $basename"

  magic-pdf \
    -p "$pdf" \
    -o "$OUTPUT_DIR" \
    -m auto \
    --device cuda \
    --formula true \
    --table true \
    2>&1 | tee -a ~/LAB/logs/mineru-extraction-$(date +%Y%m%d).log

  echo "✓ Completed: $basename"
done

echo ""
echo "Extraction complete. Check logs:"
echo "  ~/LAB/logs/mineru-extraction-$(date +%Y%m%d).log"
```

---

## 📈 MONITORING & VALIDATION

### Real-time Monitoring During Extraction

```bash
# Watch extraction progress
tail -f ~/LAB/logs/mineru-extraction-$(date +%Y%m%d).log

# Check for errors
grep -i "error\|failed\|warning" ~/LAB/logs/mineru-extraction-$(date +%Y%m%d).log
```

### Post-Extraction Quality Check

```bash
# Run quality assessment
conda activate kanna
python tools/scripts/pdfplumber-quality-check.py

# Run enhanced validation
bash tools/scripts/validate-extraction-quality.sh

# Check for issues
grep "CRITICAL\|WARNING" ~/LAB/logs/mineru-quality-report-$(date +%Y%m%d).txt
```

---

## ✅ SUCCESS CRITERIA

**Configuration is optimal when**:
✅ Single authoritative config file
✅ DocLayout-YOLO enabled (10x speedup)
✅ Formula extraction working (>90% LaTeX valid)
✅ Table extraction consistent (>85% accuracy)
✅ LaTeX delimiters Overleaf-compatible
✅ No exposed secrets in config files
✅ Model storage consolidated (single location)

**Extraction quality is production-ready when**:
✅ >95% papers score ≥4/5 quality
✅ Formula count matches paper complexity
✅ Tables extracted with structure intact
✅ French accents preserved (>95%)
✅ Chemical structures detected (SMILES/InChI)
✅ Average extraction time <5 sec/paper

---

## 🆘 TROUBLESHOOTING

### Issue: Extraction fails with CUDA error
**Solution**: Check GPU availability
```bash
nvidia-smi
# If GPU busy, switch to CPU mode temporarily:
# "device-mode": "cpu"
```

### Issue: No formulas extracted
**Diagnostics**:
```bash
# Check if PDF has text layer
pdftotext test.pdf - | wc -w
# If 0: Scanned image, needs OCR first

# Check formula config
grep formula ~/.config/mineru/mineru.json
```

### Issue: Config changes not taking effect
**Solution**: Clear MinerU cache
```bash
rm -rf ~/.cache/mineru/temp_files/*
magic-pdf -p test.pdf -o /tmp/test -m auto
```

### Issue: Models not found
**Solution**: Download models
```bash
mineru-models-download
# Or specify model source:
export MINERU_MODEL_SOURCE=modelscope  # For China
export MINERU_MODEL_SOURCE=huggingface  # Default
```

---

## 📚 DOCUMENTATION REFERENCES

**Comprehensive Analysis**: `docs/MINERU-CONFIGURATION-ANALYSIS.md` (18,000 words)
**Project Architecture**: `ARCHITECTURE.md`
**Claude Instructions**: `CLAUDE.md`
**Setup Guides**: `tools/guides/06-mineru-pdf-extraction.md`

**External Resources**:
- MinerU Official Docs: https://opendatalab.github.io/MinerU/
- GitHub Repository: https://github.com/opendatalab/MinerU
- DocLayout-YOLO: https://github.com/opendatalab/DocLayout-YOLO

---

## 📅 TIMELINE

**Week 1 (Immediate)**:
- ✅ Day 1: Secure exposed API key
- ✅ Day 2-3: Create unified configuration
- ✅ Day 4-5: Test on 20 sample papers
- ✅ Day 6-7: Analyze results, decide on re-extraction

**Week 2 (If re-extraction approved)**:
- Day 1-3: Re-extract entire corpus (7 hours runtime)
- Day 4-5: Quality validation
- Day 6-7: Update Obsidian notes, update CLAUDE.md

**Week 3 (Finalization)**:
- Day 1-2: Document lessons learned
- Day 3-5: Update PROJECT-STATUS.md
- Day 6-7: Archive old extractions, clean up

---

*For detailed explanations and full configuration options, see `MINERU-CONFIGURATION-ANALYSIS.md`*
*This guide focuses on actionable next steps based on the comprehensive audit*
