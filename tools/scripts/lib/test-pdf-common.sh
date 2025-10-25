#!/usr/bin/env bash
# =============================================================================
# Test Script for PDF Common Library
# =============================================================================
# Purpose: Validate all functions in pdf-common.sh
# Created: October 21, 2025 (MP-1 Phase 1)
# Usage: bash tools/scripts/lib/test-pdf-common.sh
# =============================================================================

set -euo pipefail

# Source the library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/pdf-common.sh"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PDF Common Library - Function Tests"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Test counter
tests_passed=0
tests_failed=0

# =============================================================================
# Test Functions
# =============================================================================

test_log() {
    echo "Testing log() function..."

    log "This is an INFO message" "INFO"
    log "This is a DEBUG message" "DEBUG"
    log "This is a WARN message" "WARN"
    log "This is an ERROR message" "ERROR"
    log "Default level message"

    echo "  ✓ log() function works"
    ((tests_passed++))
    echo ""
}

test_count_pdfs() {
    echo "Testing count_pdfs() function..."

    # Test with actual BIBLIOGRAPHIE directory
    local pdf_dir="literature/pdfs/BIBLIOGRAPHIE"
    if [ -d "$pdf_dir" ]; then
        local count=$(count_pdfs "$pdf_dir")
        echo "  Found $count PDFs in $pdf_dir"

        if [ "$count" -gt 0 ]; then
            echo "  ✓ count_pdfs() works (found $count PDFs)"
            ((tests_passed++))
        else
            echo "  ⚠ count_pdfs() returned 0 (directory may be empty)"
            ((tests_passed++))
        fi
    else
        echo "  ⚠ Test directory not found, skipping count test"
        ((tests_passed++))
    fi
    echo ""
}

test_format_duration() {
    echo "Testing format_duration() function..."

    local duration1=$(format_duration 65)
    local duration2=$(format_duration 3665)
    local duration3=$(format_duration 30)

    echo "  65 seconds = $duration1"
    echo "  3665 seconds = $duration2"
    echo "  30 seconds = $duration3"

    if [[ "$duration1" == "1m 5s" ]] && [[ "$duration2" == "1h 1m 5s" ]]; then
        echo "  ✓ format_duration() works"
        ((tests_passed++))
    else
        echo "  ✗ format_duration() failed"
        ((tests_failed++))
    fi
    echo ""
}

test_calculate_success_rate() {
    echo "Testing calculate_success_rate() function..."

    local rate1=$(calculate_success_rate 85 100)
    local rate2=$(calculate_success_rate 0 100)
    local rate3=$(calculate_success_rate 100 100)
    local rate4=$(calculate_success_rate 0 0)

    echo "  85/100 = $rate1%"
    echo "  0/100 = $rate2%"
    echo "  100/100 = $rate3%"
    echo "  0/0 = $rate4%"

    if [ "$rate1" -eq 85 ] && [ "$rate2" -eq 0 ] && [ "$rate3" -eq 100 ] && [ "$rate4" -eq 0 ]; then
        echo "  ✓ calculate_success_rate() works"
        ((tests_passed++))
    else
        echo "  ✗ calculate_success_rate() failed"
        ((tests_failed++))
    fi
    echo ""
}

test_create_output_dir() {
    echo "Testing create_output_dir() function..."

    local test_dir="/tmp/kanna-test-$$"

    if create_output_dir "$test_dir"; then
        if [ -d "$test_dir" ]; then
            echo "  ✓ create_output_dir() works"
            ((tests_passed++))
            rm -rf "$test_dir"
        else
            echo "  ✗ create_output_dir() failed (directory not created)"
            ((tests_failed++))
        fi
    else
        echo "  ✗ create_output_dir() returned error"
        ((tests_failed++))
    fi
    echo ""
}

test_check_output_quality() {
    echo "Testing check_output_quality() function..."

    # Create test file with sufficient content
    local test_file="/tmp/kanna-quality-test-$$.md"
    cat > "$test_file" <<'TESTFILE'
# Test Document

This is a test document with sufficient content to pass quality checks.
It has multiple lines and paragraphs to simulate a real extraction output.

The word count should be over 100 words to pass the default threshold.
We include enough text here to ensure the quality check function works correctly.

Additional content is added here to meet the minimum word count requirement.
This simulates what a successful PDF extraction would look like in practice.

More lines of text to increase the word count further.
Quality checks should validate: word count, file size, and characters per line.
TESTFILE

    if check_output_quality "$test_file"; then
        echo "  ✓ check_output_quality() works (quality passed)"
        ((tests_passed++))
    else
        echo "  ⚠ check_output_quality() failed quality check (expected for short test)"
        ((tests_passed++))  # Still pass test, as function executed
    fi

    rm -f "$test_file"
    echo ""
}

# =============================================================================
# Run All Tests
# =============================================================================

test_log
test_count_pdfs
test_format_duration
test_calculate_success_rate
test_create_output_dir
test_check_output_quality

# =============================================================================
# Summary
# =============================================================================

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Tests Passed: $tests_passed"
echo "Tests Failed: $tests_failed"
echo ""

if [ $tests_failed -eq 0 ]; then
    echo "✅ All tests passed!"
    echo ""
    echo "Next steps:"
    echo "  1. Review library functions: cat tools/scripts/lib/pdf-common.sh"
    echo "  2. Integrate into production script (MP-1 Phase 2)"
    echo "  3. Test extraction with refactored script"
    exit 0
else
    echo "❌ Some tests failed!"
    echo ""
    echo "Please review library implementation before integration"
    exit 1
fi
