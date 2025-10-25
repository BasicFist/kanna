# PDF Extraction Troubleshooting Guide

**Version**: 1.0
**Created**: October 21, 2025
**Purpose**: Common issues, diagnostics, and solutions for KANNA PDF extraction workflow

---

## Quick Diagnostics

```bash
# Check GPU availability
conda activate mineru
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
python -c "import torch; print(f'CUDA version: {torch.version.cuda}')"

# Check MinerU installation
which magic-pdf
magic-pdf --help

# Check config location
ls -la ~/.config/mineru/mineru.json
cat ~/.config/mineru/mineru.json | head -10

# Check model files
ls -lh ~/.cache/magic-pdf/models/
ls -lh ~/.cache/magic-pdf/models/MFD/YOLO/yolo_v8_ft.pt

# Test single PDF
magic-pdf -p literature/pdfs/test.pdf -o /tmp/test -m auto
cat /tmp/test/auto/*.md | head -50
```

---

## Critical Issues

### Issue 1: Silent Extraction Failures

**Symptom**: MinerU runs without errors but produces empty or minimal output (<100 words)

**Root Cause**: Missing or corrupted model files, MinerU silently fails when models unavailable

**Diagnostic**:
```bash
# Check extraction output
find literature/pdfs/extractions-mineru/ -name "*.md" -exec wc -w {} \; | sort -n

# Check for empty files
find literature/pdfs/extractions-mineru/ -name "*.md" -size -1k

# Look for model file size issues
find ~/.cache/magic-pdf/models/ -name "*.pt" -size 0
```

**Solution**:

1. **Verify model files exist and are non-zero**:
```bash
# CRITICAL: Check model file sizes
ls -lh ~/.cache/magic-pdf/models/MFD/YOLO/yolo_v8_ft.pt
# Should be ~800 MB, NOT 0 bytes
```

2. **Re-download models if missing or 0 bytes** - See "Model Download Issues" section

3. **Validate extraction quality** with quality validation script

**Prevention**: Always check model files after MinerU installation, use quality checks in scripts

**See Also**: Session memory `session-2025-10-21-mineru-optimization-codex`

---

### Issue 2: Model Download Failures

**Symptom**: FileNotFoundError for model files, 0-byte files, Hugging Face 401 errors

**Root Cause**: MinerU models hosted on Hugging Face, require authentication

**Solution**:

**Option 1: Authenticated Download** (RECOMMENDED):
```bash
# Get Hugging Face token from https://huggingface.co/settings/tokens
export HF_TOKEN="your-token-here"

# Download models
conda activate mineru
python -c "from magic_pdf.model.model_list import AtomicModel; AtomicModel().download_models()"
```

**Option 2: Manual Download**:
```bash
mkdir -p ~/.cache/magic-pdf/models/MFD/YOLO
cd ~/.cache/magic-pdf/models/MFD/YOLO/
wget https://huggingface.co/opendatalab/MinerU-models/resolve/main/yolo_v8_ft.pt
```

**Prevention**: Document HF token in `~/.config/kanna/.env`, add model validation to setup

---

### Issue 3: CUDA Initialization Failures

**Symptom**: CUDA not available despite NVIDIA GPU, falls back to CPU (10× slower)

**Diagnostic**:
```bash
nvidia-smi  # Check driver
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
```

**Solutions**:

**Driver not loaded**:
```bash
sudo modprobe nvidia
echo "nvidia" | sudo tee -a /etc/modules
```

**PyTorch CUDA mismatch**:
```bash
conda install pytorch torchvision pytorch-cuda=12.4 -c pytorch -c nvidia
```

**VRAM exhausted**:
```bash
# Reduce in config: "vram_limit": 8
# Or disable features: "equation": {"enable": false}
```

**See Also**: CLAUDE.md "CUDA Initialization Persistent Failure"

---

### Issue 4: Configuration Location Confusion

**Symptom**: Config changes not taking effect, unclear which config is active

**Solution**:

**Re-create symlink structure**:
```bash
mkdir -p ~/.config/mineru
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/production.json ~/.config/mineru/mineru.json
ln -sf ~/.config/mineru/mineru.json ~/magic-pdf.json
```

**Verify**:
```bash
ls -la ~/magic-pdf.json  # Should point to ~/.config/mineru/mineru.json
ls -la ~/.config/mineru/mineru.json  # Should point to production.json
```

**See Also**: tools/config/mineru/README.md

---

## Common Errors

### "conda: command not found"

```bash
# Find conda
which conda

# Initialize
eval "$(/home/miko/miniforge3/bin/conda shell.bash hook)"

# Make persistent
echo 'eval "$(/home/miko/miniforge3/bin/conda shell.bash hook)"' >> ~/.bashrc
```

---

### "magic-pdf: command not found"

```bash
conda activate mineru
which magic-pdf  # Should show envs/mineru/bin/magic-pdf
```

---

### "ImportError: No module named 'pdf2image'"

```bash
conda activate kanna
pip install pdf2image
sudo apt install poppler-utils
```

---

### "Tesseract not found"

```bash
sudo apt install tesseract-ocr tesseract-ocr-fra tesseract-ocr-eng
tesseract --version
```

