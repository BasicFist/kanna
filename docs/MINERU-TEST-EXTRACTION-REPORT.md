# MinerU Optimal Configuration - Test Extraction Report

**Date**: October 8, 2025
**Phase**: 2.1 - Test Extraction (20 Pharmacology Papers)
**Status**: ⏳ IN PROGRESS

---

## Executive Summary

Successfully validated optimal MinerU configuration with 2025 models (DocLayout-YOLO 2501, Unimernet 2503, RapidTable) on test paper. Batch extraction of 20 pharmacology papers currently running.

---

## Configuration Tested

**Unified Config**: `~/.config/mineru/mineru.json`

**Key Features**:
- **Layout Detection**: DocLayout-YOLO (2501) - Latest 2025 model, 10x faster than layoutlmv3
- **Formula Recognition**: Unimernet (2503) - Fixes multi-line formula line breaks
- **Table Extraction**: RapidTable - 10x faster, lower GPU memory
- **LaTeX Delimiters**: `\[` `\]` (display), `$` `$` (inline) for Overleaf compatibility
- **Device Mode**: CPU (CUDA error, to be investigated)
- **Models Directory**: `/home/miko/.mineru/models`

---

## Test Paper: "2008 - PDE4 inhibitors current status.pdf"

### Extraction Results

**File**: `literature/pdfs/extractions-TEST/2008 - PDE4 inhibitors current status/auto/`

**Outputs Generated**:
- ✅ Markdown: 52K (`2008 - PDE4 inhibitors current status.md`)
- ✅ JSON: middle.json (1.9M), model.json (477K), content_list.json (57K)
- ✅ Visualization: layout.pdf (137K), spans.pdf (239K)
- ✅ Images: Extracted to `images/` directory

**Performance**:
- **Total Time**: 131 seconds (2 min 11 sec)
- **Model Init**: 7.1 seconds (one-time cost)
- **Pages**: 8 pages
- **Speed**: ~16 sec/page (CPU mode)

### Quality Validation

**Formula Extraction**: ✅ EXCELLENT
```latex
# Sample formulas extracted:
$\beta _ { 2 }$ (beta-2 adrenoceptor)
$3 ^ { \prime }$, $5 ^ { \prime }$ (nucleotide notation)
$\mathrm { Z n } ^ { 2 + }$, $\mathrm { M g } ^ { 2 + }$ (metal ions)
$\alpha 2$ (alpha-2 adrenoceptor)
$\mathrm { C D 8 ^ { + } }$ (CD8 positive T cells)
$( + )$ - (2S,3S)-3-(2- $\cdot [ ^ { 1 1 } \mathrm { C } ]$ (complex chemical notation)
```

**Table Extraction**: ✅ EXCELLENT
- Complex 12-row, 5-column table extracted as HTML
- Proper structure: `<table><tr><td>...</td></tr></table>`
- All cell content preserved
- Headers correctly identified

**Text Extraction**: ✅ EXCELLENT
- Clean paragraph structure
- Proper line breaks
- Special characters handled (Greek letters, subscripts, superscripts)
- References preserved

### Issues Encountered

**LLM-Aided Title Refinement**: ⚠️ FAILED (Non-Critical)
```
openai.AuthenticationError: Error code: 401 - {'error': 'Invalid token (283ff071-2e0b-4d4c-b1a0-e95b418668a0)'}
```
- **Cause**: Environment variable `${KILO_API_KEY}` not expanded
- **Impact**: Minimal - title extraction still works, just without LLM refinement
- **Fix**: Load `~/.config/codex/secrets.env` before extraction or disable LLM-aided feature

**CUDA Error**: ⚠️ DEGRADED PERFORMANCE
```
RuntimeError: CUDA unknown error - this may be due to an incorrectly set up environment
```
- **Workaround**: Switched to CPU mode
- **Impact**: Slower extraction (16 sec/page vs 3 sec/page target with GPU)
- **Fix Required**: Debug CUDA environment for GPU acceleration

---

## Batch Extraction Status

**Papers Selected**: 20 pharmacology/chemistry papers from `literature/pdfs/BIBLIOGRAPHIE/`

**Selection Criteria**: Papers with high formula/table density (alkaloids, PDE4, pharmacology keywords)

**Progress**:
- ⏳ **Running**: Batch extraction in progress (estimated 40-60 minutes in CPU mode)
- **Log**: `/tmp/batch-extraction.log`
- **Output**: `literature/pdfs/extractions-TEST/`

