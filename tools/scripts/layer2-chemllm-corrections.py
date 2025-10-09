#!/usr/bin/env python3
"""
Layer 2: ChemLLM-7B Formula Corrections

Applies chemistry-specialized LLM corrections to malformed formulas that passed
through pattern-based (Layer 1) and rule-based (Layer 2) validation but still
contain errors.

Uses ChemLLM-7B-Chat with 4-bit quantization for cost-free, chemistry-aware
formula correction.

Architecture:
  Input:  Uncorrected errors (JSON) from layer2-sequential-validation.py
  Process: ChemLLM-7B inference with category-specific prompts
  Output: Corrected formulas with confidence scores

Expected performance:
  - Accuracy: ≥95% (14/15 on validation set)
  - Avg confidence: ≥0.70
  - VRAM usage: ~6GB (4-bit quantization)
  - Cost: $0 (local inference)

Usage:
  python layer2-chemllm-corrections.py INPUT_ERRORS.json OUTPUT_CORRECTIONS.json

Author: KANNA Project - Phase 3A ChemLLM Integration
Date: 2025-10-10
"""

import json
import argparse
import torch
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
from pathlib import Path
from typing import Dict, List
import re
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class ChemLLMCorrector:
    """ChemLLM-7B based formula corrector with chemistry domain knowledge."""

    def __init__(self):
        """Initialize ChemLLM-7B with 4-bit quantization."""
        logger.info("Loading ChemLLM-7B-Chat with 4-bit quantization...")

        # Configure 4-bit quantization (reduces VRAM to ~6GB)
        bnb_config = BitsAndBytesConfig(
            load_in_4bit=True,
            bnb_4bit_quant_type="nf4",
            bnb_4bit_compute_dtype=torch.bfloat16
        )

        # Load tokenizer
        self.tokenizer = AutoTokenizer.from_pretrained(
            "AI4Chem/ChemLLM-7B-Chat",
            trust_remote_code=True
        )

        # Load model
        self.model = AutoModelForCausalLM.from_pretrained(
            "AI4Chem/ChemLLM-7B-Chat",
            quantization_config=bnb_config,
            device_map="auto",
            trust_remote_code=True
        )

        vram_used = torch.cuda.memory_allocated() / 1e9
        logger.info(f"✓ ChemLLM-7B loaded (VRAM: {vram_used:.2f} GB)")

    def correct_formula(self, error: Dict) -> Dict:
        """
        Correct a single malformed formula using ChemLLM.

        Args:
            error: Dict with keys: formula, context, category, reasoning_hint

        Returns:
            Dict with corrected formula and metadata
        """
        # Construct chemistry-aware prompt
        prompt = self._build_prompt(error)

        # Generate correction
        inputs = self.tokenizer(prompt, return_tensors="pt").to(self.model.device)

        with torch.no_grad():
            outputs = self.model.generate(
                **inputs,
                max_new_tokens=128,
                temperature=0.3,  # Lower temp for conservative corrections
                do_sample=True,
                top_p=0.9,
                use_cache=False  # Fix for quantized InternLM models
            )

        # Decode and extract corrected formula
        response = self.tokenizer.decode(outputs[0], skip_special_tokens=True)
        corrected = self._extract_correction(response, prompt)

        # Calculate confidence score
        confidence = self._calculate_confidence(error['formula'], corrected, error)

        return {
            'original': error['formula'],
            'corrected': corrected,
            'confidence': confidence,
            'category': error.get('category', 'general_chemistry'),
            'paper': error.get('paper', 'unknown'),
            'reasoning': error.get('reasoning_hint', '')
        }

    def _build_prompt(self, error: Dict) -> str:
        """Build category-specific prompt for ChemLLM."""
        category = error.get('category', 'general_chemistry')
        formula = error['formula']
        context = error.get('context', '')
        reasoning_hint = error.get('reasoning_hint', '')

        # Category-specific prompt templates (all emphasize minimal syntax repair)
        base_rules = """
CRITICAL RULES:
1. Add ONLY the missing delimiter (closing ), ], or }})
2. Keep ALL existing LaTeX commands unchanged
3. Do NOT reformat or rewrite the formula
4. Make the SMALLEST possible change to fix the syntax"""

        if category == 'mass_spectrometry':
            prompt = f"""Fix LaTeX syntax error in mass spec data. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        elif category == 'nmr_spectroscopy':
            prompt = f"""Fix LaTeX syntax error in NMR notation. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        elif category == 'xray_crystallography':
            prompt = f"""Fix LaTeX syntax error in X-ray data. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        elif category == 'experimental_data':
            prompt = f"""Fix LaTeX syntax error in experimental data. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        elif category == 'statistical':
            prompt = f"""Fix LaTeX syntax error in statistical notation. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        elif category == 'clinical':
            prompt = f"""Fix LaTeX syntax error in clinical data. Add missing delimiter ONLY.

Original: {formula}
Hint: {reasoning_hint}
{base_rules}

Corrected:"""

        else:  # general_chemistry
            prompt = f"""Fix this LaTeX formula by adding ONLY the missing delimiter. Make minimal changes.

Original: {formula}
Hint: {reasoning_hint}

CRITICAL RULES:
1. Add ONLY the missing closing ), ], or }}
2. Keep ALL existing LaTeX commands unchanged (\\mathrm, \\times, etc.)
3. Do NOT reformat or rewrite
4. Do NOT add extra content

