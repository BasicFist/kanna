#!/usr/bin/env python3
"""
PDF Collection Analyzer
Comprehensive analysis tool for academic PDF collections
Handles: statistics, metadata extraction, duplicate detection
"""

import os
import sys
import hashlib
import json
import csv
from pathlib import Path
from collections import defaultdict
from datetime import datetime
import subprocess

try:
    from pypdf import PdfReader
except ImportError:
    print("ERROR: pypdf not installed. Run: pip install --user pypdf")
    sys.exit(1)


class PDFAnalyzer:
    """Analyze PDF collections for thesis organization"""

    def __init__(self, root_dir):
        self.root_dir = Path(root_dir)
        self.pdf_files = []
        self.metadata = []
        self.duplicates = defaultdict(list)
        self.stats = {
            'total_files': 0,
            'total_pdfs': 0,
            'total_size': 0,
            'by_directory': defaultdict(lambda: {'count': 0, 'size': 0}),
            'by_extension': defaultdict(int),
            'corrupted_pdfs': [],
            'missing_metadata': []
        }

    def scan_directory(self):
        """Scan directory tree and collect all files"""
        print(f"📂 Scanning directory: {self.root_dir}")

        for root, dirs, files in os.walk(self.root_dir):
            for file in files:
                filepath = Path(root) / file
                if file.startswith('.'):
                    continue

                self.stats['total_files'] += 1
                file_size = filepath.stat().st_size
                self.stats['total_size'] += file_size

                # Track by extension
                ext = filepath.suffix.lower()
                self.stats['by_extension'][ext] += 1

                # Track by directory
                rel_path = filepath.relative_to(self.root_dir)
                top_dir = str(rel_path.parts[0]) if rel_path.parts else 'root'
                self.stats['by_directory'][top_dir]['count'] += 1
                self.stats['by_directory'][top_dir]['size'] += file_size

                # Collect PDF files
                if ext == '.pdf':
                    self.stats['total_pdfs'] += 1
                    self.pdf_files.append(filepath)

        print(f"✓ Found {self.stats['total_files']} files ({self.stats['total_pdfs']} PDFs)")
        print(f"✓ Total size: {self._format_size(self.stats['total_size'])}")
        return self.pdf_files

    def extract_metadata(self, progress_interval=50):
        """Extract metadata from all PDF files"""
        print(f"\n📋 Extracting metadata from {len(self.pdf_files)} PDFs...")

        for idx, pdf_path in enumerate(self.pdf_files, 1):
            if idx % progress_interval == 0:
                print(f"  Progress: {idx}/{len(self.pdf_files)} ({idx*100//len(self.pdf_files)}%)")

            metadata = self._extract_pdf_metadata(pdf_path)
            self.metadata.append(metadata)

            # Track missing metadata
            if not metadata.get('title') or metadata.get('title') == '':
                self.stats['missing_metadata'].append(str(pdf_path))

        print(f"✓ Metadata extracted from {len(self.metadata)} PDFs")
        print(f"⚠ {len(self.stats['missing_metadata'])} PDFs have missing titles")
        return self.metadata

    def _extract_pdf_metadata(self, pdf_path):
        """Extract metadata from single PDF file"""
        metadata = {
            'filepath': str(pdf_path),
            'filename': pdf_path.name,
            'size': pdf_path.stat().st_size,
            'modified': datetime.fromtimestamp(pdf_path.stat().st_mtime).isoformat(),
            'title': '',
            'author': '',
            'subject': '',
            'creator': '',
            'producer': '',
            'creation_date': '',
            'page_count': 0,
            'error': None
        }

        try:
            reader = PdfReader(str(pdf_path))
            metadata['page_count'] = len(reader.pages)

            if reader.metadata:
                metadata['title'] = reader.metadata.get('/Title', '') or ''
                metadata['author'] = reader.metadata.get('/Author', '') or ''
                metadata['subject'] = reader.metadata.get('/Subject', '') or ''
                metadata['creator'] = reader.metadata.get('/Creator', '') or ''
                metadata['producer'] = reader.metadata.get('/Producer', '') or ''

                # Handle creation date
                creation_date = reader.metadata.get('/CreationDate', '')
                if creation_date:
                    metadata['creation_date'] = str(creation_date)

        except Exception as e:
            metadata['error'] = str(e)
            self.stats['corrupted_pdfs'].append({
                'file': str(pdf_path),
                'error': str(e)
            })

        return metadata

    def find_duplicates(self, hash_algorithm='md5'):
        """Find duplicate PDFs using content hashing"""
        print(f"\n🔍 Finding duplicates using {hash_algorithm.upper()} hashing...")

        hash_map = defaultdict(list)

        for idx, pdf_path in enumerate(self.pdf_files, 1):
            if idx % 50 == 0:
                print(f"  Hashing: {idx}/{len(self.pdf_files)} ({idx*100//len(self.pdf_files)}%)")

            file_hash = self._compute_file_hash(pdf_path, hash_algorithm)
            hash_map[file_hash].append(pdf_path)

        # Find duplicate sets (hash with multiple files)
        duplicate_count = 0
        duplicate_sets = 0

        for file_hash, files in hash_map.items():
            if len(files) > 1:
                duplicate_sets += 1
                duplicate_count += len(files) - 1  # All but one are duplicates
                self.duplicates[file_hash] = files

        print(f"✓ Found {duplicate_sets} sets of duplicates")
        print(f"✓ Total duplicate files: {duplicate_count}")

        if duplicate_count > 0:
            wasted_space = sum(
                sum(f.stat().st_size for f in files[1:])
                for files in self.duplicates.values()
            )
            print(f"✓ Space wasted by duplicates: {self._format_size(wasted_space)}")

        return self.duplicates

    def _compute_file_hash(self, filepath, algorithm='md5'):
        """Compute hash of file content"""
        if algorithm == 'md5':
            hasher = hashlib.md5()
        elif algorithm == 'sha256':
            hasher = hashlib.sha256()
        else:
            hasher = hashlib.md5()

        try:
            with open(filepath, 'rb') as f:
                while chunk := f.read(8192):
                    hasher.update(chunk)
            return hasher.hexdigest()
        except Exception as e:
            return f"ERROR:{e}"

    def export_metadata_csv(self, output_file):
        """Export metadata to CSV file"""
        print(f"\n💾 Exporting metadata to {output_file}...")

        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            if not self.metadata:
                print("⚠ No metadata to export")
                return

            fieldnames = list(self.metadata[0].keys())
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(self.metadata)

        print(f"✓ Exported {len(self.metadata)} records to {output_file}")

    def export_duplicates_report(self, output_file):
        """Export duplicate files report"""
        print(f"\n💾 Exporting duplicates report to {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("=" * 80 + "\n")
            f.write("DUPLICATE FILES REPORT\n")
            f.write(f"Generated: {datetime.now().isoformat()}\n")
            f.write("=" * 80 + "\n\n")

            if not self.duplicates:
                f.write("No duplicates found!\n")
                print("✓ No duplicates to report")
                return

            total_sets = len(self.duplicates)
            total_duplicates = sum(len(files) - 1 for files in self.duplicates.values())

            f.write(f"Total duplicate sets: {total_sets}\n")
            f.write(f"Total duplicate files: {total_duplicates}\n\n")

            for idx, (file_hash, files) in enumerate(self.duplicates.items(), 1):
                f.write(f"\n{'='*80}\n")
                f.write(f"DUPLICATE SET #{idx}\n")
                f.write(f"Hash: {file_hash}\n")
                f.write(f"Files: {len(files)}\n")
                f.write(f"Size: {self._format_size(files[0].stat().st_size)}\n")
                f.write(f"Wasted space: {self._format_size(files[0].stat().st_size * (len(files) - 1))}\n")
                f.write(f"\n")

                for file in sorted(files):
                    rel_path = file.relative_to(self.root_dir)
                    f.write(f"  - {rel_path}\n")

        print(f"✓ Exported {total_sets} duplicate sets to {output_file}")

    def export_statistics_report(self, output_file):
        """Export comprehensive statistics report"""
        print(f"\n💾 Exporting statistics report to {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("=" * 80 + "\n")
            f.write("PDF COLLECTION STATISTICS REPORT\n")
            f.write(f"Directory: {self.root_dir}\n")
            f.write(f"Generated: {datetime.now().isoformat()}\n")
            f.write("=" * 80 + "\n\n")

            # Overall stats
            f.write("OVERALL STATISTICS\n")
            f.write("-" * 80 + "\n")
            f.write(f"Total files: {self.stats['total_files']}\n")
            f.write(f"Total PDFs: {self.stats['total_pdfs']}\n")
            f.write(f"Total size: {self._format_size(self.stats['total_size'])}\n")
            f.write(f"Corrupted PDFs: {len(self.stats['corrupted_pdfs'])}\n")
            f.write(f"PDFs with missing titles: {len(self.stats['missing_metadata'])}\n")
            f.write("\n")

            # By directory
            f.write("BREAKDOWN BY DIRECTORY\n")
            f.write("-" * 80 + "\n")
            for directory in sorted(self.stats['by_directory'].keys()):
                info = self.stats['by_directory'][directory]
                f.write(f"{directory:30} {info['count']:6} files  {self._format_size(info['size']):>10}\n")
            f.write("\n")

            # By file type
            f.write("BREAKDOWN BY FILE TYPE\n")
            f.write("-" * 80 + "\n")
            for ext in sorted(self.stats['by_extension'].keys(), key=lambda x: self.stats['by_extension'][x], reverse=True):
                count = self.stats['by_extension'][ext]
                f.write(f"{ext:15} {count:6} files\n")
            f.write("\n")

            # Corrupted files
            if self.stats['corrupted_pdfs']:
                f.write("CORRUPTED/UNREADABLE PDFs\n")
                f.write("-" * 80 + "\n")
                for item in self.stats['corrupted_pdfs']:
                    f.write(f"File: {item['file']}\n")
                    f.write(f"Error: {item['error']}\n\n")

        print(f"✓ Statistics report exported to {output_file}")

    def export_missing_metadata_list(self, output_file):
        """Export list of PDFs with missing metadata"""
        print(f"\n💾 Exporting missing metadata list to {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("PDFs WITH MISSING TITLES\n")
            f.write("=" * 80 + "\n\n")

            for filepath in sorted(self.stats['missing_metadata']):
                rel_path = Path(filepath).relative_to(self.root_dir)
                f.write(f"{rel_path}\n")

        print(f"✓ Exported {len(self.stats['missing_metadata'])} files to {output_file}")

    @staticmethod
    def _format_size(size_bytes):
        """Format byte size to human-readable format"""
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_bytes < 1024.0:
                return f"{size_bytes:.1f} {unit}"
            size_bytes /= 1024.0
        return f"{size_bytes:.1f} TB"


def main():
    """Main execution function"""
    root_dir = Path.cwd()

    print("="*80)
    print("PDF COLLECTION ANALYZER")
    print("="*80)
    print(f"Root directory: {root_dir}\n")

    # Initialize analyzer
    analyzer = PDFAnalyzer(root_dir)

    # Scan directory
    analyzer.scan_directory()

    # Extract metadata
    analyzer.extract_metadata()

    # Find duplicates
    analyzer.find_duplicates()

    # Create output directory
    output_dir = root_dir / "analysis_results"
    output_dir.mkdir(exist_ok=True)
    print(f"\n📁 Output directory: {output_dir}")

    # Export all reports
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    analyzer.export_metadata_csv(output_dir / f"metadata_catalog_{timestamp}.csv")
    analyzer.export_duplicates_report(output_dir / f"duplicates_report_{timestamp}.txt")
    analyzer.export_statistics_report(output_dir / f"statistics_report_{timestamp}.txt")
    analyzer.export_missing_metadata_list(output_dir / f"missing_metadata_{timestamp}.txt")

    print("\n" + "="*80)
    print("✅ ANALYSIS COMPLETE!")
    print("="*80)
    print(f"\nAll reports saved to: {output_dir}")
    print("\nNext steps:")
    print("  1. Review the reports in the analysis_results/ directory")
    print("  2. Check duplicates_report.txt for files that can be removed")
    print("  3. Review missing_metadata.txt for papers needing manual metadata")
    print("  4. Use metadata_catalog.csv for searching and organizing")


if __name__ == "__main__":
    main()
