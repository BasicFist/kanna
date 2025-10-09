#!/usr/bin/env python3
"""
Organize MinerU extractions by thesis chapter using keyword matching
"""

import os
import shutil
from pathlib import Path

# Configuration
EXTRACTION_DIR = Path("/home/miko/LAB/projects/KANNA/literature/pdfs/extractions")

# Chapter classification keywords
CHAPTER_KEYWORDS = {
    'chapter-02-botany': [
        'taxonom', 'phylogen', 'botanic', 'species', 'flora', 'morpholog',
        'leaf', 'succulent', 'aizoaceae', 'mesembryanthemaceae', 'gis',
        'distribution', 'habitat', 'biodiversity', 'hyperdiversity', 'narrow leaf'
    ],
    'chapter-03-ethnobotany': [
        'ethnobotany', 'traditional', 'indigenous', 'khoisan', 'san', 'hottentot',
        'folklore', 'medicinal use', 'cultural', 'heritage', 'bei', 'icf',
        'informant', 'healer', 'kanna', 'kougoed', 'channa'
    ],
    'chapter-04-pharmacology': [
        'alkaloid', 'mesembrine', 'mesembrenone', 'tortuosamine', 'mesembrenol',
        'phytochemistry', 'chemical', 'lc-ms', 'gc-ms', 'nmr', 'hplc',
        'extract', 'compound', 'metabolite', 'chemotype', 'qsar', 'ic50',
        'perkin', 'synthesis', 'structure elucidation', 'permeation'
    ],
    'chapter-05-clinical': [
        'clinical', 'trial', 'placebo', 'double-blind', 'randomized', 'rct',
        'safety', 'toxicolog', 'adverse', 'efficacy', 'human study',
        'patient', 'dose', 'pharmacokinetic', 'bioavailability',
        'zembrin', 'supplement'
    ],
    'chapter-06-addiction': [
        'addiction', 'dependence', 'reward', 'dopamine', 'serotonin',
        'pde4', 'phosphodiesterase', 'neurotransmitter', 'receptor',
        'anxiolytic', 'antidepressant', 'mood', 'cognitive', 'memory',
        'electropharmacogram', 'eeg', 'brain', 'neurobiolog',
        'psychoactive', 'substance', 'withdrawal', 'craving'
    ],
    'chapter-07-legal': [
        'patent', 'intellectual property', 'biopiracy', 'benefit-sharing',
        'nagoya', 'cbd', 'wipo', 'traditional knowledge', 'access',
        'commercialization', 'proprietary'
    ]
}

def classify_paper(paper_name):
    """Classify paper into chapter based on keyword matching"""
    paper_lower = paper_name.lower()

    # Score each chapter
    scores = {}
    for chapter, keywords in CHAPTER_KEYWORDS.items():
        score = sum(1 for kw in keywords if kw in paper_lower)
        if score > 0:
            scores[chapter] = score

    if not scores:
        return 'uncategorized'

    # Return chapter with highest score
    return max(scores, key=scores.get)

def main():
    print("=" * 70)
    print("Organizing Extractions by Chapter")
    print("=" * 70)
    print()

    # Find all extraction directories
    auto_dirs = [d.parent for d in EXTRACTION_DIR.glob("*/auto")]

    # Skip chapter directories
    auto_dirs = [d for d in auto_dirs if not d.name.startswith('chapter-')]

    print(f"Found {len(auto_dirs)} papers to organize\n")

    classification = {ch: [] for ch in CHAPTER_KEYWORDS.keys()}
    classification['uncategorized'] = []

    for paper_dir in sorted(auto_dirs):
        paper_name = paper_dir.name
        chapter = classify_paper(paper_name)
        classification[chapter].append(paper_name)

        # Move directory to chapter folder
        target_dir = EXTRACTION_DIR / chapter / paper_name

        # Skip if already moved
        if target_dir.exists():
            print(f"✓ Already in {chapter}: {paper_name[:60]}")
            continue

        try:
            shutil.move(str(paper_dir), str(target_dir))
            print(f"→ {chapter}: {paper_name[:60]}")
        except Exception as e:
            print(f"⚠ Failed to move {paper_name}: {e}")

    # Summary
    print("\n" + "=" * 70)
    print("CHAPTER DISTRIBUTION")
    print("=" * 70)
    for chapter in sorted(classification.keys()):
        count = len(classification[chapter])
        print(f"{chapter:30s}: {count:2d} papers")
        if chapter != 'uncategorized' and count > 0:
            for paper in classification[chapter][:3]:  # Show first 3
                print(f"  - {paper[:60]}")
            if count > 3:
                print(f"  ... and {count-3} more")

    total = sum(len(papers) for papers in classification.values())
    print(f"\n{'Total':30s}: {total:2d} papers")

if __name__ == "__main__":
    main()
