#!/usr/bin/env bash
set -Eeuo pipefail

# Phase 3 - Diverse Paper Validation Batch Processor
# Processes 7 diverse papers through Layer 1 + Layer 2 pipeline
# Collects errors for LLM correction and generates validation report

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$PROJECT_ROOT"

# Define the 7 diverse papers
declare -a PAPERS=(
    "2014 - Meyer et al.   2015   GC MS, LC MSn, LC high resolution MSn, and NMR stu"
    "2014 - Administrator - S-EM-8-2-165-14-272-Sobiecki-J-F-Tx[7].pmd_1"
    "2013 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae)"
    "2016 - Krstenansky - Mesembrine alkaloids_ Review of their occurrence, chemistry, and pharmacology"
    "2013 - Nell - Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract..."
    "2010 - Schultes   1970   The Botanical and Chemical Distribution of Halluci"
    "2015 - Novel psychoactive substances of interest for psychiatry"
)

declare -a PAPER_TYPES=(
    "Chemistry-Heavy (Meyer 2015)"
    "Ethnobotany (Sobiecki 2014)"
    "Botany/Taxonomy (Aizoaceae 2013)"
    "Pharmacology Review (Krstenansky 2016)"
    "Clinical Trial (Nell 2013)"
    "Classic Review (Schultes 1970)"
    "Psychiatry/Conceptual (Psychoactive 2015)"
)

INPUT_DIR="literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008"
LAYER1_OUTPUT="literature/pdfs/extractions-PHASE3-VALIDATION/layer1-output"
LAYER2_OUTPUT="literature/pdfs/extractions-PHASE3-VALIDATION/layer2-output"

echo "========================================="
echo "Phase 3 - Diverse Paper Validation"
echo "========================================="
echo ""
echo "Processing 7 papers:"
for i in "${!PAPERS[@]}"; do
    echo "  $((i+1)). ${PAPER_TYPES[$i]}"
done
echo ""
echo "Pipeline: MinerU → Layer 1 (Pattern) → Layer 2 (Rule-based)"
echo ""

# Activate conda environment
source ~/miniforge3/etc/profile.d/conda.sh
conda activate kanna

# Process each paper
for i in "${!PAPERS[@]}"; do
    PAPER="${PAPERS[$i]}"
    PAPER_TYPE="${PAPER_TYPES[$i]}"

    echo "----------------------------------------"
    echo "Paper $((i+1))/7: $PAPER_TYPE"
    echo "----------------------------------------"

    # Layer 1: Pattern-based refinement
    echo "[Layer 1] Pattern-based refinement..."
    python tools/scripts/layer1-formula-refinement.py \
        "$INPUT_DIR/$PAPER" \
        "$LAYER1_OUTPUT/$PAPER" \
        --validate

    # Layer 2: Rule-based validation
    echo "[Layer 2] Rule-based validation..."
    python tools/scripts/layer2-sequential-validation.py \
        "$LAYER1_OUTPUT/$PAPER" \
        "$LAYER2_OUTPUT/$PAPER" \
        --confidence-threshold 0.7

    echo "✓ Completed: $PAPER_TYPE"
    echo ""
done

echo "========================================="
echo "✓ All 7 papers processed successfully!"
echo "========================================="
echo ""
echo "Next steps:"
echo "1. Review Layer 2 outputs in: $LAYER2_OUTPUT"
echo "2. Extract remaining errors for LLM correction"
echo "3. Apply LLM corrections using MCP Sequential tool"
echo "4. Generate validation report comparing all 7 papers"
echo ""
