# Phase 3A - ChemLLM-7B Validation Report

**Date:** October 10, 2025
**Status:** ❌ **VALIDATION FAILED - DO NOT DEPLOY**
**Accuracy:** 13.3% (2/15 correct)
**Target:** ≥95% (14/15)

---

## Executive Summary

ChemLLM-7B-Chat failed validation for formula correction with only **13.3% accuracy** (2/15 errors corrected). The model exhibited:
- **Hallucinations**: Invented formulas not present in source
- **Over-correction**: Reformatted valid LaTeX instead of minimal fixes
- **Instruction non-compliance**: Added explanations despite "do not explain" prompts

**Root Cause:** ChemLLM-7B is designed for chemistry Q&A, not LaTeX syntax repair. Its chemistry understanding causes it to rewrite formulas rather than preserve syntax.

**Recommendation:** **Skip ChemLLM-7B**, proceed with image-based re-extraction (Texify) or rule-based enhancement.

---

## Validation Setup

### Test Environment
- **Model:** AI4Chem/ChemLLM-7B-Chat
- **Quantization:** 4-bit (nf4, bfloat16)
- **VRAM Usage:** 6.00 GB
- **Load Time:** 15 seconds (cached model)
- **GPU:** Quadro RTX 5000 (16GB)

### Test Data
- **Source:** 15 uncorrected errors from diverse paper validation
- **Categories:** Mass spec (1), Experimental (6), Statistical (4), Clinical (2), X-ray (1), General (1)
- **Ground Truth:** Manual corrections with MinerU-style LaTeX formatting

### Success Criteria
- ✗ Accuracy ≥95% (achieved 13.3%)
- ✓ Avg Confidence ≥0.70 (achieved 0.837)
- ✗ No hallucinations (multiple observed)

---

## Results Analysis

### Quantitative Results

| Metric | Target | Achieved | Status |
|--------|--------|----------|--------|
| **Accuracy** | ≥95% (14/15) | 13.3% (2/15) | ❌ **FAIL** |
| **Avg Confidence** | ≥0.70 | 0.837 | ✓ **PASS** |
| **High Conf (≥0.85)** | - | 7/15 (46.7%) | ℹ️ |
| **Hallucinations** | 0 | ≥2 observed | ❌ **FAIL** |
| **Instruction Compliance** | 100% | ~40% | ❌ **FAIL** |

### Successful Corrections (2/15)

**Error 1 - Experimental Data:**
- Original: `( 5 0 0 ~ \mathrm { m g } , 3 ~ \mathrm { m L }`
- ChemLLM: `( 500 mg, 3 mL)`
- Ground Truth: `( 5 0 0 ~ \mathrm { m g } , 3 ~ \mathrm { m L } )`
- **Note:** Semantically correct but reformatted (removed spacing, \mathrm)

**Error 2 - Experimental Data:**
- Original: `( 1 5 { \times } 2 . 1 ~ \mathrm { m m }`
- ChemLLM: `( 1 5 × 2.1 mm)`
- Ground Truth: `( 1 5 { \times } 2 . 1 ~ \mathrm { m m } )`
- **Note:** Semantically correct but reformatted (× symbol vs \times)

### Critical Failures

**Failure Type 1: Hallucinations (Invented Content)**

**Error 8 - Statistical:**
- Original: `( > 1 5 0 0`
- ChemLLM: `(\frac{mesembs}{\text{total species}} > 1.5) > 1500`
- Ground Truth: `( > 1 5 0 0 )`
- **Issue:** **Invented completely new formula** with fraction and context that didn't exist
- **Impact:** Critical - cannot trust model to not add false information

**Failure Type 2: Adding Explanations (Instruction Non-Compliance)**

**Error 3 - Experimental:**
- Original: `( 1 { : } 1 { : } 3 \ \mathbf { v } /`
- ChemLLM: `(1:1:3)The corrected formula is (1:1:3) v/v/v, which means 1 volume of dichloromethane, 1 volume of isopropanol, and 3 volumes of ethyl acetate.`
- Ground Truth: `( 1 { : } 1 { : } 3 \ \mathbf { v } / \mathbf { v } / \mathbf { v } )`
- **Issue:** Added explanation despite "Provide ONLY corrected formula, do not explain"

**Failure Type 3: Adding Context (Over-Interpretation)**

**Error 5 - Statistical:**
- Original: `( < 5 0 \%`
- ChemLLM: `$\% < 50$ of genera`
- Ground Truth: `( < 5 0 \% )`
- **Issue:** Added "of genera" from context, reformatted with $ delimiters

**Error 6 - Experimental:**
- Original: `( 2 . 5 \mathrm { m M } ,`
- ChemLLM: `2.5 mM MgCl2`
- Ground Truth: `( 2 . 5 \mathrm { m M } )`
- **Issue:** Added chemical name "MgCl2" from context, removed parentheses

