#!/usr/bin/env python3
"""
Filename Collision Fix Script
Adds topic prefix to files with duplicate names to ensure uniqueness
"""

import os
from pathlib import Path
import shutil

# Topic directory mappings to short codes
TOPIC_CODES = {
    '00_Core_References': 'Core',
    '01_Sceletium_Pharmacology': 'Pharma',
    '02_Ethnopharmacology': 'Ethno',
    '03_PDE4_Neurogenesis': 'PDE4',
    '04_Clinical_Trials': 'Clinical',
    '05_Khoi_San_Traditional': 'KhoiSan',
    '06_Related_Compounds': 'Related',
    '99_Supplementary_Data': 'Supp'
}

# List of duplicate filenames to fix
DUPLICATE_FILENAMES = [
    "2004 - doi10.1016j.tips.2004.01.003.pdf",
    "2004 - Group - World Bank Document.pdf",
    "2007 - 06_Low.indd.pdf",
    "2008 - doi10.1016j.jep.2008.05.029.pdf",
    "2008 - doi10.1016j.jep.2008.07.043.pdf",
    "2008 - doi10.1016j.jep.2008.08.010.pdf",
    "2018 - ESPD50NigelGerickepaper.pdf.pdf",
    "2021 - Khan - Brendler 2020-0332-MS.pdf",
    "2022 - fphar-2022-895286 1..38.pdf",
    "2023 - Smith - First People.pdf",
    "2023 - Untitled.pdf"
]

def find_files_with_name(base_dir, filename):
    """Find all files with the given name across directories"""
    matches = []
    for topic_dir in TOPIC_CODES.keys():
        filepath = base_dir / topic_dir / filename
        if filepath.exists():
            matches.append(filepath)
    return matches

def generate_unique_name(filepath, topic_code):
    """Generate unique filename by adding topic code"""
    stem = filepath.stem  # filename without extension
    ext = filepath.suffix  # .pdf

    # Handle files that already have collision suffix (_1, _2, etc)
    if stem.endswith('_1'):
        stem = stem[:-2]

    # Add topic code before extension
    new_name = f"{stem} [{topic_code}]{ext}"
    return filepath.parent / new_name

def main():
    base_dir = Path(__file__).parent

    print("="*80)
    print("FILENAME COLLISION FIX UTILITY")
    print("="*80)
    print(f"\nWorking directory: {base_dir}")
    print(f"\nFiles to process: {len(DUPLICATE_FILENAMES)} duplicate filenames")

    # Dry run first - show what will be renamed
    print("\n" + "="*80)
    print("DRY RUN - Proposed Changes:")
    print("="*80)

    rename_operations = []

    for filename in DUPLICATE_FILENAMES:
        matches = find_files_with_name(base_dir, filename)

        if len(matches) > 1:
            print(f"\n{filename} (found in {len(matches)} locations):")
            for filepath in matches:
                topic_dir = filepath.parent.name
                topic_code = TOPIC_CODES.get(topic_dir, 'Unknown')
                new_path = generate_unique_name(filepath, topic_code)

                print(f"  {filepath.relative_to(base_dir)}")
                print(f"    → {new_path.relative_to(base_dir)}")

                rename_operations.append((filepath, new_path))

    # Handle the fphar file variants (different years, _1 suffix)
    fphar_variants = [
        "2025 - fphar-2022-895286 1..38.pdf",
        "2022 - fphar-2022-895286 1..38_1.pdf"
    ]

    for filename in fphar_variants:
        matches = find_files_with_name(base_dir, filename)
        for filepath in matches:
            if filepath.exists():
                topic_dir = filepath.parent.name
                topic_code = TOPIC_CODES.get(topic_dir, 'Unknown')
                new_path = generate_unique_name(filepath, topic_code)

                print(f"\n{filename}:")
                print(f"  {filepath.relative_to(base_dir)}")
                print(f"    → {new_path.relative_to(base_dir)}")

                rename_operations.append((filepath, new_path))

    print(f"\n{'='*80}")
    print(f"Total rename operations: {len(rename_operations)}")
    print("="*80)

    # Ask for confirmation
    response = input("\nProceed with renaming? (yes/no): ").strip().lower()

    if response == 'yes':
        print("\nExecuting renames...")
        success_count = 0

        for old_path, new_path in rename_operations:
            try:
                # Check if target already exists
                if new_path.exists():
                    print(f"  ⚠ SKIP: Target exists: {new_path.name}")
                    continue

                old_path.rename(new_path)
                print(f"  ✓ Renamed: {old_path.name} → {new_path.name}")
                success_count += 1

            except Exception as e:
                print(f"  ✗ ERROR: {old_path.name}: {e}")

        print(f"\n{'='*80}")
        print(f"Completed: {success_count}/{len(rename_operations)} files renamed")
        print("="*80)
        print("\nNEXT STEPS:")
        print("1. Verify renamed files are accessible")
        print("2. Regenerate _INDEX.csv if needed")
        print("3. Check FILENAME_COLLISION_REPORT.txt for details")

    else:
        print("\nOperation cancelled. No files were modified.")

if __name__ == "__main__":
    main()
