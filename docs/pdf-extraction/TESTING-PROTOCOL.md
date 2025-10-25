# PDF Extraction Testing Protocol

**Version**: 1.0
**Created**: October 21, 2025
**Purpose**: Comprehensive validation of PDF extraction scripts after MP-1 consolidation

---

## Test Scope

### Scripts Under Test

1. **extract-pdfs-mineru-production.sh** (primary production script)
2. **smart-pdf-extraction.sh** (auto-fallback script)
3. **tools/scripts/lib/pdf-common.sh** (shared library)

### Test Objectives

- ✅ Verify refactored scripts maintain 100% functionality
- ✅ Validate shared library functions work correctly
- ✅ Confirm no regression from original scripts
- ✅ Verify config integration (symlink chain)
- ✅ Test error handling and logging
- ✅ Validate quality checks and output

---

## Test Environment

### Prerequisites

```bash
# 1. Verify environment
conda activate mineru
python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}')"
which magic-pdf

# 2. Verify config location
ls -la ~/.config/mineru/mineru.json
ls -la ~/magic-pdf.json

# 3. Verify test data exists
ls -lh literature/pdfs/BIBLIOGRAPHIE/*.pdf | head -5

# 4. Create test output directories
mkdir -p /tmp/kanna-test/{production,smart,library}
```

### Test Data

**Small test set**: 3 PDFs from BIBLIOGRAPHIE (varied complexity)
- 1 simple text-only paper (baseline)
- 1 formula-heavy paper (Chapter 4 chemistry)
- 1 French paper (Chapter 3 ethnobotany)

**Selection criteria**: Representative of thesis corpus diversity

---

## Test Cases

### TC-1: Shared Library Unit Tests

**Objective**: Validate all 7 library functions independently

**Procedure**:
```bash
# Test script location
cd ~/LAB/academic/KANNA

# Source library
source tools/scripts/lib/pdf-common.sh

# Test each function
echo "=== Testing log() ==="
log "Test message" "INFO"
log "Warning test" "WARN"
log "Error test" "ERROR"

echo "=== Testing count_pdfs() ==="
count_pdfs "literature/pdfs/BIBLIOGRAPHIE"

echo "=== Testing format_duration() ==="
format_duration 65        # Should: 1m 5s
format_duration 3665      # Should: 1h 1m 5s

echo "=== Testing calculate_success_rate() ==="
calculate_success_rate 85 100  # Should: 85%
calculate_success_rate 140 142 # Should: 99%

echo "=== Testing create_output_dir() ==="
create_output_dir "/tmp/kanna-test/library/test-dir"
ls -ld /tmp/kanna-test/library/test-dir

echo "=== Testing check_output_quality() ==="
# Create test file
echo "This is a test file with enough words to pass quality check. Lorem ipsum dolor sit amet, consectetur adipiscing elit. We need at least 200 words to pass the default threshold. Adding more content here to reach the word count requirement. Sceletium tortuosum is a succulent plant endemic to South Africa. It has been used traditionally by Khoisan peoples for mood enhancement and stress relief. The plant contains several alkaloids including mesembrine, mesembrenone, and mesembrenol. These compounds act as serotonin reuptake inhibitors and phosphodiesterase-4 inhibitors. Clinical trials have shown efficacy in treating anxiety and depression. The traditional use has been documented extensively in ethnobotanical literature. Modern research focuses on standardized extracts with defined alkaloid content. Sustainable harvesting practices are essential for conservation. Intellectual property rights and benefit-sharing agreements with indigenous communities are important ethical considerations. The plant requires specific climatic conditions to thrive. It grows naturally in the Succulent Karoo biome. Conservation status varies depending on specific populations and collection pressure." > /tmp/kanna-test/library/test-quality.txt

check_output_quality "/tmp/kanna-test/library/test-quality.txt" 100 200
echo "Quality check result: $?"

# Test with insufficient file
echo "Too short" > /tmp/kanna-test/library/test-short.txt
check_output_quality "/tmp/kanna-test/library/test-short.txt" 100 200
echo "Quality check result (should fail): $?"
```

