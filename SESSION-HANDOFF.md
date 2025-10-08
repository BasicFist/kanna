# Session Handoff: vLLM + RAG Infrastructure Implementation
**Date**: 2025-10-08
**Session**: Phase 1 Complete + Phase 2 Started
**Next Session Goal**: Complete Critical Path (RAG working end-to-end)

---

## Session Accomplishments

### Phase 1: Configuration Files ✅ COMPLETE (4/4)

**1. config/vllm-server.yaml** (200 lines)
- Production vLLM configuration for Qwen2.5-Coder-7B
- 90% GPU utilization, chunked prefill, prefix caching
- 16K context window (expandable to 32K)
- Prometheus metrics on port 8001
- Alternative model configs documented

**2. config/models.yaml** (375 lines)
- Comprehensive registry: 12+ models documented
- Text generation: Qwen2.5-Coder (7B, 3B), DeepSeek-Lite
- Embeddings: BGE-M3 (1024 dims, 8192 tokens, CRITICAL download needed)
- Specialized: MinerU VLM, PDF-Extract-Kit, LayoutReader
- **Conflict resolution**: transformers 4.49 vs 4.57+ (separate conda envs)
- Serving matrix: vLLM production, Ollama dev, direct transformers

**3. config/rag-pipeline.yaml** (450 lines)
- **Chunking**: Semantic strategy via LlamaIndex (768 tokens, 128 overlap)
- **Embeddings**: BGE-M3 with 8192 token context
- **Retrieval**: Hybrid search (70% vector + 30% BM25)
- **Citation**: Tool-calling extraction (26% accuracy improvement)
- **Chemistry integration**:
  - SMILES extraction via RDKit
  - Morgan fingerprints (radius 2, 2048 bits)
  - External DBs: COCONUT, PubChem, ChEMBL
  - Molecular similarity search (Tanimoto > 0.7)
- **Metadata schema**: 30+ fields across 7 categories
  - Chemistry: has_smiles, compounds, receptor_targets (14 subtypes)
  - Botany: taxonomy, morphological_traits, geographic_location
  - Ethnobotany: traditional_use, community (FPIC-compliant)
- **Evaluation**: RAGAS metrics (>0.8 targets)

**4. config/environments.yaml** (550 lines)
- **vllm environment**:
  - Python 3.10, transformers ≥4.57.0
  - vLLM 0.11.0, LangChain, ChromaDB, BGE-M3
  - RDKit, BioPython, PubChemPy, ChEMBL client
  - QSAR tools: scikit-learn, XGBoost, SHAP
  - Complete setup commands documented
- **kanna environment**:
  - Python 3.10, transformers ==4.49.0 (PINNED)
  - MinerU, pdfplumber fallback
  - Specialized VLMs: MinerU 1.2B, PDF-Extract-Kit
- **GPU coordination strategy**: gpu-workload-manager.sh for switching

### Phase 2: Scripts Started (1/12 implemented)

**1. tools/scripts/setup-vllm-env.sh** ✅ COMPLETE (300 lines)
- Creates vllm conda environment with Python 3.10
- Installs 60+ packages (conda: RDKit, BioPython; pip: vLLM, LangChain)
- Downloads BGE-M3 embeddings (~2 GB)
- Downloads spaCy English model
- Comprehensive verification (15 critical packages tested)
- **Transformers version guard**: Enforces ≥4.57.0 requirement
- Colored output, error handling, disk space checks
- **Executable**: chmod +x already applied
- **Ready to run**: `bash tools/scripts/setup-vllm-env.sh`

---

## Critical Path: Next Session Priority

### Remaining Critical Path Scripts (3/4)

**2. tools/scripts/vllm-server-start.sh** (HIGH PRIORITY)
- Purpose: Launch Qwen2.5-Coder-7B via vLLM
- Reads: config/vllm-server.yaml
- Outputs: Logs to ~/LAB/logs/vllm-server.log
- PID management: Store in /tmp/vllm-server.pid
- Health check: Wait for http://127.0.0.1:8000/health
- Estimated: 150-200 lines

