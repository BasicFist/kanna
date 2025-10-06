#!/usr/bin/env python3
"""
Auto-classify PDFs by chapter based on filename keywords.
Helps pre-organize PDFs before Zotero import.
"""
import re
from pathlib import Path
import shutil

# Chapter classification rules (keyword → chapter)
CHAPTER_KEYWORDS = {
    2: ['taxonomy', 'phylogen', 'aizoaceae', 'mesembr', 'botanical', 'klak', 'distribution'],
    3: ['ethnobotany', 'khoisan', 'traditional', 'bei', 'icf', 'indigenous', 'ferment'],
    4: ['alkaloid', 'mesembrine', 'pde4', 'sert', 'qsar', 'docking', 'pharmacol', 'chemistry'],
    5: ['clinical', 'trial', 'rct', 'meta-analysis', 'anxiety', 'depression', 'zembrin'],
    6: ['addiction', 'neurobiology', 'substance', 'dependence', 'reward'],
    7: ['biopiracy', 'patent', 'legal', 'wipo', 'benefit-sharing', 'ethics'],
}

def classify_pdf(filename: str) -> int:
    """Classify PDF by chapter based on filename keywords."""
    filename_lower = filename.lower()

    # Check each chapter's keywords
    scores = {chapter: 0 for chapter in CHAPTER_KEYWORDS}
    for chapter, keywords in CHAPTER_KEYWORDS.items():
        for keyword in keywords:
            if keyword in filename_lower:
                scores[chapter] += 1

    # Return chapter with highest score, or 0 if no match
    max_score = max(scores.values())
    if max_score == 0:
        return 0  # Unclassified

    return max(scores, key=scores.get)

def main():
    staging_dir = Path.home() / "LAB/projects/KANNA/literature/zotero-import-staging"
    general_dir = staging_dir / "general"

    if not general_dir.exists():
        print(f"ERROR: {general_dir} not found")
        return

    pdfs = list(general_dir.glob("*.pdf"))
    print(f"Classifying {len(pdfs)} PDFs...")

    classified = {ch: 0 for ch in range(9)}

    for pdf in pdfs:
        chapter = classify_pdf(pdf.name)
        classified[chapter] += 1

        if chapter > 0:
            dest_dir = staging_dir / f"chapter-0{chapter}"
            dest_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy2(pdf, dest_dir / pdf.name)
            print(f"  → Chapter {chapter}: {pdf.name[:60]}...")

    print("\nClassification Summary:")
    for ch in range(9):
        if classified[ch] > 0:
            label = f"Chapter {ch}" if ch > 0 else "Unclassified"
            print(f"  {label}: {classified[ch]} PDFs")

    print(f"\nPDFs organized in: {staging_dir}/")
    print("Review and adjust before importing to Zotero.")

if __name__ == "__main__":
    main()
