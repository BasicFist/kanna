#!/usr/bin/env python3
"""
Detailed File-by-File Checker - Second Pass
Shows complete details for each file with enhanced verification
"""

import os
from pathlib import Path
from datetime import datetime
import hashlib
import time

try:
    from pypdf import PdfReader
except ImportError:
    os.system("pip install --user pypdf")
    from pypdf import PdfReader

def compute_hash(filepath):
    """Compute MD5 hash"""
    md5 = hashlib.md5()
    with open(filepath, 'rb') as f:
        for chunk in iter(lambda: f.read(8192), b''):
            md5.update(chunk)
    return md5.hexdigest()

def extract_year_from_filename(filename):
    """Extract year from filename"""
    import re
    match = re.match(r'^(\d{4})', filename)
    return int(match.group(1)) if match else None

def check_file_detailed(filepath, file_num, total_files):
    """Perform extremely detailed check of a single file"""

    print("\n" + "="*80)
    print(f"FILE {file_num}/{total_files}")
    print("="*80)

    # Basic info
    print(f"\n📄 FILENAME: {filepath.name}")
    print(f"📁 LOCATION: {filepath.parent.name}/")
    print(f"🗂️  FULL PATH: {filepath.relative_to(filepath.parent.parent)}")

    # File system properties
    stat = filepath.stat()
    size_bytes = stat.st_size
    size_kb = size_bytes / 1024
    size_mb = size_bytes / (1024 * 1024)

    print(f"\n💾 SIZE:")
    print(f"   {size_bytes:,} bytes")
    print(f"   {size_kb:.2f} KB")
    print(f"   {size_mb:.2f} MB")

    # Compute hash
    print(f"\n🔐 COMPUTING HASH...")
    try:
        file_hash = compute_hash(filepath)
        print(f"   MD5: {file_hash}")
    except Exception as e:
        print(f"   ✗ HASH ERROR: {e}")
        file_hash = None

    # PDF Analysis
    print(f"\n📖 PDF ANALYSIS:")
    try:
        reader = PdfReader(filepath)
        pages = len(reader.pages)
        print(f"   Pages: {pages}")

        # Metadata
        meta = reader.metadata or {}

        print(f"\n📋 EMBEDDED METADATA:")
        title = meta.get('/Title', '').strip()
        author = meta.get('/Author', '').strip()
        subject = meta.get('/Subject', '').strip()
        keywords = meta.get('/Keywords', '').strip()
        creator = meta.get('/Creator', '').strip()
        producer = meta.get('/Producer', '').strip()
        creation_date = str(meta.get('/CreationDate', ''))

        print(f"   Title:    {title if title else '[MISSING]'}")
        print(f"   Author:   {author if author else '[MISSING]'}")
        print(f"   Subject:  {subject if subject else '[MISSING]'}")
        print(f"   Keywords: {keywords if keywords else '[MISSING]'}")
        print(f"   Creator:  {creator if creator else '[MISSING]'}")
        print(f"   Producer: {producer if producer else '[MISSING]'}")
        if creation_date:
            print(f"   Created:  {creation_date}")

        # Metadata quality score
        score = sum([bool(title), bool(author), bool(subject), bool(keywords)])
        print(f"\n   ⭐ Metadata Quality: {score}/4", end="")
        if score == 4:
            print(" (EXCELLENT ✓)")
        elif score == 3:
            print(" (GOOD)")
        elif score == 2:
            print(" (FAIR)")
        elif score == 1:
            print(" (POOR)")
        else:
            print(" (CRITICAL - NO METADATA)")

        # Extract first page text
        print(f"\n📄 FIRST PAGE CONTENT:")
        try:
            first_page = reader.pages[0]
            text = first_page.extract_text()[:400]  # First 400 chars

            # Clean up text
            text = ' '.join(text.split())  # Normalize whitespace

            if text:
                print(f"   \"{text[:300]}...\"")
            else:
                print(f"   [NO TEXT EXTRACTED - Possible scanned image]")
        except Exception as e:
            print(f"   [TEXT EXTRACTION FAILED: {e}]")

    except Exception as e:
        print(f"   ✗ PDF READ ERROR: {e}")
        pages = None
        title = author = subject = keywords = None
        score = 0

    # Classification
    print(f"\n🏷️  CLASSIFICATION:")

    filename_lower = filepath.name.lower()
    classification = "UNKNOWN"
    recommendations = []
    warnings = []

    # Size-based
    if size_mb < 0.1:
        classification = "REFERENCE_LIST or ABSTRACT"
        warnings.append(f"Very small file ({size_mb:.2f} MB)")
        recommendations.append("→ Consider moving to 99_Supplementary_Data/Reference_Lists/")

    elif size_mb > 10 or (pages and pages > 100):
        classification = "BOOK or MONOGRAPH"
        warnings.append(f"Large file ({size_mb:.2f} MB, {pages} pages)")
        recommendations.append("→ Move to 08_Reference_Books/")

    # Keyword-based
    elif any(kw in filename_lower for kw in ['réf', 'scifinder', 'brevets', 'patent']):
        classification = "REFERENCE_LIST"
        warnings.append("Reference list keyword detected in filename")
        recommendations.append("→ Move to 99_Supplementary_Data/Reference_Lists/")

    elif 'corrigendum' in filename_lower or 'erratum' in filename_lower:
        if pages == 1:
            classification = "CORRIGENDUM"
            warnings.append("Single-page correction notice")
            recommendations.append("→ Move to 99_Supplementary_Data/Corrigenda/")
        else:
            classification = "RESEARCH_PAPER (with correction)"

    elif any(kw in filename_lower for kw in ['pharmacopoeia', 'archaeology', 'ecology', 'book']):
        classification = "BOOK"
        recommendations.append("→ Move to 08_Reference_Books/")

    else:
        classification = "RESEARCH_PAPER"

    print(f"   Type: {classification}")

    # Additional checks
    if not title:
        warnings.append("Missing embedded title - difficult to catalog")

    if not author:
        warnings.append("Missing embedded author - citation problems")

    if filename_lower.startswith('doi'):
        warnings.append("DOI-based filename (not descriptive)")

    if 'untitled' in filename_lower:
        warnings.append("Generic 'Untitled' filename")

    if '_1' in filepath.name or '_2' in filepath.name:
        warnings.append("Collision suffix detected (_1 or _2) - possible duplicate or multi-topic")

    if pages == 1 and classification != "CORRIGENDUM":
        warnings.append("Single-page document - verify completeness")

    if pages and pages > 500:
        warnings.append(f"Extremely long ({pages} pages) - definitely a book")

    # Year extraction
    year = extract_year_from_filename(filepath.name)
    if year:
        print(f"   Year: {year}")
        if year == 2025:
            warnings.append("2025 date - verify if preprint or misdated")

    # Display warnings
    if warnings:
        print(f"\n⚠️  WARNINGS ({len(warnings)}):")
        for w in warnings:
            print(f"   • {w}")
    else:
        print(f"\n✅ No warnings - file looks good")

    # Display recommendations
    if recommendations:
        print(f"\n💡 RECOMMENDATIONS:")
        for r in recommendations:
            print(f"   {r}")

    # Final status
    print(f"\n📊 SUMMARY:")
    print(f"   Status: ", end="")

    if classification == "RESEARCH_PAPER" and score >= 3 and not warnings:
        print("✅ EXCELLENT - Ready for thesis use")
    elif classification == "RESEARCH_PAPER" and score >= 2:
        print("✓ GOOD - Minor metadata improvements needed")
    elif classification == "RESEARCH_PAPER":
        print("⚠ FAIR - Metadata enrichment recommended")
    elif classification in ["BOOK", "REFERENCE_LIST", "CORRIGENDUM"]:
        print(f"⚠ MISCLASSIFIED - Should be in different folder")
    else:
        print("❓ REVIEW NEEDED")

    print(f"   Classification: {classification}")
    print(f"   Metadata Score: {score}/4")
    print(f"   Warnings: {len(warnings)}")

    return {
        'filename': filepath.name,
        'path': str(filepath),
        'size_mb': size_mb,
        'pages': pages,
        'hash': file_hash,
        'classification': classification,
        'metadata_score': score,
        'warnings': warnings,
        'recommendations': recommendations
    }

