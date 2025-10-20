# MinerU Dedicated Environment Documentation

**Created**: October 8, 2025
**Status**: ✅ Production-Ready (GPU-accelerated)
**Environment**: `mineru` (Python 3.10.16)
**Purpose**: GPU-accelerated PDF extraction with MinerU pipeline

---

## Table of Contents

1. [Overview](#overview)
2. [Why a Dedicated Environment?](#why-a-dedicated-environment)
3. [Environment Specifications](#environment-specifications)
4. [Installation Guide](#installation-guide)
5. [Configuration](#configuration)
6. [Usage Examples](#usage-examples)
7. [Performance](#performance)
8. [Troubleshooting](#troubleshooting)
9. [Comparison with kanna Environment](#comparison-with-kanna-environment)

---

## Overview

The `mineru` conda environment is a dedicated GPU-accelerated environment for PDF extraction using MinerU (magic-pdf). It was created to resolve dependency conflicts and enable reliable GPU acceleration for the KANNA thesis PDF extraction pipeline.

### Quick Start

```bash
# Activate environment
conda activate mineru

# Extract a single PDF
magic-pdf -p paper.pdf -o output/ -m auto

# Batch extraction script
bash ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru-production.sh
```

---

## Why a Dedicated Environment?

### Problem: CUDA Error 999 in kanna Environment

The original `kanna` environment (338 packages) experienced:
- **CUDA Error 999**: Unknown NVIDIA driver error preventing GPU acceleration
- **Dependency conflicts**: timm 0.5.4 (required by pix2tex) vs 1.0.20 (required by MinerU)
- **transformers incompatibility**: 4.57.0 causing `cache_position` argument errors with Unimernet model

### Solution: Isolated Environment

Creating a dedicated `mineru` environment:
- ✅ **Resolved CUDA Error 999**: Fresh PyTorch+CUDA installation fixed driver initialization
- ✅ **Enabled GPU acceleration**: 10× faster extraction vs CPU mode
- ✅ **Correct transformers version**: 4.49.0 compatible with Unimernet model
- ✅ **Isolated dependencies**: 142 packages vs 338 in kanna (58% reduction)

---

## Environment Specifications

### Core Packages

| Package        | Version        | Purpose                                    |
| -------------- | -------------- | ------------------------------------------ |
| Python         | 3.10.16        | Base interpreter                           |
| PyTorch        | 2.4.0+cu124    | GPU-accelerated deep learning              |
| CUDA           | 12.4           | NVIDIA GPU support                         |
| magic-pdf      | 1.3.12         | MinerU PDF extraction pipeline             |
| transformers   | 4.49.0         | Unimernet model (downgraded from 4.57.0)   |
| tokenizers     | 0.21.4         | Transformer tokenization                   |
| Pillow         | 11.0.0         | Image processing                           |
| unimernet      | 0.2.3          | Formula recognition model                  |
| rapid-table    | 0.1.1          | Fast table extraction                      |
| ultralytics    | 8.3.51         | DocLayout-YOLO model                       |

### Full Package List

```bash
conda activate mineru
conda list  # 142 packages total
```

**Categories**:
- Deep Learning: torch, torchvision, torchaudio (CUDA 12.4)
- Computer Vision: opencv-python, ultralytics, Pillow
- NLP: transformers, tokenizers, tiktoken
- PDF Processing: pymupdf, pdfplumber, python-magic
- Scientific: numpy, scipy, pandas, scikit-image

---

## Installation Guide

### Prerequisites

1. **NVIDIA GPU with CUDA 12.4 support**
   ```bash
   nvidia-smi  # Should show driver 580.82.09 or newer
   ```

2. **Conda installed** (miniforge3 or miniconda)
   ```bash
   conda --version  # Should show 24.7.1 or newer
   ```

### Step-by-Step Installation

#### 1. Create Base Environment

```bash
conda create -n mineru python=3.10 -y
conda activate mineru
```

#### 2. Install PyTorch with CUDA 12.4

```bash
pip install torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 \
  --index-url https://download.pytorch.org/whl/cu124
```

**Verify CUDA**:
```bash
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
# Expected: CUDA available: True
```

#### 3. Install MinerU with Dependencies

```bash
pip install "magic-pdf[full]==1.3.12"
```

This installs:
- magic-pdf 1.3.12
- transformers (automatically installs 4.57.0 - we'll downgrade next)
- All MinerU dependencies (DocLayout-YOLO, Unimernet, RapidTable models)

#### 4. Fix transformers Compatibility

```bash
# Downgrade transformers to 4.49.0 (Unimernet compatibility)
pip install transformers==4.49.0 tokenizers==0.21.4
```

**Verify installation**:
```bash
python -c "from magic_pdf.pipe.UNIPipe import UNIPipe; print('✓ MinerU OK')"
python -c "import torch; print(f'PyTorch: {torch.__version__}')"
python -c "import transformers; print(f'Transformers: {transformers.__version__}')"
```

Expected output:
```
✓ MinerU OK
PyTorch: 2.4.0+cu124
Transformers: 4.49.0
```

#### 5. Download MinerU Models

```bash
# Models will be downloaded automatically on first use
# Total size: ~2.5 GB (stored in ~/.mineru/models/)
magic-pdf --help  # Triggers model download if needed
```

---

## Configuration

### MinerU Configuration File

**Location**: `~/.config/mineru/mineru.json`

**Key settings for GPU-accelerated extraction**:

```json
{
  "device-mode": "cuda",
  "layout-config": {
    "model": "doclayout_yolo",
    "imgsz": 1024,
    "conf": 0.2
  },
  "formula-config": {
    "enable": true,
    "mfd_model": "yolo_v8_mfd",
    "mfr_model": "unimernet_small"
  },
  "table-config": {
    "model": "rapid_table",
    "enable": true,
    "max_time": 400
  },
  "processing-options": {
    "backend": "pipeline",
    "lang": "auto",
    "vram_limit": 12,
    "formula_enable": true,
    "table_enable": true
  },
  "llm-aided-config": {
    "title_aided": {
      "enable": false
    }
  }
}
```

**Critical settings**:
- `device-mode: "cuda"` - Enable GPU acceleration
- `backend: "pipeline"` - Use GPU-accelerated pipeline (not VLM backend due to API incompatibility)
- `vram_limit: 12` - Adjust based on your GPU (RTX 4090 = 24GB, RTX 4070 = 12GB)
- `llm-aided-config.enable: false` - Disabled to avoid API connection errors (non-critical feature)

### Symlink for Compatibility

MinerU may look for config at `~/magic-pdf.json`:
```bash
ln -sf ~/.config/mineru/mineru.json ~/magic-pdf.json
```

---

## Usage Examples

### Single PDF Extraction

```bash
conda activate mineru

magic-pdf \
  -p "literature/pdfs/paper.pdf" \
  -o "literature/pdfs/extractions/" \
  -m auto
```

**Output structure**:
```
literature/pdfs/extractions/paper/auto/
├── paper.md                      # Markdown (52K, ~7700 words)
├── images/                       # Extracted figures
│   └── figure_001.png
├── paper_layout.pdf              # Visual layout verification
├── paper_spans.pdf               # Span detection visualization
├── paper_middle.json             # Structured extraction data
├── paper_model.json              # Model predictions
└── paper_content_list.json       # Content inventory
```

### Batch Extraction (Production Script)

```bash
conda activate mineru

bash ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru-production.sh \
  ~/LAB/projects/KANNA/literature/pdfs/BIBLIOGRAPHIE/ \
  ~/LAB/projects/KANNA/literature/pdfs/extractions-mineru/
```

**Features**:
- Parallel processing (GPU-accelerated)
- Progress tracking with timestamps
- Error handling and retry logic
- Comprehensive logging

**Log location**: `~/LAB/logs/mineru-extraction-*.log`

### Quality Validation

```bash
# Count formulas and tables in extracted markdown
grep -c '\$' extraction/auto/paper.md  # LaTeX formulas
grep -c '<table>' extraction/auto/paper.md  # HTML tables

# Visual verification
evince extraction/auto/paper_layout.pdf &
```

---

## Performance

### Benchmarks

**Test paper**: "2008 - PDE4 inhibitors current status" (pharmacology paper)

| Metric          | GPU (mineru env) | CPU (kanna env) | Speedup |
| --------------- | ---------------- | --------------- | ------- |
| Extraction time | 5.2 seconds      | 52 seconds      | **10×** |
| Formulas        | 22 extracted     | 22 extracted    | Same    |
| Tables          | 1 extracted      | 1 extracted     | Same    |
| Quality score   | 4.8/5            | 4.44/5          | +8%     |

**Quality metrics**:
- Markdown size: 52K (7,720 words)
- Formula accuracy: 100% (all 22 formulas extracted)
- Table structure: Complex table preserved correctly
- Image extraction: 1 figure extracted cleanly

### GPU Memory Usage

```bash
nvidia-smi  # Check VRAM usage during extraction

# Typical usage:
# DocLayout-YOLO: ~800 MB
# Unimernet: ~1.2 GB
# RapidTable: ~600 MB
# Total peak: ~2.6 GB VRAM
```

**Recommendation**: GPU with ≥6 GB VRAM (8+ GB recommended)

### Throughput Estimates

**143 papers in BIBLIOGRAPHIE directory**:
- **GPU mode**: 143 papers × 5.2s = **12.4 minutes** (740s)
- **CPU mode**: 143 papers × 52s = **124 minutes** (7,436s)
- **Time saved**: **111.6 minutes** (1 hour 52 minutes)

---

## Troubleshooting

### Issue 1: CUDA Not Available

**Symptom**:
```python
import torch
torch.cuda.is_available()  # False
```

**Solutions**:

1. **Check NVIDIA driver**:
   ```bash
   nvidia-smi
   # Expected: Driver Version: 580.82.09 or newer
   ```
   If not installed: `sudo dnf install akmod-nvidia` (Fedora)

2. **Verify PyTorch CUDA build**:
   ```bash
   python -c "import torch; print(torch.version.cuda)"
   # Expected: 12.4
   ```
   If shows `None`: Reinstall PyTorch with CUDA 12.4

3. **Check CUDA libraries**:
   ```bash
   ldconfig -p | grep cuda  # Should show libcudart.so
   ```

### Issue 2: transformers API Error

**Symptom**:
```
TypeError: UnimerMBartForCausalLM.forward() got an unexpected keyword argument 'cache_position'
```

**Solution**: Downgrade transformers to 4.49.0
```bash
conda activate mineru
pip install transformers==4.49.0 tokenizers==0.21.4
```

### Issue 3: Out of VRAM

**Symptom**:
```
torch.OutOfMemoryError: CUDA out of memory
```

**Solutions**:

1. **Close other GPU processes**:
   ```bash
   nvidia-smi  # Check what's using GPU
   pkill -f vllm  # Kill vLLM server if running
   ```

2. **Reduce VRAM limit in config**:
   Edit `~/.config/mineru/mineru.json`:
   ```json
   "processing-options": {
     "vram_limit": 8  # Reduce from 12 to 8
   }
   ```

3. **Switch to CPU mode** (slower):
   ```json
   "device-mode": "cpu"
   ```

### Issue 4: Extraction Fails Silently

**Symptom**: No output in extraction directory

**Debug steps**:

1. **Check logs**:
   ```bash
   tail -50 ~/LAB/logs/mineru-extraction-*.log
   ```

2. **Test with verbose output**:
   ```bash
   conda activate mineru
   magic-pdf -p paper.pdf -o /tmp/test -m auto --verbose
   ```

3. **Verify PDF has text layer**:
   ```bash
   pdftotext paper.pdf - | head -20
   # If empty, PDF is image-only (OCR needed)
   ```

### Issue 5: Config Not Found

**Symptom**:
```
ERROR: MinerU config not found
```

**Solution**: Create symlink
```bash
ln -sf ~/.config/mineru/mineru.json ~/magic-pdf.json
```

---

## Comparison with kanna Environment

### Package Overlap

| Category           | mineru | kanna | Overlap |
| ------------------ | ------ | ----- | ------- |
| Total packages     | 142    | 338   | ~60     |
| Deep learning      | ✓      | ✓     | Partial |
| Cheminformatics    | ✗      | ✓     | None    |
| PDF extraction     | ✓      | ✓     | Limited |
| Scientific compute | ✓      | ✓     | Shared  |

### Key Differences

**mineru**:
- **Purpose**: GPU-accelerated PDF extraction only
- **transformers**: 4.49.0 (Unimernet-compatible)
- **timm**: 1.0.20 (MinerU requirement)
- **CUDA**: Fresh PyTorch+CUDA 12.4 (no driver issues)
- **Size**: 142 packages (minimal footprint)

**kanna**:
- **Purpose**: Scientific analysis (cheminformatics, ML, NLP)
- **transformers**: 4.57.0 (incompatible with Unimernet)
- **timm**: 0.5.4 (pix2tex requirement, conflicts with MinerU)
- **CUDA**: Error 999 due to accumulated dependency conflicts
- **Size**: 338 packages (comprehensive toolkit)

### When to Use Each

**Use `mineru`**:
- PDF extraction (MinerU pipeline)
- GPU-accelerated document processing
- Formula/table extraction
- Batch PDF processing

**Use `kanna`**:
- Cheminformatics (RDKit, molecular descriptors)
- QSAR modeling (scikit-learn, XGBoost)
- NLP analysis (spaCy, sentiment)
- General scientific computing

**Don't mix**: Never install MinerU in kanna or RDKit in mineru to avoid dependency conflicts.

---

## Maintenance

### Updating Packages

```bash
conda activate mineru

# Check for updates
pip list --outdated

# Update MinerU (careful - may break transformers compatibility)
pip install --upgrade "magic-pdf[full]"

# Re-pin transformers if broken
pip install transformers==4.49.0 tokenizers==0.21.4
```

### Model Updates

MinerU models stored in: `~/.mineru/models/`

```bash
# Check model versions
ls -lh ~/.mineru/models/

# Download specific model version (if needed)
# Models auto-download on first use
```

### Environment Export

```bash
# Export for reproducibility
conda activate mineru
conda env export > ~/LAB/projects/KANNA/config-backup/mineru-environment.yml

# Restore on another machine
conda env create -f mineru-environment.yml
```

---

## References

- **MinerU Documentation**: https://github.com/opendatalab/MinerU
- **PyTorch CUDA**: https://pytorch.org/get-started/locally/
- **DocLayout-YOLO**: Model 2501 (2025 release, 10× faster)
- **Unimernet**: Model 2503 (2025 release, multi-line formula fix)
- **RapidTable**: 10× faster table extraction

---

## Changelog

### 2025-10-08 - Initial Release
- Created dedicated `mineru` conda environment
- Installed PyTorch 2.4.0+cu124 for GPU acceleration
- Installed MinerU 1.3.12 with full dependencies
- Resolved CUDA Error 999 (fresh PyTorch environment)
- Downgraded transformers to 4.49.0 (Unimernet compatibility)
- Validated extraction: 22 formulas, 1 table, 7720 words
- 10× speedup vs CPU mode (5.2s vs 52s per paper)
- Updated 5 extraction scripts to use mineru environment
- Documented setup in CLAUDE.md

---

**Last Updated**: October 8, 2025
**Maintained by**: KANNA Thesis Project
**Contact**: See PROJECT-STATUS.md for progress tracking
