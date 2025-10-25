#!/usr/bin/env python3
"""
Literature Note Generator for KANNA Obsidian Vault

Converts MinerU PDF extractions to Obsidian literature notes with:
- YAML frontmatter (metadata)
- Automatic concept detection ([[wiki-links]])
- Abstract and key findings
- Links to source extraction

Usage:
    python generate-lit-notes.py --mineru-dir DIR --output DIR [--limit N]

Author: Generated for KANNA PhD project
Date: October 2025
"""

import argparse
import json
import re
from pathlib import Path
from typing import Dict, List, Optional, Set
import yaml


class LiteratureNoteGenerator:
    """Generate Obsidian literature notes from MinerU extractions"""

    # Known alkaloids in Sceletium tortuosum
    ALKALOIDS = [
        'mesembrine', 'mesembrenone', 'mesembrenol', 'tortuosamine',
        'mesembranol', 'sceletium', 'joubertiamine', 'sceletine'
    ]

    # Key concepts across chapters
    CONCEPTS = [
        # Pharmacology (Chapter 4)
        'SERT', 'serotonin', 'PDE4', 'phosphodiesterase', 'anxiolytic',
        'antidepressant', 'norepinephrine', 'dopamine', 'neurotransmitter',

        # Methods
        'QSAR', 'molecular docking', 'LC-MS', 'HPLC', 'NMR', 'GC-MS',
        'meta-analysis', 'RCT', 'clinical trial', 'ethnobotany',

        # Biology
        'Sceletium tortuosum', 'Sceletium', 'Kanna', 'kougoed',
        'Aizoaceae', 'Mesembryanthemaceae', 'alkaloid biosynthesis',

        # Traditional knowledge
        'Khoisan', 'San', 'traditional use', 'fermentation',
        'ethnomedicine', 'traditional medicine',

        # Legal/Ethics
        'biopiracy', 'benefit-sharing', 'FPIC', 'patent',
        'indigenous knowledge', 'traditional knowledge'
    ]

    def __init__(self, mineru_dir: Path, output_dir: Path, limit: Optional[int] = None):
        self.mineru_dir = Path(mineru_dir)
        self.output_dir = Path(output_dir)
        self.limit = limit
        self.output_dir.mkdir(parents=True, exist_ok=True)

    def find_markdown_files(self) -> List[Path]:
        """Find all MinerU markdown extractions"""
        md_files = []

        for extraction_dir in self.mineru_dir.iterdir():
            if not extraction_dir.is_dir():
                continue

            # Look for markdown in auto/ subdirectory
            auto_dir = extraction_dir / 'auto'
            if not auto_dir.exists():
                continue

            # Find .md file (should be only one per extraction)
            md_candidates = list(auto_dir.glob('*.md'))
            if md_candidates:
                md_files.append(md_candidates[0])

        print(f"Found {len(md_files)} markdown extractions")

        if self.limit:
            md_files = md_files[:self.limit]
            print(f"Limited to {self.limit} files for testing")

        return md_files

    def extract_metadata(self, md_path: Path) -> Dict:
        """Extract metadata from MinerU markdown file"""
        content = md_path.read_text(encoding='utf-8')

        # Extract filename-based metadata
        filename = md_path.stem
        year_match = re.search(r'^(\d{4})', filename)
        year = year_match.group(1) if year_match else 'Unknown'

        # Extract DOI from filename if present
        doi_match = re.search(r'doi(10\.\S+)', filename)
        doi = doi_match.group(1) if doi_match else None

        # Extract title (first # heading)
        title_match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
        title = title_match.group(1).strip() if title_match else filename

        # Extract authors (look for patterns like "Author1, Author2")
        # Common patterns: "B.-E. van Wyk∗" or "Smith, J. et al."
        author_match = re.search(r'^#\s+.+\n(.+?)(?:\n\n|Department)', content, re.MULTILINE | re.DOTALL)
        authors = author_match.group(1).strip() if author_match else 'Unknown'

        # Extract keywords
        keywords = []
        keywords_match = re.search(r'Keywords?:(.+?)(?:\n\n|#)', content, re.DOTALL)
        if keywords_match:
            kw_text = keywords_match.group(1)
            keywords = [k.strip() for k in re.split(r'[,;\n]', kw_text) if k.strip()]

        # Extract abstract
        abstract = ''
        abstract_match = re.search(r'#\s*a\s*b\s*s\s*t\s*r\s*a\s*c\s*t\s*\n\n(.+?)(?:\n\n#|\$)', content, re.DOTALL)
        if abstract_match:
            abstract = abstract_match.group(1).strip()
            # Clean up formatting
            abstract = re.sub(r'\s+', ' ', abstract)

        return {
            'title': title,
            'authors': authors,
            'year': year,
            'doi': doi,
            'keywords': keywords,
            'abstract': abstract,
            'filename': filename,
            'extraction_path': str(md_path.parent.parent.relative_to(self.mineru_dir.parent))
        }

    def detect_concepts(self, text: str) -> Set[str]:
        """Detect concepts in text for wiki-linking"""
        detected = set()

        text_lower = text.lower()

        # Check alkaloids
        for alkaloid in self.ALKALOIDS:
            if alkaloid.lower() in text_lower:
                detected.add(alkaloid)

        # Check concepts (case-insensitive matching)
        for concept in self.CONCEPTS:
            if concept.lower() in text_lower:
                detected.add(concept)

        return detected

    def classify_chapters(self, metadata: Dict, concepts: Set[str]) -> List[int]:
        """Classify paper relevance to thesis chapters"""
        chapters = []

        text = ' '.join([
            metadata['title'],
            metadata['abstract'],
            ' '.join(metadata['keywords'])
        ]).lower()

        # Chapter 1: Introduction (all papers potentially relevant)
        # Chapter 2: Botany
        if any(term in text for term in ['taxonomy', 'phylogen', 'biogeography', 'aizoaceae', 'mesembryanthemaceae']):
            chapters.append(2)

        # Chapter 3: Ethnobotany
        if any(term in text for term in ['khoisan', 'san', 'traditional use', 'ethnobotany', 'traditional medicine', 'fermentation']):
            chapters.append(3)

        # Chapter 4: Pharmacology
        if any(term in text for term in ['alkaloid', 'mesembrine', 'sert', 'pde4', 'pharmacolog', 'neurotransmitter', 'qsar']):
            chapters.append(4)

        # Chapter 5: Clinical
        if any(term in text for term in ['clinical trial', 'rct', 'efficacy', 'safety', 'anxiety', 'depression']):
            chapters.append(5)

        # Chapter 6: Addiction
        if any(term in text for term in ['addiction', 'dependence', 'withdrawal', 'abuse potential', 'neurodependence']):
            chapters.append(6)

        # Chapter 7: Legal/Ethics
        if any(term in text for term in ['patent', 'biopiracy', 'benefit-sharing', 'fpic', 'indigenous knowledge']):
            chapters.append(7)

        return sorted(chapters) if chapters else [1]  # Default to Chapter 1

    def generate_obsidian_note(self, metadata: Dict) -> str:
        """Generate Obsidian markdown note with YAML frontmatter"""

        # Detect concepts
        search_text = f"{metadata['title']} {metadata['abstract']} {' '.join(metadata['keywords'])}"
        concepts = self.detect_concepts(search_text)

        # Classify chapters
        chapters = self.classify_chapters(metadata, concepts)

        # Build YAML frontmatter
        frontmatter = {
            'title': metadata['title'],
            'authors': metadata['authors'],
            'year': metadata['year'],
            'type': 'literature-note',
            'source': 'MinerU-extraction',
            'extraction_path': metadata['extraction_path'],
            'concepts': sorted(list(concepts)),
            'chapters': chapters,
            'tags': ['literature', f"year-{metadata['year']}"] + [f"chapter-{ch:02d}" for ch in chapters]
        }

        if metadata['doi']:
            frontmatter['doi'] = metadata['doi']

        if metadata['keywords']:
            frontmatter['keywords'] = metadata['keywords']

        # Build note content
        note = "---\n"
        note += yaml.dump(frontmatter, default_flow_style=False, allow_unicode=True, sort_keys=False)
        note += "---\n\n"

        # Title
        note += f"# {metadata['title']}\n\n"

        # Metadata section
        note += "## Metadata\n\n"
        note += f"- **Authors**: {metadata['authors']}\n"
        note += f"- **Year**: {metadata['year']}\n"
        if metadata['doi']:
            note += f"- **DOI**: [{metadata['doi']}](https://doi.org/{metadata['doi']})\n"
        note += f"- **Source**: MinerU extraction\n"
        note += f"- **Path**: `{metadata['extraction_path']}`\n\n"

        # Keywords
        if metadata['keywords']:
            note += "## Keywords\n\n"
            note += ', '.join(f"`{kw}`" for kw in metadata['keywords'][:10])
            note += "\n\n"

        # Abstract
        if metadata['abstract']:
            note += "## Abstract\n\n"
            note += metadata['abstract'] + "\n\n"

        # Detected concepts
        if concepts:
            note += "## Related Concepts\n\n"
            for concept in sorted(concepts):
                note += f"- [[{concept}]]\n"
            note += "\n"

        # Chapter relevance
        note += "## Chapter Relevance\n\n"
        chapter_names = {
            1: "Introduction",
            2: "Botanical Foundations",
            3: "Khoisan Ethnobotanical Heritage",
            4: "Pharmacognosy & Neurobiology",
            5: "Clinical Validation",
            6: "Addiction & Neurodependence",
            7: "Legal & Ethical Issues",
            8: "Synthesis & Perspectives"
        }
        for ch in chapters:
            note += f"- [[Chapter {ch:02d}]]: {chapter_names.get(ch, 'Unknown')}\n"
        note += "\n"

        # Link to full extraction
        note += "## Full Text\n\n"
        note += f"See MinerU extraction: `{metadata['extraction_path']}/auto/*.md`\n\n"

        # Notes section (for manual additions)
        note += "## Notes\n\n"
        note += "*Add your synthesis notes here*\n\n"

        # Backlinks section
        note += "## Backlinks\n\n"
        note += "*Papers citing this work will appear here via Obsidian backlinks*\n"

        return note

    def sanitize_filename(self, title: str, year: str) -> str:
        """Create safe filename from title and year"""
        # Remove special characters
        safe_title = re.sub(r'[^\w\s-]', '', title)
        # Truncate to reasonable length
        safe_title = safe_title[:80].strip()
        # Replace spaces with hyphens
        safe_title = re.sub(r'\s+', '-', safe_title)

        return f"{year}-{safe_title}.md"

    def process_all(self) -> Dict:
        """Process all MinerU extractions"""
        md_files = self.find_markdown_files()

        stats = {
            'total': len(md_files),
            'success': 0,
            'failed': 0,
            'errors': []
        }

        for i, md_path in enumerate(md_files, 1):
            try:
                print(f"[{i}/{len(md_files)}] Processing: {md_path.parent.name}")

                # Extract metadata
                metadata = self.extract_metadata(md_path)

                # Generate note
                note_content = self.generate_obsidian_note(metadata)

                # Create filename
                note_filename = self.sanitize_filename(metadata['title'], metadata['year'])
                note_path = self.output_dir / note_filename

                # Write note
                note_path.write_text(note_content, encoding='utf-8')

                stats['success'] += 1
                print(f"  ✓ Created: {note_filename}")

            except Exception as e:
                stats['failed'] += 1
                error_msg = f"{md_path.name}: {str(e)}"
                stats['errors'].append(error_msg)
                print(f"  ✗ Failed: {error_msg}")

        return stats


