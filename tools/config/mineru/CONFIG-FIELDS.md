# MinerU Configuration Fields Reference

**Version**: 1.3.0
**Last Updated**: October 21, 2025
**For**: MinerU PDF extraction pipeline

---

## Quick Reference

| Config File | Purpose | Use When |
|-------------|---------|----------|
| `production.json` | Current active config | Normal PDF extraction |
| `baseline-20251009.json` | Pre-optimization baseline | Rollback or comparison |
| `experimental.json` | Testing new settings | Experimenting with performance tuning |

---

## Core Configuration Fields

### device-mode
**Type**: `string`
**Values**: `"cuda"` | `"cpu"` | `"mps"` (Apple Silicon)
**Default**: `"cuda"`
**Description**: GPU acceleration mode

**Performance Impact**:
- `cuda`: **10× faster** (3 sec/paper vs 30 sec/paper)
- `cpu`: Slower but works without GPU
- `mps`: Apple Silicon acceleration (macOS only)

**Usage**:
```json
{
  "device-mode": "cuda"
}
```

**Troubleshooting**:
- CUDA not available: Check `nvidia-smi`, verify driver ≥550
- Out of VRAM: Reduce `imgsz` or switch to `"cpu"`

---

### models-dir
**Type**: `string` (path)
**Default**: `"/home/miko/.cache/magic-pdf/models"`
**Description**: Directory where MinerU models are stored

**Models Stored** (~2-3 GB total):
- DocLayout-YOLO (2501) - Layout detection
- Unimernet Small (2503) - Formula recognition
- RapidTable - Table extraction
- YOLOv8 MFD - Math formula detection

**Usage**:
```json
{
  "models-dir": "/home/miko/.mineru/models"
}
```

**Best Practices**:
- Use SSD for faster model loading
- Ensure 5+ GB free space
- Backup models before major updates

---

## Layout Detection

### layout-config.model
**Type**: `string`
**Values**: `"doclayout_yolo"` | `"layoutlmv3"` | `"auto"`
**Default**: `"doclayout_yolo"`
**Description**: Model for page layout analysis

**Model Comparison**:
| Model | Speed | Accuracy | VRAM | Recommended |
|-------|-------|----------|------|-------------|
| **doclayout_yolo** | **10× faster** | High | Low | ✅ Yes (2025) |
| layoutlmv3 | Slow | High | High | ❌ Deprecated |

**Usage**:
```json
{
  "layout-config": {
    "model": "doclayout_yolo",
    "imgsz": 1024,
    "conf": 0.2
  }
}
```

### layout-config.imgsz
**Type**: `integer`
**Values**: `640` | `1024` | `1280`
**Default**: `1024`
**Description**: Image size for layout detection

**Performance Tuning**:
- `640`: Fast, lower accuracy (simple layouts)
- `1024`: **Balanced** (recommended)
- `1280`: Slower, higher accuracy (complex layouts)

### layout-config.conf
**Type**: `float`
**Range**: `0.0` - `1.0`
**Default**: `0.2`
**Description**: Confidence threshold for layout detection

**Tuning Guide**:
- `0.1`: Detect more elements (may include noise)
- `0.2`: **Balanced** (recommended)
- `0.5`: Only high-confidence detections (may miss elements)

---

## Formula Extraction

### equation.enable (Production) / formula-config.enable (Baseline)
**Type**: `boolean`
**Default**: `true` (baseline) | `false` (production)
**Description**: Enable LaTeX formula extraction

**Performance Impact**:
- Enabled: +2-3 seconds per paper
- Disabled: Faster but no formulas

**Use Cases**:
- ✅ Enable for: Chemistry, physics, mathematics papers
- ❌ Disable for: Text-only papers, social sciences

**Usage**:
```json
{
  "equation": {
    "enable": true
  }
}
```

or (baseline format):

```json
{
  "formula-config": {
    "enable": true,
    "mfd_model": "yolo_v8_mfd",
    "mfr_model": "unimernet_small"
  }
}
```

### formula-config.mfr_model
**Type**: `string`
**Values**: `"unimernet_small"` | `"unimernet_base"`
**Default**: `"unimernet_small"`
**Description**: Formula recognition model

**Model Comparison**:
| Model | Speed | Accuracy | VRAM | Use For |
|-------|-------|----------|------|---------|
| **unimernet_small** | Fast | 85-90% | 2GB | ✅ Most papers |
| unimernet_base | Slower | 90-95% | 4GB | Complex formulas |

---

## Table Extraction

### table.enable (Production) / table-config.enable (Baseline)
**Type**: `boolean`
**Default**: `true` (baseline) | `false` (production)
**Description**: Enable table extraction

**Usage**:
```json
{
  "table": {
    "enable": true
  }
}
```

or (baseline format):

```json
{
  "table-config": {
    "model": "rapid_table",
    "enable": true,
    "max_time": 400
  }
}
```

### table-config.model
**Type**: `string`
**Values**: `"rapid_table"` | `"struct_eqtable"`
**Default**: `"rapid_table"`
**Description**: Table extraction model