**Expected Results**:
- log(): Colored output with timestamps (INFO=green, WARN=yellow, ERROR=red)
- count_pdfs(): Returns 142 (or current BIBLIOGRAPHIE count)
- format_duration(): Correct human-readable format
- calculate_success_rate(): Correct percentage with % symbol
- create_output_dir(): Directory created, no errors
- check_output_quality(): Returns 0 for good file, 1 for short file

**Success Criteria**: All 7 functions return expected results

---

### TC-2: Production Script Basic Functionality

**Objective**: Verify extract-pdfs-mineru-production.sh works with refactored code

**Procedure**:
```bash
cd ~/LAB/academic/KANNA

# Syntax check (already done, but reconfirm)
bash -n tools/scripts/extract-pdfs-mineru-production.sh
echo "Syntax check: $?"

# Create test input directory with 3 PDFs
mkdir -p /tmp/kanna-test/production/input
cp literature/pdfs/BIBLIOGRAPHIE/*.pdf /tmp/kanna-test/production/input/ | head -3

# Run extraction
conda activate mineru
bash tools/scripts/extract-pdfs-mineru-production.sh \
  /tmp/kanna-test/production/input \
  /tmp/kanna-test/production/output

# Check results
echo "Exit code: $?"
ls -lh /tmp/kanna-test/production/output/
find /tmp/kanna-test/production/output -name "*.md" | head -10
```

**Expected Results**:
- Syntax check: Exit 0
- Execution: No fatal errors
- Output: Markdown files created for each PDF
- Logging: Colored output with timestamps
- Summary: Success rate calculated and displayed

**Success Criteria**:
- Script runs without errors
- All PDFs extracted (or known failures documented)
- Output files exist and non-empty (>100 bytes)

---

### TC-3: Smart Extraction Fallback Logic

**Objective**: Verify smart-pdf-extraction.sh fallback behavior

**Procedure**:
```bash
cd ~/LAB/academic/KANNA

# Syntax check
bash -n tools/scripts/smart-pdf-extraction.sh
echo "Syntax check: $?"

# Test with a known good PDF (should succeed with MinerU)
bash tools/scripts/smart-pdf-extraction.sh \
  literature/pdfs/BIBLIOGRAPHIE/<test-pdf-name>.pdf \
  /tmp/kanna-test/smart

# Check Stage 1 (MinerU) success
ls -lh /tmp/kanna-test/smart/mineru/
cat /tmp/kanna-test/smart/mineru/<pdf-name>/auto/*.md | wc -w

# Test quality check function
# If word count > 200, should have stopped at Stage 1
# If word count < 200, should have proceeded to Stage 2
```

**Expected Results**:
- Syntax check: Exit 0
- Stage 1: MinerU extraction attempt
- Quality check: Evaluates word count, file size
- Stage 2: Only triggered if quality check fails
- Logging: Clear indication of which stage succeeded

**Success Criteria**:
- Quality check correctly identifies good/bad extractions
- Fallback logic triggers only when needed
- Clear logging of success/failure at each stage

---

### TC-4: Configuration Integration

**Objective**: Verify symlink chain and config loading

**Procedure**:
```bash
# Verify symlink chain
ls -la ~/.config/mineru/mineru.json
echo "Should point to: ~/LAB/academic/KANNA/tools/config/mineru/production.json"

ls -la ~/magic-pdf.json
echo "Should point to: ~/.config/mineru/mineru.json"

# Verify content matches
diff ~/magic-pdf.json ~/LAB/academic/KANNA/tools/config/mineru/production.json
echo "Diff exit code (should be 0): $?"

# Test config switching
cd ~/LAB/academic/KANNA/tools/config/mineru

# Switch to baseline
rm ~/.config/mineru/mineru.json
ln -s ~/LAB/academic/KANNA/tools/config/mineru/baseline-20251009.json ~/.config/mineru/mineru.json
echo "Switched to baseline"
cat ~/.config/mineru/mineru.json | jq .device-mode

# Switch back to production
rm ~/.config/mineru/mineru.json
ln -s ~/LAB/academic/KANNA/tools/config/mineru/production.json ~/.config/mineru/mineru.json
echo "Switched to production"
cat ~/.config/mineru/mineru.json | jq .device-mode
```

