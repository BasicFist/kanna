#!/usr/bin/env python3
"""
Quality Assessment for MinerU Extractions
Generates comprehensive quality metrics for all extracted papers
"""

import re
from pathlib import Path
from collections import defaultdict
import json

# Configuration
EXTRACTION_DIR = Path("/home/miko/LAB/projects/KANNA/literature/pdfs/extractions-mineru")
MIN_WORDS = 500  # Minimum words for valid extraction
OUTPUT_REPORT = Path.home() / "LAB/logs" / "mineru-quality-report.json"

def analyze_extraction(md_file):
    """Analyze single markdown extraction"""

    content = md_file.read_text(errors='ignore')

    metrics = {
        'file_size_bytes': md_file.stat().st_size,
        'file_size_kb': md_file.stat().st_size / 1024,
        'word_count': len(content.split()),
        'character_count': len(content),
        'line_count': len(content.split('\n')),
        'page_count': len(re.findall(r'^## Page \d+', content, re.MULTILINE)),
        'table_count': len(re.findall(r'\|.*\|', content)) // 3,  # Rough estimate
        'has_tables': '|' in content,
        'has_numbers': bool(re.search(r'\d+', content)),
        'avg_words_per_page': 0,
    }

    # Calculate avg words per page
    if metrics['page_count'] > 0:
        metrics['avg_words_per_page'] = metrics['word_count'] // metrics['page_count']

    # Quality score (0-5)
    score = 0
    issues = []

    # Factor 1: File size (>5KB)
    if metrics['file_size_kb'] > 5:
        score += 1
    else:
        issues.append(f"Small file: {metrics['file_size_kb']:.1f}KB")

    # Factor 2: Word count (>MIN_WORDS)
    if metrics['word_count'] >= MIN_WORDS:
        score += 1
    else:
        issues.append(f"Low word count: {metrics['word_count']}")

    # Factor 3: Page detection (>2 pages)
    if metrics['page_count'] > 2:
        score += 1
    else:
        issues.append(f"Few pages: {metrics['page_count']}")

    # Factor 4: Content density (>100 words/page)
    if metrics['avg_words_per_page'] > 100:
        score += 1
    else:
        issues.append(f"Low density: {metrics['avg_words_per_page']} words/page")

    # Factor 5: Tables present
    if metrics['has_tables']:
        score += 1

    metrics['quality_score'] = score
    metrics['issues'] = issues

    return metrics

def main():
    print("=" * 70)
    print("MinerU Extraction Quality Assessment")
    print("=" * 70)
    print()

    # Find all markdown files (in auto/ subdirectories)
    md_files = list(EXTRACTION_DIR.glob("*/auto/*.md"))

    if not md_files:
        print(f"⚠ No markdown files found in {EXTRACTION_DIR}")
        return

    print(f"Found {len(md_files)} extracted papers\n")

    results = []
    quality_distribution = defaultdict(int)
    total_words = 0
    total_pages = 0

    for md_file in sorted(md_files):
        # MinerU structure: [paper-name]/auto/[paper-name].md
        # Get the grandparent directory name (paper name)
        paper_name = md_file.parent.parent.name
        metrics = analyze_extraction(md_file)

        quality_distribution[metrics['quality_score']] += 1
        total_words += metrics['word_count']
        total_pages += metrics['page_count']

        results.append({
            'paper': paper_name,
            'metrics': metrics
        })

        # Print summary
        status = "✅" if metrics['quality_score'] >= 4 else "⚠"
        print(f"{status} {paper_name[:60]:<60} | Score: {metrics['quality_score']}/5 | Words: {metrics['word_count']:>6} | Pages: {metrics['page_count']:>3}")

        if metrics['issues'] and metrics['quality_score'] < 4:
            for issue in metrics['issues']:
                print(f"     → {issue}")

    # Summary statistics
    print("\n" + "=" * 70)
    print("SUMMARY STATISTICS")
    print("=" * 70)

    avg_score = sum(r['metrics']['quality_score'] for r in results) / len(results)
    avg_words = total_words / len(results)
    avg_pages = total_pages / len(results)

    print(f"Total papers:        {len(results)}")
    print(f"Total words:         {total_words:,}")
    print(f"Total pages:         {total_pages}")
    print(f"Average score:       {avg_score:.2f}/5")
    print(f"Average words:       {avg_words:.0f} per paper")
    print(f"Average pages:       {avg_pages:.1f} per paper")

    print("\nQuality Distribution:")
    for score in range(6):
        count = quality_distribution[score]
        bar = "█" * (count // 5) if count > 0 else ""
        print(f"  Score {score}/5: {bar} ({count} papers)")

    # Low quality papers
    low_quality = [r for r in results if r['metrics']['quality_score'] < 3]
    if low_quality:
        print(f"\n⚠ Low quality papers ({len(low_quality)} total, score <3):")
        for r in low_quality[:10]:  # Show first 10
            print(f"  - {r['paper'][:60]} (score: {r['metrics']['quality_score']}/5)")

    # High quality papers
    high_quality = [r for r in results if r['metrics']['quality_score'] >= 4]
    print(f"\n✅ High quality papers: {len(high_quality)}/{len(results)} ({len(high_quality)*100//len(results)}%)")

    # Export report
    OUTPUT_REPORT.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_REPORT, 'w') as f:
        json.dump({
            'total_papers': len(results),
            'total_words': total_words,
            'total_pages': total_pages,
            'average_score': avg_score,
            'average_words': avg_words,
            'average_pages': avg_pages,
            'quality_distribution': dict(quality_distribution),
            'low_quality_papers': [r['paper'] for r in low_quality],
            'high_quality_papers': [r['paper'] for r in high_quality],
            'detailed_results': results
        }, f, indent=2)

    print(f"\n📄 Detailed report saved to: {OUTPUT_REPORT}")

if __name__ == "__main__":
    main()