Corrected:"""

        return prompt

    def _extract_correction(self, response: str, prompt: str) -> str:
        """Extract corrected formula from model response."""
        # Remove prompt from response
        if "Corrected Formula:" in response:
            parts = response.split("Corrected Formula:")
            if len(parts) > 1:
                corrected = parts[-1].strip()
            else:
                corrected = response.strip()
        else:
            corrected = response.strip()

        # Clean up response (remove extra text)
        corrected = corrected.split('\n')[0].strip()  # Take first line only
        corrected = corrected.strip('"\'')  # Remove quotes

        return corrected

    def _calculate_confidence(self, original: str, corrected: str, error: Dict) -> float:
        """
        Calculate confidence score for correction.

        Heuristics:
        - Balanced delimiters → +0.15
        - Valid LaTeX syntax → +0.10
        - Minimal changes → +0.05
        - Category-specific boost
        """
        confidence = 0.70  # Base confidence

        # Check balanced delimiters
        if self._has_balanced_delimiters(corrected):
            confidence += 0.15

        # Check valid LaTeX syntax
        if self._is_valid_latex(corrected):
            confidence += 0.10

        # Check minimal changes (similarity ≥80%)
        if self._minimal_changes(original, corrected):
            confidence += 0.05

        # Category-specific boost
        category = error.get('category', 'general_chemistry')
        if category == 'xray_crystallography':
            confidence = min(confidence + 0.05, 0.95)
        elif category == 'mass_spectrometry':
            confidence = min(confidence + 0.05, 0.90)
        elif category == 'experimental_data':
            confidence = min(confidence, 0.85)
        elif category == 'statistical':
            confidence = min(confidence, 0.80)
        elif category == 'clinical':
            confidence = min(confidence, 0.75)

        return min(confidence, 1.0)

    def _has_balanced_delimiters(self, formula: str) -> bool:
        """Check if formula has balanced parentheses/braces/brackets."""
        stack = []
        pairs = {'(': ')', '{': '}', '[': ']'}

        for char in formula:
            if char in pairs:
                stack.append(char)
            elif char in pairs.values():
                if not stack or pairs[stack.pop()] != char:
                    return False

        return len(stack) == 0

    def _is_valid_latex(self, formula: str) -> bool:
        """Validate LaTeX syntax (basic checks)."""
        # Check for common LaTeX commands
        valid_commands = ['\\mathrm', '\\mathbf', '\\times', '\\mu', '\\circ', '\\ce']
        has_valid_commands = any(cmd in formula for cmd in valid_commands)

        # Check for balanced delimiters
        has_balanced = self._has_balanced_delimiters(formula)

        # Accept if has valid commands OR (balanced and ASCII)
        return has_balanced and (has_valid_commands or formula.replace(' ', '').replace('\\', '').isascii())

    def _minimal_changes(self, original: str, corrected: str) -> bool:
        """Check if correction made minimal changes (≥80% similarity)."""
        from difflib import SequenceMatcher
        similarity = SequenceMatcher(None, original, corrected).ratio()
        return similarity >= 0.8

    def correct_batch(self, errors: List[Dict]) -> List[Dict]:
        """Correct multiple errors in batch."""
        corrections = []

        for i, error in enumerate(errors, 1):
            logger.info(f"Processing error {i}/{len(errors)}: {error.get('formula', '')[:50]}...")
            correction = self.correct_formula(error)
            corrections.append(correction)

        return corrections


def main():
    parser = argparse.ArgumentParser(
        description="ChemLLM-7B Formula Corrections"
    )
    parser.add_argument('input_file', type=Path,
                       help='Input JSON file with uncorrected errors')
    parser.add_argument('output_file', type=Path,
                       help='Output JSON file for corrections')
    parser.add_argument('--dry-run', action='store_true',
                       help='Print corrections without saving')

    args = parser.parse_args()

    # Load errors
    logger.info(f"Loading errors from {args.input_file}")
    with open(args.input_file, 'r') as f:
        errors = json.load(f)

    logger.info(f"Loaded {len(errors)} errors for correction")

    # Initialize corrector
    corrector = ChemLLMCorrector()

    # Apply corrections
    corrections = corrector.correct_batch(errors)

    # Calculate statistics
    avg_confidence = sum(c['confidence'] for c in corrections) / len(corrections)
    high_conf = len([c for c in corrections if c['confidence'] >= 0.85])
    mid_conf = len([c for c in corrections if 0.75 <= c['confidence'] < 0.85])
    low_conf = len([c for c in corrections if c['confidence'] < 0.75])

    logger.info("\n" + "="*60)
    logger.info("ChemLLM Corrections Summary")
    logger.info("="*60)
    logger.info(f"Total corrections: {len(corrections)}")
    logger.info(f"Average confidence: {avg_confidence:.3f}")
    logger.info(f"High confidence (≥0.85): {high_conf}/{len(corrections)}")
    logger.info(f"Mid confidence (0.75-0.84): {mid_conf}/{len(corrections)}")
    logger.info(f"Low confidence (<0.75): {low_conf}/{len(corrections)}")
    logger.info("="*60)

    # Save corrections
    if not args.dry_run:
        args.output_file.parent.mkdir(parents=True, exist_ok=True)
        with open(args.output_file, 'w') as f:
            json.dump(corrections, f, indent=2, ensure_ascii=False)
        logger.info(f"✓ Corrections saved to {args.output_file}")
    else:
        logger.info("Dry run - corrections not saved")
        for c in corrections[:3]:  # Show first 3
            print(f"\nOriginal: {c['original']}")
            print(f"Corrected: {c['corrected']}")
            print(f"Confidence: {c['confidence']:.2f}")


if __name__ == "__main__":
    main()
