# Priority Papers for Phase 3 (LaTeX-OCR Enhancement)

**Generated**: October 7, 2025
**Purpose**: List of papers requiring re-extraction with LaTeX-OCR for enhanced formula accuracy

---

## Category 1: Formula-Heavy Papers (LaTeX-OCR Priority)

These papers have chemical formulas that would benefit from 88% accurate LaTeX-OCR recognition:

### High Priority (10+ formulas)
1. **2014 - Meyer et al. GC MS, LC MSn** - 10 formulas
   - Location: `chapter-04-pharmacology/`
   - Content: Chemical analysis, likely IC₅₀ data
   - Expected improvement: 30-40% formula accuracy gain

### Medium Priority (5 formulas)
2. **2003 - 1098 J.C.S. Perkin I1** - 5 formulas
   - Location: `chapter-04-pharmacology/`
   - Content: Alkaloid structure elucidation

3. **2003 - Capps et al. 1098 J.C.S. Perkin II Sceletium** - 5 formulas
   - Location: `chapter-04-pharmacology/`
   - Content: Sceletium alkaloids structural analysis

4. **2003 - Capps et al. Sceletium alkaloids Part 7** - 5 formulas
   - Location: `chapter-04-pharmacology/`
   - Content: Structure and absolute configuration

### Low Priority (1-2 formulas)
5. **2011 - Wyk - potential of South African plants** - 1 formula
   - Location: `uncategorized/`
   - Content: Review paper

6. **2011 - potential of South African plants in development** - 1 formula
   - Location: `uncategorized/`
   - Content: Development perspectives (duplicate?)

7. **2012 - In Vitro Permeation of Mesembrine Alkaloids** - 1 formula
   - Location: `chapter-04-pharmacology/`
   - Content: Permeation studies

8. **2012 - Shikanga - chemotypic variation** - 1 formula
   - Location: `chapter-04-pharmacology/`
   - Content: Chemotype classification

---

## Category 2: Low Quality Papers (Re-extraction Priority)

These papers scored <6/8 and need re-extraction for structural issues:

### Score 4/8 (Critical)
1. **2015 - Pickard - Alternative models of addiction** - Score: 4/8
   - Location: `chapter-06-addiction/`
   - Issues: Poor structure (only 2 headings), 1366 words
   - Recommendation: Manual review + re-extract with higher OCR confidence

### Score 5/8 (High)
2. **2007 - 06_Low.indd** - Score: 5/8
   - Location: `uncategorized/`
   - Issues: Missing visualization PDF
   - Size: 12,622 words (decent content)

3. **2013 - Torregrossa and Taylor - Learning to forget** - Score: 5/8
   - Location: `uncategorized/`
   - Issues: Missing visualization PDF
   - Size: 11,719 words (decent content)

4. **2015 - Novel psychoactive substances** - Score: 5/8
   - Location: `chapter-06-addiction/`
   - Issues: Missing visualization PDF
   - Size: 9,811 words (decent content)

---

## Recommended Extraction Order

### Phase 3A: Formula Enhancement (4-6 hours)
1. Meyer et al. (2014) - 10 formulas, highest ROI
2. Capps et al. papers (2003) - 3 papers, 15 formulas total
3. In Vitro Permeation (2012) - 1 formula
4. Shikanga (2012) - 1 formula

**Total**: 6 papers, ~18 formulas to enhance
**Expected output**: IC₅₀ equations, QSAR formulas, chemical structures validated

### Phase 3B: Quality Re-Extraction (2-3 hours)
1. Pickard (2015) - Critical quality issue
2. 06_Low (2007) - Large file, missing artifacts
3. Torregrossa (2013) - Neurobiology paper, missing artifacts
4. Novel psychoactive (2015) - Chapter 6 relevance

**Total**: 4 papers
**Expected output**: Improved structure preservation, complete visualization PDFs

---

## Success Metrics

**Formula Accuracy Target**:
- Current: 60-70% baseline (MinerU)
- Target: 88% with LaTeX-OCR
- Net improvement: +18-28%

**Quality Score Target**:
- Current low-quality papers: 4-5/8
- Target after re-extraction: 6-7/8
- Net improvement: +1-2 points

---

## Notes

- All priority papers are in Chapters 4-6 (pharmacology, clinical, addiction)
- Formula-heavy papers align with QSAR modeling needs (Chapter 4)
- Low-quality papers primarily have missing artifacts, not content issues
- 24 papers remain "uncategorized" - may need manual classification

**Next Actions**:
1. Complete GPU batch extraction (Phase 2) for remaining 94 papers
2. Re-extract these 10 priority papers with hybrid pipeline (Phase 3)
3. Run full quality validation on 142-paper corpus (Phase 4)
