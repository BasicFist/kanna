#!/usr/bin/env python3
"""
Simple PDF extraction using pdfplumber (MinerU workaround).

Usage:
    conda run -n kanna python extract-pdfs-pdfplumber.py [pdf_directory]
"""
import sys
from pathlib import Path
import pdfplumber

def extract_pdf(pdf_path, output_dir):
    """Extract text and tables from a PDF file."""
    pdf_name = pdf_path.stem
    markdown_file = output_dir / f"{pdf_name}.md"

    # Skip if already extracted
    if markdown_file.exists():
        print(f"✓ Skipping (already extracted): {pdf_name}")
        return False

    print(f"Extracting: {pdf_name}")

    try:
        with pdfplumber.open(pdf_path) as pdf:
            full_text = []

            for page_num, page in enumerate(pdf.pages, 1):
                # Extract text
                text = page.extract_text()
                if text:
                    full_text.append(f"## Page {page_num}\n\n{text}\n\n")

                # Extract tables
                tables = page.extract_tables()
                if tables:
                    for table_num, table in enumerate(tables, 1):
                        full_text.append(f"### Table {table_num} (Page {page_num})\n\n")
                        if table:
                            header = table[0]
                            rows = table[1:]
                            # Markdown table
                            full_text.append("| " + " | ".join(str(cell) if cell else "" for cell in header) + " |\n")
                            full_text.append("| " + " | ".join("---" for _ in header) + " |\n")
                            for row in rows:
                                full_text.append("| " + " | ".join(str(cell) if cell else "" for cell in row) + " |\n")
                            full_text.append("\n")

            # Save markdown
            with open(markdown_file, 'w', encoding='utf-8') as f:
                f.write(''.join(full_text))

            print(f"  ✓ Extracted {len(pdf.pages)} pages")
            return True

    except Exception as e:
        print(f"  ⚠ Error: {str(e)}")
        return False


def main():
    # Configuration
    pdf_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path('literature/pdfs/PILOT-20')
    output_base = Path('data/extracted-papers-simple')

    # Create output directory
    output_base.mkdir(parents=True, exist_ok=True)

    # Find all PDFs
    pdf_files = list(pdf_dir.glob('*.pdf'))
    print(f"Found {len(pdf_files)} PDF files in {pdf_dir}")

    if not pdf_files:
        print(f"ERROR: No PDF files found in {pdf_dir}")
        return 1

    # Extract each PDF
    success_count = 0
    for pdf_path in pdf_files:
        pdf_name = pdf_path.stem
        output_dir = output_base / pdf_name
        output_dir.mkdir(parents=True, exist_ok=True)

        if extract_pdf(pdf_path, output_dir):
            success_count += 1

    print(f"\n✓ Extraction complete!")
    print(f"Successfully extracted: {success_count}/{len(pdf_files)} PDFs")
    print(f"Output directory: {output_base}")
    return 0


if __name__ == '__main__':
    sys.exit(main())
