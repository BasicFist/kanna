#!/usr/bin/env bash
# Stop vLLM Server for KANNA Thesis Project
# Gracefully shuts down the running vLLM server
# Last updated: 2025-10-08
#
# Usage: bash tools/scripts/vllm-server-stop.sh

set -Eeuo pipefail

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

PID_FILE="/tmp/vllm-server.pid"
LOG_FILE="$HOME/LAB/logs/vllm-server.log"
SHUTDOWN_TIMEOUT=10  # seconds to wait for graceful shutdown

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
# Check if Server is Running
# ═══════════════════════════════════════════════════════════════

if [ ! -f "$PID_FILE" ]; then
    log_warning "PID file not found at: $PID_FILE"
    log_info "Server may not be running, or was started manually"

    # Try to find vllm processes anyway
    VLLM_PIDS=$(pgrep -f "vllm serve" || true)
    if [ -n "$VLLM_PIDS" ]; then
        log_warning "Found running vLLM processes: $VLLM_PIDS"
        log_info "Kill manually with: kill $VLLM_PIDS"
    else
        log_info "No vLLM processes found"
    fi
    exit 1
fi

# Read PID
VLLM_PID=$(cat "$PID_FILE")

# Check if process exists
if ! ps -p "$VLLM_PID" > /dev/null 2>&1; then
    log_warning "Process $VLLM_PID not running (stale PID file)"
    rm -f "$PID_FILE"
    log_info "Cleaned up PID file"
    exit 0
fi

# ═══════════════════════════════════════════════════════════════
# Stop Server
# ═══════════════════════════════════════════════════════════════

log_info "Stopping vLLM server (PID: $VLLM_PID)..."

# Try graceful shutdown first (SIGTERM)
kill -TERM "$VLLM_PID" 2>/dev/null || {
    log_error "Failed to send SIGTERM to process $VLLM_PID"
    exit 1
}

# Wait for graceful shutdown
WAIT_TIME=0
while [ $WAIT_TIME -lt $SHUTDOWN_TIMEOUT ]; do
    if ! ps -p "$VLLM_PID" > /dev/null 2>&1; then
        log_success "vLLM server stopped gracefully"
        rm -f "$PID_FILE"
        exit 0
    fi

    echo -n "."
    sleep 1
    WAIT_TIME=$((WAIT_TIME + 1))
done

echo ""  # Newline after progress dots

# Force kill if still running
if ps -p "$VLLM_PID" > /dev/null 2>&1; then
    log_warning "Graceful shutdown timeout - forcing kill..."
    kill -KILL "$VLLM_PID" 2>/dev/null || {
        log_error "Failed to kill process $VLLM_PID"
        exit 1
    }

    # Wait a moment and verify
    sleep 2
    if ps -p "$VLLM_PID" > /dev/null 2>&1; then
        log_error "Process $VLLM_PID still running after SIGKILL"
        exit 1
    fi

    log_success "vLLM server forcefully stopped"
fi

# Clean up PID file
rm -f "$PID_FILE"

# ═══════════════════════════════════════════════════════════════
# Summary
# ═══════════════════════════════════════════════════════════════

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  vLLM Server Stopped"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Server logs preserved at: $LOG_FILE"
echo ""
echo "To view last 50 lines of log:"
echo "  tail -50 $LOG_FILE"
echo ""
echo "To start server again:"
echo "  bash tools/scripts/vllm-server-start.sh"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