---

### "API key not found" (Ollama Cloud)

```bash
cp .env.example ~/.config/kanna/.env
nano ~/.config/kanna/.env  # Add: export OLLAMA_API_KEY="key"
source ~/.config/kanna/.env
echo $OLLAMA_API_KEY  # Verify
```

---

## Quality Validation

### Low Word Count Extractions

**Diagnostic**:
```bash
find literature/pdfs/extractions-mineru/ -name "*.md" -exec wc -w {} \; | sort -n
```

**Causes**: Scanned PDF, missing models, unsupported language, complex layout

**Solutions**:

1. Check if PDF has text layer: `pdftotext test.pdf - | wc -w`
2. Use Vision-LLM fallback: `bash tools/scripts/smart-pdf-extraction.sh <pdf>`
3. Try OCR preprocessing: `bash tools/scripts/preprocess-hard-ocr.sh <pdf>`

---

### Missing Formulas

**Diagnostic**:
```bash
grep -c "\\$\\|\\\\[" extractions/*.md  # Count formula delimiters
```

**Solution**:

Enable in config:
```json
{
  "equation": {"enable": true},
  "formula-config": {"enable": true, "mfr_model": "unimernet_small"}
}
```

Or switch to baseline config (formulas enabled):
```bash
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/baseline-20251009.json ~/.config/mineru/mineru.json
```

---

### Malformed Tables

**Diagnostic**:
```bash
grep -c "^|" extractions/*.md  # Count table rows
```

**Solution**:

Enable in config:
```json
{
  "table": {"enable": true},
  "table-config": {"model": "rapid_table", "enable": true}
}
```

---

## Performance Issues

### Slow Extraction (>30 sec/paper)

**Diagnostics**:
```bash
time magic-pdf -p test.pdf -o /tmp/test -m auto
nvidia-smi  # Check GPU usage
htop  # Check CPU usage
```

**Solutions**:

1. Verify GPU: `python -c "import torch; print(torch.cuda.is_available())"`
2. Use production config (faster): Switch to production.json
3. Reduce image size: Set `"imgsz": 640` in config

---

### VRAM Exhaustion

**Symptoms**: CUDA out of memory, system freeze, crashes

**Solutions**:

1. Reduce VRAM limit: `"vram_limit": 8`
2. Reduce image size: `"imgsz": 640`
3. Disable features: `"equation": false`, `"table": false`
4. Process smaller batches (20 PDFs at a time)

---

## Validation Workflow

### Pre-Flight Checks

```bash
# 1. GPU
nvidia-smi

# 2. Environment
conda activate mineru

# 3. Models
ls -lh ~/.cache/magic-pdf/models/**/*.pt

# 4. Config
cat ~/.config/mineru/mineru.json | jq .

# 5. Test
magic-pdf -p test.pdf -o /tmp/test -m auto
cat /tmp/test/auto/*.md | wc -w
```

### Post-Extraction Validation

```bash
# Success rate
TOTAL=$(ls -1 pdfs/*.pdf | wc -l)
SUCCESS=$(find extractions/ -name "*.md" -size +1k | wc -l)
echo "Success: $((SUCCESS * 100 / TOTAL))%"

# Quality check
python tools/scripts/validate-mineru-quality.py --input extractions/ --output report.json

# Spot check 10%
find extractions/ -name "*.md" | shuf -n 14 > /tmp/sample.txt
```

---

## Emergency Recovery

### Crashes Mid-Batch

**Recovery**:
```bash
# Find completed
find extractions/ -name "*.md" -size +1k | wc -l

# List remaining
comm -23 \
  <(ls pdfs/*.pdf | sort) \
  <(find extractions/ -name "*.md" | sed 's|.*/||; s|\.md$|.pdf|' | sort) \
  > /tmp/remaining.txt

# Resume
while read pdf; do
  magic-pdf -p "pdfs/$pdf" -o extractions/ -m auto
done < /tmp/remaining.txt
```

---

## Advanced Debugging

### Enable Debug Logging

```bash
magic-pdf -p test.pdf -o /tmp/test -m auto -d
cat /tmp/test/magic-pdf-debug.log
```

### Inspect Intermediate Outputs

```bash
ls /tmp/test/auto/  # images/, layout/, formulas/, tables/
cat /tmp/test/auto/layout/page-001-layout.json | jq .
```

---

## Getting Help

### Documentation

1. **EXTRACTION-GUIDE.md** - Decision trees, benchmarks, use cases
2. **CONFIG-FIELDS.md** - Configuration options
3. **CLAUDE.md** - Project context

### Session Memories

- `session-2025-10-21-crash-recovery-pdf-extraction` - Silent failures, quality validation
- `session-2025-10-21-mineru-optimization-codex` - CUDA issues, model downloads, Codex troubleshooting

### External Resources

- MinerU GitHub: https://github.com/opendatalab/MinerU
- PyTorch CUDA: https://pytorch.org/get-started/locally/
- Hugging Face: https://huggingface.co/opendatalab

---

**Last Updated**: October 21, 2025
**Maintained By**: KANNA Infrastructure (MP-3)
**Version**: 1.0
