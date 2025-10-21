#!/usr/bin/env bash
# =============================================================================
# PDF Extraction Common Library
# =============================================================================
# Purpose: Shared functions for PDF extraction scripts
# Created: October 21, 2025 (Week 1 Day 3 - MP-1 Phase 1)
# Usage: source tools/scripts/lib/pdf-common.sh
#
# Functions:
#   - log()                     Unified logging with timestamps
#   - activate_conda()          Safe conda environment activation
#   - check_output_quality()    Validate extraction output
#   - count_pdfs()              Count PDFs in directory
#   - format_duration()         Human-readable time formatting
#
# =============================================================================

# Global configuration
LOG_LEVEL="${LOG_LEVEL:-INFO}"  # DEBUG, INFO, WARN, ERROR
LOG_FILE="${LOG_FILE:-}"        # Optional log file path

# =============================================================================
# Logging Functions
# =============================================================================

# log() - Unified logging with timestamps
#
# Usage:
#   log "Starting extraction"
#   log "Processing file" "INFO"
#   log "Error occurred" "ERROR"
#
# Arguments:
#   $1 - Message to log
#   $2 - Log level (optional, default: INFO)
#
log() {
    local message="$1"
    local level="${2:-INFO}"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local formatted="[$timestamp] [$level] $message"

    # Color output for terminal
    case "$level" in
        DEBUG)
            echo -e "\033[0;36m$formatted\033[0m"  # Cyan
            ;;
        INFO)
            echo -e "\033[0;32m$formatted\033[0m"  # Green
            ;;
        WARN)
            echo -e "\033[0;33m$formatted\033[0m"  # Yellow
            ;;
        ERROR)
            echo -e "\033[0;31m$formatted\033[0m"  # Red
            ;;
        *)
            echo "$formatted"
            ;;
    esac

    # Append to log file if specified
    if [ -n "$LOG_FILE" ]; then
        echo "$formatted" >> "$LOG_FILE"
    fi
}

# =============================================================================
# Conda Environment Functions
# =============================================================================

# activate_conda() - Safe conda environment activation
#
# Usage:
#   activate_conda "mineru"
#   activate_conda "kanna" || exit 1
#
# Arguments:
#   $1 - Conda environment name
#
# Returns:
#   0 on success, 1 on failure
#
activate_conda() {
    local env_name="$1"

    if [ -z "$env_name" ]; then
        log "Error: Environment name required" "ERROR"
        return 1
    fi

    log "Activating conda environment: $env_name" "INFO"

    # Initialize conda if not already done
    if ! command -v conda &> /dev/null; then
        log "Conda not found, attempting initialization..." "WARN"

        # Try common conda locations
        local conda_paths=(
            "$HOME/miniforge3/etc/profile.d/conda.sh"
            "$HOME/miniconda3/etc/profile.d/conda.sh"
            "$HOME/anaconda3/etc/profile.d/conda.sh"
        )

        local conda_initialized=false
        for conda_path in "${conda_paths[@]}"; do
            if [ -f "$conda_path" ]; then
                source "$conda_path"
                conda_initialized=true
                log "Conda initialized from: $conda_path" "INFO"
                break
            fi
        done

        if [ "$conda_initialized" = false ]; then
            log "Error: Could not initialize conda" "ERROR"
            return 1
        fi
    fi

    # Activate environment
    if conda activate "$env_name" 2>/dev/null; then
        log "✓ Activated: $env_name" "INFO"
        return 0
    else
        log "✗ Failed to activate: $env_name" "ERROR"
        log "Available environments:" "INFO"
        conda env list
        return 1
    fi
}

# =============================================================================
# PDF Processing Functions
# =============================================================================

# count_pdfs() - Count PDFs in directory
#
# Usage:
#   pdf_count=$(count_pdfs "literature/pdfs/")
#   count_pdfs "/path/to/pdfs" "recursive"
#
# Arguments:
#   $1 - Directory path
#   $2 - Mode: "recursive" or "flat" (default: flat)
#
# Returns:
#   Number of PDF files
#
count_pdfs() {
    local dir="$1"
    local mode="${2:-flat}"

    if [ ! -d "$dir" ]; then
        log "Error: Directory not found: $dir" "ERROR"
        echo 0
        return 1
    fi

    local count
    if [ "$mode" = "recursive" ]; then
        count=$(find "$dir" -type f -name "*.pdf" 2>/dev/null | wc -l)
    else
        count=$(find "$dir" -maxdepth 1 -type f -name "*.pdf" 2>/dev/null | wc -l)
    fi

    echo "$count"
}

