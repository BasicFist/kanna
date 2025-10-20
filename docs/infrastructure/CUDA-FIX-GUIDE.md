# CUDA Fix Guide - PyTorch Version Mismatch

**Date**: October 8, 2025
**Issue**: PyTorch CUDA initialization failure
**Root Cause**: PyTorch compiled for CUDA 12.1, system has CUDA 13.0

---

## Problem Summary

**Error**:
```
UserWarning: CUDA initialization: CUDA unknown error - this may be due to an
incorrectly set up environment, e.g. changing env variable CUDA_VISIBLE_DEVICES
after program start. Setting the available devices to be zero.
```

**Version Mismatch**:
| Component | Current | Required |
|-----------|---------|----------|
| System CUDA | **13.0** | 12.4+ |
| PyTorch | 2.4.0+**cu121** | 2.4.0+**cu124** |
| Driver | 580.82.09 (supports CUDA 13.0) | ✅ OK |

**Impact**:
- MinerU forced to CPU mode
- Extraction speed: 16 sec/page (CPU) vs 3 sec/page (GPU target)
- 5× performance degradation

---

## Solution: Reinstall PyTorch for CUDA 12.4

### Quick Fix (5 minutes)

```bash
# Run automated fix script
bash /tmp/fix-pytorch-cuda.sh
```

The script will:
1. Uninstall PyTorch 2.4.0+cu121
2. Install PyTorch 2.4.0+cu124 (compatible with CUDA 13.0 driver)
3. Verify CUDA is now available
4. Test MinerU still works

### Manual Fix (if script fails)

```bash
# Step 1: Activate environment
conda activate kanna

# Step 2: Uninstall current PyTorch
pip uninstall -y torch torchvision

# Step 3: Install PyTorch with CUDA 12.4 support
pip install torch==2.4.0 torchvision==0.19.0 \
    --index-url https://download.pytorch.org/whl/cu124

# Step 4: Verify
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
```

**Expected Output**:
```
CUDA available: True
```

---

## Update MinerU Config After Fix

Once CUDA is working, switch from CPU to GPU mode:

```bash
# Edit config
nano ~/.config/mineru/mineru.json

# Change line 15:
#   "device-mode": "cpu",
# To:
#   "device-mode": "cuda",

# Save and exit (Ctrl+O, Enter, Ctrl+X)
```

---

## Verify GPU Acceleration

### Test with single paper

```bash
conda activate kanna
time magic-pdf \
    -p "literature/pdfs/BIBLIOGRAPHIE/2008 - PDE4 inhibitors current status.pdf" \
    -o /tmp/test-gpu/ \
    -m auto
```

**Expected Performance**:
- CPU mode: ~131 seconds (2 min 11 sec) for 8-page paper
- GPU mode: ~24 seconds (or faster) for 8-page paper

**Speed improvement**: 5-6× faster

---

## Why CUDA 12.4 Works with CUDA 13.0

**CUDA Forward Compatibility**:
- Applications compiled for CUDA 12.4 can run on CUDA 13.0 driver
- Driver version 580.82.09 supports CUDA 13.0, which is backward compatible with 12.4
- PyTorch 2.4.0+cu124 will use the CUDA 13.0 runtime libraries

**Why cu121 Doesn't Work**:
- PyTorch+cu121 looks for CUDA 12.1 libraries
- Finds CUDA 13.0 libraries instead
- Version mismatch causes initialization failure

---

## Troubleshooting

### If CUDA still not available after fix

**Check 1: Verify PyTorch version**
```bash
python -c "import torch; print(torch.__version__)"
# Should show: 2.4.0+cu124 (NOT cu121)
```

**Check 2: Test CUDA manually**
```bash
python -c "
import torch
print(f'CUDA available: {torch.cuda.is_available()}')
print(f'CUDA version: {torch.version.cuda}')
print(f'Device count: {torch.cuda.device_count()}')
"
```

**Check 3: Environment variables**
```bash
echo $CUDA_VISIBLE_DEVICES
# Should be empty or "0"

# If issues, try:
export CUDA_VISIBLE_DEVICES=0
```