def main():
    parser = argparse.ArgumentParser(
        description='Generate Obsidian literature notes from MinerU extractions'
    )
    parser.add_argument(
        '--mineru-dir',
        required=True,
        help='Directory containing MinerU extractions'
    )
    parser.add_argument(
        '--output',
        required=True,
        help='Output directory for Obsidian notes'
    )
    parser.add_argument(
        '--limit',
        type=int,
        help='Limit number of files to process (for testing)'
    )

    args = parser.parse_args()

    # Validate paths
    mineru_dir = Path(args.mineru_dir)
    if not mineru_dir.exists():
        print(f"Error: MinerU directory not found: {mineru_dir}")
        return 1

    output_dir = Path(args.output)

    # Create generator
    generator = LiteratureNoteGenerator(mineru_dir, output_dir, args.limit)

    # Process files
    print("=" * 60)
    print("KANNA Literature Note Generator")
    print("=" * 60)
    print(f"MinerU directory: {mineru_dir}")
    print(f"Output directory: {output_dir}")
    print(f"Limit: {args.limit or 'None (process all)'}")
    print("=" * 60)
    print()

    stats = generator.process_all()

    # Print summary
    print()
    print("=" * 60)
    print("SUMMARY")
    print("=" * 60)
    print(f"Total files:    {stats['total']}")
    print(f"Successful:     {stats['success']} ({stats['success']/stats['total']*100:.1f}%)")
    print(f"Failed:         {stats['failed']}")

    if stats['errors']:
        print("\nErrors:")
        for error in stats['errors'][:10]:  # Show first 10
            print(f"  - {error}")
        if len(stats['errors']) > 10:
            print(f"  ... and {len(stats['errors']) - 10} more")

    print("=" * 60)

    return 0 if stats['failed'] == 0 else 1


if __name__ == '__main__':
    exit(main())
