#!/usr/bin/env python3
"""
MinerU Extraction Quality Validator
Based on Codex recommendations for detecting low-quality extractions

Usage:
    python validate-mineru-quality.py <extraction-dir>

Output:
    - Quality metrics per PDF
    - Fallback recommendations (which PDFs need Vision-LLM)
    - Chemical formula validation status
"""

import sys
import json
import re
from pathlib import Path
from typing import Dict, List, Tuple
from dataclasses import dataclass

@dataclass
class QualityMetrics:
    """Quality metrics for PDF extraction"""
    pdf_name: str
    total_pages: int
    extracted_chars: int
    avg_chars_per_page: float
    has_tables: bool
    has_equations: bool
    detected_formulas: List[str]
    word_count: int
    needs_fallback: bool
    fallback_reason: str = ""
    confidence_score: float = 0.0


class MinerUQualityValidator:
    """Validate MinerU extraction quality based on Codex recommendations"""

    # Codex-recommended thresholds
    MIN_WORD_COUNT = 100
    MIN_CHARS_PER_PAGE = 200
    MIN_CONFIDENCE = 0.75

    # Chemical formula patterns (basic Hill system)
    FORMULA_PATTERN = re.compile(
        r'\b[A-Z][a-z]?\d*(?:[A-Z][a-z]?\d*)*\b'
    )

    # Academic section headers (Codex: check for expected structure)
    SECTION_HEADERS = [
        r'abstract',
        r'introduction',
        r'methods?',
        r'results?',
        r'discussion',
        r'conclusion',
        r'references?'
    ]

    def __init__(self, extraction_dir: Path):
        self.extraction_dir = Path(extraction_dir)

    def validate_extraction(self, pdf_dir: Path) -> QualityMetrics:
        """
        Validate a single PDF extraction

        Codex recommendations implemented:
        1. Check word count & char count (coverage)
        2. Detect chemical formulas (structure validation)
        3. Check for expected sections (completeness)
        4. Flag low-quality extractions for fallback
        """
        pdf_name = pdf_dir.name

        # Find markdown output
        md_files = list(pdf_dir.rglob("*.md"))
        if not md_files:
            return QualityMetrics(
                pdf_name=pdf_name,
                total_pages=0,
                extracted_chars=0,
                avg_chars_per_page=0,
                has_tables=False,
                has_equations=False,
                detected_formulas=[],
                word_count=0,
                needs_fallback=True,
                fallback_reason="No markdown output found"
            )

        # Read markdown content
        md_path = md_files[0]
        content = md_path.read_text(encoding='utf-8', errors='ignore')

        # Basic metrics
        word_count = len(content.split())
        char_count = len(content)

        # Detect tables (markdown table syntax)
        has_tables = '|' in content and ('---' in content or '====' in content)

        # Detect equations (LaTeX markers)
        has_equations = '$$' in content or '$' in content or '\\(' in content

        # Extract chemical formulas
        formulas = self._extract_formulas(content)

        # Check for academic structure
        has_structure = self._check_academic_structure(content)

        # Calculate pages (rough estimate from content length)
        estimated_pages = max(1, char_count // 3000)  # ~3000 chars/page
        avg_chars_per_page = char_count / estimated_pages

        # Determine if fallback needed (Codex: multi-factor decision)
        needs_fallback = False
        fallback_reason = ""

        if word_count < self.MIN_WORD_COUNT:
            needs_fallback = True
            fallback_reason = f"Low word count ({word_count} < {self.MIN_WORD_COUNT})"
        elif avg_chars_per_page < self.MIN_CHARS_PER_PAGE:
            needs_fallback = True
            fallback_reason = f"Low chars/page ({avg_chars_per_page:.0f} < {self.MIN_CHARS_PER_PAGE})"
        elif not has_structure and word_count > 500:
            needs_fallback = True
            fallback_reason = "Missing expected academic structure"

        # Calculate confidence score (simple heuristic)
        confidence = self._calculate_confidence(
            word_count, avg_chars_per_page, has_structure, has_tables
        )

        return QualityMetrics(
            pdf_name=pdf_name,
            total_pages=estimated_pages,
            extracted_chars=char_count,
            avg_chars_per_page=avg_chars_per_page,
            has_tables=has_tables,
            has_equations=has_equations,
            detected_formulas=formulas[:10],  # First 10 formulas
            word_count=word_count,
            needs_fallback=needs_fallback,
            fallback_reason=fallback_reason,
            confidence_score=confidence
        )

    def _extract_formulas(self, content: str) -> List[str]:
        """Extract potential chemical formulas (Codex: validation target)"""
        formulas = []

        # Find LaTeX math blocks
        latex_blocks = re.findall(r'\$\$(.*?)\$\$|\$(.*?)\$', content, re.DOTALL)
        for block in latex_blocks:
            text = block[0] or block[1]
            # Extract potential formulas from LaTeX
            potential = self.FORMULA_PATTERN.findall(text)
            formulas.extend(potential)

        # Find inline formulas (C6H12O6 pattern)
        inline = self.FORMULA_PATTERN.findall(content)
        formulas.extend(inline)

        return list(set(formulas))  # Deduplicate

    def _check_academic_structure(self, content: str) -> bool:
        """Check if document has expected academic sections"""
        content_lower = content.lower()

        # Count how many standard sections are present
        found_sections = sum(
            1 for pattern in self.SECTION_HEADERS
            if re.search(pattern, content_lower)
        )

        # Need at least 3 standard sections for academic paper
        return found_sections >= 3

    def _calculate_confidence(
        self, word_count: int, chars_per_page: float,
        has_structure: bool, has_tables: bool
    ) -> float:
        """
        Calculate extraction confidence score

        Codex recommendation: Multi-factor quality assessment
        """
        score = 0.0

        # Word count component (0-0.4)
        if word_count >= self.MIN_WORD_COUNT:
            score += 0.4 * min(1.0, word_count / 3000)

        # Chars per page component (0-0.3)
        if chars_per_page >= self.MIN_CHARS_PER_PAGE:
            score += 0.3 * min(1.0, chars_per_page / 3000)

        # Structure component (0-0.2)
        if has_structure:
            score += 0.2

        # Table detection component (0-0.1)
        if has_tables:
            score += 0.1

        return min(1.0, score)

    def validate_all(self) -> List[QualityMetrics]:
        """Validate all extractions in directory"""
        results = []

        # Find all PDF extraction directories
        pdf_dirs = [d for d in self.extraction_dir.iterdir() if d.is_dir()]

        for pdf_dir in sorted(pdf_dirs):
            metrics = self.validate_extraction(pdf_dir)
            results.append(metrics)

        return results

    def print_report(self, results: List[QualityMetrics]):
        """Print validation report (Codex: actionable insights)"""
        print("=" * 80)
        print("MinerU Extraction Quality Report")
        print("=" * 80)
        print()

        total = len(results)
        needs_fallback = sum(1 for r in results if r.needs_fallback)
        high_quality = sum(1 for r in results if r.confidence_score >= 0.8)

        print(f"Total PDFs: {total}")
        print(f"High Quality (≥0.8): {high_quality} ({100*high_quality/total if total else 0:.1f}%)")
        print(f"Needs Fallback: {needs_fallback} ({100*needs_fallback/total if total else 0:.1f}%)")
        print()

        # Fallback candidates
        if needs_fallback > 0:
            print("=" * 80)
            print("PDFs Requiring Vision-LLM Fallback")
            print("=" * 80)
            print()

            for r in results:
                if r.needs_fallback:
                    print(f"📄 {r.pdf_name}")
                    print(f"   Reason: {r.fallback_reason}")
                    print(f"   Words: {r.word_count}, Confidence: {r.confidence_score:.2f}")
                    print()

        # Quality summary
        print("=" * 80)
        print("Quality Distribution")
        print("=" * 80)
        print()

        for r in sorted(results, key=lambda x: x.confidence_score, reverse=True)[:10]:
            status = "✅" if not r.needs_fallback else "⚠️ "
            formulas = f", {len(r.detected_formulas)} formulas" if r.detected_formulas else ""
            print(f"{status} {r.pdf_name[:50]:50} | Score: {r.confidence_score:.2f} | "
                  f"{r.word_count:5} words{formulas}")

        if total > 10:
            print(f"... and {total - 10} more")

        print()


def main():
    if len(sys.argv) < 2:
        print("Usage: python validate-mineru-quality.py <extraction-dir>")
        print()
        print("Example:")
        print("  python validate-mineru-quality.py literature/pdfs/extractions-mineru/")
        sys.exit(1)

    extraction_dir = Path(sys.argv[1])

    if not extraction_dir.exists():
        print(f"Error: Directory not found: {extraction_dir}")
        sys.exit(1)

    validator = MinerUQualityValidator(extraction_dir)
    results = validator.validate_all()

    if not results:
        print("No extractions found in directory")
        sys.exit(0)

    validator.print_report(results)

    # Export JSON for programmatic use
    json_output = extraction_dir / "quality-report.json"
    with open(json_output, 'w') as f:
        json.dump(
            [
                {
                    'pdf': r.pdf_name,
                    'words': r.word_count,
                    'confidence': r.confidence_score,
                    'needs_fallback': r.needs_fallback,
                    'reason': r.fallback_reason,
                    'formulas': r.detected_formulas
                }
                for r in results
            ],
            f,
            indent=2
        )

    print(f"📊 Full report saved to: {json_output}")


if __name__ == '__main__':
    main()