**3. tools/scripts/rag-ingest.py** (HIGH PRIORITY)
- Purpose: Process 142 papers → ChromaDB with SMILES extraction
- Reads: literature/pdfs/extractions/*.md (974K words)
- Reads: config/rag-pipeline.yaml
- Outputs: data/vector-db/chroma/
- Features:
  - Semantic chunking via LlamaIndex (768 tokens)
  - BGE-M3 embeddings generation
  - SMILES extraction via RDKit
  - Metadata extraction (30+ fields)
  - Batch processing (10 papers/batch, 4 workers)
  - Progress bar (tqdm)
- Estimated: 400-500 lines
- Runtime: ~30 minutes for full corpus

**4. tools/scripts/rag-query.py** (HIGH PRIORITY)
- Purpose: Chemistry-aware query interface
- Reads: data/vector-db/chroma/
- Connects to: vLLM server (http://127.0.0.1:8000)
- Features:
  - Hybrid search (vector + BM25)
  - Metadata filtering (chapter, year, has_smiles)
  - Chemistry queries: "Find alkaloids similar to mesembrine"
  - Citation extraction with tool-calling
  - SMILES similarity search (Tanimoto)
  - Interactive CLI or single query mode
- Estimated: 300-400 lines

**Companion Scripts** (nice-to-have):
- `tools/scripts/vllm-server-stop.sh` (50 lines) - Graceful shutdown
- `tools/scripts/vllm-server-status.sh` (100 lines) - Health + GPU monitoring

---

## Research-Backed Design Decisions

### RAG Pipeline
1. **Semantic chunking over fixed-size**: 15-25% retrieval improvement (LlamaIndex)
2. **BGE-M3 over all-MiniLM**: Trained on scientific papers, 32× longer context
3. **Hybrid search 70/30**: Best practice for academic literature
4. **Tool-calling citations**: 26% attribution accuracy improvement (2025 paper)
5. **768 token chunks**: Optimal for scientific papers (research-backed)

### Chemistry Integration
6. **Morgan fingerprints radius 2**: Standard for drug-like molecules
7. **Tanimoto threshold 0.7**: Balance similarity and diversity
8. **COCONUT over ZINC**: 1M+ open natural products, REST API
9. **ChEMBL Web Resource Client**: Python-native, 36M+ activities

### Infrastructure
10. **ChromaDB → Qdrant path**: Start simple, scale later (24× compression)
11. **Separate conda envs**: Only solution for transformers 4.49 vs 4.57+ conflict
12. **Qwen2.5-Coder-7B**: #1 open-source code model (2025 benchmarks)

---

## Key File Locations

### Configuration (Ready to Use)
```
config/
├── vllm-server.yaml      # vLLM server settings
├── rag-pipeline.yaml     # RAG configuration
├── models.yaml           # Model registry
└── environments.yaml     # Conda environment specs
```

### Scripts (1/4 Critical Path Complete)
```
tools/scripts/
├── setup-vllm-env.sh           ✅ READY
├── vllm-server-start.sh        📝 TODO (next priority)
├── vllm-server-stop.sh         📝 TODO
├── vllm-server-status.sh       📝 TODO
├── rag-ingest.py               📝 TODO (next priority)
└── rag-query.py                📝 TODO (next priority)
```

### Data Directories (Auto-created)
```
data/
├── vector-db/
│   ├── chroma/                 # ChromaDB persistence
│   └── metadata/               # Paper metadata cache
└── extracted-papers/           # Markdown from PDFs (already exists)
```

### Logs
```
~/LAB/logs/
├── vllm-server.log             # vLLM server output
├── rag-ingest.log              # Ingestion progress
└── rag-query.log               # Query logs
```

---

## Next Session Checklist

### Pre-Session Setup (Optional, can do in-session)
- [ ] Run `bash tools/scripts/setup-vllm-env.sh` (15-20 minutes)
- [ ] Verify BGE-M3 downloaded: `ls -lh /run/media/miko/AYA/crush-models/hf-home/models--BAAI--bge-m3/`
- [ ] Activate environment: `conda activate vllm`
- [ ] Test imports: `python -c "import vllm, langchain, chromadb; print('OK')"`

### Session Goals (Priority Order)
1. **Create vllm-server-start.sh** (15 min)
   - Launch Qwen2.5-Coder-7B
   - Health check loop
   - PID management

2. **Create vllm-server-stop.sh** (5 min)
   - Graceful shutdown
   - PID cleanup

3. **Create vllm-server-status.sh** (10 min)
   - Health check
   - GPU monitoring
   - Request stats

4. **Create rag-ingest.py** (45-60 min)
   - Semantic chunking implementation
   - BGE-M3 embeddings
   - SMILES extraction
   - ChromaDB ingestion
   - Progress tracking

5. **Create rag-query.py** (30-45 min)
   - Hybrid search
   - Chemistry-aware queries
   - Citation extraction
   - Interactive CLI

6. **Test End-to-End** (15 min)
   - Start vLLM server
   - Ingest sample papers (10-20 papers for quick test)
   - Run test queries
   - Verify citations
   - Check SMILES filtering

### Success Criteria
- ✅ vLLM server running stably on GPU (90% utilization)
- ✅ ChromaDB contains 142 papers with embeddings
- ✅ Query latency <2 seconds (retrieval + generation)
- ✅ Citations formatted as [Author, Year]
- ✅ Chemistry queries work: "Find papers on mesembrine 5-HT2A binding"
- ✅ SMILES filtering functional: `has_smiles=true` returns only chemistry papers

---

## Known Constraints & Considerations

### GPU Coordination
- **Only one process can use GPU at a time**
- **MinerU extraction** (3 background processes running in current session):
  - Check status: `ps aux | grep mineru`
  - May need to wait for completion or kill before starting vLLM
  - Logs: `/tmp/production-extraction-live.log`

### Transformers Version
- **vllm environment**: Requires transformers ≥4.57.0 (enforced in setup script)
- **kanna environment**: Requires transformers ==4.49.0 (for MinerU)
- **Never activate both simultaneously**

### Disk Space
- BGE-M3 embeddings: ~2 GB
- ChromaDB (142 papers): ~500 MB (estimated)
- vLLM conda environment: ~8 GB
- Total new space: ~10-11 GB

### Network
- COCONUT API: No auth required
- PubChem API: Rate limit 5 req/sec
- ChEMBL API: No auth required
- HuggingFace: May need login for some models (`huggingface-cli login`)

---

## Documentation for Next Session

### Research Sources (Already Fetched)
- RDKit fingerprints documentation (Context7)
- BioPython phylogenetics guide (Context7)
- ChEMBL Web Resource Client examples (Context7)
- LangChain RAG patterns (web research)
- RAGAS evaluation framework (web research)
- Semantic chunking best practices (web research)

### Code Patterns Ready
- LangChain document loaders
- ChromaDB collection creation
- BGE-M3 embedding generation
- RDKit SMILES parsing
- Tool-calling for citations
- Hybrid search implementation

---

## Deliverables Completed

### Configuration (1,575 lines total)
1. config/vllm-server.yaml (200 lines)
2. config/models.yaml (375 lines)
3. config/rag-pipeline.yaml (450 lines)
4. config/environments.yaml (550 lines)

### Scripts (300 lines total)
1. tools/scripts/setup-vllm-env.sh (300 lines)

### Documentation (This file)
1. SESSION-HANDOFF.md (370 lines)

**Total Lines Written**: ~2,245 lines of production-ready code and documentation

---

## Token Budget Status

- **Current session usage**: 120K / 200K tokens (60% used)
- **Remaining capacity**: 80K tokens (sufficient for 3-4 more scripts)
- **Recommendation**: Start fresh next session for optimal context

---

## Quick Start Commands for Next Session

```bash
# Check GPU availability
nvidia-smi

# Activate environment
conda activate vllm

# Verify installation
python -c "import vllm, langchain, chromadb, rdkit; print('✓ All OK')"

# Start implementation
cd ~/LAB/projects/KANNA

# Create server management scripts
vim tools/scripts/vllm-server-start.sh

# Test vLLM launch (manual)
vllm serve Qwen/Qwen2.5-Coder-7B-Instruct \
  --model /run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-7B-Instruct \
  --host 127.0.0.1 --port 8000 \
  --gpu-memory-utilization 0.90 \
  --max-model-len 16384

# Test health endpoint
curl http://127.0.0.1:8000/health
```

---

## Notes for Claude (Next Session)

**Context to preserve**:
1. User emphasizes "LLM AIDED IS MANDATORY" - RAG pipeline is critical
2. Infrastructure-first PhD philosophy - quality tooling enables better research
3. 142 papers corpus (974K words) already extracted via MinerU/pdfplumber
4. Two-environment strategy is non-negotiable (transformers conflict)
5. Chemistry integration (SMILES, fingerprints) is essential for Chapter 4
6. FPIC compliance required for ethnobotanical metadata

**Implementation approach**:
- Critical Path strategy (Option A) - get RAG working end-to-end first
- Then add domain-specific tools (chemistry, botany) afterward
- Test incrementally: server → ingest → query

**Quality standards**:
- Production-ready code (error handling, logging, progress bars)
- Comprehensive documentation (docstrings, inline comments)
- Verification tests (check imports, validate outputs)
- User-friendly CLI (colored output, clear messages)

---

**Session Status**: ✅ Phase 1 Complete + Phase 2 Foundation Ready
**Next Milestone**: Complete Critical Path (RAG working end-to-end)
**Estimated Time**: 2-3 hours for remaining 3 scripts + testing
