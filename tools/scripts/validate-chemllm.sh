#!/usr/bin/env bash
set -euo pipefail

#===============================================================================
# ChemLLM-7B Validation Script
#
# Validates ChemLLM-7B corrections against ground truth from diverse paper set.
# Tests 15 errors across 6 categories (mass spec, NMR, experimental, statistical,
# clinical, general chemistry).
#
# Success Criteria:
#   - Accuracy: ≥95% (14/15 correct)
#   - Avg confidence: ≥0.70
#   - No hallucinations (nonsensical outputs)
#
# Usage:
#   bash tools/scripts/validate-chemllm.sh
#
# Output:
#   tools/output/chemllm-validation-results.json
#
# Author: KANNA Project - Phase 3A ChemLLM Validation
# Date: 2025-10-10
#===============================================================================

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
INPUT_ERRORS="/tmp/diverse_papers_errors_for_llm.json"
GROUND_TRUTH="/tmp/diverse_papers_llm_corrections.json"
CHEMLLM_OUTPUT="$PROJECT_ROOT/tools/output/chemllm-corrections.json"
RESULTS_FILE="$PROJECT_ROOT/tools/output/chemllm-validation-results.json"

# Change to project directory
cd "$PROJECT_ROOT"

echo "================================================================"
echo "ChemLLM-7B Validation"
echo "================================================================"
echo ""

# Check input files exist
if [[ ! -f "$INPUT_ERRORS" ]]; then
    echo -e "${RED}ERROR: Input file not found: $INPUT_ERRORS${NC}"
    echo "Please ensure diverse paper validation has been run first."
    exit 1
fi

if [[ ! -f "$GROUND_TRUTH" ]]; then
    echo -e "${RED}ERROR: Ground truth file not found: $GROUND_TRUTH${NC}"
    exit 1
fi

echo "Input errors: $INPUT_ERRORS"
echo "Ground truth: $GROUND_TRUTH"
echo ""

# Activate conda environment
echo "Activating kanna environment..."
eval "$(conda shell.bash hook)"
conda activate kanna

# Run ChemLLM corrections
echo "Running ChemLLM-7B corrections..."
echo ""

python tools/scripts/layer2-chemllm-corrections.py \
    "$INPUT_ERRORS" \
    "$CHEMLLM_OUTPUT"

echo ""
echo "================================================================"
echo "Comparing ChemLLM Corrections vs Ground Truth"
echo "================================================================"
echo ""

# Python validation script
python << 'PYEOF'
import json
import sys
from pathlib import Path

# Load data
with open('/tmp/diverse_papers_errors_for_llm.json', 'r') as f:
    errors = json.load(f)

with open('/tmp/diverse_papers_llm_corrections.json', 'r') as f:
    ground_truth = json.load(f)

with open('tools/output/chemllm-corrections.json', 'r') as f:
    chemllm_corrections = json.load(f)

# Compare corrections
correct = 0
total = len(errors)
matches = []
mismatches = []

for i, (error, gt, chem) in enumerate(zip(errors, ground_truth, chemllm_corrections)):
    error_num = i + 1

    # Semantic comparison (normalize formatting)
    def normalize_formula(formula):
        """Normalize LaTeX formula for semantic comparison."""
        import re
        # Remove all whitespace
        formula = formula.replace(' ', '').replace('\n', '').replace('\t', '')
        # Normalize mathrm/text commands
        formula = re.sub(r'\\mathrm\{([^}]+)\}', r'\1', formula)
        formula = re.sub(r'\\text\{([^}]+)\}', r'\1', formula)
        # Normalize times symbol
        formula = formula.replace('×', r'\times').replace('{\\times}', r'\times')
        # Normalize tilde spacing
        formula = formula.replace('~', '')
        # Normalize math delimiters
        formula = formula.replace('$', '')
        # Normalize fractions: \frac{a}{b} == a/b
        formula = re.sub(r'\\frac\{(\d+)\}\{(\d+)\}', r'\1/\2', formula)
        # Normalize parentheses spacing
        formula = re.sub(r'\(\s*', '(', formula)
        formula = re.sub(r'\s*\)', ')', formula)
        # Case normalize (alpha vs \alpha)
        formula = formula.replace('\\alpha', 'α').replace('alpha', 'α')
        return formula.lower()

    gt_norm = normalize_formula(gt['corrected'])
    chem_norm = normalize_formula(chem['corrected'])

    is_match = gt_norm == chem_norm

    if is_match:
        correct += 1
        matches.append({
            'error_num': error_num,
            'original': error['formula'],
            'corrected': chem['corrected'],
            'confidence': chem['confidence'],
            'category': error.get('category', 'unknown')
        })
        status = "✓ MATCH"
    else:
        mismatches.append({
            'error_num': error_num,
            'original': error['formula'],
            'ground_truth': gt['corrected'],
            'chemllm': chem['corrected'],
            'gt_confidence': gt.get('confidence', 0),
            'chemllm_confidence': chem['confidence'],
            'category': error.get('category', 'unknown')
        })
        status = "✗ MISMATCH"

    print(f"Error {error_num:2d}: {status}")
    if not is_match:
        print(f"  Ground Truth: {gt['corrected']}")
        print(f"  ChemLLM:      {chem['corrected']}")
        print(f"  GT Conf: {gt.get('confidence', 0):.2f}, ChemLLM Conf: {chem['confidence']:.2f}")
        print()

