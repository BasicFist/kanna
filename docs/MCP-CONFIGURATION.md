# KANNA MCP Server Configuration

**Last Updated**: October 2025
**Total Servers**: 13 (optimized for PhD research)

## Configuration Philosophy

This MCP configuration is **purpose-built for PhD thesis research**, focusing on:
- Academic literature management (142-paper corpus)
- Scientific computing (R, Python, Jupyter)
- Data analysis and visualization
- French academic writing
- Web scraping for research papers
- Cheminformatics and QSAR modeling

## Server Inventory

### 📁 Core Infrastructure (4 servers)

#### 1. **filesystem**
- **Purpose**: Local file operations (read, write, edit)
- **Use Cases**:
  - Reading analysis scripts (`analysis/r-scripts/`, `analysis/python/`)
  - Editing thesis chapters (`writing/thesis-chapters/*.tex`)
  - Managing data files (`data/ethnobotanical/`, `data/chemical/`)
- **Command**: `/home/miko/LAB/bin/mcp-fs`

#### 2. **git**
- **Purpose**: Git repository operations
- **Use Cases**:
  - Commit analysis results
  - Track thesis writing progress
  - Collaborate on code changes
  - Manage data versioning
- **Command**: `/home/miko/LAB/bin/mcp-git`
- **Points to**: KANNA repository (`/home/miko/LAB/projects/KANNA`)

#### 3. **github**
- **Purpose**: GitHub API integration
- **Use Cases**:
  - Create pull requests for major changes
  - Manage issues and milestones
  - Track collaboration workflows
  - Access remote repositories
- **Command**: `/home/miko/LAB/bin/mcp-github`
- **Requires**: `GITHUB_PERSONAL_ACCESS_TOKEN` in secrets

#### 4. **sqlite**
- **Purpose**: SQLite database operations
- **Use Cases**:
  - Query ethnobotanical survey databases
  - Manage chemical compound datasets
  - Store BEI/ICF calculations
  - Track clinical trial data
- **Command**: `/home/miko/LAB/bin/mcp-sqlite`

---

### 🔬 Scientific Computing (1 server)

#### 5. **jupyter**
- **Purpose**: Jupyter notebook integration
- **Use Cases**:
  - Interactive QSAR modeling (`notebooks/qsar-analysis.ipynb`)
  - Exploratory data analysis
  - Visualization prototyping
  - Statistical model testing
- **Command**: `/home/miko/LAB/bin/mcp-jupyter`
- **Requires**: `JUPYTER_MCP_TOKEN` in secrets
- **Environment**: Works with `conda activate kanna` (Python 3.10)

---

### 🧠 AI & Research Tools (5 servers)

#### 6. **context7**
- **Purpose**: Up-to-date documentation for libraries
- **Use Cases**:
  - Get latest RDKit API docs (cheminformatics)
  - Check scikit-learn ML methods
  - Reference R packages (sf, brms, metafor)
  - Verify ggplot2 syntax for publication figures
- **Command**: `/home/miko/LAB/bin/mcp-context7`
- **Requires**: `CONTEXT7_API_KEY` in secrets

#### 7. **perplexity**
- **Purpose**: AI-powered web search
- **Use Cases**:
  - Find recent Sceletium research papers (2024-2025)
  - Search for clinical trial updates
  - Discover new analytical methods
  - Background research for thesis sections
- **Command**: `/home/miko/LAB/bin/mcp-perplexity`
- **Requires**: `PERPLEXITY_API_KEY` in secrets

#### 8. **sequential**
- **Purpose**: Sequential thinking & problem-solving
- **Use Cases**:
  - Break down complex QSAR modeling steps
  - Plan multi-step statistical analyses
  - Debug R/Python analysis pipelines
  - Structure thesis argumentation
- **Command**: `/home/miko/LAB/bin/mcp-sequential`

#### 9. **memory**
- **Purpose**: Persistent memory across sessions
- **Use Cases**:
  - Remember thesis structure and decisions
  - Track long-running analysis workflows
  - Maintain context for multi-day tasks
  - Store project-specific preferences
- **Command**: `/home/miko/LAB/bin/mcp-memory`