**Expected Results**:
- Symlinks correctly point to production.json
- Content matches between symlink and source
- Config switching works without errors
- Scripts respect active config

**Success Criteria**:
- Symlink chain intact
- Config switching successful
- No broken links or permission errors

---

### TC-5: Error Handling & Edge Cases

**Objective**: Verify error handling and graceful degradation

**Test cases**:

**5a. Missing input directory**:
```bash
bash tools/scripts/extract-pdfs-mineru-production.sh \
  /nonexistent/path \
  /tmp/test-output

# Expected: Clear error message, non-zero exit code
```

**5b. Empty input directory**:
```bash
mkdir -p /tmp/kanna-test/empty-input
bash tools/scripts/extract-pdfs-mineru-production.sh \
  /tmp/kanna-test/empty-input \
  /tmp/test-output

# Expected: "No PDFs found" message, graceful exit
```

**5c. Invalid output permissions**:
```bash
mkdir -p /tmp/kanna-test/readonly-output
chmod 444 /tmp/kanna-test/readonly-output
bash tools/scripts/extract-pdfs-mineru-production.sh \
  /tmp/kanna-test/production/input \
  /tmp/kanna-test/readonly-output

# Expected: Permission error, clear message
chmod 755 /tmp/kanna-test/readonly-output  # Cleanup
```

**Success Criteria**:
- All error conditions handled gracefully
- Clear error messages (no cryptic stack traces)
- Non-zero exit codes for errors
- No partial/corrupted output

---

### TC-6: Performance & Resource Usage

**Objective**: Verify performance matches pre-refactoring baseline

**Procedure**:
```bash
# Time a 3-PDF extraction
time bash tools/scripts/extract-pdfs-mineru-production.sh \
  /tmp/kanna-test/production/input \
  /tmp/kanna-test/production/output-timed

# Monitor resource usage
# GPU: nvidia-smi (if applicable)
# Memory: htop or top
# Disk I/O: iotop
```

**Expected Results**:
- GPU mode: ~3 seconds/paper
- CPU mode: ~30 seconds/paper
- No memory leaks (stable RAM usage)
- Normal disk I/O patterns

**Success Criteria**:
- Performance within ±10% of baseline
- No resource exhaustion
- Clean process termination

---

## Validation Checklist

After running all test cases, verify:

- [ ] All 7 library functions work correctly (TC-1)
- [ ] Production script extracts PDFs successfully (TC-2)
- [ ] Smart extraction fallback logic works (TC-3)
- [ ] Config symlinks intact and functional (TC-4)
- [ ] Error handling graceful for all edge cases (TC-5)
- [ ] Performance meets expectations (TC-6)
- [ ] No regression from pre-refactoring behavior
- [ ] All output files quality-checked (word count >200)

---

## Rollback Procedure

If critical issues found:

```bash
# 1. Stop using refactored scripts
cd ~/LAB/academic/KANNA

# 2. Restore from archive
cp tools/scripts/archive/deprecated-2025-10/extract-pdfs-mineru.sh \
   tools/scripts/extract-pdfs-mineru-production.sh.RESTORED

# 3. Document issue in GitHub issue or Serena memory
# 4. Fix refactored script
# 5. Re-test before re-deploying
```

---

## Test Execution Log

**Test Run**: _____________
**Tester**: Claude Code
**Environment**: mineru conda env, CUDA available: ___

| Test Case | Status | Notes |
|-----------|--------|-------|
| TC-1: Library functions | ⏳ | |
| TC-2: Production script | ⏳ | |
| TC-3: Smart extraction | ⏳ | |
| TC-4: Config integration | ⏳ | |
| TC-5: Error handling | ⏳ | |
| TC-6: Performance | ⏳ | |

**Overall Result**: ⏳ PENDING

**Issues Found**: (list any failures or regressions)

**Recommended Actions**: (next steps based on results)

---

## Maintenance

**Update Triggers**:
- New script version released
- New MinerU version installed
- Config structure changes
- New test cases identified

**Review Frequency**: After any script modification

**Last Updated**: October 21, 2025
**Next Review**: After LP-2 Script Cleanup completion
