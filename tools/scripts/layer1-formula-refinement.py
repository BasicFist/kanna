#!/usr/bin/env python3
"""
Layer 1: Formula Refinement (Pattern-Based Correction)

Refines LaTeX formulas extracted by MinerU (Layer 0) using pattern-based corrections
for common OCR errors in chemical/mathematical formulas.

Architecture:
  Input:  MinerU extraction (markdown + JSON)
  Process: Pattern matching → error correction → validation
  Output: Refined markdown with corrected formulas

Common formula errors corrected:
  1. Middle dot (·, \cdot) → dash (-) in chemical names
  2. Zero (0) → oxygen (O) after prime symbols (')
  3. Spurious \cdot symbols in chemical formulas
  4. Malformed chemical group names (e.g., "methoxy- ·4'" → "methoxy-4'")

Expected improvement: 85% → 92% formula accuracy

Usage:
  python layer1-formula-refinement.py INPUT_DIR OUTPUT_DIR [--validate]

Author: KANNA Project - Phase 3 Formula Optimization
Date: 2025-10-09
"""

import re
import json
import argparse
from pathlib import Path
from typing import Dict, List, Tuple
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class FormulaRefinementEngine:
    """Pattern-based formula correction for chemical/mathematical LaTeX."""

    def __init__(self):
        self.corrections_applied = 0
        self.formulas_processed = 0
        self.error_patterns = self._compile_patterns()

    def _compile_patterns(self) -> List[Tuple[re.Pattern, str, str]]:
        """
        Compile regex patterns for common formula errors.

        Returns:
            List of (pattern, replacement, description) tuples
        """
        patterns = [
            # Pattern 1: "4' \cdot 0" → "4' - O" (prime + middle dot + zero → prime + dash + oxygen)
            (re.compile(r"(\d\s*\^\s*\{\s*\\prime\s*\})\s*\\cdot\s*0"),
             r"\1 – O",
             "Prime apostrophe + middle dot + zero → dash + oxygen"),

            # Pattern 2: Spurious \cdot before numbers in chemical names
            # Example: "methoxy- ·4'" → "methoxy-4'"
            (re.compile(r"(\w+)\s*-\s*\\?·\s*(\d)"),
             r"\1-\2",
             "Remove spurious middle dot in chemical names"),

            # Pattern 3: "\cdot O" → "- O" (middle dot + oxygen → dash + oxygen)
            (re.compile(r"\\cdot\s+O(?=[^a-z])"),  # Lookahead: O not followed by lowercase (avoid "Of", "Or")
             "– O",
             "Middle dot + oxygen → dash + oxygen"),

            # Pattern 4: "\cdot" in middle of chemical group → remove
            # Example: "{ } 4' { \cdot }" → "{ } 4'"
            (re.compile(r"(\{\s*\})\s*\d+\s*\^\s*\{\s*\\prime\s*\}\s*\{\s*\\cdot\s*\}"),
             lambda m: m.group(0).replace(r"{ \cdot }", "").replace(r"{\cdot}", ""),
             "Remove spurious \\cdot in chemical group notation"),

            # Pattern 5: Multiple spaces around operators → single space
            (re.compile(r"\s{2,}"),
             " ",
             "Normalize multiple spaces"),

            # Pattern 6: "0" (zero) after apostrophe in chemical context → "O" (oxygen)
            # Only in context like "4'-0-methyl" → "4'-O-methyl"
            (re.compile(r"(\d\s*'\s*)-\s*0\s*-"),
             r"\1-O-",
             "Zero in chemical linkage → oxygen"),
        ]
        return patterns

    def refine_formula(self, formula: str) -> Tuple[str, bool, List[str]]:
        """
        Apply pattern-based corrections to a single LaTeX formula.

        Args:
            formula: LaTeX formula string (without $ delimiters)

        Returns:
            Tuple of (refined_formula, was_corrected, corrections_applied)
        """
        self.formulas_processed += 1
        original = formula
        corrections = []

        # Apply each error pattern
        for pattern, replacement, description in self.error_patterns:
            matches = pattern.findall(formula)
            if matches:
                formula = pattern.sub(replacement, formula)
                corrections.append(description)
                self.corrections_applied += 1

        was_corrected = (formula != original)

        if was_corrected:
            logger.debug(f"Corrected: '{original}' → '{formula}'")
            logger.debug(f"  Applied: {', '.join(corrections)}")

        return formula, was_corrected, corrections

    def refine_markdown(self, markdown_path: Path) -> Tuple[str, Dict]:
        """
        Refine all formulas in a markdown file.

        Args:
            markdown_path: Path to MinerU-generated markdown

        Returns:
            Tuple of (refined_markdown_text, statistics_dict)
        """
        with open(markdown_path, 'r', encoding='utf-8') as f:
            content = f.read()

        original_content = content
        formula_count = 0
        corrected_count = 0

        # Find all inline LaTeX formulas ($...$)
        def replace_formula(match):
            nonlocal formula_count, corrected_count
            formula_count += 1
            formula = match.group(1)

            refined, was_corrected, corrections = self.refine_formula(formula)
            if was_corrected:
                corrected_count += 1

            return f"${refined}$"

        # Replace formulas
        content = re.sub(r'\$([^\$]+)\$', replace_formula, content)

        stats = {
            'formulas_found': formula_count,
            'formulas_corrected': corrected_count,
            'correction_rate': corrected_count / formula_count if formula_count > 0 else 0,
            'content_changed': (content != original_content)
        }

        return content, stats

    def get_statistics(self) -> Dict:
        """Get overall refinement statistics."""
        return {
            'total_formulas': self.formulas_processed,
            'total_corrections': self.corrections_applied,
            'average_corrections_per_formula': (
                self.corrections_applied / self.formulas_processed
                if self.formulas_processed > 0 else 0
            )
        }