def main():
    base_dir = Path(__file__).parent

    print("="*80)
    print("DETAILED FILE-BY-FILE CHECKER - SECOND PASS")
    print("="*80)
    print(f"\nWorking directory: {base_dir}")
    print("Performing enhanced individual verification of every file...")
    print("\nPress Ctrl+C to stop at any time")

    input("\nPress Enter to begin detailed checking...")

    # Collect all PDFs
    all_pdfs = []
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
            pdfs = sorted(topic_path.glob("*.pdf"))
            all_pdfs.extend(pdfs)

    total_files = len(all_pdfs)
    print(f"\nTotal files to check: {total_files}\n")

    # Check each file
    results = []
    start_time = time.time()

    for i, pdf_file in enumerate(all_pdfs, 1):
        result = check_file_detailed(pdf_file, i, total_files)
        results.append(result)

        # Brief pause for readability
        time.sleep(0.1)

    elapsed = time.time() - start_time

    # Final summary
    print("\n" + "="*80)
    print("DETAILED CHECK COMPLETE")
    print("="*80)

    print(f"\nFiles checked: {total_files}")
    print(f"Time elapsed: {elapsed:.1f} seconds")
    print(f"Average: {elapsed/total_files:.2f} seconds per file")

    # Classification summary
    by_classification = {}
    for r in results:
        cls = r['classification']
        by_classification[cls] = by_classification.get(cls, 0) + 1

    print(f"\nClassification Summary:")
    for cls, count in sorted(by_classification.items(), key=lambda x: -x[1]):
        pct = (count/total_files)*100
        print(f"  {cls:30s}: {count:3d} ({pct:5.1f}%)")

    # Metadata summary
    metadata_scores = [r['metadata_score'] for r in results]
    avg_score = sum(metadata_scores) / len(metadata_scores)
    print(f"\nMetadata Quality:")
    print(f"  Average score: {avg_score:.2f}/4")
    print(f"  Excellent (4): {sum(1 for s in metadata_scores if s == 4)} files")
    print(f"  Good (3):      {sum(1 for s in metadata_scores if s == 3)} files")
    print(f"  Fair (2):      {sum(1 for s in metadata_scores if s == 2)} files")
    print(f"  Poor (1):      {sum(1 for s in metadata_scores if s == 1)} files")
    print(f"  Critical (0):  {sum(1 for s in metadata_scores if s == 0)} files")

    # Warning summary
    total_warnings = sum(len(r['warnings']) for r in results)
    files_with_warnings = sum(1 for r in results if r['warnings'])

    print(f"\nWarnings:")
    print(f"  Total warnings: {total_warnings}")
    print(f"  Files with warnings: {files_with_warnings} ({files_with_warnings/total_files*100:.1f}%)")
    print(f"  Clean files: {total_files - files_with_warnings} ({(total_files-files_with_warnings)/total_files*100:.1f}%)")

    # Save detailed log
    output_file = base_dir / f"DETAILED_CHECK_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
    print(f"\nDetailed log saved to: {output_file.name}")

if __name__ == "__main__":
    main()