**Model Comparison**:
| Model | Speed | Accuracy | Use For |
|-------|-------|----------|---------|
| **rapid_table** | **10× faster** | >85% | ✅ Most tables |
| struct_eqtable | Slower | Higher | Complex nested tables |

### table-config.max_time
**Type**: `integer` (seconds)
**Default**: `400`
**Description**: Maximum time to spend extracting a single table

**Tuning**:
- `200`: Fast, may timeout on complex tables
- `400`: **Balanced** (recommended)
- `600`: Slower, handles very complex tables

---

## Output Formats

### output-formats.markdown.enable
**Type**: `boolean`
**Default**: `true`
**Description**: Generate markdown output

**Always enable** for Obsidian/thesis workflow.

### output-formats.markdown.format
**Type**: `string`
**Values**: `"obsidian-optimized"` | `"standard"` | `"github"`
**Default**: `"obsidian-optimized"`
**Description**: Markdown output format

**Format Comparison**:
| Format | Best For | Features |
|--------|----------|----------|
| **obsidian-optimized** | ✅ KANNA thesis | Wiki-links, metadata, LaTeX |
| standard | Generic markdown | Basic markdown |
| github | GitHub | GFM syntax |

### output-formats.markdown.include_metadata
**Type**: `boolean`
**Default**: `true`
**Description**: Include PDF metadata in markdown

**Metadata Included**:
- Title, author, date
- Page count, extraction date
- MinerU version, model used

### output-formats.json.enable
**Type**: `boolean`
**Default**: `true`
**Description**: Generate JSON output for RAG/processing

**Use Cases**:
- ✅ RAG systems (search, retrieval)
- ✅ Secondary processing
- ❌ Disable if only need markdown

---

## LaTeX Delimiters

### latex-delimiter-config
**Type**: `object`
**Description**: Configure LaTeX formula delimiters

**Overleaf Compatibility** (Recommended):
```json
{
  "latex-delimiter-config": {
    "display": {
      "left": "\\[",
      "right": "\\]"
    },
    "inline": {
      "left": "$",
      "right": "$"
    }
  }
}
```

**Alternative Delimiters**:
- Display: `$$...$$` (Markdown-style)
- Inline: `\\(...\\)` (LaTeX-style)

---

## LLM-Aided Extraction (Advanced)

### llm-aided-config.enable
**Type**: `boolean`
**Default**: `false`
**Description**: Use Claude Sonnet 4.5 for low-confidence formulas

**Cost Analysis**:
- Per paper: ~$0.020
- 142 papers: ~$2.91
- Only called if OCR confidence <80%

**Setup Required**:
1. Set `ANTHROPIC_API_KEY` in `~/.config/codex/secrets.env`
2. Enable in config: `"enable": true`
3. Test with 1-2 papers first

**Usage**:
```json
{
  "llm-aided-config": {
    "enable": true,
    "formula_aided": {
      "model": "claude-sonnet-4-5-20250929",
      "api_key": "${ANTHROPIC_API_KEY}",
      "only_if_confidence_below": 0.80
    }
  }
}
```

**Performance**:
- Accuracy: 95-98% (vs 85-90% OCR-only)
- Speed: +5-10 seconds per paper
- Cost: Selective invocation (only low-confidence)

---

## Processing Options

### processing-options.backend
**Type**: `string`
**Values**: `"pipeline"` | `"vlm-vllm-engine"`
**Default**: `"pipeline"`
**Description**: Extraction pipeline backend

**Backend Comparison**:
| Backend | Speed | Setup | Recommended |
|---------|-------|-------|-------------|
| **pipeline** | Fast | ✅ Built-in | ✅ Yes |
| vlm-vllm-engine | **20-30× faster** | Requires vLLM | Advanced users |

**vLLM Setup** (Optional):
```bash
pip install vllm
# Then use: "backend": "vlm-vllm-engine"
```

### processing-options.lang
**Type**: `string`
**Values**: `"auto"` | `"en"` | `"fr"` | `"de"` | ... (84 languages)
**Default**: `"auto"`
**Description**: Document language

**Auto-detection** works well for French/English mix (KANNA corpus).

### processing-options.vram_limit
**Type**: `integer` (GB)
**Default**: `12`
**Description**: Maximum VRAM usage

**Tuning by GPU**:
| GPU VRAM | Recommended Limit |
|----------|-------------------|
| 8 GB | `6` |
| 12 GB | `10` |
| 16 GB | `14` |
| 24 GB+ | `20` |

**Symptoms of too high**:
- CUDA out of memory errors
- System freeze

**Symptoms of too low**:
- Falls back to CPU
- Slower extraction

---

## Quality Thresholds (Baseline Only)

### quality-thresholds.min_ocr_confidence
**Type**: `float`
**Range**: `0.0` - `1.0`
**Default**: `0.85`
**Description**: Minimum OCR confidence threshold

**Flagging Behavior**:
- Below threshold: Flag for manual review
- Above threshold: Auto-accept

