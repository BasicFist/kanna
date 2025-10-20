#!/usr/bin/env python3
"""
Systematic Collection Cleanup Script
Implements all identified fixes in organized phases
"""

import os
import shutil
from pathlib import Path
from collections import defaultdict
import hashlib

class SystematicCleanup:
    def __init__(self, base_dir):
        self.base_dir = Path(base_dir)
        self.actions = []
        self.dry_run = True

    def compute_hash(self, filepath):
        """Compute MD5 hash of file"""
        md5 = hashlib.md5()
        with open(filepath, 'rb') as f:
            for chunk in iter(lambda: f.read(8192), b''):
                md5.update(chunk)
        return md5.hexdigest()

    def phase1_identify_reference_lists(self):
        """Phase 1: Find and categorize reference lists (< 100KB)"""
        print("\n" + "="*80)
        print("PHASE 1: IDENTIFYING REFERENCE LISTS")
        print("="*80)

        reference_lists = []

        for topic_dir in self.base_dir.iterdir():
            if not topic_dir.is_dir() or topic_dir.name.startswith('.'):
                continue

            for pdf in topic_dir.glob("*.pdf"):
                size_kb = pdf.stat().st_size / 1024

                # Identify reference lists: < 100KB or "réf" in name
                if size_kb < 100 or 'réf' in pdf.name.lower() or 'scifinder' in pdf.name.lower():
                    reference_lists.append({
                        'path': pdf,
                        'size_kb': size_kb,
                        'reason': 'Small file (< 100KB)' if size_kb < 100 else 'Reference list keyword'
                    })

        print(f"\nFound {len(reference_lists)} potential reference lists:\n")
        for item in reference_lists:
            print(f"  {item['size_kb']:.1f} KB - {item['path'].name}")
            print(f"    Reason: {item['reason']}")
            print(f"    Current: {item['path'].parent.name}")

        if reference_lists:
            target_dir = self.base_dir / "99_Supplementary_Data" / "Reference_Lists"
            print(f"\nProposed action: Move to {target_dir.name}/")

            for item in reference_lists:
                self.actions.append({
                    'phase': 1,
                    'action': 'move',
                    'source': item['path'],
                    'target': target_dir / item['path'].name,
                    'reason': 'Reference list (< 100KB or keyword match)'
                })

        return reference_lists

    def phase2_identify_books(self):
        """Phase 2: Find and categorize large books (> 10MB or > 100 pages)"""
        print("\n" + "="*80)
        print("PHASE 2: IDENTIFYING BOOKS AND MONOGRAPHS")
        print("="*80)

        books = []

        try:
            from pypdf import PdfReader
        except:
            print("  Warning: pypdf not available, using size-only detection")
            PdfReader = None

        for topic_dir in self.base_dir.iterdir():
            if not topic_dir.is_dir() or topic_dir.name.startswith('.'):
                continue

            for pdf in topic_dir.glob("*.pdf"):
                size_mb = pdf.stat().st_size / (1024 * 1024)
                pages = None

                # Try to get page count
                if PdfReader:
                    try:
                        reader = PdfReader(pdf)
                        pages = len(reader.pages)
                    except:
                        pass

                # Identify books: > 10MB or > 100 pages or book keywords
                is_book = (size_mb > 10 or
                          (pages and pages > 100) or
                          any(kw in pdf.name.lower() for kw in ['pharmacopoeia', 'archaeology', 'ecology', 'book']))

                if is_book:
                    books.append({
                        'path': pdf,
                        'size_mb': size_mb,
                        'pages': pages,
                        'reason': f"{size_mb:.1f}MB" + (f", {pages}p" if pages else "")
                    })

        print(f"\nFound {len(books)} books/monographs:\n")
        for item in sorted(books, key=lambda x: x['size_mb'], reverse=True):
            print(f"  {item['size_mb']:.1f} MB - {item['path'].name}")
            print(f"    Pages: {item['pages'] if item['pages'] else 'Unknown'}")
            print(f"    Current: {item['path'].parent.name}")

        if books:
            target_dir = self.base_dir / "08_Reference_Books"
            print(f"\nProposed action: Move to {target_dir.name}/")

            for item in books:
                self.actions.append({
                    'phase': 2,
                    'action': 'move',
                    'source': item['path'],
                    'target': target_dir / item['path'].name,
                    'reason': f'Book/monograph ({item["reason"]})'
                })

        return books

    def phase3_find_duplicate_books(self):
        """Phase 3: Find duplicate copies of the same book"""
        print("\n" + "="*80)
        print("PHASE 3: FINDING DUPLICATE BOOK COPIES")
        print("="*80)

        # Group files by name and size
        file_groups = defaultdict(list)

        for topic_dir in self.base_dir.iterdir():
            if not topic_dir.is_dir() or topic_dir.name.startswith('.'):
                continue

            for pdf in topic_dir.glob("*.pdf"):
                size_mb = pdf.stat().st_size / (1024 * 1024)
                # Group by approximate size (within 1 MB) and similar name
                key = (pdf.stem[:50], int(size_mb))  # Use first 50 chars and rounded size
                file_groups[key].append(pdf)

        duplicates = {k: v for k, v in file_groups.items() if len(v) > 1 and int(k[1]) > 10}

        print(f"\nFound {len(duplicates)} potential duplicate book groups:\n")

        for (name, size), files in duplicates.items():
            print(f"  {name}... ({size} MB)")
            print(f"    Found {len(files)} copies:")

            # Verify with MD5 hash
            hashes = {}
            for f in files:
                h = self.compute_hash(f)
                if h not in hashes:
                    hashes[h] = []
                hashes[h].append(f)

            for hash_val, hash_files in hashes.items():
                if len(hash_files) > 1:
                    print(f"    → CONFIRMED DUPLICATES (same hash):")
                    for hf in hash_files:
                        print(f"      - {hf.parent.name}/{hf.name}")

                    # Keep first, mark others for deletion
                    keep = hash_files[0]
                    for dup in hash_files[1:]:
                        self.actions.append({
                            'phase': 3,
                            'action': 'delete',
                            'source': dup,
                            'target': None,
                            'reason': f'Duplicate of {keep.name}'
                        })

        return duplicates

    def phase4_identify_corrigenda(self):
        """Phase 4: Find 1-page corrigenda"""
        print("\n" + "="*80)
        print("PHASE 4: IDENTIFYING CORRIGENDA AND ERRATA")
        print("="*80)

        corrigenda = []

        try:
            from pypdf import PdfReader
        except:
            print("  Warning: pypdf not available, skipping corrigenda detection")
            return []

        for topic_dir in self.base_dir.iterdir():
            if not topic_dir.is_dir() or topic_dir.name.startswith('.'):
                continue

            for pdf in topic_dir.glob("*.pdf"):
                try:
                    reader = PdfReader(pdf)
                    pages = len(reader.pages)

                    # Identify corrigenda: 1 page + "corrigendum" in name
                    if pages == 1 and ('corrigendum' in pdf.name.lower() or
                                      'erratum' in pdf.name.lower()):
                        corrigenda.append({
                            'path': pdf,
                            'pages': pages
                        })
                except:
                    pass

        print(f"\nFound {len(corrigenda)} corrigenda/errata:\n")
        for item in corrigenda:
            print(f"  {item['path'].name}")
            print(f"    Current: {item['path'].parent.name}")

        if corrigenda:
            target_dir = self.base_dir / "99_Supplementary_Data" / "Corrigenda"
            print(f"\nProposed action: Move to {target_dir.name}/")

            for item in corrigenda:
                self.actions.append({
                    'phase': 4,
                    'action': 'move',
                    'source': item['path'],
                    'target': target_dir / item['path'].name,
                    'reason': '1-page corrigendum'
                })

        return corrigenda

    def generate_action_plan(self):
        """Generate comprehensive action plan"""
        print("\n" + "="*80)
        print("ACTION PLAN SUMMARY")
        print("="*80)

        by_phase = defaultdict(list)
        for action in self.actions:
            by_phase[action['phase']].append(action)

        total_moves = sum(1 for a in self.actions if a['action'] == 'move')
        total_deletes = sum(1 for a in self.actions if a['action'] == 'delete')

        print(f"\nTotal actions: {len(self.actions)}")
        print(f"  Moves: {total_moves}")
        print(f"  Deletions: {total_deletes}")

        for phase in sorted(by_phase.keys()):
            actions = by_phase[phase]
            print(f"\nPhase {phase}: {len(actions)} actions")

            for action in actions[:5]:  # Show first 5
                if action['action'] == 'move':
                    print(f"  MOVE: {action['source'].name}")
                    print(f"    → {action['target']}")
                elif action['action'] == 'delete':
                    print(f"  DELETE: {action['source'].name}")
                print(f"    Reason: {action['reason']}")

            if len(actions) > 5:
                print(f"  ... and {len(actions) - 5} more")

        return by_phase

    def execute_actions(self):
        """Execute all planned actions"""
        print("\n" + "="*80)
        print("EXECUTING ACTIONS")
        print("="*80)

        if self.dry_run:
            print("\n⚠ DRY RUN MODE - No files will be modified")
            print("Set self.dry_run = False to execute for real\n")
            return

        success = 0
        failed = 0

        for action in self.actions:
            try:
                if action['action'] == 'move':
                    # Create target directory
                    action['target'].parent.mkdir(parents=True, exist_ok=True)
                    # Move file
                    shutil.move(str(action['source']), str(action['target']))
                    print(f"✓ Moved: {action['source'].name}")
                    success += 1

                elif action['action'] == 'delete':
                    # Move to trash folder instead of deleting
                    trash = self.base_dir / "_Removed_Duplicates"
                    trash.mkdir(exist_ok=True)
                    shutil.move(str(action['source']), str(trash / action['source'].name))
                    print(f"✓ Removed: {action['source'].name}")
                    success += 1

            except Exception as e:
                print(f"✗ Error: {action['source'].name}: {e}")
                failed += 1

        print(f"\n{success} successful, {failed} failed")

