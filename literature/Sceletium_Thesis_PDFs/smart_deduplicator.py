#!/usr/bin/env python3
"""
Smart PDF Deduplication Script
Analyzes duplicate sets and creates intelligent removal strategy
Keeps "best" version based on multiple criteria
"""

import os
import sys
import json
import csv
from pathlib import Path
from collections import defaultdict
from datetime import datetime

try:
    from pypdf import PdfReader
except ImportError:
    print("ERROR: pypdf not installed. Run: pip install --user pypdf")
    sys.exit(1)


class SmartDeduplicator:
    """Intelligent PDF deduplication with ranking"""

    # Directory priority (higher = keep preferentially)
    DIRECTORY_PRIORITY = {
        'THESE_Main_Library': 100,
        'TEZ_Core': 90,
        'ZOTPDF_References': 70,
        'Other_Collections': 50,
        'DRAFTSS_Working': 30
    }

    def __init__(self, metadata_csv, duplicates_report):
        self.metadata_csv = Path(metadata_csv)
        self.duplicates_report = Path(duplicates_report)
        self.metadata_map = {}
        self.duplicate_sets = []
        self.removal_plan = []

    def load_metadata(self):
        """Load metadata from CSV"""
        print("📂 Loading metadata catalog...")
        with open(self.metadata_csv, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                self.metadata_map[row['filepath']] = row
        print(f"✓ Loaded metadata for {len(self.metadata_map)} files")

    def parse_duplicates_report(self):
        """Parse duplicates report to extract duplicate sets"""
        print("\n🔍 Parsing duplicates report...")

        with open(self.duplicates_report, 'r', encoding='utf-8') as f:
            content = f.read()

        sets = content.split('='*80)
        current_set = None

        for section in sets:
            if 'DUPLICATE SET #' in section:
                lines = section.strip().split('\n')
                files = []

                for line in lines:
                    if line.strip().startswith('- '):
                        filepath = line.strip()[2:]  # Remove '- '
                        files.append(filepath)

                if files:
                    self.duplicate_sets.append(files)

        print(f"✓ Found {len(self.duplicate_sets)} duplicate sets")
        return self.duplicate_sets

    def rank_file(self, filepath):
        """Rank a file based on multiple criteria. Higher score = better to keep"""
        score = 0
        filepath = Path(filepath)

        # Get metadata
        metadata = self.metadata_map.get(str(filepath), {})

        # 1. Directory priority (0-100 points)
        for dir_name, priority in self.DIRECTORY_PRIORITY.items():
            if dir_name in str(filepath):
                score += priority
                break

        # 2. File size (larger = better quality, up to 20 points)
        size = int(metadata.get('size', 0))
        score += min(size / (1024 * 100), 20)  # Scale to 0-20 based on 100KB chunks

        # 3. Metadata completeness (up to 30 points)
        if metadata.get('title') and metadata.get('title') != '':
            score += 15
        if metadata.get('author') and metadata.get('author') != '':
            score += 10
        if metadata.get('creation_date') and metadata.get('creation_date') != '':
            score += 5

        # 4. Filename quality (up to 20 points)
        # Prefer descriptive names over UUIDs or numbered directories
        filename = filepath.name
        parent = filepath.parent.name

        if not parent.isdigit():  # Not in numbered directory
            score += 10

        if len(filename) > 30:  # Descriptive filename
            score += 5

        if ' - ' in filename or '_' in filename:  # Structured filename
            score += 5

        # 5. Page count (up to 10 points)
        page_count = int(metadata.get('page_count', 0))
        score += min(page_count / 10, 10)  # Scale to 0-10

        return score

    def analyze_duplicates(self):
        """Analyze each duplicate set and decide which to keep"""
        print("\n🎯 Analyzing duplicates and creating removal strategy...")

        total_to_remove = 0
        total_space_saved = 0

        for idx, file_set in enumerate(self.duplicate_sets, 1):
            if idx % 50 == 0:
                print(f"  Analyzing set {idx}/{len(self.duplicate_sets)}")

            # Rank all files in the set
            ranked = []
            for filepath in file_set:
                score = self.rank_file(filepath)
                metadata = self.metadata_map.get(filepath, {})
                size = int(metadata.get('size', 0))

                ranked.append({
                    'filepath': filepath,
                    'score': score,
                    'size': size,
                    'metadata': metadata
                })

            # Sort by score (highest first)
            ranked.sort(key=lambda x: x['score'], reverse=True)

            # Keep the highest-ranked file, remove the rest
            keeper = ranked[0]
            to_remove = ranked[1:]

            for item in to_remove:
                self.removal_plan.append({
                    'file_to_remove': item['filepath'],
                    'keep_instead': keeper['filepath'],
                    'score_removed': item['score'],
                    'score_kept': keeper['score'],
                    'size': item['size'],
                    'reason': self._generate_reason(item, keeper)
                })

                total_to_remove += 1
                total_space_saved += item['size']

        print(f"✓ Analysis complete!")
        print(f"✓ Files to remove: {total_to_remove}")
        print(f"✓ Space to save: {self._format_size(total_space_saved)}")

        return self.removal_plan

    def _generate_reason(self, removed, kept):
        """Generate human-readable reason for removal decision"""
        reasons = []

        # Check directory priority
        removed_dir = Path(removed['filepath']).parts[0] if Path(removed['filepath']).parts else ''
        kept_dir = Path(kept['filepath']).parts[0] if Path(kept['filepath']).parts else ''

        if removed_dir != kept_dir:
            reasons.append(f"Preferred directory: {kept_dir}")

        # Check metadata
        if kept['metadata'].get('title') and not removed['metadata'].get('title'):
            reasons.append("Better metadata")

        # Check file size
        size_diff = kept['size'] - removed['size']
        if size_diff > 1024:  # More than 1KB difference
            reasons.append(f"Larger file (+{self._format_size(size_diff)})")

        # Check filename
        if len(Path(kept['filepath']).name) > len(Path(removed['filepath']).name) + 10:
            reasons.append("More descriptive filename")

        return '; '.join(reasons) if reasons else "Higher overall score"

    def export_removal_script(self, output_file, dry_run=True):
        """Export bash script to remove duplicates"""
        print(f"\n💾 Exporting removal script to {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("#!/bin/bash\n")
            f.write("#\n")
            f.write("# Smart PDF Deduplication Script\n")
            f.write(f"# Generated: {datetime.now().isoformat()}\n")
            f.write("#\n")
            f.write("# This script removes duplicate PDF files identified by the analyzer.\n")
            f.write("# Files are MOVED to an archive directory (not deleted) for safety.\n")
            f.write("#\n\n")

            f.write("set -e  # Exit on error\n\n")

            f.write("# Configuration\n")
            f.write('BASE_DIR="/home/miko/Documents/Sceletium_Thesis_PDFs"\n')
            f.write('ARCHIVE_DIR="${BASE_DIR}/duplicates_archive_' + datetime.now().strftime("%Y%m%d_%H%M%S") + '"\n\n')

            f.write('echo "Creating archive directory..."\n')
            f.write('mkdir -p "$ARCHIVE_DIR"\n\n')

            f.write(f'echo "Processing {len(self.removal_plan)} duplicate files..."\n')
            f.write('echo ""\n\n')

            f.write("# Move duplicate files to archive\n")
            for idx, item in enumerate(self.removal_plan, 1):
                filepath = item['file_to_remove']
                reason = item['reason']
                size = self._format_size(item['size'])

                f.write(f"\n# File {idx}/{len(self.removal_plan)}: {size}\n")
                f.write(f"# Keeping: {item['keep_instead']}\n")
                f.write(f"# Reason: {reason}\n")

                # Create archive subdirectory structure
                rel_path = Path(filepath)
                archive_path = f"$ARCHIVE_DIR/{rel_path}"

                f.write(f'echo "Moving: {filepath}"\n')
                f.write(f'mkdir -p "$(dirname "{archive_path}")"\n')
                f.write(f'mv "$BASE_DIR/{filepath}" "{archive_path}"\n')

            f.write('\n\necho ""\n')
            f.write('echo "✓ Deduplication complete!"\n')
            f.write(f'echo "✓ Moved {len(self.removal_plan)} files to archive"\n')
            f.write('echo ""\n')
            f.write('echo "Archive location: $ARCHIVE_DIR"\n')
            f.write('echo ""\n')
            f.write('echo "To verify results, check the remaining files in:"\n')
            f.write('echo "  $BASE_DIR"\n')
            f.write('echo ""\n')
            f.write('echo "If everything looks good, you can delete the archive with:"\n')
            f.write('echo "  rm -rf $ARCHIVE_DIR"\n')

        # Make script executable
        os.chmod(output_file, 0o755)

        print(f"✓ Script exported to {output_file}")
        print(f"⚠  IMPORTANT: Review the script before running!")

    def export_removal_report(self, output_file):
        """Export detailed removal report"""
        print(f"\n💾 Exporting removal report to {output_file}...")

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write("="*80 + "\n")
            f.write("SMART DEDUPLICATION REMOVAL PLAN\n")
            f.write(f"Generated: {datetime.now().isoformat()}\n")
            f.write("="*80 + "\n\n")

            f.write(f"Total files to remove: {len(self.removal_plan)}\n")

            total_size = sum(item['size'] for item in self.removal_plan)
            f.write(f"Total space to save: {self._format_size(total_size)}\n\n")

            # Group by directory
            by_directory = defaultdict(list)
            for item in self.removal_plan:
                dir_name = Path(item['file_to_remove']).parts[0] if Path(item['file_to_remove']).parts else 'root'
                by_directory[dir_name].append(item)

            f.write("BREAKDOWN BY SOURCE DIRECTORY\n")
            f.write("-"*80 + "\n")
            for directory in sorted(by_directory.keys()):
                items = by_directory[directory]
                dir_size = sum(item['size'] for item in items)
                f.write(f"{directory:30} {len(items):6} files  {self._format_size(dir_size):>10}\n")
            f.write("\n")

            # Detailed list
            f.write("DETAILED REMOVAL PLAN\n")
            f.write("="*80 + "\n\n")

            for idx, item in enumerate(self.removal_plan, 1):
                f.write(f"\nFILE #{idx}\n")
                f.write(f"{'Remove:':12} {item['file_to_remove']}\n")
                f.write(f"{'Keep:':12} {item['keep_instead']}\n")
                f.write(f"{'Size:':12} {self._format_size(item['size'])}\n")
                f.write(f"{'Score (rm):':12} {item['score_removed']:.1f}\n")
                f.write(f"{'Score (keep):':12} {item['score_kept']:.1f}\n")
                f.write(f"{'Reason:':12} {item['reason']}\n")

        print(f"✓ Report exported to {output_file}")

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
    print("="*80)
    print("SMART PDF DEDUPLICATOR")
    print("="*80)
    print()

    # Find latest analysis results
    analysis_dir = Path("analysis_results")
    if not analysis_dir.exists():
        print("ERROR: analysis_results directory not found!")
        print("Please run pdf_analyzer.py first.")
        sys.exit(1)

    # Find latest files
    metadata_files = sorted(analysis_dir.glob("metadata_catalog_*.csv"))
    duplicate_files = sorted(analysis_dir.glob("duplicates_report_*.txt"))

    if not metadata_files or not duplicate_files:
        print("ERROR: Could not find analysis files!")
        print("Please run pdf_analyzer.py first.")
        sys.exit(1)

    metadata_csv = metadata_files[-1]
    duplicates_report = duplicate_files[-1]

    print(f"Using metadata: {metadata_csv.name}")
    print(f"Using duplicates: {duplicates_report.name}")
    print()

    # Initialize deduplicator
    dedup = SmartDeduplicator(metadata_csv, duplicates_report)

    # Load data
    dedup.load_metadata()
    dedup.parse_duplicates_report()

    # Analyze
    dedup.analyze_duplicates()

    # Export results
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    dedup.export_removal_script(
        analysis_dir / f"remove_duplicates_{timestamp}.sh"
    )

    dedup.export_removal_report(
        analysis_dir / f"removal_plan_{timestamp}.txt"
    )

    print("\n" + "="*80)
    print("✅ DEDUPLICATION PLAN READY!")
    print("="*80)
    print()
    print("Next steps:")
    print(f"  1. Review: analysis_results/removal_plan_{timestamp}.txt")
    print(f"  2. Check:  analysis_results/remove_duplicates_{timestamp}.sh")
    print(f"  3. If satisfied, run: ./analysis_results/remove_duplicates_{timestamp}.sh")
    print()
    print("⚠  Files will be MOVED (not deleted) to duplicates_archive/ for safety")
    print()


if __name__ == "__main__":
    main()
