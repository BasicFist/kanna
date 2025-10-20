#!/usr/bin/env python3
"""
Create Author and Year Distribution Indexes
Analyze metadata to create searchable indexes
"""

import csv
from pathlib import Path
from collections import defaultdict, Counter
from datetime import datetime
import re


def extract_year_from_date(date_str):
    """Extract year from various date formats"""
    if not date_str:
        return None

    # Try to find 4-digit year
    match = re.search(r'(19|20)\d{2}', str(date_str))
    if match:
        return match.group(0)

    return None


def extract_year_from_filename(filename):
    """Extract year from filename if present"""
    # Look for patterns like "2021 - Author" or "Author_2021_"
    match = re.search(r'(19|20)\d{2}', filename)
    if match:
        return match.group(0)
    return None


def main():
    print("="*80)
    print("CREATING AUTHOR & YEAR INDEXES")
    print("="*80)
    print()

    # Find latest metadata CSV
    analysis_dir = Path("analysis_results")
    metadata_files = sorted(analysis_dir.glob("metadata_catalog_*.csv"))

    if not metadata_files:
        print("ERROR: Could not find metadata catalog!")
        return

    metadata_csv = metadata_files[-1]
    print(f"Using: {metadata_csv.name}\n")

    # Load metadata
    papers = []
    with open(metadata_csv, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        papers = list(reader)

    print(f"Loaded {len(papers)} papers\n")

    # Create author index
    print("📚 Creating author index...")
    authors = defaultdict(list)
    author_count = Counter()

    for paper in papers:
        author = paper.get('author', '').strip()
        if author:
            # Split multiple authors (common separators: ; , and &)
            author_list = re.split(r'[;,&]|\sand\s', author)
            for auth in author_list:
                auth = auth.strip()
                if auth:
                    authors[auth].append(paper['filepath'])
                    author_count[auth] += 1

    # Export author index
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    author_file = analysis_dir / f"author_index_{timestamp}.txt"

    with open(author_file, 'w', encoding='utf-8') as f:
        f.write("="*80 + "\n")
        f.write("AUTHOR INDEX\n")
        f.write(f"Generated: {datetime.now().isoformat()}\n")
        f.write("="*80 + "\n\n")

        f.write(f"Total unique authors: {len(authors)}\n")
        f.write(f"Total papers with authors: {sum(author_count.values())}\n\n")

        f.write("TOP 20 AUTHORS BY PAPER COUNT\n")
        f.write("-"*80 + "\n")
        for author, count in author_count.most_common(20):
            f.write(f"{count:4} papers  {author}\n")

        f.write("\n\nCOMPLETE AUTHOR LIST\n")
        f.write("="*80 + "\n\n")

        for author in sorted(authors.keys()):
            f.write(f"\n{author} ({len(authors[author])} papers)\n")
            f.write("-"*80 + "\n")
            for filepath in sorted(authors[author]):
                rel_path = Path(filepath).name
                f.write(f"  - {rel_path}\n")

    print(f"✓ Author index created: {author_file.name}")
    print(f"  - {len(authors)} unique authors")
    print(f"  - Top author: {author_count.most_common(1)[0] if author_count else 'N/A'}\n")

    # Create year distribution
    print("📅 Creating year distribution...")
    years = defaultdict(list)
    year_count = Counter()

    for paper in papers:
        # Try to get year from creation date
        year = extract_year_from_date(paper.get('creation_date', ''))

        # Fall back to filename
        if not year:
            year = extract_year_from_filename(paper.get('filename', ''))

        if year:
            years[year].append(paper['filepath'])
            year_count[year] += 1

    # Export year distribution
    year_file = analysis_dir / f"year_distribution_{timestamp}.txt"

    with open(year_file, 'w', encoding='utf-8') as f:
        f.write("="*80 + "\n")
        f.write("YEAR DISTRIBUTION INDEX\n")
        f.write(f"Generated: {datetime.now().isoformat()}\n")
        f.write("="*80 + "\n\n")

        f.write(f"Total papers with year information: {sum(year_count.values())}\n")
        f.write(f"Papers without year: {len(papers) - sum(year_count.values())}\n")
        f.write(f"Year range: {min(years.keys()) if years else 'N/A'} - {max(years.keys()) if years else 'N/A'}\n\n")

        f.write("DISTRIBUTION BY YEAR\n")
        f.write("-"*80 + "\n")
        for year in sorted(years.keys(), reverse=True):
            count = year_count[year]
            bar = '#' * (count // 5)  # Visual bar chart
            f.write(f"{year}  {count:4} papers  {bar}\n")

        f.write("\n\nPAPERS BY YEAR\n")
        f.write("="*80 + "\n")

        for year in sorted(years.keys(), reverse=True):
            f.write(f"\n{year} ({len(years[year])} papers)\n")
            f.write("-"*80 + "\n")
            for filepath in sorted(years[year]):
                rel_path = Path(filepath).name
                f.write(f"  - {rel_path}\n")

    print(f"✓ Year distribution created: {year_file.name}")
    if years:
        recent_year = max(years.keys())
        oldest_year = min(years.keys())
        print(f"  - Year range: {oldest_year} - {recent_year}")
        print(f"  - Most papers: {year_count.most_common(1)[0]}\n")

    # Create topic analysis (basic keyword extraction)
    print("🔍 Creating topic analysis...")
    topic_keywords = {
        'Sceletium': ['sceletium', 'kanna', 'kougoed'],
        'Alkaloids': ['mesembrine', 'mesembrenone', 'alkaloid', 'mesembrenol'],
        'Neurogenesis': ['neurogenesis', 'hippocampus', 'neuroplasticity'],
        'PDE4': ['pde4', 'pde-4', 'phosphodiesterase'],
        'Addiction': ['addiction', 'drug abuse', 'substance'],
        'Ethnopharmacology': ['ethnopharmacology', 'traditional', 'indigenous'],
        'Anxiety/Depression': ['anxiety', 'depression', 'antidepressant'],
        'Khoi-San': ['khoi', 'san', 'khoisan', 'bushmen']
    }

    topics = defaultdict(list)

    for paper in papers:
        title = (paper.get('title', '') or '').lower()
        filename = paper.get('filename', '').lower()
        combined = title + ' ' + filename

        for topic, keywords in topic_keywords.items():
            if any(kw in combined for kw in keywords):
                topics[topic].append(paper['filepath'])

    # Export topic analysis
    topic_file = analysis_dir / f"topic_analysis_{timestamp}.txt"

    with open(topic_file, 'w', encoding='utf-8') as f:
        f.write("="*80 + "\n")
        f.write("TOPIC ANALYSIS\n")
        f.write(f"Generated: {datetime.now().isoformat()}\n")
        f.write("="*80 + "\n\n")

        f.write("PAPERS BY TOPIC\n")
        f.write("-"*80 + "\n")
        for topic in sorted(topics.keys(), key=lambda x: len(topics[x]), reverse=True):
            count = len(topics[topic])
            f.write(f"{topic:25} {count:4} papers\n")

        f.write("\n\nDETAILED TOPIC BREAKDOWN\n")
        f.write("="*80 + "\n")

        for topic in sorted(topics.keys()):
            f.write(f"\n{topic} ({len(topics[topic])} papers)\n")
            f.write("-"*80 + "\n")
            for filepath in sorted(set(topics[topic])):  # Remove duplicates
                rel_path = Path(filepath).name
                f.write(f"  - {rel_path}\n")

    print(f"✓ Topic analysis created: {topic_file.name}")
    print(f"  - {len(topics)} topics identified\n")

    print("="*80)
    print("✅ INDEXES CREATED!")
    print("="*80)
    print("\nCreated files:")
    print(f"  - {author_file.name}")
    print(f"  - {year_file.name}")
    print(f"  - {topic_file.name}")
    print()


if __name__ == "__main__":
    main()