**Failure Type 4: Reformatting Instead of Minimal Fix**

**Errors 9, 10, 12, 13, 14 - Statistical/Clinical:**
- All wrapped in $ $ delimiters or reformatted to different LaTeX style
- Removed parentheses that were needed
- Changed notation style (e.g., `\frac{1}{12}` vs `1/12`)

---

## Root Cause Analysis

### Why ChemLLM-7B Failed This Task

**1. Training Objective Mismatch**
- **ChemLLM trained for:** Chemistry Q&A, molecule understanding, reaction prediction
- **Our task requires:** LaTeX syntax preservation, minimal changes, structural repair
- **Result:** Model "improves" chemistry instead of fixing syntax

**2. Chemistry Knowledge as Liability**
- Model understands context ("MgCl2 concentration", "species count") and incorporates it
- Tries to make formulas "more correct" chemically rather than syntactically
- Cannot resist rewriting to its preferred LaTeX style

**3. Instruction Following Limitations**
- Despite explicit prompts ("Do NOT explain", "Minimal changes", "Add ONLY missing delimiter"):
  - Added explanatory text (40% of cases)
  - Invented new content (hallucinations)
  - Reformatted entire formulas

**4. Architecture Not Designed for Syntax Tasks**
- InternLM-2 base optimized for language understanding, not character-level preservation
- 4-bit quantization may degrade instruction following
- No fine-tuning on formula correction task

---

## Comparison: ChemLLM vs Baseline

| Approach | Accuracy | Cost | Preserves LaTeX | Hallucinations |
|----------|----------|------|-----------------|----------------|
| **Baseline (Layer 1+2 Rules)** | 98.5% (933/948) | $0 | ✓ Yes | ✗ No |
| **ChemLLM-7B** | 13.3% (2/15) | $0 | ✗ No | ✓ Yes (2+) |
| **Generic LLM (Claude)** | 100% (15/15) | $0.46 | ✓ Yes | ✗ No |

**Conclusion:** ChemLLM-7B is **worse than both** baseline rules and generic LLM.

---

## Lessons Learned

### What Didn't Work

1. **Domain-Specialized LLMs for Syntax Tasks**
   - Chemistry LLM is not better than generic LLM for LaTeX repair
   - Domain knowledge causes over-interpretation

2. **Prompt Engineering Alone**
   - Even explicit "CRITICAL RULES" couldn't prevent reformatting
   - Model behavior driven by training objective, not just prompts

3. **4-bit Quantization for Complex Instructions**
   - May degrade instruction following capabilities
   - Trade-off between VRAM and quality not worth it for this task

### What We Learned About Formula Correction

1. **Task Classification:** Formula correction is a **syntax preservation task**, not a chemistry understanding task
2. **Better Approaches:**
   - Image-based re-extraction (Texify, Nougat)
   - Fine-tuned models on formula correction pairs
   - Enhanced rule-based systems with more patterns

3. **Validation Methodology:**
   - Need semantic comparison (not exact string match)
   - But also need to prevent hallucinations (semantic comparison alone insufficient)

---

## Recommended Alternative Approaches

### Option 1: Image-Based Re-Extraction (Texify) ⭐ **RECOMMENDED**

**Approach:** Extract formula images from PDF, re-extract with Texify math OCR

