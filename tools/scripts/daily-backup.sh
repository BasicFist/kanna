#!/usr/bin/env bash
# =============================================================================
# KANNA Daily Backup Script
# =============================================================================
# Purpose: Automated backup following 3-2-1 rule
# Schedule: Run daily at 2 AM via cron
# =============================================================================

set -euo pipefail

KANNA_DIR="$HOME/LAB/academic/KANNA"
BACKUP_DIR="/run/media/miko/AYA/KANNA-backup"
CLOUD_REMOTE="tresorit:KANNA"
LOG_FILE="$HOME/LAB/logs/kanna-backup.log"

# Create log directory if needed
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "========================================"
log "Starting KANNA daily backup..."
log "========================================"

# =============================================================================
# 1. BACKUP TO EXTERNAL HDD
# =============================================================================

if [ -d "$BACKUP_DIR" ]; then
    log "Backing up to external HDD: $BACKUP_DIR"
    rsync -av --delete \
        --exclude='*.raw' \
        --exclude='*.wiff' \
        --exclude='venv/' \
        --exclude='.git/' \
        --exclude='__pycache__/' \
        --exclude='.ipynb_checkpoints/' \
        "$KANNA_DIR/" "$BACKUP_DIR/" 2>&1 | tee -a "$LOG_FILE"
    log "✓ Local backup complete"
else
    log "⚠ WARNING: External HDD not mounted at $BACKUP_DIR"
    log "  Please mount external drive for complete backup"
fi

# =============================================================================
# 2. BACKUP TO CLOUD (ENCRYPTED)
# =============================================================================

if command -v rclone &> /dev/null; then
    log "Syncing to encrypted cloud: $CLOUD_REMOTE"
    rclone sync "$KANNA_DIR" "$CLOUD_REMOTE" \
        --exclude="*.raw" \
        --exclude="*.wiff" \
        --exclude="venv/" \
        --exclude=".git/" \
        --exclude="__pycache__/" \
        --progress 2>&1 | tee -a "$LOG_FILE"
    log "✓ Cloud backup complete"
else
    log "⚠ WARNING: rclone not installed"
    log "  Install with: sudo apt install rclone (or brew install rclone)"
fi

# =============================================================================
# 3. GIT AUTO-COMMIT (WIP)
# =============================================================================

cd "$KANNA_DIR"
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    log "Uncommitted changes detected. Creating auto-commit..."
    git add -A
    git commit -m "auto: daily backup $(date +%Y-%m-%d)" 2>&1 | tee -a "$LOG_FILE"
    log "✓ Git auto-commit created"
else
    log "✓ No uncommitted changes in Git"
fi

# =============================================================================
# 4. BACKUP VERIFICATION
# =============================================================================

log "Verifying backups..."

# Check external HDD
if [ -d "$BACKUP_DIR" ]; then
    BACKUP_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
    log "  External HDD: $BACKUP_SIZE"
fi

# Check cloud
if command -v rclone &> /dev/null && rclone listremotes | grep -q "$CLOUD_REMOTE"; then
    CLOUD_SIZE=$(rclone size "$CLOUD_REMOTE" 2>/dev/null | grep 'Total size' | awk '{print $3 " " $4}' || echo "Unknown")
    log "  Cloud storage: $CLOUD_SIZE"
fi

# Check Git
LAST_COMMIT=$(git log -1 --format="%h - %s (%ar)" 2>/dev/null || echo "No Git repository")
log "  Last Git commit: $LAST_COMMIT"

# =============================================================================
# 5. CLEANUP OLD LOGS (KEEP LAST 30 DAYS)
# =============================================================================

find "$HOME/LAB/logs" -name "kanna-backup.log*" -mtime +30 -delete 2>/dev/null || true

log "========================================"
log "✓ Backup complete!"
log "========================================"
echo ""