#### 10. **rag-query**
- **Purpose**: RAG-based documentation search
- **Use Cases**:
  - Search 142-paper literature corpus
  - Find specific methods in papers
  - Extract chemical structures from PDFs
  - Query research methodologies
- **Command**: `/home/miko/LAB/bin/mcp-rag-query`
- **Data Source**: `literature/pdfs/extractions-mineru/`

---

### 🌐 Web & Data Collection (3 servers)

#### 11. **fetch**
- **Purpose**: Web content fetching
- **Use Cases**:
  - Download research papers (PubMed, arXiv)
  - Fetch supplementary materials
  - Access online databases (PubChem, ChEMBL)
  - Retrieve documentation from academic sites
- **Command**: `/home/miko/LAB/bin/mcp-fetch`

#### 12. **cloudflare-browser**
- **Purpose**: Browser rendering & web scraping
- **Use Cases**:
  - Scrape JavaScript-heavy academic sites
  - Convert web pages to markdown for literature notes
  - Extract chemical structures from online databases
  - Screenshot academic figures for reference
- **Command**: `/home/miko/LAB/bin/mcp-cloudflare-browser`
- **OAuth**: Requires OAuth flow (browser-based)
- **Primary Tool**: `get_url_markdown` (HTML → clean markdown)

#### 13. **cloudflare-container**
- **Purpose**: Ephemeral execution sandbox
- **Use Cases**:
  - Test new Python/R analysis scripts safely
  - Run experimental QSAR models
  - Prototype data processing pipelines
  - Evaluate new cheminformatics tools
- **Command**: `/home/miko/LAB/bin/mcp-cloudflare-container`
- **OAuth**: Requires OAuth flow (browser-based)
- **Lifetime**: ~10 minutes per container

---

## Removed Servers (Not Needed for PhD)

The following servers from LAB's 19-server config are **intentionally excluded**:

- **reddit**: Not relevant for academic research
- **openapi**: No API documentation needs for thesis
- **cloudflare-docs**: Infrastructure tool, not research-focused
- **cloudflare-bindings**: Workers development (not needed)
- **cloudflare-observability**: Application monitoring (not needed)
- **cloudflare-radar**: Internet intelligence (not academic)
- **playwright**: Replaced by cloudflare-browser (better for research)

---

## Server Organization

Servers are ordered by **frequency of use** in PhD workflows:

1. **Core Infrastructure** (filesystem, git, github, sqlite) - Daily use
2. **Scientific Computing** (jupyter) - Weekly for analysis
3. **AI & Research** (context7, perplexity, sequential, memory, rag-query) - Frequent
4. **Web & Data** (fetch, cloudflare-browser, cloudflare-container) - As needed

---

## Environment Integration

### Conda Environments

```bash
# Python scientific computing
conda activate kanna  # RDKit, scikit-learn, spaCy
# Uses: jupyter, sqlite, context7

# R statistical analysis
conda activate r-gis  # sf, brms, metafor, tidyverse
# Uses: sqlite, context7, memory

# PDF extraction (GPU-accelerated)
conda activate mineru  # MinerU, PyTorch, transformers
# Uses: filesystem, fetch, cloudflare-browser
```

### Data Workflows

**Literature Corpus Pipeline**:
```
fetch/cloudflare-browser → Download PDFs
    ↓
filesystem → Store in literature/pdfs/
    ↓
mineru extraction → literature/pdfs/extractions-mineru/
    ↓
rag-query → Search corpus
```

**Analysis Pipeline**:
```
sqlite → Load data
    ↓
jupyter → Interactive analysis
    ↓
context7 → Check library docs
    ↓
git → Commit results
```

**Research Pipeline**:
```
perplexity → Find recent papers
    ↓
fetch → Download PDFs
    ↓
rag-query → Search corpus
    ↓
memory → Track findings
```

---

## Health Monitoring

**Check all servers**:
```bash
cd ~/LAB/projects/KANNA
claude
/mcp  # Should show 13 connected servers
```

**Individual health checks**:
```bash
# From LAB directory
~/LAB/bin/mcp-health-dashboard

# View logs
tail -f ~/LAB/logs/mcp-*.log
```

**Expected Status**: 13/13 servers operational (100%)

---

## Secret Requirements

**Required environment variables** (in `~/.config/codex/secrets.env`):

