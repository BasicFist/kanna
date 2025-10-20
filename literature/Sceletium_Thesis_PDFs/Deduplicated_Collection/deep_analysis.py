#!/usr/bin/env python3
"""
Deep Analysis Script for Deduplicated Collection
Performs comprehensive multi-dimensional analysis
"""

import os
import sys
from pathlib import Path
from collections import defaultdict, Counter
import re
from datetime import datetime
import csv

try:
    from pypdf import PdfReader
except ImportError:
    print("Installing pypdf...")
    os.system("pip install --user pypdf")
    from pypdf import PdfReader

class DeepAnalyzer:
    def __init__(self, collection_dir):
        self.collection_dir = Path(collection_dir)
        self.pdfs = []
        self.metadata = []
        self.topic_distribution = defaultdict(list)
        self.year_distribution = defaultdict(list)
        self.author_network = defaultdict(set)
        self.size_analysis = []

    def scan_collection(self):
        """Scan all PDFs in collection"""
        print("Scanning collection...")

        for topic_dir in self.collection_dir.iterdir():
            if not topic_dir.is_dir() or topic_dir.name.startswith('.'):
                continue

            for pdf_file in topic_dir.glob("*.pdf"):
                self.pdfs.append({
                    'path': pdf_file,
                    'topic': topic_dir.name,
                    'filename': pdf_file.name,
                    'size': pdf_file.stat().st_size
                })

        print(f"Found {len(self.pdfs)} PDFs")

    def extract_deep_metadata(self):
        """Extract comprehensive metadata from each PDF"""
        print("\nExtracting metadata (this may take a minute)...")

        for i, pdf_info in enumerate(self.pdfs):
            if (i + 1) % 50 == 0:
                print(f"  Processed {i + 1}/{len(self.pdfs)} files...")

            try:
                reader = PdfReader(pdf_info['path'])
                meta = reader.metadata or {}

                # Extract metadata
                title = meta.get('/Title', '').strip()
                author = meta.get('/Author', '').strip()
                subject = meta.get('/Subject', '').strip()
                keywords = meta.get('/Keywords', '').strip()
                creator = meta.get('/Creator', '').strip()
                producer = meta.get('/Producer', '').strip()

                # Page count
                page_count = len(reader.pages)

                # Extract year from filename
                year_match = re.match(r'(\d{4})', pdf_info['filename'])
                year = int(year_match.group(1)) if year_match else None

                # Extract author from filename
                filename_parts = pdf_info['filename'].replace('.pdf', '').split(' - ')
                filename_author = filename_parts[1] if len(filename_parts) > 1 else ''

                # Build comprehensive metadata record
                record = {
                    'filepath': str(pdf_info['path']),
                    'topic': pdf_info['topic'],
                    'filename': pdf_info['filename'],
                    'size': pdf_info['size'],
                    'size_mb': round(pdf_info['size'] / (1024*1024), 2),
                    'pages': page_count,
                    'title': title,
                    'author': author,
                    'filename_author': filename_author,
                    'subject': subject,
                    'keywords': keywords,
                    'creator': creator,
                    'producer': producer,
                    'year': year,
                    'has_title': bool(title),
                    'has_author': bool(author),
                    'has_keywords': bool(keywords),
                    'metadata_score': sum([bool(title), bool(author), bool(subject), bool(keywords)])
                }

                self.metadata.append(record)

                # Populate distributions
                self.topic_distribution[pdf_info['topic']].append(record)
                if year:
                    self.year_distribution[year].append(record)

            except Exception as e:
                print(f"  Error processing {pdf_info['filename']}: {e}")

        print(f"  Completed: {len(self.metadata)}/{len(self.pdfs)} files")

    def analyze_metadata_quality(self):
        """Analyze metadata completeness"""
        print("\n" + "="*80)
        print("METADATA QUALITY ANALYSIS")
        print("="*80)

        total = len(self.metadata)
        with_title = sum(1 for m in self.metadata if m['has_title'])
        with_author = sum(1 for m in self.metadata if m['has_author'])
        with_keywords = sum(1 for m in self.metadata if m['has_keywords'])

        print(f"\nTotal PDFs: {total}")
        print(f"With embedded title:    {with_title:3d} ({with_title/total*100:.1f}%)")
        print(f"With embedded author:   {with_author:3d} ({with_author/total*100:.1f}%)")
        print(f"With keywords:          {with_keywords:3d} ({with_keywords/total*100:.1f}%)")

        # Metadata score distribution
        score_dist = Counter(m['metadata_score'] for m in self.metadata)
        print("\nMetadata Completeness Score (0-4):")
        for score in sorted(score_dist.keys(), reverse=True):
            count = score_dist[score]
            bar = "█" * int(count / 5)
            print(f"  Score {score}: {count:3d} files {bar}")

        # Best and worst metadata
        best = sorted(self.metadata, key=lambda x: x['metadata_score'], reverse=True)[:5]
        worst = sorted(self.metadata, key=lambda x: x['metadata_score'])[:10]

        print("\nBest metadata (top 5):")
        for m in best:
            print(f"  {m['filename'][:60]} (score: {m['metadata_score']})")

        print("\nWorst metadata (bottom 10):")
        for m in worst:
            print(f"  {m['filename'][:60]} (score: {m['metadata_score']})")

        return {
            'total': total,
            'with_title': with_title,
            'with_author': with_author,
            'with_keywords': with_keywords,
            'score_distribution': dict(score_dist)
        }

    def analyze_size_anomalies(self):
        """Identify size anomalies"""
        print("\n" + "="*80)
        print("SIZE ANOMALY ANALYSIS")
        print("="*80)

        sizes = [m['size_mb'] for m in self.metadata]
        avg_size = sum(sizes) / len(sizes)

        # Calculate statistics
        sorted_sizes = sorted(sizes)
        median_size = sorted_sizes[len(sorted_sizes)//2]
        min_size = min(sizes)
        max_size = max(sizes)

        print(f"\nSize Statistics:")
        print(f"  Average:   {avg_size:.2f} MB")
        print(f"  Median:    {median_size:.2f} MB")
        print(f"  Min:       {min_size:.2f} MB")
        print(f"  Max:       {max_size:.2f} MB")

        # Find anomalies
        unusually_small = [m for m in self.metadata if m['size_mb'] < 0.1]  # < 100 KB
        unusually_large = [m for m in self.metadata if m['size_mb'] > 10.0]  # > 10 MB

        print(f"\nUnusually small files (< 100 KB): {len(unusually_small)}")
        for m in unusually_small[:10]:
            print(f"  {m['size_mb']:.2f} MB - {m['filename'][:60]}")

        print(f"\nUnusually large files (> 10 MB): {len(unusually_large)}")
        for m in unusually_large[:10]:
            print(f"  {m['size_mb']:.2f} MB - {m['filename'][:60]}")

        return {
            'avg_size': avg_size,
            'median_size': median_size,
            'unusually_small': len(unusually_small),
            'unusually_large': len(unusually_large)
        }

    def analyze_page_counts(self):
        """Analyze page count distribution"""
        print("\n" + "="*80)
        print("PAGE COUNT ANALYSIS")
        print("="*80)

        pages = [m['pages'] for m in self.metadata]
        avg_pages = sum(pages) / len(pages)

        # Categorize by page count
        categories = {
            'Short (1-5 pages)': [m for m in self.metadata if 1 <= m['pages'] <= 5],
            'Medium (6-15 pages)': [m for m in self.metadata if 6 <= m['pages'] <= 15],
            'Standard (16-30 pages)': [m for m in self.metadata if 16 <= m['pages'] <= 30],
            'Long (31-50 pages)': [m for m in self.metadata if 31 <= m['pages'] <= 50],
            'Very Long (51+ pages)': [m for m in self.metadata if m['pages'] > 50]
        }

        print(f"\nAverage page count: {avg_pages:.1f} pages")
        print("\nDistribution by length:")
        for category, papers in categories.items():
            print(f"  {category:25s}: {len(papers):3d} papers")

        # Find outliers
        shortest = sorted(self.metadata, key=lambda x: x['pages'])[:5]
        longest = sorted(self.metadata, key=lambda x: x['pages'], reverse=True)[:5]

        print("\nShortest papers:")
        for m in shortest:
            print(f"  {m['pages']:3d} pages - {m['filename'][:55]}")

        print("\nLongest papers:")
        for m in longest:
            print(f"  {m['pages']:3d} pages - {m['filename'][:55]}")

        return categories

    def analyze_temporal_distribution(self):
        """Analyze publication years and trends"""
        print("\n" + "="*80)
        print("TEMPORAL DISTRIBUTION ANALYSIS")
        print("="*80)

        years_with_data = [m['year'] for m in self.metadata if m['year']]

        if not years_with_data:
            print("No year data available")
            return

        min_year = min(years_with_data)
        max_year = max(years_with_data)

        print(f"\nYear range: {min_year} - {max_year}")
        print(f"Papers with year data: {len(years_with_data)}/{len(self.metadata)}")

        # Decade distribution
        decade_dist = defaultdict(int)
        for year in years_with_data:
            decade = (year // 10) * 10
            decade_dist[decade] += 1

        print("\nBy decade:")
        for decade in sorted(decade_dist.keys()):
            count = decade_dist[decade]
            bar = "█" * (count // 5)
            print(f"  {decade}s: {count:3d} papers {bar}")

        # Year-over-year trend (last 10 years)
        recent_years = sorted([y for y in years_with_data if y >= max_year - 10])
        year_counts = Counter(recent_years)

        print(f"\nRecent trend (last 10 years):")
        for year in sorted(year_counts.keys()):
            count = year_counts[year]
            bar = "█" * (count // 3)
            print(f"  {year}: {count:3d} papers {bar}")

        return decade_dist

    def analyze_topic_classification(self):
        """Analyze topic distribution and potential misclassifications"""
        print("\n" + "="*80)
        print("TOPIC CLASSIFICATION ANALYSIS")
        print("="*80)

        print("\nPapers per topic:")
        for topic in sorted(self.topic_distribution.keys()):
            papers = self.topic_distribution[topic]
            avg_size = sum(p['size_mb'] for p in papers) / len(papers)
            avg_pages = sum(p['pages'] for p in papers) / len(papers)

            print(f"\n{topic}:")
            print(f"  Papers: {len(papers)}")
            print(f"  Avg size: {avg_size:.2f} MB")
            print(f"  Avg pages: {avg_pages:.1f}")

            # Show sample titles
            samples = [p for p in papers if p['has_title']][:3]
            if samples:
                print(f"  Sample titles:")
                for s in samples:
                    print(f"    - {s['title'][:70]}")

    def identify_cross_topic_papers(self):
        """Identify papers that might belong to multiple topics"""
        print("\n" + "="*80)
        print("CROSS-TOPIC PAPER IDENTIFICATION")
        print("="*80)

        # Look for similar titles across different topics
        title_map = defaultdict(list)

        for m in self.metadata:
            if m['has_title']:
                # Normalize title
                normalized = re.sub(r'[^\w\s]', '', m['title'].lower())
                # Use first 5 words as signature
                words = normalized.split()[:5]
                signature = ' '.join(words)
                title_map[signature].append(m)

        cross_topic = []
        for signature, papers in title_map.items():
            topics = set(p['topic'] for p in papers)
            if len(topics) > 1 and len(papers) > 1:
                cross_topic.append((signature, papers))

        print(f"\nFound {len(cross_topic)} potential cross-topic paper groups")

        if cross_topic:
            print("\nSample cross-topic papers:")
            for signature, papers in cross_topic[:5]:
                topics = ', '.join(set(p['topic'] for p in papers))
                print(f"\n  '{signature[:60]}...'")
                print(f"  Topics: {topics}")
                print(f"  Files: {len(papers)}")

        return cross_topic

    def generate_comprehensive_report(self, output_file):
        """Generate final comprehensive report"""
        print("\n" + "="*80)
        print("GENERATING COMPREHENSIVE REPORT")
        print("="*80)

        with open(output_file, 'w') as f:
            f.write("="*80 + "\n")
            f.write("COMPREHENSIVE DEEP ANALYSIS REPORT\n")
            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write("="*80 + "\n\n")

            f.write("COLLECTION OVERVIEW\n")
            f.write("-"*80 + "\n")
            f.write(f"Total PDFs: {len(self.metadata)}\n")
            f.write(f"Total size: {sum(m['size_mb'] for m in self.metadata):.1f} MB\n")
            f.write(f"Total pages: {sum(m['pages'] for m in self.metadata):,}\n")
            f.write(f"Avg pages per paper: {sum(m['pages'] for m in self.metadata)/len(self.metadata):.1f}\n\n")

            # Export detailed CSV
            csv_file = str(output_file).replace('.txt', '_detailed.csv')
            with open(csv_file, 'w', newline='', encoding='utf-8') as csvf:
                fieldnames = ['topic', 'filename', 'year', 'pages', 'size_mb', 'has_title',
                             'has_author', 'metadata_score', 'title', 'author', 'keywords']
                writer = csv.DictWriter(csvf, fieldnames=fieldnames)
                writer.writeheader()

                for m in sorted(self.metadata, key=lambda x: (x['topic'], x['filename'])):
                    writer.writerow({k: m.get(k, '') for k in fieldnames})

            f.write(f"Detailed data exported to: {csv_file}\n\n")

        print(f"\nReport saved to: {output_file}")
        print(f"Detailed CSV saved to: {csv_file}")

def main():
    collection_dir = Path(__file__).parent

    print("="*80)
    print("DEEP ANALYSIS OF DEDUPLICATED COLLECTION")
    print("="*80)
    print(f"\nAnalyzing: {collection_dir}\n")

    analyzer = DeepAnalyzer(collection_dir)

    # Run all analyses
    analyzer.scan_collection()
    analyzer.extract_deep_metadata()
    analyzer.analyze_metadata_quality()
    analyzer.analyze_size_anomalies()
    analyzer.analyze_page_counts()
    analyzer.analyze_temporal_distribution()
    analyzer.analyze_topic_classification()
    analyzer.identify_cross_topic_papers()

    # Generate final report
    output_file = collection_dir / f"DEEP_ANALYSIS_REPORT_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
    analyzer.generate_comprehensive_report(output_file)

    print("\n" + "="*80)
    print("ANALYSIS COMPLETE")
    print("="*80)

if __name__ == "__main__":
    main()
