#!/usr/bin/env bash
# Preprocessing for hard-to-OCR PDFs
# Uses ImageMagick + Tesseract with enhancement

PDF="$1"
OUTPUT_DIR="$2"

# Convert PDF to high-res images
pdftoppm -png -r 600 "$PDF" "$OUTPUT_DIR/page"

# Enhance each image
for img in "$OUTPUT_DIR"/page-*.png; do
    convert "$img" \
        -density 600 \
        -type Grayscale \
        -contrast-stretch 0.1%x0.1% \
        -sharpen 0x1 \
        -despeckle \
        "${img%.png}_enhanced.png"
done

# OCR with Tesseract (high quality, English only)
for img in "$OUTPUT_DIR"/*_enhanced.png; do
    tesseract "$img" "${img%.png}" \
        -l eng \
        --psm 6 \
        --dpi 600 \
        pdf
done
