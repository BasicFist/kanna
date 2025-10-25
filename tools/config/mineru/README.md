# MinerU Configuration Management

**Purpose**: Version-controlled MinerU configurations for reproducible PDF extraction

**Created**: October 21, 2025 (Week 1 Day 5 - MP-2)
**Status**: Production Ready

---

## Configuration Files

### `production.json` (Active Configuration)
**Purpose**: Current production config used for all 142-paper corpus extraction
**Source**: Copied from `~/magic-pdf.json` on Oct 21, 2025
**Status**: ✅ Production Ready (GPU-accelerated)

**Key Settings**:
- **Layout**: doclayout_yolo(2501) - Latest 2025 model, 10× faster
- **Formula**: unimernet(2503) - Fixed multi-line formulas
- **Tables**: RapidTable - 10× faster table extraction
- **Device**: CUDA (GPU-accelerated)

### `baseline-20251009.json` (Known-Good Fallback)
**Purpose**: Pre-optimization baseline configuration
**Source**: `config-backup/mineru-config-20251009-pre-optimization.json`
**Date**: October 9, 2025
**Use Case**: Rollback if production config causes issues

### `experimental.json` (Testing)
**Purpose**: Testing new optimizations before promoting to production
**Source**: Copy of production.json (modify for experiments)
**Use Case**: Test parameter changes before applying to production

---

## Usage

### Standard Extraction (Production Config)
```bash
# MinerU automatically uses ~/.config/mineru/mineru.json
# Which is symlinked to tools/config/mineru/production.json

conda activate mineru
magic-pdf -p file.pdf -o output/ -m auto
```

### Test New Configuration
```bash
# Edit experimental.json with new parameters
nano tools/config/mineru/experimental.json

# Copy to active location for testing
cp tools/config/mineru/experimental.json ~/.config/mineru/mineru.json

# Test on small subset
bash tools/scripts/test-mineru-batch.sh

# If successful, promote to production:
cp tools/config/mineru/experimental.json tools/config/mineru/production.json
git commit -m "feat: update MinerU production config"
```

### Rollback to Baseline
```bash
# If production config causes issues
cp tools/config/mineru/baseline-20251009.json ~/.config/mineru/mineru.json

# Verify extraction works
bash tools/scripts/test-mineru-batch.sh

# If resolved, update production
cp tools/config/mineru/baseline-20251009.json tools/config/mineru/production.json
git commit -m "fix: rollback MinerU config to baseline"
```

---

## Configuration Location Strategy

**Canonical Location**: `~/.config/mineru/mineru.json`
**Legacy Support**: `~/magic-pdf.json` → symlink to canonical location

**Setup**:
```bash
# Ensure ~/.config/mineru exists
mkdir -p ~/.config/mineru

# Copy production config to canonical location
cp tools/config/mineru/production.json ~/.config/mineru/mineru.json

# Create symlink for legacy compatibility
ln -sf ~/.config/mineru/mineru.json ~/magic-pdf.json
```

---

## Field Documentation

See `CONFIG-FIELDS.md` for detailed field explanations, valid values, and performance tuning guidance.

---

## Version Control

**Tracked Files**:
- `production.json` - Active production configuration
- `baseline-20251009.json` - Known-good fallback
- `experimental.json` - Testing configuration
- `README.md` - This file
- `CONFIG-FIELDS.md` - Field documentation

**Git Workflow**:
```bash
# After config changes
git add tools/config/mineru/production.json
git commit -m "feat: update MinerU config - [describe change]"

# Track config evolution
git log tools/config/mineru/production.json
```

---

## Backup Strategy

**Local Backups**: `config-backup/` directory (project root)
**Frequency**: Before major config changes
**Retention**: Keep pre/post optimization snapshots

**Create Backup**:
```bash
cp tools/config/mineru/production.json config-backup/mineru-config-$(date +%Y%m%d).json
```

---

## Related Documentation

- **Configuration Analysis**: `docs/mineru/MINERU-CONFIGURATION-ANALYSIS.md`
- **Extraction Guide**: `docs/pdf-extraction/EXTRACTION-GUIDE.md` (Week 2)
- **Troubleshooting**: `docs/pdf-extraction/TROUBLESHOOTING.md` (Week 2)

---

**Last Updated**: October 21, 2025
**Maintainer**: Infrastructure consolidation v4.2.1
