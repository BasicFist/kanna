#!/usr/bin/env bash
# Check vLLM Server Status for KANNA Thesis Project
# Displays health, GPU usage, and performance metrics
# Last updated: 2025-10-08
#
# Usage: bash tools/scripts/vllm-server-status.sh

set -Eeuo pipefail

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

PID_FILE="/tmp/vllm-server.pid"
LOG_FILE="$HOME/LAB/logs/vllm-server.log"
HEALTH_ENDPOINT="http://127.0.0.1:8000/health"
METRICS_ENDPOINT="http://127.0.0.1:8001/metrics"

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

# ═══════════════════════════════════════════════════════════════
# Check Process Status
# ═══════════════════════════════════════════════════════════════

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  vLLM Server Status Check"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check PID file
if [ ! -f "$PID_FILE" ]; then
    log_error "PID file not found - server not running"
    echo ""
    echo "Start server with: bash tools/scripts/vllm-server-start.sh"
    echo ""
    exit 1
fi

VLLM_PID=$(cat "$PID_FILE")

# Check if process exists
if ! ps -p "$VLLM_PID" > /dev/null 2>&1; then
    log_error "Process $VLLM_PID not running (stale PID file)"
    echo ""
    echo "Clean up and restart:"
    echo "  rm $PID_FILE"
    echo "  bash tools/scripts/vllm-server-start.sh"
    echo ""
    exit 1
fi

log_success "Process running (PID: $VLLM_PID)"

# Get process info
PROCESS_INFO=$(ps -p "$VLLM_PID" -o pid,vsz,rss,pcpu,etime,cmd --no-headers)
CPU_USAGE=$(echo "$PROCESS_INFO" | awk '{print $4}')
MEM_RSS=$(echo "$PROCESS_INFO" | awk '{print $3}')
MEM_RSS_MB=$((MEM_RSS / 1024))
UPTIME=$(echo "$PROCESS_INFO" | awk '{print $5}')

echo "  CPU:       ${CPU_USAGE}%"
echo "  Memory:    ${MEM_RSS_MB} MB (RSS)"
echo "  Uptime:    $UPTIME"
echo ""

# ═══════════════════════════════════════════════════════════════
# Check Health Endpoint
# ═══════════════════════════════════════════════════════════════

log_info "Checking health endpoint..."

if curl -s -f "$HEALTH_ENDPOINT" > /dev/null 2>&1; then
    HEALTH_RESPONSE=$(curl -s "$HEALTH_ENDPOINT")
    log_success "Health check passed"
    echo "  Response: $HEALTH_RESPONSE"
else
    log_error "Health check failed"
    echo "  Endpoint: $HEALTH_ENDPOINT"
    log_warning "Server may still be loading or experiencing issues"
fi
echo ""

# ═══════════════════════════════════════════════════════════════
# Check GPU Status
# ═══════════════════════════════════════════════════════════════

log_info "Checking GPU status..."

if command -v nvidia-smi &> /dev/null; then
    GPU_INFO=$(nvidia-smi --query-gpu=index,name,utilization.gpu,utilization.memory,memory.used,memory.total,temperature.gpu --format=csv,noheader)

    GPU_UTIL=$(echo "$GPU_INFO" | awk -F', ' '{print $3}')
    GPU_MEM=$(echo "$GPU_INFO" | awk -F', ' '{print $5}')
    GPU_MEM_TOTAL=$(echo "$GPU_INFO" | awk -F', ' '{print $6}')
    GPU_TEMP=$(echo "$GPU_INFO" | awk -F', ' '{print $7}')

    echo "  GPU Model:       $(echo "$GPU_INFO" | awk -F', ' '{print $2}')"
    echo "  GPU Utilization: $GPU_UTIL"
    echo "  Memory Used:     $GPU_MEM / $GPU_MEM_TOTAL"
    echo "  Temperature:     ${GPU_TEMP}°C"

    # Check if GPU is being used
    GPU_UTIL_NUM=$(echo "$GPU_UTIL" | sed 's/ %//')
    if [ "$GPU_UTIL_NUM" -lt 10 ]; then
        log_warning "Low GPU utilization - server may be idle or not using GPU"
    fi
else
    log_warning "nvidia-smi not found - cannot check GPU status"
fi
echo ""

# ═══════════════════════════════════════════════════════════════
# Check Metrics (if available)
# ═══════════════════════════════════════════════════════════════

log_info "Checking Prometheus metrics..."

if curl -s -f "$METRICS_ENDPOINT" > /dev/null 2>&1; then
    METRICS=$(curl -s "$METRICS_ENDPOINT")

    # Extract key metrics (simple grep, not parsing all Prometheus metrics)
    RUNNING_REQUESTS=$(echo "$METRICS" | grep "vllm:num_requests_running" | tail -1 | awk '{print $2}' || echo "0")
    WAITING_REQUESTS=$(echo "$METRICS" | grep "vllm:num_requests_waiting" | tail -1 | awk '{print $2}' || echo "0")

    echo "  Running requests:  ${RUNNING_REQUESTS}"
    echo "  Waiting requests:  ${WAITING_REQUESTS}"
    echo "  Metrics endpoint:  $METRICS_ENDPOINT"
else
    log_warning "Metrics endpoint not available"
fi
echo ""

# ═══════════════════════════════════════════════════════════════
# Recent Log Activity
# ═══════════════════════════════════════════════════════════════

log_info "Recent log activity (last 10 lines):"
echo ""

if [ -f "$LOG_FILE" ]; then
    tail -10 "$LOG_FILE" | sed 's/^/  /'
else
    log_warning "Log file not found: $LOG_FILE"
fi
echo ""

# ═══════════════════════════════════════════════════════════════
# Summary & Management Commands
# ═══════════════════════════════════════════════════════════════

echo "════════════════════════════════════════════════════════════════"
echo "  Management Commands"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Monitor logs (live):"
echo "  tail -f $LOG_FILE"
echo ""
echo "Test query:"
echo '  curl http://127.0.0.1:8000/v1/completions \'
echo '    -H "Content-Type: application/json" \'
echo '    -d '"'"'{"model": "Qwen/Qwen2.5-Coder-7B-Instruct", "prompt": "Hello", "max_tokens": 10}'"'"
echo ""
echo "GPU monitoring:"
echo "  watch -n 1 nvidia-smi"
echo ""
echo "Stop server:"
echo "  bash tools/scripts/vllm-server-stop.sh"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
