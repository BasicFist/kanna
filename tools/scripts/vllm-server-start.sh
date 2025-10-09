#!/usr/bin/env bash
# Start vLLM Server for KANNA Thesis Project
# Launches Qwen2.5-Coder-7B-Instruct with production settings
# Last updated: 2025-10-08
#
# Usage: bash tools/scripts/vllm-server-start.sh
# Estimated startup time: 30-60 seconds (model loading)

set -Eeuo pipefail

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

PROJECT_ROOT="${LAB_HOME:-$HOME/LAB}/projects/KANNA"
CONFIG_FILE="$PROJECT_ROOT/config/vllm-server.yaml"
LOG_FILE="$HOME/LAB/logs/vllm-server.log"
PID_FILE="/tmp/vllm-server.pid"
HEALTH_ENDPOINT="http://127.0.0.1:8000/health"
MAX_HEALTH_CHECKS=30  # 30 seconds timeout

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

cleanup() {
    if [ -f "$PID_FILE" ]; then
        log_warning "Cleaning up PID file..."
        rm -f "$PID_FILE"
    fi
}

trap cleanup EXIT

# ═══════════════════════════════════════════════════════════════
# Preflight Checks
# ═══════════════════════════════════════════════════════════════

log_info "Running preflight checks..."

# Check if already running
if [ -f "$PID_FILE" ]; then
    EXISTING_PID=$(cat "$PID_FILE")
    if ps -p "$EXISTING_PID" > /dev/null 2>&1; then
        log_error "vLLM server already running (PID: $EXISTING_PID)"
        log_info "Stop it first with: bash tools/scripts/vllm-server-stop.sh"
        exit 1
    else
        log_warning "Stale PID file found, cleaning up..."
        rm -f "$PID_FILE"
    fi
fi

# Check conda environment
if [ -z "${CONDA_DEFAULT_ENV:-}" ] || [ "$CONDA_DEFAULT_ENV" != "vllm" ]; then
    log_error "Not in 'vllm' conda environment"
    log_info "Activate with: conda activate vllm"
    exit 1
fi

# Check vLLM installation
if ! command -v vllm &> /dev/null; then
    log_error "vLLM not installed in current environment"
    log_info "Run setup script: bash tools/scripts/setup-vllm-env.sh"
    exit 1
fi

# Check CUDA availability
if ! command -v nvidia-smi &> /dev/null; then
    log_error "nvidia-smi not found - GPU support required"
    exit 1
fi

# Check GPU availability
GPU_MEM=$(nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits | head -1)
if [ "$GPU_MEM" -lt 14000 ]; then
    log_warning "GPU memory low: ${GPU_MEM} MB free (need ~14 GB)"
    log_warning "Other processes may be using GPU"
    nvidia-smi --query-gpu=index,name,memory.used,memory.total --format=csv
fi

# Check model exists
# Point to snapshot directory with config.json (not cache root)
# Using 3B model for 16 GB GPU (7 GiB model + 4-5 GiB infrastructure = ~11-12 GiB total)
MODEL_PATH="/run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-3B-Instruct/snapshots/488639f1ff808d1d3d0ba301aef8c11461451ec5"
if [ ! -d "$MODEL_PATH" ]; then
    log_error "Model not found at: $MODEL_PATH"
    exit 1
fi

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

log_success "Preflight checks passed"

# ═══════════════════════════════════════════════════════════════
# Launch vLLM Server
# ═══════════════════════════════════════════════════════════════

log_info "Launching vLLM server (Qwen2.5-Coder-3B)..."
log_info "Model path: $MODEL_PATH"
log_info "Logs: $LOG_FILE"
log_info "Health endpoint: $HEALTH_ENDPOINT"

# Launch vLLM in background
# Note: Parameters optimized for Quadro RTX 5000 (16 GB VRAM)
# vLLM 0.11.0+ syntax: model path as positional argument (not --model flag)
# 3B model (~7 GiB) fits comfortably with full context window and good batch size
# gpu_memory_utilization=0.85 balances model (7 GB) + KV cache + sampler buffers
nohup vllm serve "$MODEL_PATH" \
    --host 127.0.0.1 \
    --port 8000 \
    --gpu-memory-utilization 0.85 \
    --max-model-len 16384 \
    --tensor-parallel-size 1 \
    --max-num-seqs 64 \
    --enable-chunked-prefill \
    --enable-prefix-caching \
    --swap-space 4 \
    --dtype float16 \
    --trust-remote-code \
    > "$LOG_FILE" 2>&1 &

VLLM_PID=$!

# Save PID
echo "$VLLM_PID" > "$PID_FILE"

log_success "vLLM server started (PID: $VLLM_PID)"
log_info "Waiting for server to be ready..."

# ═══════════════════════════════════════════════════════════════
# Health Check Loop
# ═══════════════════════════════════════════════════════════════

HEALTH_CHECKS=0
while [ $HEALTH_CHECKS -lt $MAX_HEALTH_CHECKS ]; do
    # Check if process still running
    if ! ps -p "$VLLM_PID" > /dev/null 2>&1; then
        log_error "vLLM process died during startup"
        log_error "Check logs: tail -100 $LOG_FILE"
        exit 1
    fi

    # Check health endpoint
    if curl -s -f "$HEALTH_ENDPOINT" > /dev/null 2>&1; then
        log_success "Server is healthy and ready!"
        break
    fi

    # Progress indicator
    echo -n "."
    sleep 1
    HEALTH_CHECKS=$((HEALTH_CHECKS + 1))
done

echo ""  # Newline after progress dots

if [ $HEALTH_CHECKS -ge $MAX_HEALTH_CHECKS ]; then
    log_error "Health check timeout after ${MAX_HEALTH_CHECKS}s"
    log_error "Server may still be loading - check logs: tail -f $LOG_FILE"
    log_warning "If loading continues, wait and test manually: curl $HEALTH_ENDPOINT"
    exit 1
fi

# ═══════════════════════════════════════════════════════════════
# Display Server Info
# ═══════════════════════════════════════════════════════════════

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  vLLM Server Running"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "PID:              $VLLM_PID"
echo "API Endpoint:     http://127.0.0.1:8000"
echo "Metrics:          http://127.0.0.1:8001/metrics"
echo "Health Check:     $HEALTH_ENDPOINT"
echo "Logs:             $LOG_FILE"
echo ""
echo "Model:            Qwen2.5-Coder-3B-Instruct"
echo "Context Window:   16,384 tokens"
echo "GPU Utilization:  85%"
echo "Max Batch Size:   64 sequences"
echo ""
echo "Management:"
echo "  Stop:           bash tools/scripts/vllm-server-stop.sh"
echo "  Status:         bash tools/scripts/vllm-server-status.sh"
echo "  Monitor logs:   tail -f $LOG_FILE"
echo ""
echo "Test query:"
echo '  curl http://127.0.0.1:8000/v1/completions \'
echo '    -H "Content-Type: application/json" \'
echo '    -d '"'"'{"model": "Qwen/Qwen2.5-Coder-3B-Instruct", "prompt": "Write a Python function to", "max_tokens": 50}'"'"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""

log_success "vLLM server ready for requests!"