# check_output_quality() - Validate extraction output
#
# Usage:
#   if check_output_quality "output.md"; then
#       echo "Quality passed"
#   fi
#
# Arguments:
#   $1 - Path to markdown output file
#   $2 - Minimum word count (default: 100)
#   $3 - Minimum chars per line (default: 200)
#
# Returns:
#   0 if quality check passes, 1 otherwise
#
check_output_quality() {
    local output_file="$1"
    local min_words="${2:-100}"
    local min_chars="${3:-200}"

    if [ ! -f "$output_file" ]; then
        log "Output file not found: $output_file" "ERROR"
        return 1
    fi

    # Check file size
    local file_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null)
    if [ "$file_size" -eq 0 ]; then
        log "Quality check failed: Empty file (0 bytes)" "WARN"
        return 1
    fi

    # Check word count
    local word_count=$(wc -w < "$output_file")
    if [ "$word_count" -lt "$min_words" ]; then
        log "Quality check failed: Too few words ($word_count < $min_words)" "WARN"
        return 1
    fi

    # Check average characters per line
    local line_count=$(wc -l < "$output_file")
    if [ "$line_count" -gt 0 ]; then
        local avg_chars_per_line=$((file_size / line_count))
        if [ "$avg_chars_per_line" -lt "$min_chars" ]; then
            log "Quality check warning: Low chars/line ($avg_chars_per_line < $min_chars)" "WARN"
            # Don't fail on this, just warn
        fi
    fi

    log "✓ Quality check passed: $word_count words, $file_size bytes" "INFO"
    return 0
}

# =============================================================================
# Utility Functions
# =============================================================================

# format_duration() - Human-readable time formatting
#
# Usage:
#   start_time=$(date +%s)
#   # ... do work ...
#   end_time=$(date +%s)
#   duration=$(format_duration $((end_time - start_time)))
#
# Arguments:
#   $1 - Duration in seconds
#
# Returns:
#   Formatted duration string (e.g., "2h 15m 30s")
#
format_duration() {
    local total_seconds="$1"
    local hours=$((total_seconds / 3600))
    local minutes=$(( (total_seconds % 3600) / 60 ))
    local seconds=$((total_seconds % 60))

    local formatted=""
    [ $hours -gt 0 ] && formatted="${hours}h "
    [ $minutes -gt 0 ] && formatted="${formatted}${minutes}m "
    formatted="${formatted}${seconds}s"

    echo "$formatted"
}

# create_output_dir() - Create output directory with error handling
#
# Usage:
#   create_output_dir "output/path" || exit 1
#
# Arguments:
#   $1 - Directory path to create
#
# Returns:
#   0 on success, 1 on failure
#
create_output_dir() {
    local dir="$1"

    if [ -z "$dir" ]; then
        log "Error: Directory path required" "ERROR"
        return 1
    fi

    if [ -d "$dir" ]; then
        log "Output directory exists: $dir" "DEBUG"
        return 0
    fi

    if mkdir -p "$dir" 2>/dev/null; then
        log "Created output directory: $dir" "INFO"
        return 0
    else
        log "Failed to create directory: $dir" "ERROR"
        return 1
    fi
}

# =============================================================================
# Statistics Functions
# =============================================================================

# calculate_success_rate() - Calculate success percentage
#
# Usage:
#   rate=$(calculate_success_rate 85 100)
#   echo "Success rate: $rate%"
#
# Arguments:
#   $1 - Successful count
#   $2 - Total count
#
# Returns:
#   Percentage (integer)
#
calculate_success_rate() {
    local successful="$1"
    local total="$2"

    if [ "$total" -eq 0 ]; then
        echo "0"
        return
    fi

    local rate=$((successful * 100 / total))
    echo "$rate"
}

# =============================================================================
# Exports
# =============================================================================

# Export functions for use in other scripts
export -f log
export -f activate_conda
export -f count_pdfs
export -f check_output_quality
export -f format_duration
export -f create_output_dir
export -f calculate_success_rate

# Log library initialization
log "PDF Common Library loaded (v1.0)" "DEBUG"
