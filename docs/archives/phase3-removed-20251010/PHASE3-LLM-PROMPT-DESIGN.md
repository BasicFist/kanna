# Phase 3 LLM Integration - Prompt Design

**Date**: October 9, 2025
**Session**: Phase 3 Formula Extraction Optimization - Step 4
**Objective**: Design chemistry-aware prompts for LLM-powered LaTeX formula correction

---

## Overview

**Problem**: Rule-based Layer 2 validation reaches 96.2% accuracy ceiling due to ambiguous errors requiring domain knowledge.

**Solution**: Use MCP Sequential tool with chemistry-aware prompts to correct errors that rule-based patterns can't handle.

**Expected improvement**: 96.2% → 98.5%+ accuracy (12 → 4-5 errors per 314 formulas)

---

## Prompt Architecture

### Core Principles

1. **Domain-Specific Context**: Each error category gets specialized chemistry knowledge
2. **Conservative Corrections**: LLM should only correct when confident (≥0.8)
3. **Structured Output**: JSON format for easy parsing and validation
4. **Examples**: Provide few-shot examples for each category

### Prompt Template Structure

```
System Context: You are a chemistry LaTeX formula expert specializing in scientific paper extraction.

Task: Correct a structural LaTeX error in a chemistry formula.

Error Details:
- Formula: ${formula}$
- Error Type: {error_type}
- Context: {surrounding_text}

Domain Knowledge: {category_specific_knowledge}

Instructions:
1. Analyze the formula and context
2. Determine the correct LaTeX syntax
3. Apply chemistry domain knowledge
4. Return corrected formula with confidence score

Output Format:
{
  "corrected_formula": "...",
  "confidence": 0.0-1.0,
  "reasoning": "..."
}
```

---

## Category-Specific Prompts

### 1. Mass Spectrometry (confidence: 0.9)

**Domain Knowledge**:
```
Mass spectrometry notation patterns:
- M⁺ (molecular ion): $(M ^ { + })$
- M - fragment: $(M - \text{fragment})$
- Fragment losses: $(M - C_3H_8N)$, $(M - CH_3)$, $(M - 1)$

Common errors:
- Missing opening parenthesis before M
- Missing closing parenthesis after fragment
- Example fix: $M - C_3H_8N)$ → $(M - C_3H_8N)$
```

**Prompt Template**:
```python
MASS_SPEC_PROMPT = """You are a mass spectrometry LaTeX expert.

Task: Fix the LaTeX formula for a mass spectrum fragment.

Formula: ${formula}$
Context: {context}

Mass Spectrometry Notation:
- Molecular ion: M⁺ should be $(M ^ {{ + }})$
- Fragment ion: M - X should be $(M - X)$
- Always enclose in parentheses: $(...)$

Common patterns:
- $M ^ {{ + }} )$ → $(M ^ {{ + }})$ (add opening paren)
- $M - C_3H_8N )$ → $(M - C_3H_8N)$ (add opening paren)
- $( M - CH_3$ → $(M - CH_3)$ (add closing paren)

Examples:
Input:  $M ^ {{ + }} )$
Output: $(M ^ {{ + }})$
Reason: Missing opening parenthesis before M⁺

Input:  $M - C_4H_10N )$
Output: $(M - C_4H_10N)$
Reason: Missing opening parenthesis for fragment notation

Correct this formula:
${formula}$

Return JSON:
{{
  "corrected_formula": "...",
  "confidence": 0.9,
  "reasoning": "..."
}}
"""
```

---

### 2. NMR Spectroscopy (confidence: 0.85)

**Domain Knowledge**:
```
NMR notation patterns:
- Chemical shift: δ (ppm)
- Multiplet: (s, 3H), (d, J=10Hz, 2H), (m, 4H)
- Always enclose multiplet in parentheses

Common errors:
- Missing closing parenthesis after proton count
- Example fix: $(m, 3H$ → $(m, 3H)$
```

**Prompt Template**:
```python
NMR_PROMPT = """You are an NMR spectroscopy LaTeX expert.

Task: Fix the LaTeX formula for NMR multiplet notation.

Formula: ${formula}$
Context: {context}

NMR Multiplet Notation:
- Format: (multiplicity, proton_count)
- Examples: $(s, 3H)$, $(d, J=10Hz, 2H)$, $(m, 4H)$
- Always enclose in parentheses

Common patterns:
- $(m, 3H$ → $(m, 3H)$ (add closing paren)
- $(d, J=10.0Hz, 1H$ → $(d, J=10.0Hz, 1H)$ (add closing paren)
- $s, 2H )$ → $(s, 2H)$ (add opening paren)

Keywords in context: NMR, δ, ppm, multiplet, coupling

Correct this formula:
${formula}$

Return JSON:
{{
  "corrected_formula": "...",
  "confidence": 0.85,
  "reasoning": "..."
}}
"""
```

