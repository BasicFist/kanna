# Phase 3 - Diverse Paper Validation Plan

**Date**: October 9, 2025
**Objective**: Validate LLM integration across diverse paper types before production deployment
**Rationale**: Capps 1977 is chemistry-heavy; need to test on ethnobotany, botany, clinical, and review papers

---

## Validation Set Selection (7 Papers)

### 1. **Chemistry-Heavy** (Baseline - similar to Capps 1977)
**Paper**: Meyer et al. 2015 - GC MS, LC MSn, LC high resolution MSn, and NMR
**Year**: 2014
**Type**: Analytical chemistry
**Expected formula density**: Very high (mass spec, NMR, chromatography)
**Why**: Validates performance on similar chemistry-heavy papers

### 2. **Ethnobotany** (Low chemistry content)
**Paper**: Sobiecki 2014 - Ethnobotanical survey
**Year**: 2014
**Type**: Ethnobotanical methods
**Expected formula density**: Low (mainly descriptive, possibly some statistics)
**Why**: Tests performance on papers with minimal chemical formulas

### 3. **Botany/Taxonomy** (Conceptual + some data)
**Paper**: Correlates of hyperdiversity in southern African ice plants (Aizoaceae)
**Year**: 2013
**Type**: Botanical taxonomy and ecology
**Expected formula density**: Low-moderate (statistical formulas, no chemistry)
**Why**: Different formula types (statistical models, not chemical structures)

### 4. **Pharmacology Review** (Moderate chemistry)
**Paper**: Krstenansky 2016 - Mesembrine alkaloids: Review
**Year**: 2016
**Type**: Comprehensive review
**Expected formula density**: Moderate (chemical structures, some pharmacological data)
**Why**: Mix of chemistry and pharmacology notation

### 5. **Clinical Trial** (Medical notation)
**Paper**: Nell 2013 - Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial
**Year**: 2013
**Type**: Clinical research
**Expected formula density**: Low (statistical formulas, medical notation, dosages)
**Why**: Different notation style (clinical vs chemistry)

### 6. **Classic Review** (Older format)
**Paper**: Schultes 1970 - The Botanical and Chemical Distribution of Hallucinogens
**Year**: 1970 (scanned in 2010)
**Type**: Classic ethnobotanical review
**Expected formula density**: Moderate (chemical structures, older notation)
**Why**: Tests OCR quality on older paper, different formatting era

### 7. **Psychiatry/Conceptual** (Minimal formulas)
**Paper**: Novel psychoactive substances of interest for psychiatry
**Year**: 2015
**Type**: Psychiatric review
**Expected formula density**: Very low (conceptual, minimal chemistry)
**Why**: Edge case - what happens when there are few/no formulas?

---

## Validation Metrics

For each paper, we'll measure:

1. **Formula Extraction Quality**
   - Total formulas detected
   - Formula density (formulas per page)
   - Error types (parentheses, brackets, braces, complex notation)

2. **LLM Performance**
   - Errors detected by Layer 2
   - Corrections applied (count, confidence distribution)
   - Final accuracy (estimated from sample validation)

3. **Category Distribution**
   - Mass spectrometry vs NMR vs statistical vs other
   - Domain-specific vs general chemistry
   - New categories not seen in Capps 1977?

4. **Edge Cases**
   - Papers with very few formulas (< 10)
   - Papers with very many formulas (> 500)
   - Non-chemistry notation (statistics, medical)

---

## Expected Outcomes

### Success Criteria

**Minimum acceptance**:
- Average accuracy across 7 papers: ≥ 97%
- No catastrophic failures (< 90% on any paper)
- False correction rate: < 1%
- LLM handles new formula types appropriately

**Ideal outcome**:
- Average accuracy: 98-100%
- Consistent performance across paper types
- New categories handled well (statistics, medical notation)
- Confidence scores remain reliable

### Risk Factors

**Potential issues**:
1. **Statistics formulas**: Different notation (p-values, t-tests, regression)
   - May require new prompt category
2. **Medical dosages**: mg/kg, mL notation without chemistry context
   - General chemistry prompt should handle
3. **Older papers**: OCR quality may be lower for 1970s papers
   - May have more structural errors overall
4. **Low formula density**: Papers with < 10 formulas
   - Less statistical confidence, but should still work

---

## Validation Workflow

### Phase 1: Extraction (if needed)
```bash
# Check if papers already extracted
ls literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008/

# Extract missing papers
conda activate mineru
for paper in SELECTED_PAPERS; do
    magic-pdf -p "$paper" -o extractions/ -m auto
done
```

### Phase 2: Layer 1 Refinement
```bash
conda activate kanna
python tools/scripts/layer1-formula-refinement.py \
  INPUT_DIR OUTPUT_DIR --validate
```

### Phase 3: Layer 2 Validation (Rule-based)
```bash
python tools/scripts/layer2-sequential-validation.py \
  INPUT_DIR OUTPUT_DIR --confidence-threshold 0.7
```

### Phase 4: LLM Corrections
- Extract remaining errors from each paper
- Apply MCP Sequential tool corrections
- Document confidence scores and categories

### Phase 5: Analysis
- Compare accuracy across papers
- Identify new error patterns
- Assess confidence score reliability
- Recommend adjustments if needed

---

## Timeline

**Estimated duration**: 3-4 hours

- Paper extraction (if needed): 30 min
- Layer 1+2 processing: 10 min per paper = 70 min
- LLM corrections: 20 min per paper = 140 min
- Analysis & documentation: 60 min

**Total**: ~280 minutes (~4.7 hours)

---

## Deliverables

1. **Multi-Paper Validation Report**
   - Accuracy by paper type
   - Formula density analysis
   - Error pattern comparison
   - Confidence score distribution

2. **Updated Prompt Templates** (if needed)
   - New category for statistics formulas
   - Medical notation handling
   - Adjustments based on findings

3. **Production Deployment Decision**
   - Go/No-Go recommendation
   - Risk assessment
   - Any required optimizations

---

**Status**: Planning complete | Ready to begin validation
**Next**: Extract/verify 7 papers are available
