#!/usr/bin/env python3
"""
Hard-to-OCR PDF Extraction using Ollama Cloud Vision-LLM
Uses deepseek-v3.1:671b-cloud for intelligent document understanding
"""

import os
import sys
import json
import base64
from pathlib import Path
import requests
from pdf2image import convert_from_path

# Ollama Cloud API configuration
OLLAMA_API_URL = "https://ollama.com/api/chat"
OLLAMA_API_KEY = os.getenv("OLLAMA_API_KEY")
if not OLLAMA_API_KEY:
    print("ERROR: OLLAMA_API_KEY environment variable not set")
    print("Export it with: export OLLAMA_API_KEY='your-key-here'")
    sys.exit(1)
MODEL = "deepseek-v3.1:671b-cloud"


def extract_pdf_with_vision_llm(pdf_path: str, output_dir: str):
    """
    Extract text from hard-to-OCR PDF using vision-language model.

    Args:
        pdf_path: Path to PDF file
        output_dir: Directory to save extracted markdown
    """
    pdf_path = Path(pdf_path)
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    print(f"📄 Processing: {pdf_path.name}")

    # Convert PDF to images (one per page)
    print("  Converting PDF to images...")
    images = convert_from_path(pdf_path, dpi=300)

    markdown_content = []

    for page_num, image in enumerate(images, 1):
        print(f"  📖 Extracting page {page_num}/{len(images)}...")

        # Save image temporarily
        img_path = output_dir / f"temp_page_{page_num}.png"
        image.save(img_path, "PNG")

        # Read image as base64
        with open(img_path, "rb") as img_file:
            img_base64 = base64.b64encode(img_file.read()).decode('utf-8')

        # Call Ollama Cloud API with vision capabilities
        prompt = """Extract ALL text, formulas, tables, and chemical structures from this image.

Instructions:
1. Preserve exact formatting and layout
2. Convert mathematical formulas to LaTeX (e.g., $K_i = ...$)
3. Convert tables to markdown tables
4. Describe chemical structures if present
5. Include figure captions and references
6. Maintain paragraph structure

Return only the extracted content in clean markdown format."""

        payload = {
            "model": MODEL,
            "messages": [{
                "role": "user",
                "content": prompt,
                "images": [img_base64]
            }],
            "stream": False
        }

        headers = {
            "Authorization": f"Bearer {OLLAMA_API_KEY}",
            "Content-Type": "application/json"
        }

        try:
            response = requests.post(OLLAMA_API_URL, json=payload, headers=headers)
            response.raise_for_status()

            result = response.json()
            page_text = result.get("message", {}).get("content", "")

            markdown_content.append(f"## Page {page_num}\n\n{page_text}\n\n")

            # Clean up temp image
            img_path.unlink()

        except Exception as e:
            print(f"  ❌ Error on page {page_num}: {e}")
            markdown_content.append(f"## Page {page_num}\n\n[Extraction failed: {e}]\n\n")

    # Save combined markdown
    output_file = output_dir / f"{pdf_path.stem}.md"
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("".join(markdown_content))

    print(f"✅ Saved to: {output_file}")
    return output_file


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python extract-hard-ocr-ollama.py <pdf_file> <output_dir>")
        sys.exit(1)

    pdf_file = sys.argv[1]
    output_dir = sys.argv[2]

    extract_pdf_with_vision_llm(pdf_file, output_dir)
