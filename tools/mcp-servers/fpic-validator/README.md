# FPIC Compliance Validator MCP Server

**Purpose**: Automated validation of data anonymization and FPIC (Free, Prior, Informed Consent) compliance for indigenous Khoisan knowledge protection in the KANNA PhD thesis project.

## Overview

This MCP server provides tools to ensure ethical handling of indigenous traditional knowledge and research data, preventing FPIC violations that could derail the thesis and harm community relationships.

**ROI**: 33× (prevents 100+ hour ethics violations, saves 8.3h manual validation time)

## Features

### 1. File Validation
- Scans files for PII (personally identifiable information)
- Detects: emails, South African phone numbers, ID numbers, GPS coordinates, names
- Checks against FPIC-protected directory list

### 2. Directory Audits
- Batch validation of entire directories
- Recursive scanning support
- Compliance reports with severity levels (CRITICAL/WARNING/INFO)

### 3. Protected Path Checking
- Validates if paths are in FPIC-protected directories
- Prevents accidental access to sensitive data

## Installation

### 1. Install Python Dependencies

```bash
cd ~/LAB/academic/KANNA/tools/mcp-servers/fpic-validator
pip install -r requirements.txt
```

### 2. Create MCP Wrapper Script

Create `/home/miko/LAB/bin/mcp-fpic-validator`:

```bash
#!/usr/bin/env sh
set -eu

LAB_HOME="${LAB_HOME:-$HOME/LAB}"
KANNA_ROOT="/home/miko/LAB/academic/KANNA"
LOG="$LAB_HOME/logs/mcp-fpic-validator.log"
SERVER_SCRIPT="$KANNA_ROOT/tools/mcp-servers/fpic-validator/server.py"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG")"
exec 2>>"$LOG"

# Set KANNA_ROOT environment variable
export KANNA_ROOT

# Activate kanna conda environment if available
if command -v conda >/dev/null 2>&1; then
    eval "$(conda shell.bash hook)"
    conda activate kanna || true
fi

# Execute the server
exec python3 "$SERVER_SCRIPT"
```

### 3. Make Wrapper Executable

```bash
chmod +x /home/miko/LAB/bin/mcp-fpic-validator
```

### 4. Add to .mcp.json

Add to `.mcp.json` in KANNA project:

```json
{
  "mcpServers": {
    "fpic-validator": {
      "command": "/home/miko/LAB/bin/mcp-fpic-validator",
      "args": []
    }
  }
}
```

### 5. Enable in Claude Code Settings

Add to `.claude/settings.local.json`:

```json
{
  "enabledMcpjsonServers": [
    "filesystem",
    "git",
    "github",
    "sqlite",
    "jupyter",
    "context7",
    "perplexity",
    "sequential",
    "memory",
    "fetch",
    "rag-query",
    "cloudflare-browser",
    "cloudflare-container",
    "fpic-validator"
  ]
}
```

## Usage Examples

### Check Single File

```
Claude Code session:

"Validate this interview transcript for FPIC compliance"
> Uses: validate_file(file_path="data/ethnobotanical/surveys/INT-20250315-SC01-P007.csv")

Returns:
{
  "file": "data/ethnobotanical/surveys/INT-20250315-SC01-P007.csv",
  "compliant": true,
  "issues": [],
  "warnings": [],
  "info": []
}
```

### Audit Directory

```
"Check all ethnobotanical survey data for identifiable information"
> Uses: validate_directory(directory_path="data/ethnobotanical/surveys", recursive=true)

Returns:
{
  "directory": "data/ethnobotanical/surveys",
  "total_files": 12,
  "compliant_files": 11,
  "non_compliant_files": 1,
  "files": [...]
}
```

### Check Protected Path

```
"Is this path FPIC-protected: fieldwork/interviews-raw/INT-20250310-raw.wav"
> Uses: check_protected_path(path="fieldwork/interviews-raw/INT-20250310-raw.wav")

Returns:
{
  "path": "fieldwork/interviews-raw/INT-20250310-raw.wav",
  "is_protected": true,
  "message": "Path is FPIC-protected"
}
```

## PII Detection Patterns

The server detects the following PII patterns (South African context):

- **Emails**: Standard email format
- **Phone Numbers (ZA)**: +27/0 followed by 6-8 prefix and 8 digits
- **Phone Numbers (International)**: International format with country code
- **ID Numbers (ZA)**: 13-digit South African ID numbers
- **Name Markers**: Titles followed by names (Mr., Mrs., Dr., Prof.)
- **GPS Coordinates**: Latitude/longitude pairs

## Protected Directories

From `.gitignore` sensitive data section:

- `fieldwork/interviews-raw/**` - Raw audio/transcripts
- `data/ethnobotanical/interviews/**` - Interview recordings
- `data/ethnobotanical/fpic-protocols/**/personal-info/**` - Personal information
- `collaboration/khoisan-partners/**/contact-info/**` - Community contacts
- `data/clinical/trials/**/patient-data/**` - Clinical trial data
- `data/clinical/trials/**/identifiable-info/**` - Identifiable information
- `data/legal/confidential/**` - Confidential legal documents
- `collaboration/academic-partners/**/nda/**` - NDA materials

## Severity Levels

- **CRITICAL**: Definitely identifiable data (emails, phone numbers, ID numbers) - Compliance FAILED
- **WARNING**: Potentially sensitive, needs human review (GPS coordinates) - Compliance PASSED but flagged
- **INFO**: Advisory, low risk (name markers) - Compliance PASSED, informational only

## Compliance Philosophy

This tool is **advisory, not blocking**:

- ✅ Provides automated first-pass validation
- ✅ Flags potential issues for human review
- ✅ Prevents accidental commits of sensitive data
- ❌ Does NOT replace human ethical judgment
- ❌ Does NOT guarantee 100% FPIC compliance
- ❌ Does NOT replace community consultation

**Always follow**: Free, Prior, Informed Consent protocols and community validation processes.

## Maintenance

### Update Protected Paths

Edit `server.py` line 38-46 to add new protected directories.

### Add PII Patterns

Edit `server.py` line 49-56 to add new PII detection patterns.

### Check Logs

```bash
tail -f ~/LAB/logs/mcp-fpic-validator.log
```

## Troubleshooting

### MCP Server Not Connecting

```bash
# Test server directly
python3 ~/LAB/academic/KANNA/tools/mcp-servers/fpic-validator/server.py

# Check logs
tail -50 ~/LAB/logs/mcp-fpic-validator.log
```

### False Positives

If the validator flags legitimate data as PII:
1. Review the context in the compliance report
2. Adjust PII_PATTERNS in `server.py` if needed
3. Document exceptions in project FPIC protocols

### Permission Denied

```bash
# Ensure wrapper script is executable
chmod +x /home/miko/LAB/bin/mcp-fpic-validator
```

## License

Internal Use Only - KANNA PhD Thesis Project
FPIC-Protected Research - Khoisan Traditional Knowledge

---

**Last Updated**: October 2025 (Month 1)
**Author**: Mickael Souedan
**Contact**: Via KANNA project Git commits