**Tuning**:
- `0.75`: Accept more (may include errors)
- `0.85`: **Balanced** (recommended)
- `0.95`: Very strict (may flag good extractions)

---

## Configuration Versioning

### config_version
**Type**: `string`
**Default**: `"1.3.0"`
**Description**: MinerU config schema version

**Version History**:
- `1.0.0`: Initial config
- `1.2.0`: Added RapidTable
- `1.3.0`: Added doclayout_yolo(2501), unimernet(2503)

---

## Performance Expectations

**With 2025 Models** (baseline config):
- **Extraction Speed**: 3 sec/paper (10× faster)
- **Formula Accuracy**: 85-90% (up from 60-70%)
- **Table Accuracy**: >85% (up from 60%)
- **Quality Score**: 4.8/5 (up from 4.44/5)

**GPU Speedup**:
- 16GB+ VRAM: 50% faster than baseline
- vLLM backend: 20-30× faster (advanced)

---

## Common Configurations

### Minimal (Production - Current)
**Purpose**: Fast extraction, text-only
**Use**: Quick text extraction, no formulas/tables

```json
{
  "device-mode": "cuda",
  "models-dir": "/home/miko/.cache/magic-pdf/models",
  "layout-config": {
    "model": "doclayout_yolo"
  },
  "output-formats": {
    "markdown": {
      "enable": true,
      "format": "obsidian-optimized",
      "include_metadata": true
    },
    "json": {
      "enable": true,
      "format": "middle_json"
    }
  },
  "equation": {
    "enable": false
  },
  "table": {
    "enable": false
  }
}
```

### Comprehensive (Baseline)
**Purpose**: Maximum quality, all features
**Use**: Chemistry/physics papers, complex layouts

See: `baseline-20251009.json` (full config with comments)

### High-Quality Chemistry Papers
**Purpose**: KANNA Chapter 4 (pharmacology papers)

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
    "mfr_model": "unimernet_small"
  },
  "table-config": {
    "enable": true,
    "model": "rapid_table"
  },
  "latex-delimiter-config": {
    "display": {"left": "\\[", "right": "\\]"},
    "inline": {"left": "$", "right": "$"}
  },
  "output-formats": {
    "markdown": {
      "enable": true,
      "format": "obsidian-optimized"
    }
  }
}
```

### Fast Batch Processing
**Purpose**: Extract 100+ papers quickly

```json
{
  "device-mode": "cuda",
  "layout-config": {
    "model": "doclayout_yolo",
    "imgsz": 640
  },
  "processing-options": {
    "backend": "vlm-vllm-engine",
    "vram_limit": 14
  },
  "equation": {"enable": false},
  "table": {"enable": false}
}
```

---

## Rollback Procedures

### Restore Baseline Config
```bash
# From KANNA root directory
cp tools/config/mineru/baseline-20251009.json ~/magic-pdf.json

# Or use symbolic link
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/baseline-20251009.json ~/magic-pdf.json

# Test extraction
conda activate mineru
magic-pdf -p literature/pdfs/BIBLIOGRAPHIE/test.pdf -o /tmp/test -m auto
```

### Restore Production Config
```bash
cp tools/config/mineru/production.json ~/magic-pdf.json

# Or use symbolic link
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/production.json ~/magic-pdf.json
```

### Create Custom Config
```bash
# Start from baseline
cp tools/config/mineru/baseline-20251009.json tools/config/mineru/custom.json

# Edit as needed
nano tools/config/mineru/custom.json

# Test
ln -sf ~/LAB/academic/KANNA/tools/config/mineru/custom.json ~/magic-pdf.json
```

---

## Troubleshooting

### Config Not Found
**Error**: `MinerU config not found`

**Solution**:
```bash
# Check config locations
ls -lh ~/magic-pdf.json
ls -lh ~/.config/mineru/mineru.json

# Copy from version control
cp tools/config/mineru/production.json ~/magic-pdf.json
```

### Formula/Table Not Extracted
**Check**:
1. Is feature enabled? (`"equation": {"enable": true}`)
2. Does PDF have text layer? (`pdftotext test.pdf -`)
3. Is model downloaded? (`ls ~/.cache/magic-pdf/models/`)

### CUDA Out of Memory
**Solutions**:
1. Reduce `vram_limit`: `12` → `8`
2. Reduce `imgsz`: `1024` → `640`
3. Switch to CPU: `"device-mode": "cpu"`

### API Key Error (LLM-Aided)
**Check**:
```bash
# Verify key is set
echo $ANTHROPIC_API_KEY

# Or check secrets file
cat ~/.config/codex/secrets.env | grep ANTHROPIC_API_KEY
```

---

## References

- **MinerU Documentation**: https://github.com/opendatalab/MinerU
- **KANNA MinerU Analysis**: `docs/MINERU-CONFIGURATION-ANALYSIS.md` (if exists)
- **Baseline Config**: `tools/config/mineru/baseline-20251009.json`
- **Production Config**: `tools/config/mineru/production.json`

---

**Last Updated**: October 21, 2025
**Maintained By**: KANNA Infrastructure (MP-2)
**Version**: 1.0
