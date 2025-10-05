#!/usr/bin/env bash
# =============================================================================
# Simple PDF Extraction with pdfplumber
# =============================================================================
# Purpose: Extract text from PDFs using pdfplumber (no complex dependencies)
#
# Usage:
#   ./extract-pdfs-simple.sh [pdf-directory]
#
# Requirements:
#   - pdfplumber installed in conda env 'kanna'
#
# Author: KANNA Thesis Project
# Date: October 2025
# Status: MinerU workaround (layoutlmv3 dependency blocker)
# =============================================================================

set -Eeuo pipefail

# Configuration
PDF_DIR="${1:-literature/pdfs/PILOT-20}"
OUTPUT_BASE="data/extracted-papers-simple"
LOG_FILE="logs/simple-extraction-$(date +%Y%m%d-%H%M%S).log"

# Ensure directories exist
mkdir -p "$(dirname "$LOG_FILE")"
mkdir -p "$OUTPUT_BASE"

echo "Starting PDF extraction with pdfplumber" | tee -a "$LOG_FILE"
echo "Input directory: $PDF_DIR" | tee -a "$LOG_FILE"
echo "Output directory: $OUTPUT_BASE" | tee -a "$LOG_FILE"

# Python extraction script
PDF_DIR="$PDF_DIR" OUTPUT_BASE="$OUTPUT_BASE" conda run -n kanna python <<'PYTHON_SCRIPT' 2>>"$LOG_FILE"
import os
import sys
from pathlib import Path
import pdfplumber

# Configuration
PDF_DIR = os.getenv('PDF_DIR', 'literature/pdfs/PILOT-20')
OUTPUT_BASE = os.getenv('OUTPUT_BASE', 'data/extracted-papers-simple')
print(f"DEBUG: PDF_DIR={PDF_DIR}, OUTPUT_BASE={OUTPUT_BASE}", file=sys.stderr)

# Find all PDFs
pdf_files = list(Path(PDF_DIR).glob('*.pdf'))
print(f"Found {len(pdf_files)} PDF files")

for pdf_path in pdf_files:
    pdf_name = pdf_path.stem
    output_dir = Path(OUTPUT_BASE) / pdf_name
    output_dir.mkdir(parents=True, exist_ok=True)

    markdown_file = output_dir / f"{pdf_name}.md"

    # Skip if already extracted
    if markdown_file.exists():
        print(f"✓ Skipping (already extracted): {pdf_name}")
        continue

    print(f"Extracting: {pdf_name}")

    try:
        with pdfplumber.open(pdf_path) as pdf:
            # Extract text from all pages
            full_text = []

            for page_num, page in enumerate(pdf.pages, 1):
                # Extract text
                text = page.extract_text()
                if text:
                    full_text.append(f"## Page {page_num}\n\n{text}\n\n")

                # Extract tables (if any)
                tables = page.extract_tables()
                if tables:
                    for table_num, table in enumerate(tables, 1):
                        full_text.append(f"### Table {table_num} (Page {page_num})\n\n")
                        # Convert table to markdown
                        if table:
                            header = table[0]
                            rows = table[1:]
                            # Simple markdown table
                            full_text.append("| " + " | ".join(str(cell) if cell else "" for cell in header) + " |\n")
                            full_text.append("| " + " | ".join("---" for _ in header) + " |\n")
                            for row in rows:
                                full_text.append("| " + " | ".join(str(cell) if cell else "" for cell in row) + " |\n")
                            full_text.append("\n")

            # Save markdown
            with open(markdown_file, 'w', encoding='utf-8') as f:
                f.write(''.join(full_text))

            print(f"  ✓ Extracted {len(pdf.pages)} pages")

    except Exception as e:
        print(f"  ⚠ Error: {str(e)}")
        continue

print("\n✓ Extraction complete!")
print(f"Output directory: {OUTPUT_BASE}")
PYTHON_SCRIPT

echo -e "\n=== Extraction Summary ===" | tee -a "$LOG_FILE"
total_pdfs=$(find "$OUTPUT_BASE" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo "PDFs extracted: $total_pdfs" | tee -a "$LOG_FILE"
echo "Output directory: $OUTPUT_BASE" | tee -a "$LOG_FILE"
echo "Log file: $LOG_FILE" | tee -a "$LOG_FILE"