```bash
CONTEXT7_API_KEY=your_key              # For context7 server
GITHUB_PERSONAL_ACCESS_TOKEN=your_pat  # For github server
JUPYTER_MCP_TOKEN=your_token           # For jupyter server
PERPLEXITY_API_KEY=your_key            # For perplexity server
```

**Optional OAuth servers** (complete flow when first used):
- `cloudflare-browser` - Browser-based OAuth
- `cloudflare-container` - Browser-based OAuth

**Sync secrets**:
```bash
~/LAB/bin/populate-secrets-interactive.sh
```

---

## Troubleshooting

### Server Won't Connect

1. **Check logs**:
   ```bash
   cat ~/LAB/logs/mcp-<server-name>.log
   ```

2. **Verify secrets**:
   ```bash
   grep <KEY_NAME> ~/.config/codex/secrets.env
   ```

3. **Test wrapper directly**:
   ```bash
   /home/miko/LAB/bin/mcp-<server-name>
   ```

4. **Check dependencies**:
   ```bash
   # npm-based servers
   ls -la ~/LAB/mcp/<server-name>/node_modules

   # Python servers (uvx)
   which uvx  # Should be ~/.local/bin/uvx
   ```

### Cloudflare OAuth Issues

**Complete OAuth flow manually**:
```bash
# From LAB directory
~/LAB/bin/mcp-cloudflare-browser
# Follow browser prompts

# Check logs for success
tail -20 ~/LAB/logs/mcp-cloudflare-browser.log
```

**Clear OAuth cache** (if stuck):
```bash
rm -rf ~/.config/mcp-remote/
# Re-run OAuth flow
```

### RAG Query Not Finding Papers

**Verify extraction path**:
```bash
ls -la literature/pdfs/extractions-mineru/
# Should contain paper-name/auto/ directories

# Re-index if needed
bash tools/scripts/extract-pdfs-mineru-production.sh \
  literature/pdfs/BIBLIOGRAPHIE/ \
  literature/pdfs/extractions-mineru/
```

---

## Usage Examples

### Example 1: Literature Search
```bash
# In Claude Code session
"Search the literature corpus for Sceletium alkaloid biosynthesis studies"
# Uses: rag-query, context7, memory
```

### Example 2: QSAR Analysis
```bash
# In Claude Code session
"Run QSAR model on mesembrine derivatives, check RDKit docs for fingerprint methods"
# Uses: jupyter, context7, sqlite, git
```

### Example 3: Thesis Writing
```bash
# In Claude Code session
"Help me write Chapter 3 Section 3.4 on ethnobotanical index calculations"
# Uses: memory, filesystem, rag-query, git
```

### Example 4: Data Collection
```bash
# In Claude Code session
"Download supplementary materials from this PubChem link and extract chemical structures"
# Uses: fetch, cloudflare-browser, filesystem
```

---

## Maintenance

**Monthly tasks**:
1. Update MCP server versions (`npm update` in `~/LAB/mcp/*/`)
2. Rotate API keys (check expiration)
3. Review logs for errors (`~/LAB/logs/mcp-*.log`)
4. Verify health checks (100% operational)

**After adding new servers**:
1. Update this documentation
2. Add to `.gitignore` if needed
3. Test with `/mcp` command
4. Run health check validation

**Before major changes**:
1. Backup current config: `cp .mcp.json .mcp.json.backup`
2. Test in separate worktree: `~/LAB/worktrees/experimental/`
3. Validate with health dashboard
4. Commit changes with semantic message

---

## References

- **LAB MCP Infrastructure**: `~/LAB/docs/mcp/MCP-INFRASTRUCTURE-AUDIT-2025-10-08.md`
- **MCP Secrets Setup**: `~/LAB/docs/mcp/MCP-SECRETS-SETUP.md`
- **Cloudflare Integration**: `~/LAB/docs/mcp/MCP-CLOUDFLARE-INTEGRATION.md`
- **Health Monitoring**: `~/LAB/bin/mcp-health-dashboard`

---

**Configuration Optimized For**: 120,000-word PhD thesis on Sceletium tortuosum spanning botany, ethnobotany, phytochemistry, pharmacology, clinical research, and legal/ethical analysis.

**Last Validated**: October 2025 (Month 1 - Infrastructure Complete)