**Check 4: GPU accessibility**
```bash
nvidia-smi
# Should show GPU with 0% utilization
```

### If installation fails

**Alternative: Use conda channel**
```bash
conda install pytorch==2.4.0 torchvision==0.19.0 pytorch-cuda=12.4 \
    -c pytorch -c nvidia
```

**Alternative: Use nightly build**
```bash
pip install --pre torch torchvision \
    --index-url https://download.pytorch.org/whl/nightly/cu124
```

---

## Performance Impact

### Before Fix (CPU Mode)
- Test paper (8 pages): 131 seconds
- 20 test papers: 40-60 minutes
- 142 baseline papers: 75-125 minutes

### After Fix (GPU Mode)
- Test paper (8 pages): ~24 seconds (5.5× faster)
- 20 test papers: 8-12 minutes (5× faster)
- 142 baseline papers: 15-25 minutes (5× faster)

**Time Saved**:
- Phase 2.1 (20 papers): 30-50 minutes saved
- Phase 3 (142 papers): 60-100 minutes saved

---

## References

- **PyTorch CUDA Compatibility**: https://pytorch.org/get-started/locally/
- **CUDA Toolkit Archive**: https://developer.nvidia.com/cuda-toolkit-archive
- **NVIDIA Driver Compatibility**: https://docs.nvidia.com/deploy/cuda-compatibility/

---

## Quick Decision Matrix

| Scenario | Recommendation |
|----------|----------------|
| **Need to run Phase 2.1 NOW** | Keep CPU mode, fix later |
| **Can wait 5 minutes** | Fix CUDA now, run faster extraction |
| **After Phase 2.1, before Phase 3** | Fix CUDA to save 1+ hour on full corpus |

---

## Update: NVIDIA Open Kernel Module Issue (Oct 8, 2025)

**Critical Finding**: CUDA error 999 (CUDA_ERROR_UNKNOWN) persists even after PyTorch 2.4.0+cu124 installation.

**Root Cause**:
- NVIDIA Open Kernel Module driver (580.82.09) compiled **today** (Oct 8 2025)
- Fresh kernel module causing initialization issues
- CUDA driver API returns error 999 on cuInit(0)

**Evidence**:
```bash
# Driver is freshly compiled
$ cat /proc/driver/nvidia/version
NVRM version: NVIDIA UNIX Open Kernel Module for x86_64  580.82.09
Release Build (akmods@fedora)  Wed Oct  8 00:02:31 CEST 2025

# CUDA initialization fails
$ python -c "import ctypes; cuda = ctypes.CDLL('libcuda.so.1'); print(cuda.cuInit(0))"
999  # CUDA_ERROR_UNKNOWN
```

**What Works**:
✅ PyTorch 2.4.0+cu124 correctly installed
✅ NVIDIA driver loaded (nvidia-smi works)
✅ GPU accessible (Quadro RTX 5000 detected)
✅ All CUDA libraries present

**What Doesn't Work**:
❌ CUDA driver initialization (error 999)
❌ PyTorch CUDA availability (False)

**Required Fix** (Needs sudo/reboot):

**Option 1: System Reboot** (Most Reliable)
```bash
# Reboot to reinitialize NVIDIA kernel modules
sudo reboot
```

**Option 2: Reload Kernel Modules** (No Reboot)
```bash
# Reload NVIDIA modules
sudo rmmod nvidia_uvm nvidia_drm nvidia_modeset nvidia
sudo modprobe nvidia
sudo modprobe nvidia_uvm
```

**Option 3: Enable Persistence Mode**
```bash
# Enable GPU persistence daemon
sudo nvidia-smi -pm 1
```

**After Fix**:
```bash
# Verify CUDA is available
conda activate kanna
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')"
# Should print: CUDA available: True
```

---

**Status**: PyTorch 2.4.0+cu124 installed, CUDA driver issue requires system-level fix
**Estimated Time**: 2 minutes (reboot) or 1 minute (module reload)
**Risk**: Low (standard NVIDIA driver maintenance)
**Benefit**: 5× faster extraction once fixed

---

*Created: October 8, 2025*
*Last Updated: October 8, 2025 (NVIDIA Open Kernel Module issue identified)*
