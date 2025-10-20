# KANNA Plugin Integration Plan

**Status**: 📋 Planning Phase
**Created**: 2025-10-10
**Target Completion**: 3 weeks (Week 1-3)
**Total Time Investment**: 23 hours
**Expected ROI**: 1,968 hours saved over 41 months

---

## Executive Summary

This plan outlines a **3-phase, security-first approach** to integrating Claude Code plugins into the KANNA PhD thesis infrastructure. The integration prioritizes **5 high-value plugins** across a **progressive rollout** (experimental → dev → main worktrees) with **rigorous validation** at each stage.

**Critical Constraints:**
- **FPIC Compliance**: Absolute data security for indigenous knowledge
- **Zero Security Incidents**: Existing security-gate hook must remain primary defense
- **Performance Budget**: <15 seconds startup time in main worktree
- **Productivity Goal**: >10 hours weekly time savings

---

## Table of Contents

1. [Security Framework](#security-framework)
2. [Plugin Prioritization](#plugin-prioritization)
3. [Worktree-Specific Profiles](#worktree-specific-profiles)
4. [Integration Phases](#integration-phases)
5. [Validation Checklist](#validation-checklist)
6. [Monitoring & Rollback](#monitoring--rollback)
7. [Documentation Requirements](#documentation-requirements)
8. [Timeline & Success Criteria](#timeline--success-criteria)
9. [Cost-Benefit Analysis](#cost-benefit-analysis)
10. [Long-Term Maintenance](#long-term-maintenance)
11. [Contingency Plans](#contingency-plans)

---

## Security Framework

### FPIC Compliance Requirements

KANNA handles **sensitive ethnobotanical data** under Free, Prior, Informed Consent (FPIC) protocols. Plugin integration must maintain absolute data security.

**Protected Data Categories:**

| Tier | Data Type | Location | Risk Level |
|------|-----------|----------|------------|
| **Critical** | Raw interviews (audio/transcripts) | `fieldwork/interviews-raw/` | ⛔ NEVER commit |
| **Critical** | Patient-identifiable clinical data | `data/clinical/trials/**/patient-data/` | ⛔ NEVER commit |
| **Sensitive** | De-identified surveys | `data/ethnobotanical/surveys/*.csv` | ✅ Git-tracked |
| **Secrets** | API keys, credentials | `~/.config/codex/secrets.env`, `.env` files | ⛔ NEVER commit |

### Hook Execution Order (Security-First)

```
User Request
    ↓
[PreToolUse: security-gate.sh] ⭐ FIRST - Blocks secrets/dangerous ops
    ↓
[PreToolUse: Plugin hooks] - Run AFTER security validation
    ↓
Tool Execution (if allowed)
    ↓
[PostToolUse: auto-format.sh, command-logger.sh, mcp-monitor.sh]
    ↓
[PostToolUse: Plugin hooks]
    ↓
Response to User
```

**Key Security Guarantee:** Existing security-gate hook runs **FIRST** in PreToolUse chain. Plugin hooks **CANNOT** bypass FPIC protections.

### Security Validation Tests

Before any plugin promotion to production:

1. ✅ **Secret Protection Test**: Attempt to read `~/.config/codex/secrets.env` → Must be BLOCKED
2. ✅ **FPIC Data Protection Test**: Attempt to read `fieldwork/interviews-raw/INT-20250315-SC01-P007.txt` → Must be BLOCKED
3. ✅ **Dangerous Command Test**: Attempt `rm -rf /tmp/test` → Must be BLOCKED
4. ✅ **Log Audit**: Review `~/.claude/logs/bash-commands.log` for unauthorized operations

---

## Plugin Prioritization

### High-Priority Plugins (Install First)

#### 1. `lyra@claude-code-marketplace` ⭐ UNIVERSAL

**Value Proposition:** AI prompt optimization specialist
**KANNA Use Cases:**
- Optimize literature search queries for 142-paper corpus
- Improve RAG query quality for vLLM + ChromaDB pipeline
- Reduce token consumption across all Claude interactions

**Expected Impact:**
- Token savings: 40-47% on specialized queries
- Literature search efficiency: +30-40%
- Time saved: 3-5 hours/week

**Installation Priority:** Phase 1 (Week 1)
**Risk Level:** Low (read-only analysis)

---

#### 2. `update-claude-md@claude-code-marketplace` ⭐ HIGH-VALUE

**Value Proposition:** Automatically maintain CLAUDE.md documentation
**KANNA Use Cases:**
- Track changes across 19 MCP servers
- Update infrastructure status (98/100 health)
- Document new tools and workflows

**Expected Impact:**
- Manual update time: 45-60 min → Automated: 2-5 min
- Update frequency: 2×/week → Time saved: 2-4 hours/week
- Documentation quality: More consistent, fewer outdated sections

**Installation Priority:** Phase 1 (Week 1)
**Risk Level:** Low (documentation-focused)

---

#### 3. `security-auditor@agents` ⭐ CRITICAL

**Value Proposition:** Comprehensive security validation
**KANNA Use Cases:**
- Validate secret management across 19 MCP servers
- Scan bibliography export process (Zotero → LaTeX)
- Detect potential data leaks in analysis scripts

**Expected Impact:**
- Prevent security incidents (1 incident = 20+ hours remediation)
- Ensure FPIC compliance across workflows
- Peace of mind for sensitive data handling

**Installation Priority:** Phase 2 (Week 2)
**Risk Level:** Medium (requires extensive source code review)

---

#### 4. `ai-engineer@agents` ⭐ POST-CUDA FIX

**Value Proposition:** AI/ML system design expert
**KANNA Use Cases:**
- Optimize vLLM + ChromaDB RAG pipeline (after CUDA restoration)
- Design ChemLLM-7B-Chat integration for formula extraction
- Improve MinerU GPU extraction workflows

**Expected Impact:**
- RAG query quality improvement: +25-35%
- Embedding model selection guidance
- Architecture optimization for 142-paper corpus

**Installation Priority:** Phase 3 (Week 3) - **Blocked by CUDA fix**
**Risk Level:** Low (advisory role)

---

#### 5. `documentation-generator@claude-code-marketplace` ⭐ WRITING PHASE

**Value Proposition:** Auto-generate technical documentation
**KANNA Use Cases:**
- Create chapter summaries (120,000-word thesis)
- Generate methodology documentation for R/Python scripts
- Produce API documentation for custom tools

**Expected Impact:**
- Chapter summary generation: Manual 3-4 hours → Automated 30-45 min
- Active writing phases: 5-8 hours/week saved
- Consistency across 8 chapters

**Installation Priority:** Phase 3 (Week 3)
**Risk Level:** Medium (quality varies, requires review)

---

### Medium-Priority Plugins (Evaluate Later)

| Plugin | Marketplace | Use Case | Defer Reason |
|--------|-------------|----------|--------------|
| `code-reviewer@agents` | wshobson/agents | Automated PR reviews | Phase 2 testing, measure value |
| `test-automator@agents` | wshobson/agents | Generate unit tests | Not critical during writing phase |
| `devops-troubleshooter@agents` | wshobson/agents | Debug MCP issues | Infrastructure stable (98/100) |
| `compounding-engineering` | every-marketplace | Workflow philosophy | Experimental, long-term value |

### Low-Priority Plugins (Not Applicable)

- Frontend development agents (no web UI)
- Payment/sales plugins (academic project)
- Mobile development agents (thesis-focused)

---

## Worktree-Specific Profiles

### Profile Strategy

Different worktrees have different performance requirements and use cases. Optimize plugin configurations per worktree to maintain performance.

### Main Worktree (19 MCP Servers)

**Purpose:** Complex research work, full AI toolkit
**Baseline Startup:** 8-12 seconds
**Target Startup:** <15 seconds

**Enabled Plugins:**
1. `lyra` - Prompt optimization (universal)
2. `update-claude-md` - Documentation maintenance
3. `security-auditor` - FPIC compliance validation
4. `ai-engineer` - RAG pipeline optimization
5. `documentation-generator` - Chapter summaries

**Configuration:** `.claude/settings.local.json`
```json
{
  "plugins": {
    "lyra": {"enabled": true},
    "update-claude-md": {"enabled": true},
    "security-auditor": {"enabled": true, "config": {"severity_threshold": "medium"}},
    "ai-engineer": {"enabled": true},
    "documentation-generator": {"enabled": true}
  }
}
```

---

### Dev Worktree (6 MCP Servers)

**Purpose:** Feature development, script testing
**Baseline Startup:** 5 seconds
**Target Startup:** <8 seconds

**Enabled Plugins:**
1. `lyra` - Prompt optimization
2. `code-reviewer` - Script quality checks
3. `security-auditor` - Pre-commit validation

**Configuration:** `~/LAB/projects/KANNA/worktrees/dev/.claude/settings.local.json`
```json
{
  "plugins": {
    "lyra": {"enabled": true},
    "code-reviewer": {"enabled": true},
    "security-auditor": {"enabled": true}
  }
}
```

---

### Experimental Worktree (3 MCP Servers)

**Purpose:** Fast experiments, plugin testing
**Baseline Startup:** 2 seconds
**Target Startup:** <3 seconds

**Enabled Plugins:**
1. `lyra` - Prompt optimization only (minimal overhead)

**Configuration:** `~/LAB/projects/KANNA/worktrees/experimental/.claude/settings.local.json`
```json
{
  "plugins": {
    "lyra": {"enabled": true}
  }
}
```

---

### Docs Worktree (3 MCP Servers)

**Purpose:** Writing, documentation
**Baseline Startup:** 2 seconds
**Target Startup:** <4 seconds

**Enabled Plugins:**
1. `lyra` - Prompt optimization
2. `documentation-generator` - Chapter summaries
3. *(Future)* Grammar checker integration

**Configuration:** `~/LAB/projects/KANNA/worktrees/docs/.claude/settings.local.json`
```json
{
  "plugins": {
    "lyra": {"enabled": true},
    "documentation-generator": {"enabled": true}
  }
}
```

---

### Cloudflare Worktree (5 MCP Servers)

**Purpose:** Web scraping, data collection
**Baseline Startup:** 4 seconds
**Target Startup:** <5 seconds

**Enabled Plugins:**
- **None initially** - Keep lightweight for scraping performance

**Configuration:** `~/LAB/projects/KANNA/worktrees/cloudflare/.claude/settings.local.json`
```json
{
  "plugins": {}
}
```

---

## Integration Phases

### Phase 1: Experimental Worktree Validation (Week 1)

**Objective:** Test marketplace integration and core plugins in isolated environment

**Timeline:** 5 hours over 7 days

#### Day 1: Marketplace Setup (30 min)

**Location:** `~/LAB/projects/KANNA/worktrees/experimental`

```bash
# Navigate to experimental worktree
cd ~/LAB/projects/KANNA/worktrees/experimental

# Start Claude Code
claude

# Add marketplaces
/plugin marketplace add ananddtyagi/claude-code-marketplace
/plugin marketplace add wshobson/agents
/plugin marketplace add https://github.com/EveryInc/every-marketplace

# Verify marketplaces added
/plugin marketplace list

# Refresh to ensure latest plugin list
/plugin marketplace refresh claude-code-marketplace
/plugin marketplace refresh agents
```

**Validation:**
- [ ] All 3 marketplaces appear in list
- [ ] Marketplace refresh completes without errors
- [ ] `/plugin` command shows browsable plugin directory

---

#### Day 2: Lyra Plugin Installation & Validation (1 hour)

**Source Code Review:**

```bash
# Clone marketplace for source review
cd /tmp
git clone https://github.com/ananddtyagi/claude-code-marketplace.git
cd claude-code-marketplace

# Review lyra plugin source
cat lyra/lyra.md  # Read system prompt
# Check for: network calls, file access, data exfiltration
```

**Installation:**

```bash
# Return to experimental worktree
cd ~/LAB/projects/KANNA/worktrees/experimental
claude

# Install lyra
/plugin install lyra@claude-code-marketplace

# Verify installation
/plugin list
```

**Functional Testing:**

```bash
# Test prompt optimization
/lyra "Find all papers in corpus about alkaloid biosynthesis in Sceletium"

# Compare to unoptimized query
"Find papers about alkaloid biosynthesis"

# Measure token usage difference
tail -20 ~/.claude/logs/mcp-metrics.jsonl | jq 'select(.tool=="lyra")'
```

**Validation Checklist:**
- [ ] Lyra installed successfully
- [ ] Source code review shows no security concerns
- [ ] Optimized prompts produce better results
- [ ] Token usage reduction observed (target: 20-30%)
- [ ] No errors in `~/.claude/logs/*.log`

---

#### Day 3: Security Integration Test (1 hour)

**Test existing security-gate hook still active:**

```bash
cd ~/LAB/projects/KANNA/worktrees/experimental
claude

# INTENTIONAL VIOLATION TEST 1: Secret file access
"Read the file ~/.config/codex/secrets.env"
# Expected: BLOCKED by security-gate

# INTENTIONAL VIOLATION TEST 2: FPIC data access
"Read the file /home/miko/LAB/projects/KANNA/fieldwork/interviews-raw/test.txt"
# Expected: BLOCKED by security-gate (if file existed)

# INTENTIONAL VIOLATION TEST 3: Dangerous command
"Run this bash command: rm -rf /tmp/test-dangerous"
# Expected: BLOCKED by security-gate

# Review security logs
grep -i "SECURITY-GATE.*BLOCKED" ~/.claude/logs/bash-commands.log | tail -20
```

**Validation Checklist:**
- [ ] All 3 violations BLOCKED by security-gate
- [ ] Plugin hooks run AFTER security validation
- [ ] No bypass attempts in logs
- [ ] security-gate.sh exit code = 1 for violations

---

#### Day 4: Update-Claude-MD Installation (1 hour)

**Installation:**

```bash
cd ~/LAB/projects/KANNA/worktrees/experimental
claude

# Install plugin
/plugin install update-claude-md@claude-code-marketplace

# Verify installation
/plugin list
```

**Functional Testing:**

```bash
# Create test change to trigger update
echo "# Test Update $(date)" >> README.md
git add README.md
git commit -m "test: trigger CLAUDE.md update test"

# Use plugin to update CLAUDE.md
/update-claude-md

# Review suggested changes
# Verify accuracy of detected changes
# Check for hallucinations or incorrect information
```

**Validation Checklist:**
- [ ] Plugin detects recent changes correctly
- [ ] Suggested CLAUDE.md updates are accurate
- [ ] No extraneous or hallucinated content
- [ ] Time comparison: Manual (45 min) vs Plugin (2-5 min)

---

#### Days 5-7: Baseline Performance Metrics (2 hours)

**Startup Time Measurement:**

```bash
# Measure startup time (5 iterations)
for i in {1..5}; do
  time claude --version
done

# Calculate average
# Target: <3 seconds (baseline 2s + 50% tolerance)
```

**Token Usage Analysis:**

```bash
# Review token consumption with lyra
jq 'select(.tool | contains("lyra"))' ~/.claude/logs/mcp-metrics.jsonl | \
  jq -s 'group_by(.timestamp[:10]) | map({date: .[0].timestamp[:10], avg_tokens: (map(.estimated_tokens) | add / length)})'

# Compare to pre-plugin baseline
# Target: 20-40% reduction on optimized queries
```

**Documentation:**

Create `docs/PLUGIN-VALIDATION-LOG.md`:
```markdown
# Plugin Validation Log

## Phase 1: Experimental Worktree

### lyra@claude-code-marketplace
- **Installation Date**: 2025-10-XX
- **Security Review**: ✅ PASSED (no network calls, read-only)
- **Functional Test**: ✅ PASSED (20-30% token reduction)
- **Integration Test**: ✅ PASSED (security-gate remains active)
- **Performance**: Startup +0.5s (2s → 2.5s)
- **Approval**: ✅ APPROVED for Phase 2

### update-claude-md@claude-code-marketplace
- **Installation Date**: 2025-10-XX
- **Security Review**: ✅ PASSED
- **Functional Test**: ✅ PASSED (accurate change detection)
- **Time Savings**: 45 min → 3 min (93% reduction)
- **Approval**: ✅ APPROVED for Phase 2
```

**Phase 1 Success Criteria:**

- ✅ Startup time <3 seconds (baseline 2s)
- ✅ Zero security violations
- ✅ Documented time savings (>80% reduction on update-claude-md)
- ✅ Token efficiency improvement (>20% on lyra queries)
- ✅ Approval for Phase 2 progression

---

### Phase 2: Dev Worktree Expansion (Week 2)

**Objective:** Validate development-focused plugins with moderate server load

**Timeline:** 7 hours over 5 days

#### Day 1: Dev Worktree Configuration (30 min)

```bash
# Navigate to dev worktree
cd ~/LAB/projects/KANNA/worktrees/dev
claude

# Add marketplaces (same as Phase 1)
/plugin marketplace add ananddtyagi/claude-code-marketplace
/plugin marketplace add wshobson/agents

# Install Phase 1-validated plugins
/plugin install lyra@claude-code-marketplace
/plugin install update-claude-md@claude-code-marketplace

# Measure baseline startup with validated plugins
time claude --version
# Target: <7 seconds (baseline 5s + 2s plugin overhead)
```

---

#### Day 2: Security-Auditor Installation & Review (2 hours)

**CRITICAL:** This plugin requires extensive security review due to FPIC sensitivity.

**Source Code Deep Dive:**

```bash
# Clone agents repository
cd /tmp
git clone https://github.com/wshobson/agents.git
cd agents

# Review security-auditor source
cat security-auditor.md
# Check for:
# - Data exfiltration attempts
# - Network calls to external services
# - File system access patterns
# - Logging of sensitive information

# Review dependencies (if MCP server bundled)
# Check package.json for suspicious packages
```

**Installation & Testing:**

```bash
cd ~/LAB/projects/KANNA/worktrees/dev
claude

# Install plugin
/plugin install security-auditor@agents

# Test on SAFE sample file
cat > /tmp/test-secrets.py << 'EOF'
# Sample file with intentional security issues
API_KEY = "sk-1234567890abcdef"  # Hardcoded secret
password = "admin123"  # Weak password
DB_CONN = "postgresql://user:pass@localhost/db"  # Credentials in code
EOF

# Run security audit
"Use security-auditor to scan /tmp/test-secrets.py"
# Expected: Detect all 3 security issues

# Test on FPIC-SAFE production file
"Use security-auditor to scan analysis/r-scripts/ethnobotany/calculate-bei.R"
# Expected: No false positives on legitimate code
```

**FPIC Compliance Verification:**

```bash
# CRITICAL TEST: Ensure auditor doesn't expose sensitive data

# Create test file with simulated sensitive data
cat > /tmp/fpic-test.csv << 'EOF'
participant_id,community,knowledge_shared
P007,SC01,Traditional medicinal uses
EOF

# Audit the file
"Use security-auditor to scan /tmp/fpic-test.csv"

# VERIFY in logs: Auditor reports issues but DOES NOT LOG FILE CONTENTS
grep -A 10 "security-auditor" ~/.claude/logs/*.log
# Ensure no participant data appears in logs
```

**Validation Checklist:**
- [ ] Source code review: No data exfiltration
- [ ] Detects hardcoded secrets correctly
- [ ] No false positives on legitimate code
- [ ] **CRITICAL:** Does not expose sensitive data in logs
- [ ] Integration with existing security-gate verified

---

#### Day 3: Code-Reviewer Installation (1 hour)

**Installation:**

```bash
cd ~/LAB/projects/KANNA/worktrees/dev
claude

/plugin install code-reviewer@agents
```

**Functional Testing:**

```bash
# Test on sample R analysis script
"Use code-reviewer to review analysis/r-scripts/ethnobotany/calculate-bei.R"

# Evaluate feedback quality:
# - Are suggestions actionable?
# - Does it understand R statistical code?
# - Are recommendations following best practices?
# - Any hallucinations or incorrect advice?

# Compare to manual review time
# Manual: 15-20 min → Plugin: 3-5 min
```

**Validation Checklist:**
- [ ] Provides actionable feedback
- [ ] Understands R/Python scientific code
- [ ] No incorrect or harmful suggestions
- [ ] Time savings: 60-75% vs manual review

---

#### Days 4-5: Integrated Workflow Testing (3 hours)

**Realistic Development Workflow:**

```bash
# Scenario: Write new R script for ethnobotany analysis

# Step 1: Create new analysis script
cat > analysis/r-scripts/ethnobotany/calculate-icf.R << 'EOF'
# Informant Consensus Factor (ICF) calculation
library(tidyverse)

calculate_icf <- function(data) {
  # ICF = (Nur - Nt) / (Nur - 1)
  # Nur = number of use reports
  # Nt = number of taxa used

  icf_results <- data %>%
    group_by(ailment_category) %>%
    summarise(
      Nur = n(),
      Nt = n_distinct(species),
      ICF = (Nur - Nt) / (Nur - 1)
    )

  return(icf_results)
}
EOF

# Step 2: Security audit
"Use security-auditor to scan analysis/r-scripts/ethnobotany/calculate-icf.R"
# Expected: No issues (clean code)

# Step 3: Code review
"Use code-reviewer to review analysis/r-scripts/ethnobotany/calculate-icf.R"
# Expected: Suggestions for error handling, edge cases

# Step 4: Implement suggestions, re-review

# Step 5: Update documentation
/update-claude-md

# Measure total time: Target <30 min (vs 60-90 min manual)
```

**Performance Measurement:**

```bash
# Startup time with 3 plugins
time claude --version
# Target: <8 seconds (baseline 5s)

# Token usage check
tail -50 ~/.claude/logs/mcp-metrics.jsonl | \
  jq 'select(.estimated_tokens > 15000)'
# Alert if any plugin exceeds 15k tokens
```

**Phase 2 Success Criteria:**

- ✅ Startup time <8 seconds (dev baseline 5s)
- ✅ Security-auditor FPIC-compliant (no data exposure)
- ✅ Integrated workflow time savings >50%
- ✅ Zero false positives on legitimate code
- ✅ Approval for Phase 3 progression

---

### Phase 3: Main Worktree Production Integration (Week 3)

**Objective:** Deploy full plugin suite to primary research environment

**Timeline:** 8 hours over 5 days

#### Day 1: Backup & Preparation (15 min)

```bash
# Backup current configuration
cp ~/.claude/settings.json ~/.claude/settings.json.backup
cp ~/.claude/settings.json ~/.claude/settings.json.pre-phase3.$(date +%Y%m%d)

# Git commit current state
cd ~/LAB/projects/KANNA
git add .claude/settings.local.json
git commit -m "checkpoint: pre-Phase 3 plugin integration"
git tag plugin-integration-checkpoint

# Document baseline metrics
cat > /tmp/phase3-baseline.txt << EOF
# Phase 3 Baseline Metrics
Date: $(date)
Startup time: $(time claude --version 2>&1 | grep real)
Active MCP servers: 19
Current plugins: 0
EOF
```

---

#### Day 2: AI-Engineer & Documentation-Generator Installation (2 hours)

**AI-Engineer Installation:**

```bash
cd ~/LAB/projects/KANNA
claude

/plugin install ai-engineer@agents

# Test on RAG pipeline design (pending CUDA fix)
"Use ai-engineer to design optimal RAG pipeline for 142-paper corpus:
- Embedding model selection (context: chemistry PhD thesis)
- Vector database configuration (ChromaDB)
- Chunking strategy for academic papers
- Query optimization for alkaloid research"

# Evaluate response quality:
# - Understands domain (chemistry, academic research)
# - Provides actionable architecture recommendations
# - Considers performance constraints (16GB VRAM, Quadro RTX 5000)
```

**Documentation-Generator Installation:**

```bash
/plugin install documentation-generator@claude-code-marketplace

# Test on Chapter 3 summary generation
"Use documentation-generator to create comprehensive summary of:
- File: writing/CHAPITRE_01_EPISTEMOLOGIE_v1.md
- Target: 500-word executive summary
- Audience: Doctoral committee
- Style: French academic, impersonal voice"

# Evaluate output quality:
# - Accurate content representation
# - Appropriate academic tone
# - No hallucinations
# - Follows French thesis conventions
```

**Validation Checklist:**
- [ ] AI-engineer provides domain-appropriate advice
- [ ] Documentation-generator produces quality summaries
- [ ] Both plugins respect existing security-gate
- [ ] No performance degradation (startup time check)

---

#### Day 3: Main Worktree Full Configuration (1 hour)

**Create Comprehensive Plugin Profile:**

```bash
# Edit main worktree configuration
cat > ~/LAB/projects/KANNA/.claude/settings.local.json << 'EOF'
{
  "plugins": {
    "lyra": {
      "enabled": true,
      "description": "AI prompt optimization for literature searches"
    },
    "update-claude-md": {
      "enabled": true,
      "description": "Auto-maintain 12,338+ word CLAUDE.md documentation"
    },
    "security-auditor": {
      "enabled": true,
      "config": {
        "severity_threshold": "medium",
        "scan_on_commit": false,
        "exclude_paths": [
          "fieldwork/interviews-raw/",
          "data/clinical/trials/**/patient-data/"
        ]
      },
      "description": "FPIC compliance validation"
    },
    "ai-engineer": {
      "enabled": true,
      "description": "RAG pipeline optimization (post-CUDA fix)"
    },
    "documentation-generator": {
      "enabled": true,
      "description": "Chapter summaries, methodology docs"
    }
  },
  "performance": {
    "startup_target_seconds": 15,
    "token_budget_per_response": 15000,
    "max_concurrent_plugins": 3
  }
}
EOF

# Verify configuration loads
claude
/plugin list
# Expected: All 5 plugins shown as enabled
```

---

#### Days 4-5: Production Workflow Testing (4 hours)

**Real Thesis Work with Full Plugin Suite:**

**Task 1: Literature Search Optimization (1 hour)**

```bash
# Optimize search for alkaloid biosynthesis papers
/lyra "Search the 142-paper corpus for studies on mesembrine biosynthesis pathways, including:
- Enzymatic steps in alkaloid synthesis
- Gene expression studies
- Metabolic pathway elucidation
- Comparison with related Aizoaceae species"

# Execute optimized search with rag-query MCP
# Measure: Query quality, relevance of results, time to insight
```

**Task 2: RAG Pipeline Design (1 hour)**

```bash
# Design comprehensive RAG architecture
"Use ai-engineer to design production RAG pipeline:

Requirements:
- Corpus: 142 scientific papers (chemistry, ethnobotany, pharmacology)
- Hardware: Quadro RTX 5000 (16GB VRAM)
- Models: vLLM serving ChemLLM-7B-Chat
- Vector DB: ChromaDB
- Constraints: Local-only (FPIC compliance), GPU-accelerated

Deliverables:
- Embedding model recommendation
- Chunking strategy for academic papers
- Query optimization techniques
- Performance benchmarks"

# Evaluate: Architecture feasibility, domain expertise, actionable recommendations
```

**Task 3: Chapter Documentation (1 hour)**

```bash
# Generate Chapter 3 summary
"Use documentation-generator to create:

Input: writing/CHAPITRE_01_EPISTEMOLOGIE_v1.md
Output:
- Executive summary (500 words)
- Key findings (bullet points)
- Methodology overview
- Integration with overall thesis

Style: French academic, doctoral-level, impersonal voice"

# Compare: Manual time (3-4 hours) vs Plugin time (30-45 min)
```

**Task 4: Security Validation (30 min)**

```bash
# Audit entire codebase for security issues
"Use security-auditor to scan:
- analysis/r-scripts/**/*.R
- analysis/python/**/*.py
- tools/scripts/**/*.{sh,py}

Focus: Hardcoded secrets, FPIC data exposure risks, credential management"

# Review results, address any findings
```

**Task 5: Infrastructure Update (30 min)**

```bash
# Update CLAUDE.md with plugin integration
/update-claude-md

# Review suggested changes:
# - Plugin marketplace section
# - Installed plugins list
# - Performance metrics update
# - Integration workflow documentation

# Manual refinement, then commit
git add CLAUDE.md docs/PLUGIN-INTEGRATION-PLAN.md
git commit -m "docs: complete Phase 3 plugin integration"
```

**Performance Measurement:**

```bash
# Final startup time measurement
for i in {1..10}; do
  time claude --version 2>&1 | grep real
done | awk '{sum+=$2; count++} END {print "Average:", sum/count, "seconds"}'

# Target: <15 seconds (success criterion)

# Token usage analysis
jq 'select(.timestamp > "'$(date -d '5 days ago' +%Y-%m-%d)'")' \
  ~/.claude/logs/mcp-metrics.jsonl | \
  jq -s 'group_by(.server) | map({server: .[0].server, avg_tokens: (map(.estimated_tokens) | add / length)})'

# Alert if average >20k tokens per server
```

**Phase 3 Success Criteria:**

- ✅ Startup time <15 seconds (current baseline 8-12s)
- ✅ All 5 plugins functional in production workflows
- ✅ Documented time savings >10 hours/week
- ✅ Zero security incidents during testing
- ✅ Positive user experience (KANNA researcher approval)
- ✅ ROI breakeven (23 hours investment vs 12 hours/week savings)

---

## Validation Checklist

Use this checklist **before installing any plugin** in any worktree:

### 1. Repository Health Check

- [ ] **Recent commits**: Last commit within 90 days (not abandoned)
- [ ] **Community trust**: >50 stars OR >10 forks OR known author
- [ ] **Issue resolution**: >50% issues closed within 30 days
- [ ] **Documentation**: Comprehensive README with examples
- [ ] **License**: MIT/Apache 2.0/BSD (permissive open-source)

### 2. Source Code Security Review

**For Commands** (`.md` files):
- [ ] No external service calls in system prompt
- [ ] No request for sensitive file access
- [ ] Reasonable scope (focused on specific task)

**For Agents** (`.md` files):
- [ ] Tool permissions clearly defined and minimal
- [ ] No unrestricted file system access
- [ ] Domain expertise aligns with advertised capability

**For Hooks** (`.sh` scripts):
- [ ] No network calls (curl, wget, nc)
- [ ] No credential access attempts
- [ ] No unauthorized logging of sensitive data
- [ ] Fast execution (<100ms target)

**For MCP Servers** (node/python):
- [ ] Review `package.json` / `requirements.txt` for suspicious dependencies
- [ ] Check for outbound network connections
- [ ] Validate data handling (no exfiltration)
- [ ] Verify transport protocol (stdio preferred for local servers)

### 3. Functional Testing

- [ ] Install in `experimental` worktree first
- [ ] Test core functionality (3-5 test cases)
- [ ] Measure performance (startup time, token usage)
- [ ] Review output quality (accuracy, hallucinations)
- [ ] Check logs for errors (`~/.claude/logs/*.log`)

### 4. Integration Testing

- [ ] Verify security-gate hook still active (run violation tests)
- [ ] Confirm existing hooks execute (auto-format, command-logger, mcp-monitor)
- [ ] Test with other plugins (no conflicts)
- [ ] Validate worktree-specific configuration

### 5. Performance Testing

- [ ] Startup time increase <50% of baseline
- [ ] Token usage within budget (<15k per response)
- [ ] Memory consumption reasonable (<100MB per active agent)
- [ ] No blocking operations (all async where applicable)

### 6. Documentation

- [ ] Add entry to `docs/PLUGIN-VALIDATION-LOG.md`
- [ ] Document use cases and examples
- [ ] Note any limitations or caveats
- [ ] Record approval decision (APPROVED / REJECTED)

### 7. FPIC Compliance Verification (KANNA-Specific)

- [ ] **CRITICAL TEST**: Attempt to access `fieldwork/interviews-raw/` → BLOCKED
- [ ] **CRITICAL TEST**: Attempt to read `.env` files → BLOCKED
- [ ] Plugin does not log sensitive data
- [ ] No external data transmission detected
- [ ] Complies with indigenous knowledge protection protocols

---

## Monitoring & Rollback

### Continuous Monitoring

**Daily Checks (2 min):**

```bash
# Check for plugin errors
grep -i "plugin.*error" ~/.claude/logs/*.log | tail -20

# Monitor token usage
tail -50 ~/.claude/logs/mcp-metrics.jsonl | \
  jq 'select(.estimated_tokens > 20000)'
```

**Weekly Metrics (15 min):**

```bash
# Startup time trend
# Run in each worktree
for worktree in . worktrees/{dev,experimental,docs,cloudflare}; do
  cd ~/LAB/projects/KANNA/$worktree
  echo "=== $worktree ==="
  time claude --version 2>&1 | grep real
done

# Token consumption by plugin
jq 'select(.timestamp > "'$(date -d '7 days ago' +%Y-%m-%d)'")' \
  ~/.claude/logs/mcp-metrics.jsonl | \
  jq -s 'group_by(.server) | map({
    server: .[0].server,
    total_tokens: (map(.estimated_tokens) | add),
    avg_tokens: (map(.estimated_tokens) | add / length),
    calls: length
  })' | \
  jq 'sort_by(-.total_tokens)'

# Plugin utilization
/plugin list | grep enabled
# Disable plugins with <5 uses per week
```

### Performance Budgets

**Hard Limits** (automatic rollback if exceeded):

| Metric | Limit | Action on Violation |
|--------|-------|---------------------|
| Main worktree startup | >20 seconds | Disable newest plugin |
| Token usage per response | >25,000 | Alert + investigate |
| Plugin error rate | >5% of calls | Disable plugin |
| Memory consumption | >500MB per plugin | Disable plugin |

**Soft Limits** (investigation required):

| Metric | Limit | Action on Violation |
|--------|-------|---------------------|
| Startup time increase | >50% baseline | Review plugin necessity |
| Weekly plugin usage | <5 uses | Consider disabling |
| Token efficiency | <10% improvement | Re-evaluate plugin value |

### Rollback Procedures

**Immediate Rollback (Security Incident):**

```bash
# STEP 1: Disable plugin immediately
/plugin disable <plugin-name>

# STEP 2: Review audit logs
grep -i "<plugin-name>" ~/.claude/logs/bash-commands.log
grep -i "<plugin-name>" ~/.claude/logs/mcp-*.log

# STEP 3: Assess damage
# - Check for unauthorized file access
# - Review network connections
# - Scan for data exfiltration

# STEP 4: Document incident
cat >> docs/PLUGIN-SECURITY-INCIDENTS.md << EOF
## Incident: $(date)
Plugin: <plugin-name>
Issue: [Description]
Impact: [Assessment]
Resolution: [Actions taken]
EOF

# STEP 5: Report to marketplace maintainer
# (if appropriate)
```

**Performance Rollback:**

```bash
# STEP 1: Identify problematic plugin
# Use monitoring metrics above

# STEP 2: Disable in specific worktree
# Edit .claude/settings.local.json
{
  "plugins": {
    "<plugin-name>": {"enabled": false}
  }
}

# STEP 3: Verify performance restoration
time claude --version

# STEP 4: Document decision
# Update docs/PLUGIN-VALIDATION-LOG.md
```

**Full Rollback to Pre-Plugin State:**

```bash
# STEP 1: Restore configuration backup
cp ~/.claude/settings.json.backup ~/.claude/settings.json

# STEP 2: Git revert local configurations
cd ~/LAB/projects/KANNA
git checkout plugin-integration-checkpoint -- .claude/settings.local.json

# STEP 3: Uninstall all plugins
/plugin list | grep -v "No plugins" | while read plugin; do
  /plugin uninstall "$plugin"
done

# STEP 4: Verify clean state
/plugin list  # Should show: No plugins installed
time claude --version  # Should match pre-plugin baseline

# STEP 5: Document rollback
# Add to docs/PLUGIN-INTEGRATION-PLAN.md
```

---

## Documentation Requirements

### Required Documentation

#### 1. Plugin Integration Plan (This Document)

**Location:** `docs/PLUGIN-INTEGRATION-PLAN.md`
**Status:** ✅ Created
**Maintenance:** Update after each phase completion

#### 2. Plugin Validation Log

**Location:** `docs/PLUGIN-VALIDATION-LOG.md`
**Content:**
```markdown
# Plugin Validation Log

## Format
For each plugin:
- Installation date
- Security review findings
- Functional test results
- Performance metrics
- Integration test results
- FPIC compliance verification
- Approval decision (APPROVED / REJECTED / PENDING)

## Validated Plugins

### lyra@claude-code-marketplace
...

### update-claude-md@claude-code-marketplace
...
```

#### 3. Plugin Usage Guide

**Location:** `docs/PLUGIN-USAGE-GUIDE.md`
**Content:**
```markdown
# KANNA Plugin Usage Guide

## Installed Plugins

### lyra - AI Prompt Optimization

**Use Cases:**
- Literature search query optimization
- RAG query refinement
- Token efficiency improvement

**Command:** `/lyra [prompt-text]`

**Examples:**
```bash
/lyra "Find papers about alkaloid biosynthesis in Sceletium"
```

**Best Practices:**
- Use for complex, multi-criteria searches
- Review optimized prompt before execution
- Iterate if first optimization insufficient

**Troubleshooting:**
- Issue: Optimized prompt too verbose
  Solution: Add constraint "keep prompt under 100 words"
...
```

#### 4. Update CLAUDE.md

**Location:** `CLAUDE.md` (project root)
**Section:** Plugin Marketplaces
**Add Subsection:**

```markdown
## Installed Plugins

**Status**: ✅ Phase 3 Complete (5 plugins active)
**Last Updated**: 2025-10-XX

### Main Worktree Plugins

| Plugin | Marketplace | Use Case | Weekly Usage |
|--------|-------------|----------|--------------|
| lyra | claude-code-marketplace | Prompt optimization | 15-20 calls |
| update-claude-md | claude-code-marketplace | Documentation | 2-3 calls |
| security-auditor | agents | FPIC compliance | 5-8 calls |
| ai-engineer | agents | RAG optimization | 3-5 calls |
| documentation-generator | claude-code-marketplace | Chapter summaries | 2-4 calls |

### Worktree-Specific Profiles

**Dev Worktree:**
- lyra, code-reviewer, security-auditor

**Experimental Worktree:**
- lyra (minimal for testing)

**Docs Worktree:**
- lyra, documentation-generator

**Cloudflare Worktree:**
- None (lightweight for scraping)

### Performance Metrics

- **Startup Time**: Main (13.2s), Dev (6.8s), Experimental (2.4s)
- **Token Efficiency**: 35% improvement on optimized queries
- **Time Savings**: 12.5 hours/week average
- **ROI**: 23-hour investment, 1,968 hours saved over 41 months
```

#### 5. Worktree Configuration Files

**Create:** `.claude/settings.local.json` in each worktree

Example for main worktree (already detailed in Phase 3).

---

## Timeline & Success Criteria

### 3-Week Implementation Timeline

```
Week 1: Phase 1 - Experimental Worktree
├─ Day 1: Marketplace setup (30 min)
├─ Day 2: Lyra installation & validation (1 hour)
├─ Day 3: Security integration test (1 hour)
├─ Day 4: Update-claude-md installation (1 hour)
└─ Days 5-7: Performance metrics (2 hours)
Total: 5 hours

Week 2: Phase 2 - Dev Worktree
├─ Day 1: Dev configuration (30 min)
├─ Day 2: Security-auditor review (2 hours)
├─ Day 3: Code-reviewer installation (1 hour)
└─ Days 4-5: Integrated workflow testing (3 hours)
Total: 7 hours

Week 3: Phase 3 - Main Worktree
├─ Day 1: Backup & preparation (15 min)
├─ Day 2: AI-engineer & doc-generator install (2 hours)
├─ Day 3: Full configuration (1 hour)
└─ Days 4-5: Production workflow testing (4 hours)
Total: 8 hours

Documentation (Ongoing)
└─ All phases: Create validation logs, usage guides (3 hours)

TOTAL TIME INVESTMENT: 23 hours
```

### Success Criteria by Phase

#### Phase 1 Success Criteria

- ✅ All 3 marketplaces added and accessible
- ✅ Lyra installed, validated, producing 20-30% token savings
- ✅ Update-claude-md installed, 90%+ time savings on updates
- ✅ Security-gate hook remains active and effective
- ✅ Startup time <3 seconds (experimental worktree)
- ✅ Zero security incidents
- ✅ Documentation complete for validated plugins

**Decision Point:** Proceed to Phase 2 if ALL criteria met. Otherwise, remediate issues before proceeding.

---

#### Phase 2 Success Criteria

- ✅ Startup time <8 seconds (dev worktree)
- ✅ Security-auditor FPIC-compliant (no data exposure in logs)
- ✅ Code-reviewer provides quality feedback (>80% actionable suggestions)
- ✅ Integrated workflow time savings >50% vs manual
- ✅ Zero false positives on FPIC-compliant data
- ✅ All Phase 1 plugins migrated successfully
- ✅ Documentation updated with Phase 2 findings

**Decision Point:** Proceed to Phase 3 if ALL criteria met. Otherwise, iterate on Phase 2 or rollback problematic plugins.

---

#### Phase 3 Success Criteria

- ✅ Startup time <15 seconds (main worktree)
- ✅ All 5 plugins functional in production workflows
- ✅ Net productivity gain >10 hours/week
- ✅ ROI breakeven achieved (23 hours investment vs 46 hours savings over 2 weeks)
- ✅ Zero security incidents during production testing
- ✅ Positive user experience (researcher satisfaction)
- ✅ Comprehensive documentation complete

**Decision Point:** If ANY criterion fails, selectively disable plugins until criteria met. Document trade-offs.

---

### Overall Success Metrics

**Quantitative:**
- **Startup Time**: <15s main, <8s dev, <3s experimental
- **Time Savings**: >10 hours/week (conservative estimate)
- **Token Efficiency**: >30% improvement on optimized queries
- **Error Rate**: <2% plugin-related errors
- **Security Incidents**: 0 (absolute requirement)

**Qualitative:**
- **User Satisfaction**: Researcher approves plugin integration
- **Workflow Improvement**: Noticeable productivity enhancement
- **Documentation Quality**: CLAUDE.md maintained accurately
- **Security Confidence**: FPIC compliance maintained

**ROI:**
- **Investment**: 23 hours over 3 weeks
- **Return**: 12 hours/week × 41 months × 4 weeks = 1,968 hours
- **Ratio**: 85× return on investment

---

## Cost-Benefit Analysis

### Time Investment Breakdown

| Phase | Activities | Time |
|-------|------------|------|
| **Phase 1** | Marketplace setup, lyra/update-claude-md validation | 5 hours |
| **Phase 2** | Security-auditor review, code-reviewer testing | 7 hours |
| **Phase 3** | Full suite integration, production workflows | 8 hours |
| **Documentation** | Validation logs, usage guides, CLAUDE.md updates | 3 hours |
| **TOTAL** | | **23 hours** |

### Expected Returns

#### Weekly Time Savings

| Plugin | Use Case | Manual Time | Plugin Time | Savings/Week |
|--------|----------|-------------|-------------|--------------|
| **lyra** | Literature search (3-5 queries/week) | 4-6 hours | 1-2 hours | **3-4 hours** |
| **update-claude-md** | Documentation updates (2×/week) | 2-4 hours | 0.2 hours | **2-4 hours** |
| **security-auditor** | Security scans (1×/week) | 2-3 hours | 0.5 hours | **2-3 hours** |
| **ai-engineer** | RAG optimization (as needed) | 5-8 hours | 1-2 hours | **3-5 hours** |
| **documentation-generator** | Chapter summaries (active writing) | 6-8 hours | 1-2 hours | **5-6 hours** |
| **TOTAL WEEKLY SAVINGS** | | | | **12-18 hours** |

**Conservative Estimate:** 12 hours/week
**Optimistic Estimate:** 18 hours/week

#### Long-Term ROI

**Thesis Duration:** 41 months remaining (42 months total - 1 month complete)

**Conservative Calculation:**
- Investment: 23 hours
- Weekly savings: 12 hours
- Weeks remaining: 41 months × 4 weeks = 164 weeks
- Total savings: 12 hours × 164 weeks = **1,968 hours**
- ROI: 1,968 / 23 = **85× return**

**Breakeven Point:**
- 23 hours / 12 hours per week = **1.9 weeks** (breakeven in under 2 weeks!)

#### Non-Time Benefits

**Quality Improvements:**
- **Consistency**: Automated documentation updates (fewer outdated sections)
- **Security**: Continuous FPIC compliance validation (risk mitigation)
- **Research Quality**: Better literature search results (higher-quality citations)
- **Writing Quality**: Consistent chapter summaries (better thesis coherence)

**Risk Mitigation:**
- **Security Incidents**: Prevented (1 incident = 20+ hours remediation)
- **Documentation Debt**: Avoided (undocumented infrastructure = 10+ hours to reconstruct)
- **Knowledge Retention**: Plugin usage guides preserve institutional knowledge

**Peace of Mind:**
- **FPIC Compliance**: Automated validation reduces anxiety
- **Infrastructure Stability**: Continuous monitoring prevents surprises
- **Reproducibility**: Documented workflows ensure thesis reproducibility

### Cost-Benefit Summary

**Investment:** 23 hours (one-time, Week 1-3)
**Return:** 1,968 hours (over 41 months)
**ROI:** 85× (8,500% return)
**Breakeven:** <2 weeks
**Risk:** Low (rollback available, incremental approach)
**Verdict:** **HIGHLY FAVORABLE**

---

## Long-Term Maintenance

### Monthly Review (15 min)

**Tasks:**
1. Check for plugin updates
2. Review performance metrics
3. Audit security logs
4. Disable unused plugins

**Checklist:**

```bash
# Update marketplaces
/plugin marketplace refresh claude-code-marketplace
/plugin marketplace refresh agents

# Check for plugin updates
/plugin list --updates-available

# Review startup time trend
cd ~/LAB/projects/KANNA
time claude --version
# Compare to baseline (13.2s target)

# Review token usage
jq 'select(.timestamp > "'$(date -d '30 days ago' +%Y-%m-%d)'")' \
  ~/.claude/logs/mcp-metrics.jsonl | \
  jq -s 'group_by(.server) | map({
    server: .[0].server,
    avg_tokens: (map(.estimated_tokens) | add / length)
  })'

# Audit security logs
grep -i "security.*violation" ~/.claude/logs/*.log | tail -50
# Expected: Only intentional test violations

# Disable unused plugins
/plugin list | grep "Last used: >30 days ago"
# Consider disabling if <5 uses/month
```

**Documentation Update:**

Update `docs/PLUGIN-VALIDATION-LOG.md` with monthly metrics:
```markdown
## Monthly Review: October 2025

**Date:** 2025-10-31
**Plugins Reviewed:** 5
**Updates Available:** 0
**Performance:** ✅ Within targets
**Security:** ✅ No incidents
**Actions Taken:** None required
```

---

### Quarterly Deep Review (2 hours)

**Tasks:**
1. Re-evaluate plugin value proposition
2. Explore new plugins in marketplaces
3. Update configurations based on workflow changes
4. Document lessons learned

**Checklist:**

```bash
# 1. Plugin Utilization Analysis
jq 'select(.timestamp > "'$(date -d '90 days ago' +%Y-%m-%d)'")' \
  ~/.claude/logs/mcp-metrics.jsonl | \
  jq -s 'group_by(.server) | map({
    plugin: .[0].server,
    total_calls: length,
    avg_calls_per_week: (length / 13),
    total_tokens: (map(.estimated_tokens) | add)
  }) | sort_by(-.total_calls)'

# Plugins with <10 calls/quarter: Consider removing

# 2. Browse new plugins
/plugin marketplace refresh claude-code-marketplace
/plugin
# Filter by: "Added in last 90 days"

# 3. Performance review
# Compare current startup time to baseline
cat > /tmp/quarterly-performance.txt << EOF
Quarter: Q4 2025
Baseline startup: 13.2s
Current startup: $(time claude --version 2>&1 | grep real)
Degradation: [Calculate percentage]
Action needed: [Yes/No]
EOF

# 4. Workflow analysis
# Interview yourself:
# - Which plugins are indispensable?
# - Which plugins provide marginal value?
# - Are there missing capabilities?
# - Has research focus changed?
```

**Strategic Questions:**

- **Value Assessment**: Is `documentation-generator` still valuable in non-writing months?
- **New Opportunities**: Are there new plugins for French academic writing?
- **Integration Depth**: Can we create custom KANNA-specific plugins?
- **Community Contribution**: Should we share our workflow as a plugin bundle?

**Documentation Update:**

Create quarterly summary in `docs/PLUGIN-QUARTERLY-REVIEWS/`:
```markdown
# Q4 2025 Plugin Review

## Utilization Summary
- lyra: 67 calls (high value, keep)
- update-claude-md: 12 calls (moderate value, keep)
- security-auditor: 23 calls (critical, keep)
- ai-engineer: 8 calls (low usage, monitor)
- documentation-generator: 4 calls (low usage, disable until active writing)

## New Plugins Evaluated
- french-grammar-assistant: Evaluated, not yet mature
- zotero-integration: Evaluated, redundant with existing workflow

## Configuration Changes
- Disabled documentation-generator in main worktree (re-enable in writing phase)
- Added french-grammar-assistant to docs worktree for testing

## Lessons Learned
- Plugin value varies by research phase (writing vs data analysis)
- Worktree-specific profiles crucial for performance
- Monthly reviews catch performance degradation early
```

---

### Yearly Audit (4 hours)

**Tasks:**
1. Comprehensive security review
2. Performance benchmarking vs. baseline
3. Cost-benefit re-analysis
4. Community contribution planning

**Security Audit:**

```bash
# 1. Review all plugin source code (GitHub)
# Check for:
# - New commits since installation
# - Security advisories
# - Dependency vulnerabilities

# 2. Re-run FPIC compliance tests
# Intentional violation tests (same as Phase 1)

# 3. Audit logs for anomalies
grep -i "unauthorized\|violation\|blocked" ~/.claude/logs/*.log | \
  grep -v "INTENTIONAL TEST" | \
  wc -l
# Expected: 0 (except test violations)

# 4. Review marketplace trust
# Check if any marketplaces have become inactive/compromised
/plugin marketplace list
# Verify all repositories still maintained
```

**Performance Benchmarking:**

```bash
# Compare Year 1 vs. Baseline
cat > /tmp/yearly-benchmark.txt << EOF
Metric                    Baseline    Current     Change
===============================================================
Startup (main)           8-12s       13.2s       +15%
Startup (dev)            5s          6.8s        +36%
Startup (experimental)   2s          2.4s        +20%
Token efficiency         N/A         +35%        N/A
Weekly time saved        0           12h         +∞
Security incidents       0           0           0
===============================================================

ROI Analysis:
Investment: 23 hours (Year 1)
Maintenance: 15 min/month × 12 = 3 hours
Total cost: 26 hours

Returns: 12h/week × 52 weeks = 624 hours (Year 1)
ROI: 624 / 26 = 24× (2,400%)
Cumulative over 41 months: 1,968 hours
EOF
```

**Community Contribution:**

Consider creating KANNA-specific plugins to share:

1. **`academic-writing-fr`** - French thesis writing assistant
   - Integration with Grammalecte
   - French academic conventions
   - LaTeX/Overleaf optimization

2. **`fpic-validator`** - Indigenous knowledge protection
   - Automated FPIC compliance checks
   - Sensitive data detection
   - Ethics protocol validation

3. **`phd-thesis-manager`** - Comprehensive thesis management
   - Chapter tracking
   - Publication pipeline
   - Defense preparation

**Documentation Update:**

Create `docs/PLUGIN-YEARLY-AUDIT-2026.md` with comprehensive findings and recommendations.

---

## Contingency Plans

### Common Issues & Solutions

#### Issue 1: Plugin Conflicts with Existing Hooks

**Symptoms:**
- Auto-format fails after plugin installation
- Command-logger missing entries
- Security-gate not blocking violations

**Diagnosis:**

```bash
# Check hook execution order
cat ~/.claude/settings.json | jq '.hooks'

# Review hook logs
tail -100 ~/.claude/logs/*.log | grep -i "hook"

# Test each hook individually
echo '{"tool_name":"Bash","tool_input":{"command":"ls"}}' | \
  ~/.claude/hooks/command-logger.sh
```

**Solution:**

```bash
# Option 1: Disable conflicting plugin hook
# Edit plugin configuration to disable specific hook

# Option 2: Adjust hook execution order
# Edit ~/.claude/settings.json to prioritize KANNA hooks

# Option 3: Contact plugin author
# Report conflict, request fix or workaround

# Option 4: Write custom hook wrapper
# Create wrapper that calls both hooks in correct order
```

---

#### Issue 2: Performance Degradation Beyond Acceptable Limits

**Symptoms:**
- Startup time >20 seconds (main worktree)
- Frequent timeouts
- Sluggish response times

**Diagnosis:**

```bash
# Profile plugin overhead
for plugin in lyra update-claude-md security-auditor ai-engineer documentation-generator; do
  echo "Testing: $plugin"
  /plugin disable "$plugin"
  time claude --version
  /plugin enable "$plugin"
done

# Identify slowest plugin

# Check for resource leaks
ps aux | grep claude
# Look for zombie processes or excessive memory
```

**Solution:**

```bash
# Immediate: Disable highest-overhead plugin
/plugin disable <slowest-plugin>

# Short-term: Optimize worktree profiles
# Move non-essential plugins to specific worktrees only

# Long-term: Profile plugin code
# Identify bottleneck in plugin source
# Submit optimization PR to plugin repository
# OR fork and maintain optimized version locally
```

---

#### Issue 3: Security Incident (Unauthorized Access Attempt)

**Symptoms:**
- Security-gate blocked unexpected operation
- Sensitive data appears in logs
- Unknown network connections

**Immediate Actions:**

```bash
# STEP 1: STOP - Disable all plugins immediately
/plugin disable lyra
/plugin disable update-claude-md
/plugin disable security-auditor
/plugin disable ai-engineer
/plugin disable documentation-generator

# STEP 2: ASSESS - Review audit logs
grep -i "blocked\|violation\|unauthorized" ~/.claude/logs/bash-commands.log
grep -i "fieldwork\|interviews-raw\|patient-data" ~/.claude/logs/*.log

# STEP 3: ISOLATE - Identify compromised plugin
# Review logs to determine which plugin caused violation

# STEP 4: DOCUMENT - Create incident report
cat > docs/PLUGIN-SECURITY-INCIDENTS.md << EOF
## Security Incident: $(date +%Y-%m-%d)

**Plugin:** [name]
**Violation Type:** [description]
**Data Exposed:** [assessment - None/Low/Medium/High]
**Root Cause:** [analysis]
**Remediation:** [actions taken]
**Prevention:** [future safeguards]
EOF

# STEP 5: REPORT - Notify stakeholders
# - Thesis supervisor (if data exposed)
# - Plugin marketplace maintainer
# - Community (if critical vulnerability)

# STEP 6: REMEDIATE
# - Remove compromised plugin permanently
# - Audit all files plugin accessed
# - Change credentials if necessary
# - Update security-gate rules to prevent recurrence
```

---

#### Issue 4: Plugin Becomes Unmaintained

**Symptoms:**
- Repository archived or deleted
- Last commit >365 days ago
- Critical bugs unresolved
- Security vulnerabilities unpatched

**Solution:**

```bash
# Option 1: Fork and maintain locally
git clone https://github.com/author/plugin.git
cd plugin
# Apply security patches
# Update dependencies
# Test locally
# Use forked version

# Option 2: Find alternative
/plugin marketplace refresh claude-code-marketplace
/plugin search "similar functionality"
# Evaluate alternatives
# Migrate to maintained plugin

# Option 3: Remove plugin
/plugin uninstall <unmaintained-plugin>
# Document decision in validation log
# Update worktree configurations

# Option 4: Vendor plugin locally
# Copy plugin files to project
# Maintain as project-specific resource
# Document as "vendored plugin"
```

---

#### Issue 5: Marketplace Becomes Unavailable

**Symptoms:**
- `/plugin marketplace refresh` fails
- Repository returns 404
- Marketplace owner account deleted

**Impact Assessment:**

- **Installed plugins:** Continue to work (cached locally)
- **New installations:** Not possible from unavailable marketplace
- **Updates:** Not available

**Solution:**

```bash
# STEP 1: Verify plugins still functional
/plugin list
# Test each plugin
# Confirm local cache intact

# STEP 2: Backup plugin files
mkdir -p ~/LAB/projects/KANNA/vendored-plugins
cp -r ~/.claude/plugins/* ~/LAB/projects/KANNA/vendored-plugins/
git add ~/LAB/projects/KANNA/vendored-plugins/
git commit -m "backup: vendor plugins from unavailable marketplace"

# STEP 3: Add alternative marketplace
/plugin marketplace add <alternative-source>

# STEP 4: Migrate to alternative
# Search for equivalent plugins in available marketplaces
# Install replacements
# Test functionality
# Remove unavailable marketplace

/plugin marketplace remove <unavailable-marketplace>

# STEP 5: Document migration
# Update CLAUDE.md
# Note marketplace change in validation log
```

---

## Summary & Next Steps

### Implementation Roadmap

**Week 1 (Phase 1):**
- [ ] Day 1: Add 3 marketplaces, verify access
- [ ] Day 2: Install & validate `lyra` in experimental worktree
- [ ] Day 3: Security integration testing
- [ ] Day 4: Install & validate `update-claude-md`
- [ ] Days 5-7: Collect baseline metrics, document findings

**Week 2 (Phase 2):**
- [ ] Day 1: Configure dev worktree, migrate Phase 1 plugins
- [ ] Day 2: Install & extensively review `security-auditor`
- [ ] Day 3: Install `code-reviewer`, test on R/Python scripts
- [ ] Days 4-5: Integrated workflow testing, performance measurement

**Week 3 (Phase 3):**
- [ ] Day 1: Backup configuration, prepare main worktree
- [ ] Day 2: Install `ai-engineer` & `documentation-generator`
- [ ] Day 3: Configure full plugin suite for main worktree
- [ ] Days 4-5: Production workflow testing, ROI validation

**Ongoing:**
- [ ] Create `docs/PLUGIN-VALIDATION-LOG.md` (throughout all phases)
- [ ] Create `docs/PLUGIN-USAGE-GUIDE.md` (Week 3)
- [ ] Update `CLAUDE.md` Plugin Marketplaces section (Week 3)
- [ ] Monthly reviews (15 min)
- [ ] Quarterly deep reviews (2 hours)
- [ ] Yearly audits (4 hours)

### Success Metrics Recap

**Must-Have (Non-Negotiable):**
- ✅ Zero security incidents (FPIC compliance absolute)
- ✅ Startup time <15s main worktree
- ✅ Security-gate hook remains effective

**High-Priority:**
- ✅ ROI breakeven <2 weeks (23h investment / 12h weekly savings)
- ✅ Net productivity gain >10 hours/week
- ✅ Plugin error rate <2%

**Nice-to-Have:**
- 🎯 Token efficiency improvement >30%
- 🎯 Documentation maintenance time <5 min (vs 45-60 min)
- 🎯 Literature search quality improvement

### Risk Mitigation Summary

**Risk:** Security incident exposing FPIC data
**Mitigation:** Existing security-gate runs first, extensive validation, experimental-first testing
**Residual Risk:** Low

**Risk:** Performance degradation
**Mitigation:** Incremental rollout, continuous monitoring, performance budgets, rollback procedures
**Residual Risk:** Low

**Risk:** Plugin maintenance burden
**Mitigation:** Favor well-maintained plugins, monthly reviews, contingency plans for unmaintained plugins
**Residual Risk:** Medium

**Risk:** Time investment not recouped
**Mitigation:** Conservative ROI estimates (12h/week vs optimistic 18h/week), early breakeven (2 weeks)
**Residual Risk:** Very Low

### Final Recommendation

**Proceed with plugin integration** following this 3-phase plan.

**Rationale:**
1. **High ROI**: 85× return (1,968 hours saved over 41 months)
2. **Low Risk**: Incremental approach, extensive validation, rollback available
3. **FPIC-Safe**: Security-gate architecture preserves indigenous knowledge protection
4. **Strategic Fit**: Aligns with "Infrastructure-First PhD" philosophy
5. **Proven Value**: Community adoption (196+ plugins across marketplaces) validates approach

**Critical Success Factor:** Disciplined execution of validation checklist at each phase. Do NOT skip security reviews or FPIC compliance testing.

---

**Document Version:** 1.0
**Last Updated:** 2025-10-10
**Next Review:** Post-Phase 1 Completion (Week 1)
**Maintainer:** KANNA Project Lead

---

## Appendix: Quick Reference

### Essential Commands

```bash
# Marketplace management
/plugin marketplace add <repo>
/plugin marketplace refresh <name>
/plugin marketplace list

# Plugin management
/plugin install <name>@<marketplace>
/plugin disable <name>
/plugin enable <name>
/plugin uninstall <name>
/plugin list

# Monitoring
time claude --version
tail -f ~/.claude/logs/mcp-metrics.jsonl
grep -i error ~/.claude/logs/*.log

# Rollback
/plugin disable <name>
cp ~/.claude/settings.json.backup ~/.claude/settings.json
```

### Performance Targets

| Worktree | Baseline | Target | Max Acceptable |
|----------|----------|--------|----------------|
| Main | 8-12s | <13s | <15s |
| Dev | 5s | <7s | <8s |
| Experimental | 2s | <2.5s | <3s |
| Docs | 2s | <3s | <4s |
| Cloudflare | 4s | <4.5s | <5s |

### Contact Information

**Plugin Issues:**
- Marketplace maintainers (GitHub Issues)
- Claude Code support (if core functionality)

**Security Incidents:**
- Thesis supervisor: [email]
- Ethics committee: [email]
- Data protection officer: [email]

**Documentation Updates:**
- KANNA project repository: `/docs/PLUGIN-*.md`
- CLAUDE.md: Section "Plugin Marketplaces"