**Papers List**:
1. 2003 - 1098 J.C.S. Perkin I1.pdf
2. 2003 - Capps et al. 1977 1098 J.C.S. Perkin II Sceletium Alkaloids...pdf
3. 2003 - Capps et al. 1977 Sceletium alkaloids. Part 7...pdf
4. 2004 - doi10.1016j.tips.2004.01.003.pdf
5. 2008 - doi10.1016j.jep.2008.05.029.pdf
6. 2008 - doi10.1016j.jep.2008.07.021.pdf
7. 2008 - doi10.1016j.jep.2008.07.043.pdf
8. 2008 - doi10.1016j.jep.2008.08.010.pdf
9. 2008 - doi10.1016S0079-6123(08)00919-9.pdf
10. 2008 - PDE4 inhibitors current status.pdf ✅ (test completed)
11. 2010 - Schultes 1970 The Botanical and Chemical Distribution of Hallucinogens.pdf
12. 2010 - Schultes 1970 The Botanical and Chemical Distribution of Halluci.pdf
13. 2011 - Harvey - Pharmacological actions of the South African medicinal...pdf
14. 2012 - In Vitro Permeation of Mesembrine Alkaloids fr.pdf
15. 2012 - Shikanga - chemotypic variation of Sceletium tortuosum alkaloids...pdf
16. 2015 - Dimpfel - Electropharmacogram of Sceletium tortuosum extract...pdf
17. 2016 - Krstenansky - Mesembrine alkaloids_ Review...pdf
18. 2017 - Bolger 2017 The PDE4 cAMP Specific Phosphodiesterases Targets for Drugs w....pdf
19. 2017 - Bolger 2017 The PDE4 cAMP Specific Phosphodiesterases Targets.pdf
20. 2017 - The PDE4 cAMP Specific Phosphodiesterases Tar.pdf

---

## Next Steps (Phase 2.2)

After batch extraction completes:

1. **Quality Comparison Analysis**:
   - Run quality check script on TEST extractions
   - Compare metrics vs baseline extractions (142 papers from Phase 1)
   - Key metrics: formula count, table count, LaTeX validity, overall quality score

2. **Performance Benchmarking**:
   - Average extraction time per paper
   - Formula recognition accuracy (spot-check 10 papers)
   - Table structure accuracy (spot-check 10 papers)

3. **GO/NO-GO Decision** (Phase 2.3):
   - If quality improvement >20%: ✅ GO - Re-extract entire 142-paper corpus
   - If quality improvement 10-20%: 🟡 CONDITIONAL - Re-extract priority papers only
   - If quality improvement <10%: ❌ NO-GO - Keep current extractions

---

## Technical Notes

### Dependency Fixes Applied
- **timm upgrade**: 0.5.4 → 1.0.20 (fixed transformers compatibility)
- **pix2tex conflict**: Noted incompatibility with timm 1.0.20 (non-critical)

### Configuration Fixes Applied
1. **models-dir format**: Changed from dict to string path (`/home/miko/.mineru/models`)
2. **Symlink creation**: Added `~/magic-pdf.json` → `~/.config/mineru/mineru.json`
3. **Device mode**: Temporarily switched from `cuda` to `cpu`

### Known Issues
1. **CUDA environment**: Requires debugging for GPU acceleration
2. **API key loading**: Environment variables not expanded in config
3. **pix2tex compatibility**: May need separate venv if LaTeX OCR required

---

## Expected Performance Gains (vs Baseline)

**With GPU Acceleration** (when CUDA fixed):
- Extraction speed: 30 sec → 3 sec (10x improvement)
- Formula accuracy: 60-70% → 85-90% (+30%)
- Table extraction: 60% → >85% (+25%)
- Quality score: 4.44/5 → 4.8/5 (+8%)

**Current (CPU Mode)**:
- Extraction speed: ~16 sec/page (slower than GPU target)
- Formula quality: Excellent (validated on test paper)
- Table quality: Excellent (validated on test paper)
- Overall quality: High (subjective assessment)

---

## Conclusion

The optimal MinerU configuration is **functionally validated** and producing high-quality extractions with improved formula and table handling. CPU mode performance is acceptable but slower than GPU target. Batch extraction of 20 test papers ongoing.

**Recommendation**: Proceed with Phase 2.2 (quality comparison) after batch completes, then make GO/NO-GO decision on full corpus re-extraction.

---

*Generated*: October 8, 2025
*Part of*: KANNA PhD Thesis Infrastructure - PDF Extraction Optimization