# Calculate metrics
accuracy = (correct / total) * 100
avg_confidence = sum(c['confidence'] for c in chemllm_corrections) / total
high_conf = len([c for c in chemllm_corrections if c['confidence'] >= 0.85])
mid_conf = len([c for c in chemllm_corrections if 0.75 <= c['confidence'] < 0.85])
low_conf = len([c for c in chemllm_corrections if c['confidence'] < 0.75])

# Determine pass/fail
passes = accuracy >= 95.0 and avg_confidence >= 0.70

print("\n" + "="*60)
print("VALIDATION RESULTS")
print("="*60)
print(f"Total Errors:       {total}")
print(f"Correct:            {correct}/{total} ({accuracy:.1f}%)")
print(f"Incorrect:          {total - correct}/{total}")
print(f"Avg Confidence:     {avg_confidence:.3f}")
print(f"High Conf (≥0.85):  {high_conf}/{total}")
print(f"Mid Conf (0.75-84): {mid_conf}/{total}")
print(f"Low Conf (<0.75):   {low_conf}/{total}")
print("="*60)

# Success criteria
print("\nSUCCESS CRITERIA:")
print(f"  Accuracy ≥95%:      {'✓ PASS' if accuracy >= 95 else '✗ FAIL'} ({accuracy:.1f}%)")
print(f"  Avg Conf ≥0.70:     {'✓ PASS' if avg_confidence >= 0.70 else '✗ FAIL'} ({avg_confidence:.3f})")
print(f"  Overall:            {'✓ PASS - DEPLOY' if passes else '✗ FAIL - DO NOT DEPLOY'}")
print("="*60)

# Save results
results = {
    'validation_date': '2025-10-10',
    'test_set_size': total,
    'accuracy': accuracy,
    'correct': correct,
    'incorrect': total - correct,
    'avg_confidence': avg_confidence,
    'confidence_distribution': {
        'high': high_conf,
        'mid': mid_conf,
        'low': low_conf
    },
    'passes_validation': passes,
    'matches': matches,
    'mismatches': mismatches,
    'deployment_decision': 'DEPLOY' if passes else 'DO NOT DEPLOY',
    'notes': 'ChemLLM-7B validation on 15-error diverse paper set'
}

Path('tools/output').mkdir(parents=True, exist_ok=True)
with open('tools/output/chemllm-validation-results.json', 'w') as f:
    json.dump(results, f, indent=2, ensure_ascii=False)

print(f"\n✓ Results saved to: tools/output/chemllm-validation-results.json")

# Exit with appropriate code
sys.exit(0 if passes else 1)

PYEOF

validation_result=$?

echo ""
echo "================================================================"

if [[ $validation_result -eq 0 ]]; then
    echo -e "${GREEN}✅ VALIDATION PASSED - ChemLLM-7B APPROVED FOR DEPLOYMENT${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Integrate ChemLLM into production pipeline"
    echo "  2. Test on full 142-paper corpus"
    echo "  3. Document cost savings"
else
    echo -e "${RED}❌ VALIDATION FAILED - DO NOT DEPLOY${NC}"
    echo ""
    echo "ChemLLM-7B did not meet minimum accuracy requirements."
    echo "Consider:"
    echo "  1. Fine-tuning on formula correction dataset"
    echo "  2. Adjusting prompts or temperature"
    echo "  3. Using ensemble with rule-based system"
fi

echo "================================================================"

exit $validation_result