---

### 3. X-ray Crystallography (confidence: 0.9)

**Domain Knowledge**:
```
X-ray notation patterns:
- Radiation source: Cu-Kα, Mo-Kα
- Always enclose in parentheses
- Format: $(Cu - K_α)$, $(Mo - K_α)$

Common errors:
- Missing closing parenthesis
- Example fix: $(Mo - K_α$ → $(Mo - K_α)$
```

**Prompt Template**:
```python
XRAY_PROMPT = """You are an X-ray crystallography LaTeX expert.

Task: Fix the LaTeX formula for X-ray radiation notation.

Formula: ${formula}$
Context: {context}

X-ray Radiation Notation:
- Format: (source - Kα)
- Examples: $(Cu - K_α)$, $(Mo - K_α)$
- Always enclose in parentheses

Common patterns:
- $(Cu - K_α$ → $(Cu - K_α)$ (add closing paren)
- $(Mo - K_α$ → $(Mo - K_α)$ (add closing paren)
- $Cu - K_α )$ → $(Cu - K_α)$ (add opening paren)

Keywords in context: X-ray, crystal, diffraction, Cu-K, Mo-K

Correct this formula:
${formula}$

Return JSON:
{{
  "corrected_formula": "...",
  "confidence": 0.9,
  "reasoning": "..."
}}
"""
```

---

### 4. Experimental Data (confidence: 0.7)

**Domain Knowledge**:
```
Experimental notation patterns:
- Yield: (1.5 g), (200 mg)
- Volume: (1 × 400 mL)
- Temperature: (25°C)
- Always enclose measurements in parentheses

Common errors:
- Missing opening/closing parenthesis
- Mixed bracket types
```

**Prompt Template**:
```python
EXPERIMENTAL_PROMPT = """You are a chemistry experimental data LaTeX expert.

Task: Fix the LaTeX formula for experimental measurements.

Formula: ${formula}$
Context: {context}

Experimental Data Notation:
- Yield: $(1.5 \\text{{ g }})$, $(200 \\text{{ mg }})$
- Volume: $(1 \\times 400 \\text{{ mL }})$
- Temperature: $(25 ^ \\circ \\text{{ C }})$
- Always use matching brackets: ( ) or [ ] or {{ }}

Common patterns:
- $(1.5 \\text{{ g }}$ → $(1.5 \\text{{ g }})$ (add closing paren)
- $200 \\text{{ mg }} )$ → $(200 \\text{{ mg }})$ (add opening paren)
- $(25) ^ \\circ ]$ → $(25) ^ \\circ$ or $[25] ^ \\circ$ (fix mixed brackets)

Keywords in context: yield, mg, g, mL, temperature, °C

Correct this formula:
${formula}$

Return JSON:
{{
  "corrected_formula": "...",
  "confidence": 0.7,
  "reasoning": "..."
}}
"""
```

---

### 5. General Chemistry (confidence: 0.7)

**Domain Knowledge**:
```
General LaTeX patterns:
- Balanced parentheses: ( )
- Balanced braces: { }
- Balanced brackets: [ ]
- Chemical formulas: C_nH_nN_n

Conservative approach: Only fix if pattern is clear
```

**Prompt Template**:
```python
GENERAL_PROMPT = """You are a chemistry LaTeX expert.

Task: Fix the LaTeX formula with structural errors.

Formula: ${formula}$
Context: {context}

LaTeX Structural Rules:
- Parentheses must balance: ( )
- Braces must balance: {{ }}
- Brackets must balance: [ ]
- Don't mix bracket types without clear reason

Common patterns:
- Add opening paren if closing paren exists with no match
- Add closing paren if opening paren exists with no match
- Only correct if context makes it clear

Conservative approach:
- If ambiguous, return confidence < 0.7 (will be skipped)
- Better to skip than make false correction

Analyze context carefully. Look for:
- Chemistry keywords (yield, mg, spectrum, NMR, etc.)
- Structural patterns (numbers, subscripts, superscripts)
- Surrounding text meaning

Correct this formula:
${formula}$

Return JSON:
{{
  "corrected_formula": "...",
  "confidence": 0.0-1.0,
  "reasoning": "..."
}}
"""
```

---

## Implementation Strategy

### Integration with Layer 2 Validator

**New parameter**: `--use-llm` (boolean flag)

**Workflow**:
```python
def repair_with_mcp(self, error: ChemistryError) -> Tuple[Optional[str], float]:
    if self.use_llm:
        # LLM-powered correction (Step 4)
        return self._llm_correction(error)
    else:
        # Rule-based correction (existing)
        return self._rule_based_correction(error)
```

