#!/usr/bin/env bash
# =============================================================================
# MinerU Model Download Script
# =============================================================================
# Purpose: Download required AI models for MinerU PDF extraction
#
# Models downloaded (~500MB total):
#   - YOLOv8 formula detection (MFD/YOLO/yolo_v8_ft.pt) - ~50MB
#   - LayoutLMv3 layout analysis - ~400MB
#   - (Optional) RapidTable for tables - ~100MB
#
# Usage:
#   chmod +x tools/scripts/download-mineru-models.sh
#   ./tools/scripts/download-mineru-models.sh
#
# Author: KANNA Thesis Project
# Date: October 2025
# =============================================================================

set -Eeuo pipefail

MODELS_DIR="${HOME}/.mineru/models"
KANNA_ENV="kanna"

echo "=== MinerU Model Download ==="
echo "This will download AI models for PDF extraction (~500MB)"
echo ""

# Create models directory
mkdir -p "$MODELS_DIR"
echo "✓ Models directory: $MODELS_DIR"

# Download models using huggingface-cli
echo ""
echo "Downloading models from HuggingFace..."

conda run -n "$KANNA_ENV" python - <<'PYTHON'
import os
from huggingface_hub import hf_hub_download

repo_id = "opendatalab/PDF-Extract-Kit-1.0"
models_dir = os.path.expanduser("~/.mineru/models")

# Required models for formula extraction
model_files = [
    "models/MFD/YOLO/yolo_v8_ft.pt",  # Formula detection
    "models/Layout/YOLO/doclayout_yolo_ft.pt",  # Layout analysis
]

print(f"Downloading to: {models_dir}")
print("")

for file_path in model_files:
    print(f"Downloading: {file_path}...")
    try:
        # Download and place in correct directory structure
        parts = file_path.split('/')
        local_dir = os.path.join(models_dir, *parts[:-1])
        os.makedirs(local_dir, exist_ok=True)

        local_file = os.path.join(local_dir, parts[-1])

        # Download from HuggingFace
        hf_hub_download(
            repo_id=repo_id,
            filename=file_path,
            local_dir=models_dir,
            local_dir_use_symlinks=False
        )

        print(f"  ✓ {file_path}")
    except Exception as e:
        print(f"  ✗ Error: {e}")

print("")
print("Model download complete!")
print("")
print("Verify installation:")
print(f"  ls -lh {models_dir}/models/MFD/YOLO/")
print(f"  ls -lh {models_dir}/models/Layout/YOLO/")
PYTHON

# Verify downloads
echo ""
echo "=== Verification ==="
if [ -f "$MODELS_DIR/models/MFD/YOLO/yolo_v8_ft.pt" ]; then
    echo "✓ YOLOv8 formula detection model: $(du -h "$MODELS_DIR/models/MFD/YOLO/yolo_v8_ft.pt" | cut -f1)"
else
    echo "✗ YOLOv8 model missing"
fi

if [ -f "$MODELS_DIR/models/Layout/YOLO/doclayout_yolo_ft.pt" ]; then
    echo "✓ Layout analysis model: $(du -h "$MODELS_DIR/models/Layout/YOLO/doclayout_yolo_ft.pt" | cut -f1)"
else
    echo "✗ Layout model missing"
fi

echo ""
echo "Next steps:"
echo "  1. Update config: Ensure /home/miko/magic-pdf.json has correct models-dir"
echo "  2. Test extraction: ./tools/scripts/extract-pdfs-hybrid.sh <pdf>"
echo "  3. If errors persist, check: tools/guides/06-mineru-pdf-extraction-setup.md"