def refine_extraction(input_dir: Path, output_dir: Path, validate: bool = False):
    """
    Refine all MinerU extractions in input directory.

    Args:
        input_dir: Directory containing MinerU auto/ subdirectories
        output_dir: Directory to write refined outputs
        validate: If True, run validation checks after refinement
    """
    engine = FormulaRefinementEngine()

    # Find all MinerU markdown files (in auto/ subdirectories)
    markdown_files = list(input_dir.rglob("auto/*.md"))

    if not markdown_files:
        logger.error(f"No markdown files found in {input_dir}")
        return

    logger.info(f"Found {len(markdown_files)} markdown files to refine")

    output_dir.mkdir(parents=True, exist_ok=True)

    # Process each file
    for md_file in markdown_files:
        logger.info(f"Processing: {md_file.name}")

        # Refine formulas
        refined_content, stats = engine.refine_markdown(md_file)

        # Write refined markdown
        relative_path = md_file.relative_to(input_dir)
        output_file = output_dir / relative_path
        output_file.parent.mkdir(parents=True, exist_ok=True)

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(refined_content)

        logger.info(f"  Formulas: {stats['formulas_found']}")
        logger.info(f"  Corrected: {stats['formulas_corrected']} ({stats['correction_rate']:.1%})")

        # Copy associated files (images, JSON) if they exist
        auto_dir = md_file.parent
        for item in auto_dir.iterdir():
            if item.is_file() and item != md_file:
                # Copy to output
                output_item = output_dir / item.relative_to(input_dir)
                output_item.parent.mkdir(parents=True, exist_ok=True)
                output_item.write_bytes(item.read_bytes())

        # Copy images directory if exists
        images_dir = auto_dir / "images"
        if images_dir.exists():
            output_images = output_dir / images_dir.relative_to(input_dir)
            output_images.mkdir(parents=True, exist_ok=True)
            for img in images_dir.iterdir():
                (output_images / img.name).write_bytes(img.read_bytes())

    # Print overall statistics
    overall = engine.get_statistics()
    logger.info("\n=== Overall Refinement Statistics ===")
    logger.info(f"Total formulas processed: {overall['total_formulas']}")
    logger.info(f"Total corrections applied: {overall['total_corrections']}")
    logger.info(f"Average corrections per formula: {overall['average_corrections_per_formula']:.2f}")

    # Validation (optional)
    if validate:
        logger.info("\n=== Validation ===")
        validate_refinements(output_dir)


def validate_refinements(output_dir: Path):
    """
    Validate refined formulas (check for LaTeX syntax errors).

    Args:
        output_dir: Directory containing refined markdown files
    """
    markdown_files = list(output_dir.rglob("*.md"))
    error_count = 0

    for md_file in markdown_files:
        with open(md_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Find formulas
        formulas = re.findall(r'\$([^\$]+)\$', content)

        for formula in formulas:
            # Check for common LaTeX errors
            if formula.count('{') != formula.count('}'):
                logger.warning(f"Mismatched braces in {md_file.name}: ${formula}$")
                error_count += 1

            if formula.count('(') != formula.count(')'):
                logger.warning(f"Mismatched parentheses in {md_file.name}: ${formula}$")
                error_count += 1

    if error_count == 0:
        logger.info("✓ All formulas passed validation")
    else:
        logger.warning(f"⚠ Found {error_count} potential LaTeX errors")


def main():
    parser = argparse.ArgumentParser(
        description="Layer 1: Refine MinerU formula extractions using pattern-based correction",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Refine single extraction
  python layer1-formula-refinement.py /tmp/mineru-test /tmp/layer1-output

  # Refine with validation
  python layer1-formula-refinement.py INPUT_DIR OUTPUT_DIR --validate

  # Process production extractions
  python layer1-formula-refinement.py \\
    literature/pdfs/extractions-mineru/ \\
    literature/pdfs/extractions-layer1/ \\
    --validate
        """
    )

    parser.add_argument('input_dir', type=Path,
                       help='Directory containing MinerU extractions (auto/ subdirs)')
    parser.add_argument('output_dir', type=Path,
                       help='Output directory for refined markdown')
    parser.add_argument('--validate', action='store_true',
                       help='Run validation checks after refinement')
    parser.add_argument('--debug', action='store_true',
                       help='Enable debug logging')

    args = parser.parse_args()

    if args.debug:
        logger.setLevel(logging.DEBUG)

    # Validate input directory
    if not args.input_dir.exists():
        logger.error(f"Input directory does not exist: {args.input_dir}")
        return 1

    # Run refinement
    try:
        refine_extraction(args.input_dir, args.output_dir, args.validate)
        logger.info(f"\n✓ Refinement complete. Output: {args.output_dir}")
        return 0
    except Exception as e:
        logger.error(f"Refinement failed: {e}", exc_info=True)
        return 1


if __name__ == '__main__':
    exit(main())