### LLM Correction Method

```python
def _llm_correction(self, error: ChemistryError) -> Tuple[Optional[str], float]:
    """Use MCP Sequential tool for chemistry-aware correction."""

    # Select prompt template based on error type
    prompt_template = self._get_prompt_template(error.error_type)

    # Format prompt with error details
    prompt = prompt_template.format(
        formula=error.formula,
        context=error.context
    )

    # Call MCP Sequential tool (via external script or API)
    # Note: This is a placeholder - actual MCP integration TBD
    response = self._call_mcp_sequential(prompt)

    # Parse JSON response
    try:
        result = json.loads(response)
        corrected = result["corrected_formula"]
        confidence = result["confidence"]
        reasoning = result["reasoning"]

        logger.info(f"LLM correction: ${error.formula}$ → ${corrected}$")
        logger.info(f"Reasoning: {reasoning}")
        logger.info(f"Confidence: {confidence:.2f}")

        return corrected, confidence
    except (json.JSONDecodeError, KeyError) as e:
        logger.warning(f"Failed to parse LLM response: {e}")
        return None, 0.0
```

### MCP Sequential Tool Integration

**Challenge**: MCP Sequential tool is not directly callable from Python script.

**Solutions**:
1. **Option A (Recommended)**: Use Claude Code's MCP integration
   - Run script interactively in Claude Code session
   - Use `/mcp` to access Sequential tool
   - Parse responses and continue execution

2. **Option B**: External API call
   - If MCP has HTTP API endpoint
   - Make REST calls from Python script
   - Requires MCP server running

3. **Option C**: Hybrid approach (for testing)
   - Generate prompts and save to JSON file
   - Run prompts through Claude Code manually
   - Read responses from JSON file
   - Continue automated pipeline

**For this implementation, we'll use Option C for testing**:
```bash
# Generate prompts
python layer2-sequential-validation.py --use-llm --generate-prompts \
  INPUT_DIR prompts.json

# Run prompts through Claude Code (manual step)
# User copies prompts, runs /mcp, pastes responses

# Apply corrections
python layer2-sequential-validation.py --use-llm --apply-responses \
  prompts.json responses.json OUTPUT_DIR
```

---

## Expected Performance

### Baseline (Rule-based, Step 1)
- Errors detected: 27
- Errors corrected: 15 (55.6%)
- Accuracy: 96.2%
- Remaining errors: 12

### Target (LLM-powered, Step 4)
- Errors detected: 27
- Errors corrected: 22-23 (81.5-85.2%)
- **Accuracy: 98.5%+**
- Remaining errors: 4-5

### Breakdown by Category

| Category | Count | Rule-based | LLM Expected | Improvement |
|----------|-------|-----------|--------------|-------------|
| Ambiguous context | 9 | 0 | 7 | +7 |
| Mixed brackets | 2 | 0 | 2 | +2 |
| Unusual formatting | 1 | 0 | 1 | +1 |
| **Total new corrections** | 12 | 0 | 10 | **+10** |

---

## Cost Analysis

### LLM API Calls
- **Errors requiring LLM**: 12 per paper
- **Token usage per call**: ~500 tokens (prompt + response)
- **Total tokens per paper**: 6,000 tokens
- **Cost per 1M tokens**: $3 (Claude Sonnet)
- **Cost per paper**: $0.018

### Full Corpus (142 papers)
- **Total LLM calls**: 1,704 calls
- **Total tokens**: 852K tokens
- **Total cost**: $2.56

**Compare to**:
- Rule-based Layer 2: $0 (CPU-only)
- Manual review: $1,200 (40 hours × $30/hr)
- **ROI**: 468× cheaper than manual review

---

## Testing Plan

### Phase 1: Single Paper (Capps 1977)
1. Generate prompts for 12 errors
2. Run through MCP Sequential tool
3. Parse responses and validate
4. Measure accuracy improvement

### Phase 2: 3-Paper Batch
1. Apply to diverse papers (simple, complex, old)
2. Validate consistency across papers
3. Measure average accuracy

### Phase 3: Production Deployment
1. If accuracy ≥98%, deploy to full 142-paper corpus
2. Monitor for edge cases
3. Manual review of remaining errors

---

## Next Steps

1. ✅ Design prompt templates (this document)
2. ⏳ Implement LLM integration in layer2-sequential-validation.py
3. ⏳ Test on Capps 1977 paper
4. ⏳ Measure accuracy improvement
5. ⏳ Document Step 4 findings

---

**Status**: Prompt design complete | Ready for implementation
**Updated**: 2025-10-09 23:45 UTC
