#!/usr/bin/env python3
"""
File-by-File Inspector
Individually examines each PDF with detailed diagnostics
"""

import os
from pathlib import Path
from datetime import datetime
import hashlib

try:
    from pypdf import PdfReader
except ImportError:
    print("Installing pypdf...")
    os.system("pip install --user pypdf")
    from pypdf import PdfReader

class FileInspector:
    def __init__(self, base_dir):
        self.base_dir = Path(base_dir)
        self.issues = []
        self.warnings = []
        self.notes = []

    def compute_hash(self, filepath):
        """Compute MD5 hash"""
        md5 = hashlib.md5()
        with open(filepath, 'rb') as f:
            for chunk in iter(lambda: f.read(8192), b''):
                md5.update(chunk)
        return md5.hexdigest()

    def inspect_file(self, filepath):
        """Perform detailed inspection of a single file"""
        result = {
            'filename': filepath.name,
            'path': str(filepath.relative_to(self.base_dir)),
            'size_bytes': filepath.stat().st_size,
            'size_mb': round(filepath.stat().st_size / (1024*1024), 2),
            'hash': None,
            'pages': None,
            'metadata': {},
            'issues': [],
            'warnings': [],
            'classification': None,
            'recommendation': None
        }

        # Compute hash
        try:
            result['hash'] = self.compute_hash(filepath)
        except Exception as e:
            result['issues'].append(f"Hash computation failed: {e}")

        # Extract PDF metadata and content
        try:
            reader = PdfReader(filepath)
            result['pages'] = len(reader.pages)

            # Get metadata
            meta = reader.metadata or {}
            result['metadata'] = {
                'title': meta.get('/Title', '').strip(),
                'author': meta.get('/Author', '').strip(),
                'subject': meta.get('/Subject', '').strip(),
                'keywords': meta.get('/Keywords', '').strip(),
                'creator': meta.get('/Creator', '').strip(),
                'producer': meta.get('/Producer', '').strip(),
                'creation_date': str(meta.get('/CreationDate', '')),
            }

            # Try to extract first page text for content verification
            try:
                first_page = reader.pages[0]
                text = first_page.extract_text()[:500]  # First 500 chars
                result['first_page_preview'] = text.replace('\n', ' ').strip()
            except:
                result['first_page_preview'] = '[Could not extract text]'

        except Exception as e:
            result['issues'].append(f"PDF read error: {e}")
            return result

        # Classification and analysis
        self.classify_file(result)

        return result

    def classify_file(self, result):
        """Classify file and identify issues"""
        filename = result['filename'].lower()
        size_mb = result['size_mb']
        pages = result['pages'] or 0
        title = result['metadata'].get('title', '')

        # Size-based classification
        if size_mb < 0.1:
            result['classification'] = 'REFERENCE_LIST'
            result['warnings'].append(f'Very small file ({size_mb} MB)')
            result['recommendation'] = 'Move to 99_Supplementary_Data/Reference_Lists/'

        elif size_mb > 10 or pages > 100:
            result['classification'] = 'BOOK'
            result['warnings'].append(f'Large file ({size_mb} MB, {pages} pages)')
            result['recommendation'] = 'Move to 08_Reference_Books/'

        # Keyword-based classification
        elif any(kw in filename for kw in ['réf', 'scifinder', 'brevets']):
            result['classification'] = 'REFERENCE_LIST'
            result['warnings'].append('Reference list keyword in filename')
            result['recommendation'] = 'Move to 99_Supplementary_Data/Reference_Lists/'

        elif 'corrigendum' in filename or 'erratum' in filename:
            if pages == 1:
                result['classification'] = 'CORRIGENDUM'
                result['warnings'].append('Single-page correction notice')
                result['recommendation'] = 'Move to 99_Supplementary_Data/Corrigenda/'

        elif any(kw in filename for kw in ['pharmacopoeia', 'archaeology', 'ecology']):
            result['classification'] = 'BOOK'
            result['recommendation'] = 'Move to 08_Reference_Books/'

        else:
            result['classification'] = 'RESEARCH_PAPER'

        # Metadata quality checks
        if not title:
            result['warnings'].append('Missing embedded title')

        if not result['metadata'].get('author'):
            result['warnings'].append('Missing embedded author')

        # Filename quality checks
        if filename.startswith('doi'):
            result['warnings'].append('DOI-based filename (not descriptive)')

        if 'untitled' in filename:
            result['warnings'].append('Generic "Untitled" filename')

        if '_1' in filename or '_2' in filename:
            result['warnings'].append('Collision suffix detected (possible duplicate)')

        # Content validation
        if pages == 1 and 'corrigendum' not in filename:
            result['warnings'].append('Single-page document (verify if complete)')

        if pages and pages > 500:
            result['warnings'].append(f'Extremely long ({pages} pages) - likely a book')

    def inspect_directory(self, topic_dir):
        """Inspect all files in a directory"""
        print(f"\n{'='*80}")
        print(f"INSPECTING: {topic_dir.name}")
        print(f"{'='*80}")

        files = sorted(topic_dir.glob("*.pdf"))
        print(f"\nTotal files: {len(files)}\n")

        results = []

        for i, pdf_file in enumerate(files, 1):
            print(f"[{i}/{len(files)}] {pdf_file.name}")

            result = self.inspect_file(pdf_file)
            results.append(result)

            # Print immediate findings
            print(f"  Size: {result['size_mb']} MB | Pages: {result['pages']} | Type: {result['classification']}")

            if result['metadata']['title']:
                title = result['metadata']['title'][:70]
                print(f"  Title: {title}...")
            else:
                print(f"  Title: [NO METADATA]")

            if result['issues']:
                for issue in result['issues']:
                    print(f"  ✗ ISSUE: {issue}")

            if result['warnings']:
                for warning in result['warnings']:
                    print(f"  ⚠ WARNING: {warning}")

            if result['recommendation']:
                print(f"  → {result['recommendation']}")

            print()

        return results

    def generate_report(self, all_results, output_file):
        """Generate comprehensive file-by-file report"""
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("="*80 + "\n")
            f.write("FILE-BY-FILE INSPECTION REPORT\n")
            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write("="*80 + "\n\n")

            # Summary statistics
            total_files = len(all_results)
            by_classification = {}
            total_issues = 0
            total_warnings = 0

            for result in all_results:
                cls = result['classification']
                by_classification[cls] = by_classification.get(cls, 0) + 1
                total_issues += len(result['issues'])
                total_warnings += len(result['warnings'])

            f.write("SUMMARY\n")
            f.write("-"*80 + "\n")
            f.write(f"Total files inspected: {total_files}\n")
            f.write(f"Total issues found: {total_issues}\n")
            f.write(f"Total warnings: {total_warnings}\n\n")

            f.write("Classification Breakdown:\n")
            for cls, count in sorted(by_classification.items()):
                pct = (count / total_files) * 100
                f.write(f"  {cls:25s}: {count:3d} ({pct:5.1f}%)\n")

            f.write("\n" + "="*80 + "\n")
            f.write("DETAILED FILE-BY-FILE ANALYSIS\n")
            f.write("="*80 + "\n\n")

            # Group by topic directory
            by_topic = {}
            for result in all_results:
                topic = result['path'].split('/')[0]
                if topic not in by_topic:
                    by_topic[topic] = []
                by_topic[topic].append(result)

            for topic in sorted(by_topic.keys()):
                f.write(f"\n{'='*80}\n")
                f.write(f"TOPIC: {topic}\n")
                f.write(f"{'='*80}\n\n")

                for result in by_topic[topic]:
                    f.write(f"FILE: {result['filename']}\n")
                    f.write(f"Path: {result['path']}\n")
                    f.write(f"Size: {result['size_mb']} MB ({result['size_bytes']:,} bytes)\n")
                    f.write(f"Pages: {result['pages']}\n")
                    f.write(f"Hash: {result['hash']}\n")
                    f.write(f"Classification: {result['classification']}\n")

                    f.write(f"\nMetadata:\n")
                    for key, value in result['metadata'].items():
                        if value:
                            f.write(f"  {key:15s}: {value[:100]}\n")

                    if result['first_page_preview']:
                        preview = result['first_page_preview'][:200]
                        f.write(f"\nFirst Page Preview:\n  {preview}...\n")

                    if result['issues']:
                        f.write(f"\n✗ ISSUES:\n")
                        for issue in result['issues']:
                            f.write(f"  - {issue}\n")

                    if result['warnings']:
                        f.write(f"\n⚠ WARNINGS:\n")
                        for warning in result['warnings']:
                            f.write(f"  - {warning}\n")

                    if result['recommendation']:
                        f.write(f"\n→ RECOMMENDATION: {result['recommendation']}\n")

                    f.write(f"\n{'-'*80}\n\n")

        print(f"\nReport saved to: {output_file}")

def main():
    base_dir = Path(__file__).parent

    print("="*80)
    print("FILE-BY-FILE INSPECTION")
    print("="*80)
    print(f"\nWorking directory: {base_dir}")
    print("This will inspect every PDF individually...\n")

    inspector = FileInspector(base_dir)
    all_results = []

    # Inspect each topic directory
    topic_dirs = [
        '00_Core_References',
        '01_Sceletium_Pharmacology',
        '02_Ethnopharmacology',
        '03_PDE4_Neurogenesis',
        '04_Clinical_Trials',
        '05_Khoi_San_Traditional',
        '06_Related_Compounds'
    ]

    for topic in topic_dirs:
        topic_path = base_dir / topic
        if topic_path.exists():
            results = inspector.inspect_directory(topic_path)
            all_results.extend(results)

    # Generate comprehensive report
    output_file = base_dir / f"FILE_BY_FILE_INSPECTION_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
    inspector.generate_report(all_results, output_file)

    print("\n" + "="*80)
    print("INSPECTION COMPLETE")
    print("="*80)
    print(f"\nInspected {len(all_results)} files")
    print(f"Report: {output_file.name}")

if __name__ == "__main__":
    main()
