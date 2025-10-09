#!/usr/bin/env bash
# =============================================================================
# Encrypt Sensitive KANNA Data
# =============================================================================
# Purpose : Create an encrypted archive containing sensitive project directories
# Usage   : ./encrypt-sensitive-data.sh [output_directory]
#           KANNA_ENCRYPTION_PASSPHRASE="your pass" ./encrypt-sensitive-data.sh
# =============================================================================

set -euo pipefail

KANNA_ROOT="${KANNA_ROOT:-$HOME/LAB/projects/KANNA}"
DEFAULT_OUTPUT_DIR="$HOME/LAB/backups/kanna-sensitive"
OUTPUT_DIR="${1:-$DEFAULT_OUTPUT_DIR}"

SENSITIVE_PATHS=(
    "data/ethnobotanical/interviews"
    "data/ethnobotanical/fpic-protocols"
    "fieldwork/interviews-raw"
    "collaboration/ethics-approvals"
    "collaboration/khoisan-partners"
)

LOG_DIR="$HOME/LAB/logs"
mkdir -p "$OUTPUT_DIR" "$LOG_DIR"

LOG_FILE="$LOG_DIR/kanna-sensitive-encryption.log"

log() {
    local ts
    ts="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[$ts] $*" | tee -a "$LOG_FILE"
}

if ! command -v gpg >/dev/null 2>&1; then
    echo "ERROR: gpg not found. Install gpg (GNU Privacy Guard) and retry." >&2
    exit 1
fi

log "========================================="
log "Starting sensitive data encryption run"
log "Destination: $OUTPUT_DIR"

pushd "$KANNA_ROOT" >/dev/null

INCLUDE_PATHS=()
for path in "${SENSITIVE_PATHS[@]}"; do
    if [ -d "$path" ]; then
        INCLUDE_PATHS+=("$path")
        log "✓ Including $path"
    else
        log "⚠ Skipping missing path: $path"
    fi
done

if [ ${#INCLUDE_PATHS[@]} -eq 0 ]; then
    log "No sensitive directories found. Exiting."
    popd >/dev/null
    exit 0
fi

ARCHIVE_NAME="kanna-sensitive-$(date '+%Y%m%d-%H%M%S').tar.gz.gpg"
ARCHIVE_PATH="$OUTPUT_DIR/$ARCHIVE_NAME"

PASSPHRASE="${KANNA_ENCRYPTION_PASSPHRASE:-}"
if [ -z "$PASSPHRASE" ]; then
    read -rsp "Enter encryption passphrase: " PASSPHRASE
    echo
    read -rsp "Confirm passphrase: " CONFIRM
    echo
    if [ "$PASSPHRASE" != "$CONFIRM" ]; then
        log "Passphrases do not match. Aborting."
        popd >/dev/null
        exit 1
    fi
fi

log "Creating encrypted archive $ARCHIVE_PATH"

tar -czf - "${INCLUDE_PATHS[@]}" \
    | gpg --batch --yes --symmetric --cipher-algo AES256 \
          --passphrase "$PASSPHRASE" \
          --output "$ARCHIVE_PATH"

sha256sum "$ARCHIVE_PATH" | tee -a "$LOG_FILE"

log "✓ Encryption complete"
log "Archive stored at $ARCHIVE_PATH"
log "========================================="

popd >/dev/null

echo "Archive created at: $ARCHIVE_PATH"
echo "Log file: $LOG_FILE"