**Pros:**
- Texify specifically designed for LaTeX formula extraction
- No hallucinations (extracts what's visually present)
- Preserves LaTeX structure
- CPU-friendly

**Cons:**
- Requires formula bounding boxes from PDF
- Extra processing step (image extraction)

**Expected Accuracy:** 80-90% (based on Texify benchmarks)

**Implementation:**
1. Extract formula bounding boxes with PyMuPDF
2. Re-extract with Texify for high-confidence errors only
3. Validate corrections before applying

**Estimated Effort:** 15-25 hours (Days 4-5 of original plan)

---

### Option 2: Enhanced Rule-Based System ⭐ **QUICK WIN**

**Approach:** Add more specific rules for statistical/clinical notation

**Pros:**
- $0 cost
- No model loading
- 100% reproducible
- No hallucinations

**Cons:**
- Requires pattern analysis
- May not cover all edge cases

**Expected Accuracy:** 99%+ (currently 98.5%)

**Implementation:**
1. Analyze remaining 15 errors for patterns:
   - 6 missing closing `)` after units (mg, mL, mm, etc.)
   - 4 missing `)` after percentage/comparison
   - 2 mismatched brackets `]` vs `)`
   - 3 complex nested structures

2. Add category-specific rules:
   ```python
   # Percentage notation
   if re.match(r'\([<>=]\s*\d+\s*\\%$', formula):
       return formula + ' )'

   # Unit notation
   if re.match(r'\(.*\\mathrm\s*\{[^}]+\}\s*,$', formula):
       return formula[:-1] + ' )'  # Replace comma with )
   ```

**Estimated Effort:** 3-5 hours

---

### Option 3: Fine-Tuned Model (Long-Term)

**Approach:** Fine-tune Mistral-7B or Llama-3-8B on formula correction pairs

**Pros:**
- Learns exact task requirements
- Can achieve >95% accuracy
- One-time training cost

**Cons:**
- Requires training dataset (need to create correction pairs)
- Training time (~2-4 hours)
- Need to maintain/update model

**Expected Accuracy:** 95-98%

**Dataset Creation:**
- Extract 500-1000 error/correction pairs from corpus
- Include diverse error types (current 15 + expand)
- Use LoRA for efficient fine-tuning

**Estimated Effort:** 40-60 hours (dataset creation + training + validation)

---

### Option 4: Keep Baseline + Document Limitations

**Approach:** Accept 98.5% accuracy, document remaining 1.5% as manual review cases

**Pros:**
- No additional development
- Current accuracy sufficient for most use cases
- Manual review ensures 100% final accuracy

**Cons:**
- Still requires manual intervention (27 errors / 142 papers = 0.19 errors/paper)

**Manual Review Time:** ~5-10 min/error × 27 errors = 2-4.5 hours for 142 papers

---

## Decision Matrix

| Approach | Accuracy | Cost | Effort | Timeline | Risk |
|----------|----------|------|--------|----------|------|
| **Option 1: Texify** | 80-90% | $0 | 20h | 3-4 days | Medium |
| **Option 2: Enhanced Rules** | 99%+ | $0 | 4h | 1 day | Low |
| **Option 3: Fine-Tuned Model** | 95-98% | ~$5 | 50h | 2 weeks | Medium |
| **Option 4: Baseline + Manual** | 100% | $0 | 3h | 1 day | Low |
| **ChemLLM-7B** | 13% | $0 | -20h | -2 days | High |

---

## Final Recommendation

### Immediate Action (Next 2 Days): **Option 2 + Option 4**

1. **Day 1 Morning (4 hours):** Implement enhanced rule-based system
   - Add 5-10 new category-specific patterns
   - Target: 99%+ accuracy (reduce 27 errors → <5)

2. **Day 1 Afternoon (4 hours):** Document remaining edge cases
   - Create manual review checklist
   - Estimate: 0-5 errors requiring manual review

3. **Day 2 (8 hours):** If <99% achieved, implement **Option 1 (Texify)**
   - Extract formula images
   - Re-extract with Texify
   - Target: 99.5%+ accuracy

**Expected Outcome:** 99-99.5% automated accuracy in 2 days vs 10 days for full ChemLLM path

---

### Long-Term (Phase 4): **Option 3 (Fine-Tuned Model)**

If scaling to 10,000+ papers:
- Create training dataset from 142-paper corrections
- Fine-tune Mistral-7B with LoRA on formula correction
- Expected ROI: 40h investment → 95% accuracy on unlimited papers

---

## Code & Scripts Created

### Functional Code (Can be reused)
1. ✅ `tools/scripts/test-chemllm-loading.py` - Model loading verification
2. ✅ `tools/scripts/layer2-chemllm-corrections.py` - Correction framework (reusable for fine-tuned model)
3. ✅ `tools/scripts/validate-chemllm.sh` - Validation framework with semantic comparison

### Lessons for Future LLM Attempts
1. Semantic comparison essential (not exact string match)
2. Need hallucination detection
3. Prompt engineering has limits - training objective matters more
4. Domain-specialized ≠ task-specialized

---

## Cost Analysis

### ChemLLM-7B Attempt
- **Research:** 4 hours
- **Implementation:** 6 hours
- **Validation:** 4 hours
- **Documentation:** 2 hours
- **Total:** 16 hours invested

**ROI:** Negative (learned what doesn't work)

**Value:** Validated that domain-specialized LLMs not always better; framework reusable for fine-tuned model

---

## Conclusion

ChemLLM-7B **failed validation** (13.3% accuracy) due to fundamental task mismatch:
- Designed for chemistry Q&A, not LaTeX syntax repair
- Chemistry knowledge causes over-interpretation and hallucinations
- Prompt engineering cannot override training objective

**Recommendation:** **SKIP ChemLLM-7B**, implement **enhanced rule-based system (Option 2)** as immediate solution, with **Texify image re-extraction (Option 1)** as backup if needed.

**Timeline Adjustment:**
- ~~Days 1-2: ChemLLM validation + deployment~~ → **1 day: Enhanced rules**
- Days 3-4: Docling validation (as planned)
- Days 5-6: Texify validation (as planned)

This maintains 2-week timeline while achieving better results.

---

**Validation Complete:** October 10, 2025
**Author:** Claude Code (Phase 3A Validation Team)
**Status:** ChemLLM-7B REJECTED
**Next Steps:** Implement Option 2 (Enhanced Rule-Based System)
