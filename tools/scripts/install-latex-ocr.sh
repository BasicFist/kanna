#!/usr/bin/env bash
# =============================================================================
# LaTeX-OCR (pix2tex) Installation Script
# =============================================================================
# Purpose: Install LaTeX-OCR for high-accuracy formula extraction (88% BLEU)
#
# What This Installs:
#   - pix2tex package (Vision Transformer OCR for formulas)
#   - Model weights (~300MB, auto-downloaded on first run)
#   - GUI dependencies (optional, for interactive use)
#
# Integration:
#   - Works with MinerU hybrid pipeline (extract-pdfs-hybrid.sh)
#   - Replaces Kilo API (zero cost alternative)
#   - Saves ~$150 for 500 papers + 200+ hours manual correction
#
# Usage:
#   ./install-latex-ocr.sh
#
# Author: KANNA Thesis Project
# Date: October 2025
# =============================================================================

set -Eeuo pipefail

KANNA_ENV="kanna"
LOG_FILE="logs/latex-ocr-install-$(date +%Y%m%d-%H%M%S).log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

echo "=== LaTeX-OCR Installation ===" | tee -a "$LOG_FILE"
echo "This will install pix2tex for formula extraction" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"

# Verify conda environment exists
echo "Verifying conda environment: $KANNA_ENV" | tee -a "$LOG_FILE"
conda run -n "$KANNA_ENV" python --version 2>&1 | tee -a "$LOG_FILE" || {
    echo "ERROR: Conda env '$KANNA_ENV' not found" | tee -a "$LOG_FILE"
    echo "Create it first: conda create -n $KANNA_ENV python=3.10" | tee -a "$LOG_FILE"
    exit 1
}

# Check if already installed
if conda run -n "$KANNA_ENV" python -c "import pix2tex" 2>/dev/null; then
    echo "✓ LaTeX-OCR already installed" | tee -a "$LOG_FILE"
    conda run -n "$KANNA_ENV" python -c "from pix2tex.cli import LatexOCR; print('  Version: OK')" 2>&1 | tee -a "$LOG_FILE"

    read -p "Reinstall anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping installation" | tee -a "$LOG_FILE"
        exit 0
    fi
fi

# Install LaTeX-OCR with GUI support
echo "" | tee -a "$LOG_FILE"
echo "Installing pix2tex with GUI support..." | tee -a "$LOG_FILE"
conda run -n "$KANNA_ENV" pip install "pix2tex[gui]" 2>&1 | tee -a "$LOG_FILE" || {
    echo "⚠ GUI installation failed, trying without GUI..." | tee -a "$LOG_FILE"
    conda run -n "$KANNA_ENV" pip install pix2tex 2>&1 | tee -a "$LOG_FILE"
}

# Verify installation
echo "" | tee -a "$LOG_FILE"
echo "Verifying installation..." | tee -a "$LOG_FILE"

conda run -n "$KANNA_ENV" python <<'PYTHON' 2>&1 | tee -a "$LOG_FILE"
import sys
try:
    from pix2tex.cli import LatexOCR
    print("✓ LaTeX-OCR import successful")

    # Check dependencies
    import torch
    print(f"✓ PyTorch {torch.__version__}")

    import transformers
    print(f"✓ Transformers {transformers.__version__}")

    print("\nInstallation complete!")
    print("\nNext steps:")
    print("  1. Test: python -c 'from pix2tex.cli import LatexOCR; m = LatexOCR()'")
    print("  2. Use: ./tools/scripts/extract-pdfs-hybrid.sh")
    print("  3. Docs: tools/guides/08-latex-ocr-integration.md")

except ImportError as e:
    print(f"✗ Import failed: {e}", file=sys.stderr)
    print("\nTroubleshooting:", file=sys.stderr)
    print("  1. Ensure conda env is activated: conda activate kanna", file=sys.stderr)
    print("  2. Reinstall: pip uninstall pix2tex && pip install pix2tex", file=sys.stderr)
    print("  3. Check dependencies: pip install torch transformers pillow", file=sys.stderr)
    sys.exit(1)
PYTHON

# Download model weights (test run)
echo "" | tee -a "$LOG_FILE"
read -p "Download model weights now (~300MB)? (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    echo "Downloading model weights..." | tee -a "$LOG_FILE"

    conda run -n "$KANNA_ENV" python <<'PYTHON' 2>&1 | tee -a "$LOG_FILE"
from pix2tex.cli import LatexOCR
import urllib.request
from PIL import Image

# Download sample image
print("Downloading test image...")
url = "https://raw.githubusercontent.com/lukas-blecher/LaTeX-OCR/main/data/example.png"
urllib.request.urlretrieve(url, "/tmp/latex_ocr_test.png")

# Initialize model (triggers weight download)
print("Initializing model (downloading weights ~300MB)...")
model = LatexOCR()

# Test extraction
img = Image.open("/tmp/latex_ocr_test.png")
latex = model(img)

print(f"\n✓ Test successful!")
print(f"Sample formula extracted: {latex}")
print(f"\nModel weights cached at: ~/.cache/pix2tex/")
PYTHON
else
    echo "Skipping weight download (will download on first use)" | tee -a "$LOG_FILE"
fi

# Print summary
echo "" | tee -a "$LOG_FILE"
echo "=== Installation Summary ===" | tee -a "$LOG_FILE"
echo "✓ pix2tex installed in conda env: $KANNA_ENV" | tee -a "$LOG_FILE"
echo "✓ Model weights: ~/.cache/pix2tex/" | tee -a "$LOG_FILE"
echo "✓ Log file: $LOG_FILE" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Usage Examples:" | tee -a "$LOG_FILE"
echo "  1. Hybrid extraction: ./tools/scripts/extract-pdfs-hybrid.sh" | tee -a "$LOG_FILE"
echo "  2. Command-line: pix2tex path/to/formula-image.png" | tee -a "$LOG_FILE"
echo "  3. GUI mode: latexocr  # If GUI installed" | tee -a "$LOG_FILE"
echo "" | tee -a "$LOG_FILE"
echo "Documentation: tools/guides/08-latex-ocr-integration.md" | tee -a "$LOG_FILE"
