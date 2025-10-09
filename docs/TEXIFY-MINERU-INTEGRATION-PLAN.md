# Texify Integration Plan - MinerU Formula Recognition Upgrade
**Date**: October 9, 2025
**Objective**: Replace Unimernet (2503) with Texify for improved formula accuracy (85% → 95% target)

## Current vs Proposed

| Component | Current (Unimernet 2503) | Proposed (Texify) | Improvement |
|-----------|-------------------------|-------------------|-------------|
| **BLEU Score** | ~0.70 (Nougat-level) | 0.842 | +20% |
| **Accuracy** | 85% usable | 95% expected | +10% |
| **Symbol handling** | Weak (·/- confusion) | Strong (diverse training) | High |
| **Hallucination** | Moderate | Low | High |
| **Speed** | Fast (GPU) | Fast (GPU) | Similar |

## Integration Approach

### Option A: MinerU Fork (Custom Formula Module)

**Modify MinerU pipeline to use Texify instead of Unimernet:**

```python
# In MinerU's formula recognition module
from texify import Texify

# Replace Unimernet call
formula_model = Texify.from_pretrained("VikParuchuri/texify")
formula_latex = formula_model.predict(formula_image)
```

**Pros:**
- Direct replacement, same workflow
- Full control over formula extraction
- Can A/B test Unimernet vs Texify

**Cons:**
- Requires MinerU codebase modification
- Need to maintain custom fork
- Updates to MinerU require merge

### Option B: Post-Processing Pipeline

**Run MinerU extraction, then re-process formulas with Texify:**

```bash
# Step 1: Extract with MinerU (current)
magic-pdf -p input.pdf -o output/ -m auto

# Step 2: Re-extract formulas with Texify
python tools/scripts/texify-formula-refinement.py output/auto/*.md
```

**Workflow:**
1. MinerU extracts layout + identifies formula regions
2. Texify re-processes formula images for higher accuracy
3. Replace LaTeX in markdown with Texify output

**Pros:**
- No MinerU modification needed
- Easy to test and compare
- Can run selectively (only on high-risk papers)

**Cons:**
- Double processing time
- Need to maintain separate script
- May miss formulas MinerU didn't detect

### Option C: Hybrid (Texify for Low-Confidence Only)

**Use Texify as fallback when Unimernet confidence <80%:**

```python
if unimernet_confidence < 0.80:
    formula_latex = texify_model.predict(formula_image)
else:
    formula_latex = unimernet_output
```

**Pros:**
- Best of both worlds (speed + accuracy)
- Minimal performance impact
- Targets the 15% error cases

**Cons:**
- Most complex implementation
- Requires confidence scores from Unimernet

## Recommended Approach: **Option B** (Post-Processing)

**Rationale:**
- **Lowest risk**: No MinerU modification
- **Easy testing**: Run on 3-paper batch, compare results
- **Selective use**: Can apply only to high-risk papers (1970s, complex formulas)
- **Fast validation**: Test within 1-2 hours

## Implementation Script

```python
#!/usr/bin/env python3
"""
Texify Formula Refinement - Post-process MinerU extractions
"""
import re
from pathlib import Path
from PIL import Image
from texify import Texify

def refine_formulas(markdown_path: Path, images_dir: Path):
    """Replace MinerU formulas with Texify re-extraction"""
    
    # Load Texify model
    model = Texify.from_pretrained("VikParuchuri/texify")
    
    # Read markdown
    content = markdown_path.read_text()
    
    # Find all inline LaTeX formulas
    formulas = re.findall(r'\$[^$]+\$', content)
    
    # For each formula, check if image exists
    for i, formula in enumerate(formulas):
        formula_img = images_dir / f"formula_{i}.png"
        if formula_img.exists():
            # Re-extract with Texify
            img = Image.open(formula_img)
            new_latex = model.predict(img)
            
            # Replace in content
            content = content.replace(formula, f"${new_latex}$", 1)
    
    # Save refined markdown
    output_path = markdown_path.parent / f"{markdown_path.stem}_texify.md"
    output_path.write_text(content)
    
    return output_path

if __name__ == "__main__":
    # Test on Capps 1977
    markdown = Path("literature/pdfs/extractions-LLM-TEST/3-paper-batch/2003 - Capps et al.../auto/...md")
    images = markdown.parent / "images"
    
    refined = refine_formulas(markdown, images)
    print(f"Refined markdown: {refined}")
```

## Testing Plan

### Phase 1: Single Paper Validation (1 hour)

1. **Test on Capps 1977** (314 formulas, 15% error rate)
2. Compare Unimernet vs Texify extraction
3. Manual validation of 20 formulas (same as before)
4. Measure accuracy improvement

**Expected Result:** 85% → 92-95% usable formulas

### Phase 2: 3-Paper Batch (2 hours)

1. Apply to all 3 test papers (Capps 1977, Shikanga 2012, Schultes 1970)
2. Compare error rates across papers
3. Identify remaining error patterns
4. Calculate processing time overhead

**Expected Result:** Consistent 92-95% across diverse papers

### Phase 3: GO/NO-GO Decision

**Criteria for adoption:**
- [ ] >92% usable formulas (vs 85% baseline)
- [ ] <10% processing time overhead
- [ ] Easy integration with existing workflow
- [ ] Fixes symbol confusion errors (·/-, ☉)

**If successful:** Deploy to 20-paper pilot with Texify refinement
**If unsuccessful:** Fallback to Option C (Claude Sonnet 4.5 LLM-aided)

## Cost-Benefit Analysis

| Metric | MinerU (Unimernet) | + Texify Post-Processing | Improvement |
|--------|-------------------|-------------------------|-------------|
| **Accuracy** | 85% | 92-95% (expected) | +7-10% |
| **Speed** | 5.7s/page | 8-10s/page (estimated) | 40-75% slower |
| **API Cost** | $0.00 | $0.00 (local GPU) | No change |
| **Manual Review** | 15% formulas | 5-8% formulas | 50-67% reduction |

**Time Savings:**
- Current: 15% × 314 formulas = 47 formulas to review manually (30 min)
- Texify: 5% × 314 formulas = 16 formulas to review (10 min)
- **Net savings: 20 minutes per paper** (even with 40% slower extraction)

**ROI for 143 papers:**
- Processing overhead: 143 papers × 2 min = 4.8 hours
- Manual review savings: 143 papers × 20 min = 47.7 hours
- **Net savings: 42.9 hours** (12× ROI)

## Next Steps

- [ ] Install Texify: `pip install texify` (in mineru conda env)
- [ ] Create refinement script: `tools/scripts/texify-formula-refinement.py`
- [ ] Test on Capps 1977 (Phase 1)
- [ ] Compare 20 formula samples (Unimernet vs Texify)
- [ ] Make GO/NO-GO decision
- [ ] Document in `FORMULA-VALIDATION-CAPPS-1977-TEXIFY.md`

---

*Integration plan created: October 9, 2025*
*Part of: KANNA PhD Thesis - Formula Extraction Quality Improvement*
