#!/usr/bin/env python3
"""
Simple Extraction Quality Validator for MinerU Output
Generates quality scores and flags papers needing re-extraction
"""

import json
import os
import re
from pathlib import Path
from collections import defaultdict

# Configuration
EXTRACTION_DIR = Path("/home/miko/LAB/projects/KANNA/literature/pdfs/extractions")
MIN_WORDS = 500  # Minimum words for valid extraction
MIN_QUALITY_SCORE = 6  # Out of 8

def count_formulas(md_content):
    """Count LaTeX formulas (both inline $ $ and display $$ $$)"""
    inline = len(re.findall(r'\$[^\$]+\$', md_content))
    display = len(re.findall(r'\$\$[^\$]+\$\$', md_content))
    return inline + display

def count_headings(md_content):
    """Count markdown headings (structure quality indicator)"""
    return len(re.findall(r'^#+\s+', md_content, re.MULTILINE))

def count_tables(md_content):
    """Count markdown tables"""
    return len(re.findall(r'\|.*\|', md_content)) // 2  # Rough estimate

def has_chemical_structures(md_content):
    """Detect SMILES or InChI strings (chemical papers)"""
    has_smiles = bool(re.search(r'[A-Z][a-z]?(\([^\)]+\))?([=\-#]|[A-Z][a-z]?)+', md_content))
    has_inchi = bool(re.search(r'InChI=1S?/', md_content))
    return has_smiles or has_inchi

def check_french_accents(md_content):
    """Check if French accents are preserved"""
    french_chars = re.findall(r'[àâäéèêëïîôùûüÿçœæ]', md_content, re.IGNORECASE)
    return len(french_chars) > 0

def validate_extraction(auto_dir):
    """Validate single extraction and return quality score (0-8)"""

    score = 0
    issues = []

    # Find markdown file
    md_files = list(auto_dir.glob("*.md"))
    if not md_files:
        return 0, ["No markdown file found"], {
            'word_count': 0,
            'formula_count': 0,
            'heading_count': 0,
            'table_count': 0,
            'file_size_kb': 0,
            'has_images': False
        }

    md_file = md_files[0]
    md_content = md_file.read_text(errors='ignore')

    # Factor 1: File size (>5KB = 1 point)
    file_size_kb = md_file.stat().st_size / 1024
    if file_size_kb > 5:
        score += 1
    else:
        issues.append(f"Small file size: {file_size_kb:.1f}KB")

    # Factor 2: Word count (>MIN_WORDS = 1 point)
    word_count = len(md_content.split())
    if word_count >= MIN_WORDS:
        score += 1
    else:
        issues.append(f"Low word count: {word_count}")

    # Factor 3: Formula detection (>0 = 1 point)
    formula_count = count_formulas(md_content)
    if formula_count > 0:
        score += 1
    # No issue if 0 formulas (not all papers have them)

    # Factor 4: Heading structure (>5 headings = 1 point)
    heading_count = count_headings(md_content)
    if heading_count > 5:
        score += 1
    else:
        issues.append(f"Poor structure: {heading_count} headings")

    # Factor 5: Images extracted (1 point if directory exists and not empty)
    img_dir = auto_dir / "images"
    has_images = False
    if img_dir.exists():
        try:
            has_images = any(True for _ in img_dir.iterdir())
        except OSError:
            has_images = False
    if has_images:
        score += 1
    # No issue if no images (some papers may not have them)

    # Factor 6: Visualization PDFs (layout.pdf = 1 point)
    if (auto_dir / f"{auto_dir.parent.name}_layout.pdf").exists():
        score += 1
    else:
        issues.append("Missing visualization PDF")

    # Factor 7: Table detection (>0 tables = 1 point)
    table_count = count_tables(md_content)
    if table_count > 0:
        score += 1
    # No issue if 0 tables

    # Factor 8: Special content (chemical structures OR French accents = 1 point)
    if has_chemical_structures(md_content) or check_french_accents(md_content):
        score += 1

    return score, issues, {
        'word_count': word_count,
        'formula_count': formula_count,
        'heading_count': heading_count,
        'table_count': table_count,
        'file_size_kb': file_size_kb,
        'has_images': has_images
    }

def main():
    print("=" * 70)
    print("MinerU Extraction Quality Validator (Simple)")
    print("=" * 70)
    print()

    # Find all extraction directories
    auto_dirs = list(EXTRACTION_DIR.glob("*/auto"))

    if not auto_dirs:
        print(f"⚠ No extractions found in {EXTRACTION_DIR}")
        return

    print(f"Found {len(auto_dirs)} extractions to validate\n")

    results = []
    quality_distribution = defaultdict(int)

    for auto_dir in sorted(auto_dirs):
        paper_name = auto_dir.parent.name
        score, issues, metrics = validate_extraction(auto_dir)
        quality_distribution[score] += 1

        results.append({
            'paper': paper_name,
            'score': score,
            'issues': issues,
            'metrics': metrics
        })

        # Print summary
        status = "✅" if score >= MIN_QUALITY_SCORE else "⚠"
        print(f"{status} {paper_name[:60]:<60} | Score: {score}/8 | Words: {metrics['word_count']:>5} | Formulas: {metrics['formula_count']:>2}")
        if issues and score < MIN_QUALITY_SCORE:
            for issue in issues:
                print(f"     → {issue}")

    # Summary statistics
    print("\n" + "=" * 70)
    print("QUALITY DISTRIBUTION")
    print("=" * 70)
    for score in range(9):
        count = quality_distribution[score]
        bar = "█" * count
        print(f"Score {score}/8: {bar} ({count} papers)")

    avg_score = sum(r['score'] for r in results) / len(results)
    print(f"\nAverage Score: {avg_score:.2f}/8")

    # Papers needing re-extraction
    low_quality = [r for r in results if r['score'] < MIN_QUALITY_SCORE]
    print(f"\n⚠ Papers needing re-extraction ({len(low_quality)} total, score <{MIN_QUALITY_SCORE}):")
    for r in low_quality:
        print(f"  - {r['paper']} (score: {r['score']}/8)")

    # Priority papers (Chapter 4 pharmacology with formulas)
    print("\n🎯 Priority papers for LaTeX-OCR enhancement (with formulas):")
    formula_papers = [r for r in results if r['metrics']['formula_count'] > 2]
    for r in sorted(formula_papers, key=lambda x: x['metrics']['formula_count'], reverse=True)[:15]:
        print(f"  - {r['paper'][:50]} ({r['metrics']['formula_count']} formulas)")

    # Export report
    report_file = Path.home() / "LAB/logs" / f"mineru-quality-report-simple.json"
    report_file.parent.mkdir(parents=True, exist_ok=True)
    with open(report_file, 'w') as f:
        json.dump({
            'total_papers': len(results),
            'average_score': avg_score,
            'quality_distribution': dict(quality_distribution),
            'low_quality_papers': [r['paper'] for r in low_quality],
            'priority_formula_papers': [r['paper'] for r in formula_papers[:20]],
            'detailed_results': results
        }, f, indent=2)

    print(f"\n📄 Detailed report saved to: {report_file}")

if __name__ == "__main__":
    main()
