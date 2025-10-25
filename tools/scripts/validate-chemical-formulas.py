#!/usr/bin/env python3
"""
Chemical Formula Validator using RDKit
Codex recommendation: "Run chemical formula validators (RDKit parsing)
on extracted equations to catch garbled text"

Usage:
    python validate-chemical-formulas.py <markdown-file>
    python validate-chemical-formulas.py <extraction-dir> --batch

Environment: conda activate kanna (requires RDKit)
"""

import sys
import re
from pathlib import Path
from typing import List, Tuple, Dict
from dataclasses import dataclass

try:
    from rdkit import Chem
    from rdkit.Chem import Descriptors
except ImportError:
    print("Error: RDKit not installed")
    print("Install with: conda activate kanna && conda install -c conda-forge rdkit")
    sys.exit(1)


@dataclass
class FormulaValidation:
    """Validation result for a chemical formula"""
    formula: str
    is_valid: bool
    mol_weight: float = 0.0
    smiles: str = ""
    error: str = ""


class ChemicalFormulaValidator:
    """
    Validate chemical formulas extracted from PDFs

    Codex: "Catch garbled text" in formula extraction
    Key validation: Can RDKit parse it as a valid molecular formula?
    """

    # Common pharmacologically relevant elements
    PHARMA_ELEMENTS = {
        'C', 'H', 'N', 'O', 'S', 'P', 'F', 'Cl', 'Br', 'I',
        'Na', 'K', 'Ca', 'Mg', 'Fe', 'Zn'
    }

    # Mesembrine alkaloids from Sceletium (for validation testing)
    KNOWN_KANNA_ALKALOIDS = {
        'C17H23NO3': 'Mesembrine',
        'C18H25NO3': 'Mesembrenone',
        'C17H23NO2': 'Mesembrenol',
        'C18H25NO2': '4′-O-Demethylmesembrenone'
    }

    def __init__(self):
        self.validated = []
        self.invalid = []
        self.stats = {'total': 0, 'valid': 0, 'invalid': 0, 'kanna_alkaloids': 0}

    def validate_formula(self, formula: str) -> FormulaValidation:
        """
        Validate a single chemical formula using RDKit

        Returns FormulaValidation with parsing results
        """
        formula = formula.strip()

        try:
            # Attempt to create molecule from formula
            mol = Chem.MolFromFormula(formula)

            if mol is None:
                return FormulaValidation(
                    formula=formula,
                    is_valid=False,
                    error="RDKit parsing failed"
                )

            # Calculate molecular weight
            mol_weight = Descriptors.MolWt(mol)

            # Generate SMILES (if possible)
            smiles = Chem.MolToSmiles(mol) if mol else ""

            # Check if this is a known Kanna alkaloid
            is_kanna = formula in self.KNOWN_KANNA_ALKALOIDS

            return FormulaValidation(
                formula=formula,
                is_valid=True,
                mol_weight=mol_weight,
                smiles=smiles,
                error=f"Kanna alkaloid: {self.KNOWN_KANNA_ALKALOIDS[formula]}" if is_kanna else ""
            )

        except Exception as e:
            return FormulaValidation(
                formula=formula,
                is_valid=False,
                error=str(e)
            )

    def extract_and_validate(self, markdown_path: Path) -> List[FormulaValidation]:
        """
        Extract and validate all chemical formulas from markdown

        Codex: "Compare extracted formulas against validation to catch garbled text"
        """
        content = markdown_path.read_text(encoding='utf-8', errors='ignore')

        # Extract potential formulas (Hill system pattern)
        # C, H, N, O + other elements with optional subscripts
        formula_pattern = re.compile(
            r'\b([A-Z][a-z]?\d*(?:[A-Z][a-z]?\d*){1,20})\b'
        )

        potential_formulas = formula_pattern.findall(content)

        # Filter to likely formulas (must contain C, reasonable length)
        likely_formulas = [
            f for f in set(potential_formulas)
            if 'C' in f and 5 <= len(f) <= 30 and any(c.isdigit() for c in f)
        ]

        # Validate each formula
        results = []
        for formula in sorted(set(likely_formulas)):
            validation = self.validate_formula(formula)
            results.append(validation)

            self.stats['total'] += 1
            if validation.is_valid:
                self.stats['valid'] += 1
                self.validated.append(validation)
                if validation.error and 'Kanna' in validation.error:
                    self.stats['kanna_alkaloids'] += 1
            else:
                self.stats['invalid'] += 1
                self.invalid.append(validation)

        return results

    def print_report(self, markdown_path: Path, results: List[FormulaValidation]):
        """Print validation report"""
        print("=" * 80)
        print(f"Chemical Formula Validation: {markdown_path.name}")
        print("=" * 80)
        print()

        print(f"Total formulas found: {len(results)}")
        print(f"Valid: {sum(1 for r in results if r.is_valid)}")
        print(f"Invalid: {sum(1 for r in results if not r.is_valid)}")

        kanna_count = sum(1 for r in results if 'Kanna' in r.error)
        if kanna_count > 0:
            print(f"✨ Kanna alkaloids detected: {kanna_count}")

        print()

        # Valid formulas
        valid_results = [r for r in results if r.is_valid]
        if valid_results:
            print("Valid Formulas:")
            print("-" * 80)
            for r in sorted(valid_results, key=lambda x: x.mol_weight, reverse=True):
                kanna_marker = "✨ " if 'Kanna' in r.error else "   "
                print(f"{kanna_marker}{r.formula:15} | MW: {r.mol_weight:7.2f} | {r.error or 'Valid'}")
            print()

        # Invalid formulas (likely extraction errors)
        invalid_results = [r for r in results if not r.is_valid]
        if invalid_results:
            print("Invalid Formulas (likely extraction errors):")
            print("-" * 80)
            for r in invalid_results:
                print(f"⚠️  {r.formula:15} | Error: {r.error}")
            print()

    def print_summary(self):
        """Print overall validation summary"""
        print("=" * 80)
        print("Validation Summary (All Documents)")
        print("=" * 80)
        print()

        print(f"Total formulas validated: {self.stats['total']}")
        print(f"Valid: {self.stats['valid']} ({100*self.stats['valid']/self.stats['total'] if self.stats['total'] else 0:.1f}%)")
        print(f"Invalid: {self.stats['invalid']} ({100*self.stats['invalid']/self.stats['total'] if self.stats['total'] else 0:.1f}%)")

        if self.stats['kanna_alkaloids'] > 0:
            print()
            print(f"✨ Kanna alkaloids found: {self.stats['kanna_alkaloids']}")
            print("   (Mesembrine, Mesembrenone, Mesembrenol, 4'-O-Demethylmesembrenone)")

        print()

        # Quality assessment (Codex: detect garbled extractions)
        if self.stats['total'] > 0:
            quality_score = self.stats['valid'] / self.stats['total']
            if quality_score >= 0.9:
                print("✅ Extraction Quality: EXCELLENT (≥90% valid formulas)")
            elif quality_score >= 0.7:
                print("✓  Extraction Quality: GOOD (≥70% valid formulas)")
            elif quality_score >= 0.5:
                print("⚠️  Extraction Quality: MODERATE (50-70% valid)")
            else:
                print("❌ Extraction Quality: POOR (<50% valid) - Consider Vision-LLM fallback")


def main():
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python validate-chemical-formulas.py <markdown-file>")
        print("  python validate-chemical-formulas.py <extraction-dir> --batch")
        print()
        print("Examples:")
        print("  python validate-chemical-formulas.py literature/pdfs/extractions-mineru/paper1/auto/paper1.md")
        print("  python validate-chemical-formulas.py literature/pdfs/extractions-mineru/ --batch")
        sys.exit(1)

    input_path = Path(sys.argv[1])
    batch_mode = '--batch' in sys.argv

    validator = ChemicalFormulaValidator()

    if batch_mode and input_path.is_dir():
        # Batch processing
        md_files = list(input_path.rglob("*.md"))

        if not md_files:
            print(f"No markdown files found in {input_path}")
            sys.exit(1)

        print(f"Found {len(md_files)} markdown files")
        print()

        for md_file in md_files:
            results = validator.extract_and_validate(md_file)
            if results:
                validator.print_report(md_file, results)

        validator.print_summary()

    elif input_path.is_file():
        # Single file
        results = validator.extract_and_validate(input_path)
        validator.print_report(input_path, results)

    else:
        print(f"Error: {input_path} not found")
        sys.exit(1)


if __name__ == '__main__':
    main()