def main():
    collection_dir = Path(__file__).parent

    print("="*80)
    print("SYSTEMATIC COLLECTION CLEANUP")
    print("="*80)
    print(f"\nWorking directory: {collection_dir}\n")

    cleanup = SystematicCleanup(collection_dir)

    # Run all identification phases
    cleanup.phase1_identify_reference_lists()
    cleanup.phase2_identify_books()
    cleanup.phase3_find_duplicate_books()
    cleanup.phase4_identify_corrigenda()

    # Generate action plan
    cleanup.generate_action_plan()

    # Ask for confirmation
    print("\n" + "="*80)
    print("READY TO EXECUTE")
    print("="*80)
    print("\nThis will reorganize your collection according to the plan above.")
    print("All files will be MOVED (not deleted) to new locations.")
    print("Duplicates will be moved to '_Removed_Duplicates/' folder.")

    response = input("\nProceed with cleanup? (yes/no): ").strip().lower()

    if response == 'yes':
        cleanup.dry_run = False
        cleanup.execute_actions()
        print("\n✓ Cleanup complete!")
        print("Review the changes and regenerate _INDEX.csv if needed.")
    else:
        print("\nCleanup cancelled. No changes made.")
        print("Review the action plan and run again when ready.")

if __name__ == "__main__":
    main()
