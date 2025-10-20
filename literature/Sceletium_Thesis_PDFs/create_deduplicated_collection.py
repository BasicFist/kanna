#!/usr/bin/env python3
"""
Create Deduplicated PDF Collection
Organizes unique PDFs into topic-based directories with clear naming
"""

import os
import sys
import csv
import shutil
import re
from pathlib import Path
from collections import defaultdict
from datetime import datetime

try:
    from pypdf import PdfReader
except ImportError:
    print("ERROR: pypdf not installed. Run: pip install --user pypdf")
    sys.exit(1)


class DeduplicatedCollectionBuilder:
    """Build organized, deduplicated PDF collection"""

    # Topic classification keywords
    TOPIC_KEYWORDS = {
        '00_Core_References': {
            'priority': True,
            'keywords': []  # Manually selected core papers
        },
        '01_Sceletium_Pharmacology': {
            'keywords': ['sceletium', 'kanna', 'kougoed', 'mesembr', 'alkaloid', 'mesembrenone', 'mesembrenol']
        },
        '02_Ethnopharmacology': {
            'keywords': ['ethnopharm', 'traditional', 'indigenous', 'medicinal plant', 'herbal', 'folk medicine']
        },
        '03_PDE4_Neurogenesis': {
            'keywords': ['pde4', 'pde-4', 'phosphodiesterase', 'neurogenesis', 'hippocampus', 'neuroplasticity', 'synaptic']
        },
        '04_Clinical_Trials': {
            'keywords': ['clinical trial', 'randomized', 'placebo', 'double-blind', 'zembrin', 'human study', 'patient']
        },
        '05_Khoi_San_Traditional': {
            'keywords': ['khoi', 'san', 'khoisan', 'bushmen', 'wind', 'hunting', 'buchu', 'indigenous knowledge']
        },
        '06_Related_Compounds': {
            'keywords': ['ranunculus', 'echinocystis', 'aizoaceae', 'mesembryanthemum', 'carpobrotus']
        }
    }

    def __init__(self, source_dir, output_dir):
        self.source_dir = Path(source_dir)
        self.output_dir = Path(output_dir)
        self.metadata_map = {}
        self.duplicates_to_keep = {}  # hash -> best file path
        self.topic_assignments = defaultdict(list)
        self.dedup_log = []
        self.core_papers = set()

    def load_metadata(self, metadata_csv):
        """Load metadata catalog"""
        print("📂 Loading metadata...")
        with open(metadata_csv, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f)
            for row in reader:
                # Convert absolute paths to relative paths
                abs_path = row['filepath']
                rel_path = str(Path(abs_path).relative_to(self.source_dir))
                self.metadata_map[rel_path] = row
        print(f"✓ Loaded {len(self.metadata_map)} metadata records\n")

    def load_deduplication_plan(self, removal_plan_file):
        """Parse removal plan to identify files to keep"""
        print("🔍 Analyzing deduplication plan...")

        files_to_remove = set()

        with open(removal_plan_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        # Parse the removal plan to get files marked for removal
        for i, line in enumerate(lines):
            if line.startswith('Remove:'):
                # Extract the filepath after "Remove:"
                remove_file = line.split('Remove:')[1].strip()
                files_to_remove.add(remove_file)

        # Calculate unique files: all files MINUS those marked for removal
        all_files = set(self.metadata_map.keys())
        unique_files = all_files - files_to_remove

        print(f"✓ Total files in collection: {len(all_files)}")
        print(f"✓ Files marked for removal: {len(files_to_remove)}")
        print(f"✓ Unique papers to keep: {len(unique_files)}")
        print(f"✓ Deduplication rate: {len(files_to_remove) / len(all_files) * 100:.1f}%\n")

        return unique_files

    def classify_topic(self, filepath, metadata):
        """Classify paper into topic category"""
        title = (metadata.get('title', '') or '').lower()
        filename = Path(filepath).name.lower()
        combined = title + ' ' + filename

        # Check if it's a core reference
        if 'TEZ_Core' in filepath:
            return '00_Core_References'

        # Check each topic
        topic_scores = defaultdict(int)

        for topic, config in self.TOPIC_KEYWORDS.items():
            if topic == '00_Core_References':
                continue

            keywords = config.get('keywords', [])
            for keyword in keywords:
                if keyword in combined:
                    topic_scores[topic] += 1

        # Return topic with highest score, or default
        if topic_scores:
            best_topic = max(topic_scores.items(), key=lambda x: x[1])
            if best_topic[1] > 0:
                return best_topic[0]

        # Default to Sceletium if no clear match
        return '01_Sceletium_Pharmacology'

    def generate_clean_filename(self, filepath, metadata):
        """Generate clean, descriptive filename"""
        title = (metadata.get('title', '') or '').strip()
        author = (metadata.get('author', '') or '').strip()
        creation_date = metadata.get('creation_date', '')

        # Extract year
        year = self._extract_year(creation_date, Path(filepath).name)

        # Get first author
        first_author = self._extract_first_author(author)

        # Clean title
        clean_title = self._clean_title(title, Path(filepath).name)

        # Build filename
        parts = []
        if year:
            parts.append(year)
        if first_author:
            parts.append(first_author)
        if clean_title:
            parts.append(clean_title)

        if parts:
            new_name = ' - '.join(parts) + '.pdf'
            # Remove invalid characters
            new_name = re.sub(r'[<>:"/\\|?*]', '', new_name)
            # Limit length
            if len(new_name) > 150:
                new_name = new_name[:147] + '...pdf'
            return new_name
        else:
            # Fall back to original filename
            return Path(filepath).name

    def _extract_year(self, date_str, filename):
        """Extract year from date or filename"""
        # Try date string first
        match = re.search(r'(19|20)\d{2}', str(date_str))
        if match:
            return match.group(0)

        # Try filename
        match = re.search(r'(19|20)\d{2}', filename)
        if match:
            return match.group(0)

        return None

    def _extract_first_author(self, author_str):
        """Extract first author surname"""
        if not author_str:
            return None

        # Split by common separators
        authors = re.split(r'[;,&]|\sand\s', author_str)
        if not authors:
            return None

        first = authors[0].strip()

        # Try to get surname (usually last word)
        words = first.split()
        if words:
            surname = words[-1]
            # Remove periods, titles
            surname = re.sub(r'[.,]', '', surname)
            return surname

        return None

    def _clean_title(self, title, filename):
        """Clean and truncate title"""
        if title:
            # Remove common prefixes
            title = re.sub(r'^(The|A|An)\s+', '', title, flags=re.IGNORECASE)
            # Limit length
            if len(title) > 80:
                title = title[:77] + '...'
            return title

        # Fall back to filename without extension
        name = Path(filename).stem
        # Remove common patterns
        name = re.sub(r'\d{10}', '', name)  # Remove 10-digit numbers
        name = re.sub(r'[_-]+', ' ', name)  # Replace separators with spaces
        name = name.strip()

        if len(name) > 80:
            name = name[:77] + '...'

        return name if name else 'Untitled'

    def create_directory_structure(self):
        """Create topic directories"""
        print("📁 Creating directory structure...")

        self.output_dir.mkdir(exist_ok=True)

        for topic in self.TOPIC_KEYWORDS.keys():
            topic_dir = self.output_dir / topic
            topic_dir.mkdir(exist_ok=True)
            print(f"  ✓ Created {topic}/")

        # Create supplementary data directory
        supp_dir = self.output_dir / "99_Supplementary_Data"
        supp_dir.mkdir(exist_ok=True)
        print(f"  ✓ Created 99_Supplementary_Data/")

        print()

    def copy_unique_files(self, unique_files):
        """Copy unique files to organized structure"""
        print("📋 Copying unique files to deduplicated collection...")
        print(f"Total files to copy: {len(unique_files)}")
        print()

        copied_count = 0
        failed_count = 0
        name_collisions = defaultdict(int)

        # Convert to sorted list for iteration
        files_list = sorted(list(unique_files))

        for idx, filepath in enumerate(files_list, 1):
            if idx % 50 == 0:
                print(f"  Progress: {idx}/{len(files_list)} ({idx*100//len(files_list)}%)")

            try:
                metadata = self.metadata_map.get(filepath, {})
                source_path = self.source_dir / filepath

                if not source_path.exists():
                    print(f"  ⚠ Not found: {filepath}")
                    failed_count += 1
                    continue

                # Classify topic
                topic = self.classify_topic(filepath, metadata)

                # Generate clean filename
                new_filename = self.generate_clean_filename(filepath, metadata)

                # Handle name collisions
                dest_path = self.output_dir / topic / new_filename
                collision_count = name_collisions[str(dest_path)]
                if collision_count > 0:
                    name, ext = os.path.splitext(new_filename)
                    new_filename = f"{name}_{collision_count}{ext}"
                    dest_path = self.output_dir / topic / new_filename

                name_collisions[str(dest_path)] += 1

                # Copy file
                shutil.copy2(source_path, dest_path)

                # Log the operation
                self.dedup_log.append({
                    'original_path': filepath,
                    'new_path': str(dest_path.relative_to(self.output_dir)),
                    'topic': topic,
                    'title': metadata.get('title', ''),
                    'author': metadata.get('author', ''),
                    'year': self._extract_year(metadata.get('creation_date', ''), Path(filepath).name)
                })

                self.topic_assignments[topic].append(new_filename)
                copied_count += 1

            except Exception as e:
                print(f"  ✗ Error copying {filepath}: {e}")
                failed_count += 1

        print(f"\n✓ Copied {copied_count} unique PDFs")
        if failed_count > 0:
            print(f"⚠ Failed: {failed_count} files")
        print()

        return copied_count

    def copy_supplementary_files(self):
        """Copy Excel and Word supplementary files"""
        print("📊 Copying supplementary data files...")

        supp_dir = self.output_dir / "99_Supplementary_Data"
        count = 0

        for ext in ['.xlsx', '.docx']:
            for filepath in self.source_dir.rglob(f'*{ext}'):
                try:
                    dest_path = supp_dir / filepath.name
                    shutil.copy2(filepath, dest_path)
                    count += 1
                except Exception as e:
                    print(f"  ✗ Error: {e}")

        print(f"✓ Copied {count} supplementary files\n")

    def generate_index(self):
        """Generate CSV index of collection"""
        print("📇 Generating collection index...")

        index_file = self.output_dir / "_INDEX.csv"

        with open(index_file, 'w', newline='', encoding='utf-8') as f:
            fieldnames = ['new_path', 'topic', 'year', 'author', 'title', 'original_path']
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(self.dedup_log)

        print(f"✓ Index created: _INDEX.csv ({len(self.dedup_log)} entries)\n")

    def generate_report(self):
        """Generate deduplication report"""
        print("📄 Generating deduplication report...")

        report_file = self.output_dir / "DEDUPLICATION_REPORT.txt"

        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("="*80 + "\n")
            f.write("DEDUPLICATED COLLECTION REPORT\n")
            f.write(f"Generated: {datetime.now().isoformat()}\n")
            f.write("="*80 + "\n\n")

            f.write("SUMMARY\n")
            f.write("-"*80 + "\n")
            f.write(f"Total unique papers: {len(self.dedup_log)}\n")
            f.write(f"Original collection: 1,013 PDFs\n")
            f.write(f"Duplicates removed: {1013 - len(self.dedup_log)}\n")
            f.write(f"Deduplication rate: {(1 - len(self.dedup_log)/1013)*100:.1f}%\n\n")

            f.write("DISTRIBUTION BY TOPIC\n")
            f.write("-"*80 + "\n")
            for topic in sorted(self.topic_assignments.keys()):
                count = len(self.topic_assignments[topic])
                f.write(f"{topic:35} {count:4} papers\n")

            f.write("\n\nORGANIZATION NOTES\n")
            f.write("-"*80 + "\n")
            f.write("- Files renamed to: YEAR - Author - Title.pdf format\n")
            f.write("- Organized into topic-based directories\n")
            f.write("- Best version kept (highest metadata quality & descriptive names)\n")
            f.write("- Original collection preserved at: ../\n")
            f.write("- Full index available in: _INDEX.csv\n\n")

            f.write("TOPIC DESCRIPTIONS\n")
            f.write("-"*80 + "\n")
            f.write("00_Core_References:        Essential papers from TEZ_Core\n")
            f.write("01_Sceletium_Pharmacology: Kanna alkaloids, mesembrine, pharmacology\n")
            f.write("02_Ethnopharmacology:      Traditional use, indigenous knowledge\n")
            f.write("03_PDE4_Neurogenesis:      PDE4 inhibition, brain plasticity\n")
            f.write("04_Clinical_Trials:        Human studies, Zembrin trials\n")
            f.write("05_Khoi_San_Traditional:   Cultural context, traditional practices\n")
            f.write("06_Related_Compounds:      Aizoaceae family, related plants\n")
            f.write("99_Supplementary_Data:     Excel/Word supplementary materials\n\n")

        print(f"✓ Report created: DEDUPLICATION_REPORT.txt\n")

    def generate_readme(self):
        """Generate README for collection"""
        print("📖 Generating README...")

        readme_file = self.output_dir / "README.md"

        with open(readme_file, 'w', encoding='utf-8') as f:
            f.write("# Deduplicated Sceletium Thesis Collection\n\n")
            f.write(f"**Created:** {datetime.now().strftime('%Y-%m-%d')}\n")
            f.write(f"**Unique Papers:** {len(self.dedup_log)}\n")
            f.write(f"**Original Collection:** 1,013 PDFs (565 duplicates removed)\n\n")

            f.write("## Directory Structure\n\n")
            for topic in sorted(self.topic_assignments.keys()):
                count = len(self.topic_assignments[topic])
                f.write(f"- **{topic}/** ({count} papers)\n")
            f.write(f"- **99_Supplementary_Data/** (Excel/Word files)\n\n")

            f.write("## Organization\n\n")
            f.write("Files are named: `YEAR - FirstAuthor - Title.pdf`\n\n")
            f.write("Example: `2021 - Hofford - Neuroimmune mechanisms.pdf`\n\n")

            f.write("## Finding Papers\n\n")
            f.write("1. **By Topic:** Browse topic directories\n")
            f.write("2. **By Search:** Open `_INDEX.csv` in spreadsheet software\n")
            f.write("3. **By Author:** Sort index by 'author' column\n")
            f.write("4. **By Year:** Sort index by 'year' column\n\n")

            f.write("## Original Collection\n\n")
            f.write("Original files preserved at: `../`\n\n")
            f.write("Full backup at: `/home/miko/Documents/Backups/`\n\n")

            f.write("## Reports\n\n")
            f.write("- `DEDUPLICATION_REPORT.txt` - Detailed deduplication summary\n")
            f.write("- `_INDEX.csv` - Searchable catalog of all papers\n\n")

        print(f"✓ README created: README.md\n")


def main():
    """Main execution"""
    print("="*80)
    print("DEDUPLICATED COLLECTION BUILDER")
    print("="*80)
    print()

    source_dir = Path.cwd()
    output_dir = source_dir / "Deduplicated_Collection"

    # Find latest analysis files
    analysis_dir = source_dir / "analysis_results"

    metadata_files = sorted(analysis_dir.glob("metadata_catalog_*.csv"))
    removal_files = sorted(analysis_dir.glob("removal_plan_*.txt"))

    if not metadata_files or not removal_files:
        print("ERROR: Analysis files not found!")
        print("Please run pdf_analyzer.py first.")
        sys.exit(1)

    metadata_csv = metadata_files[-1]
    removal_plan = removal_files[-1]

    print(f"Source: {source_dir}")
    print(f"Output: {output_dir}")
    print()

    # Initialize builder
    builder = DeduplicatedCollectionBuilder(source_dir, output_dir)

    # Load data
    builder.load_metadata(metadata_csv)
    unique_files = builder.load_deduplication_plan(removal_plan)

    # Create structure
    builder.create_directory_structure()

    # Copy files
    copied = builder.copy_unique_files(unique_files)

    # Copy supplementary
    builder.copy_supplementary_files()

    # Generate documentation
    builder.generate_index()
    builder.generate_report()
    builder.generate_readme()

    print("="*80)
    print("✅ DEDUPLICATED COLLECTION CREATED!")
    print("="*80)
    print()
    print(f"Location: {output_dir}")
    print(f"Unique papers: {copied}")
    print()
    print("Next steps:")
    print(f"  1. Review: {output_dir}/DEDUPLICATION_REPORT.txt")
    print(f"  2. Browse: {output_dir}/ directories")
    print(f"  3. Search: {output_dir}/_INDEX.csv")
    print()
    print("Original collection preserved and untouched!")
    print()


if __name__ == "__main__":
    main()
