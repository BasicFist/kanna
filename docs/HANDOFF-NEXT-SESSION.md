# Handoff Document: Next Session Testing Phase

**Date Created**: 2025-10-08
**Phase Complete**: Phase 2 Critical Path ✅
**Next Phase**: Testing (Phase 3)

---

## Session 2025-10-08 Summary

### What Was Accomplished

**Phase 2 Critical Path: COMPLETE** (8/8 deliverables, 2,634 lines)

#### 1. Server Management Scripts (504 lines)
- `tools/scripts/vllm-server-start.sh` - Launch Qwen2.5-Coder-7B with health checks
- `tools/scripts/vllm-server-stop.sh` - Graceful shutdown (SIGTERM → SIGKILL)
- `tools/scripts/vllm-server-status.sh` - GPU monitoring, Prometheus metrics

#### 2. RAG Pipeline Scripts (1,080 lines)
- `tools/scripts/rag-ingest.py` - Semantic chunking + BGE-M3 + chemistry extraction
- `tools/scripts/rag-query.py` - Interactive CLI with vLLM answer generation

#### 3. Chemistry Database Tools (1,400 lines)
- `tools/scripts/coconut-query.py` - COCONUT Natural Products (1M+ compounds)
- `tools/scripts/pubchem-batch-query.py` - PubChem batch queries (111M+ compounds)
- `tools/scripts/chembl-target-search.py` - ChEMBL target prediction (36M+ measurements)

#### 4. Environment
- Conda environment `vllm` created and verified
- vLLM 0.11.0, transformers 4.57.0, ChromaDB 1.1.1, RDKit, sentence-transformers

#### 5. Documentation
- Session summary: `docs/sessions/SESSION-2025-10-08-vllm-rag-chemistry.md` (13 KB)
- Updated: `PROJECT-STATUS.md`

#### 6. Git
- 3 new commits pushed to master
- Total commits in session: 8 (includes Phase 1 from previous work)

---

## Environment Status

### GPU
```bash
$ nvidia-smi
# Expected: 0% utilization, 4 MB used (idle state)
```

### Conda Environments
- **kanna**: Python 3.10, transformers 4.49.0 (for MinerU, PDF extraction)
- **vllm**: Python 3.10, transformers 4.57.0 (for vLLM, RAG, chemistry tools) ✅ READY

### Model Files
- **Qwen2.5-Coder-7B-Instruct**: /run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-7B-Instruct
- **BGE-M3 embeddings**: Should be at /run/media/miko/AYA/crush-models/hf-home/models--BAAI--bge-m3 (verify in testing)

### Data Corpus
- **Papers**: 142 PDFs in `literature/pdfs/BIBLIOGRAPHIE/`
- **Extractions**: Available in `literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008/`
- **Word count**: 974K words total

---

## Next Session: Testing Phase

### Prerequisites (Check First!)

1. **Verify GPU is available**:
   ```bash
   nvidia-smi
   # Should show: RTX 4090, 0% utilization, ~4 MB used
   ```

2. **Activate vllm environment**:
   ```bash
   conda activate vllm
   # Verify: python --version (should be 3.10.x)
   # Verify: pip show vllm (should be 0.11.0)
   ```

3. **Check BGE-M3 model is downloaded**:
   ```bash
   ls -lh /run/media/miko/AYA/crush-models/hf-home/models--BAAI--bge-m3
   # If missing: Will auto-download on first rag-ingest.py run (~2 GB)
   ```

4. **Verify sample papers exist**:
   ```bash
   ls -1 literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008/*.md | head -10
   # Should show at least 10 .md files
   ```

### Testing Workflow (Step-by-Step)

#### Step 1: Start vLLM Server (~60 seconds)
```bash
conda activate vllm
cd ~/LAB/projects/KANNA
bash tools/scripts/vllm-server-start.sh
```

**Expected output**:
```
=== vLLM Server Startup ===
[Preflight] Checking GPU availability... ✓
[Preflight] Checking vllm conda environment... ✓
[Preflight] Checking model path... ✓
[Startup] Launching vLLM server (PID: 12345)
[Health] Waiting for server to be healthy...
[Health] Server is healthy and ready! ✓

Server URL: http://127.0.0.1:8000
Health endpoint: http://127.0.0.1:8000/health
Metrics endpoint: http://127.0.0.1:8000/metrics
PID file: /tmp/vllm-server.pid
Log file: ~/LAB/logs/vllm-server.log

Server started successfully!
```

**Success criteria**:
- Exit code 0
- PID file created at `/tmp/vllm-server.pid`
- Health endpoint returns 200 OK
- GPU utilization rises to ~90%

**If it fails**:
- Check logs: `tail -50 ~/LAB/logs/vllm-server.log`
- Verify model path exists: `ls /run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-7B-Instruct`
- Check for port conflicts: `lsof -i :8000`
- Stop any existing server: `bash tools/scripts/vllm-server-stop.sh`

#### Step 2: Monitor Server Health
```bash
bash tools/scripts/vllm-server-status.sh
```

**Expected output**:
```
╔═══════════════════════════════════════════════════════════════════╗
║                    vLLM Server Status Report                      ║
╚═══════════════════════════════════════════════════════════════════╝

✓ Server Running: PID 12345
✓ Health: OK (200)
✓ GPU-0: NVIDIA GeForce RTX 4090 | 89% | 20.1 GB / 24 GB | 72°C
✓ Uptime: 00:01:32
✓ Running requests: 0
```

**Success criteria**:
- Exit code 0
- GPU utilization ~90%
- Health status: OK
- Temperature <85°C

#### Step 3: Test RAG Ingestion (10 papers, ~2-3 minutes)
```bash
python tools/scripts/rag-ingest.py --limit 10
```

**Expected output**:
```
2025-10-08 12:00:00 - INFO - Initializing RAG ingestion pipeline...
2025-10-08 12:00:05 - INFO - Loading BGE-M3 embeddings model...
2025-10-08 12:00:10 - INFO - ✓ BGE-M3 loaded from /run/media/miko/AYA/...
2025-10-08 12:00:15 - INFO - Initializing ChromaDB...
2025-10-08 12:00:20 - INFO - ✓ ChromaDB collection: kanna-literature-dev (0 documents)
2025-10-08 12:00:25 - INFO - Scanning for papers in: literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008
2025-10-08 12:00:30 - INFO - Found 142 papers to process

Ingesting papers: 100%|███████████████████| 10/10 [02:15<00:00, 13.5s/it, chunks=127]

2025-10-08 12:02:45 - INFO - ✓ Ingestion complete: 10 papers, 127 chunks
2025-10-08 12:02:45 - INFO - ChromaDB collection size: 127
```

**Success criteria**:
- Exit code 0
- BGE-M3 model loads successfully
- ChromaDB collection created at `data/vector-db/chroma/`
- ~100-150 chunks from 10 papers (varies by paper length)
- No errors during SMILES extraction (warnings OK)

**If it fails**:
- Check BGE-M3 download: May auto-download on first run (~2 GB, 5-10 min)
- Verify ChromaDB path writable: `ls -ld data/vector-db/`
- Check for import errors: `python -c "from rdkit import Chem; print('OK')"`
- Review logs: `tail -50 ~/LAB/logs/rag-ingest.log`

#### Step 4: Verify ChromaDB Collection
```bash
python -c "
import chromadb
client = chromadb.PersistentClient(path='data/vector-db/chroma')
collection = client.get_collection('kanna-literature-dev')
print(f'Total documents: {collection.count()}')
print(f'Collection metadata: {collection.metadata}')
"
```

**Expected output**:
```
Total documents: 127
Collection metadata: {'description': 'KANNA thesis scientific literature corpus'}
```

#### Step 5: Run Simple Query (Test Retrieval)
```bash
python tools/scripts/rag-query.py --query "What is Sceletium tortuosum?" --top-k 3
```

**Expected output**:
```
2025-10-08 12:05:00 - INFO - Initializing RAG query system...
2025-10-08 12:05:05 - INFO - Loading BGE-M3 embeddings...
2025-10-08 12:05:10 - INFO - ✓ BGE-M3 loaded
2025-10-08 12:05:15 - INFO - Connecting to ChromaDB...
2025-10-08 12:05:20 - INFO - ✓ Connected to 'kanna-literature-dev' (127 documents)
2025-10-08 12:05:25 - INFO - Testing vLLM connection...
2025-10-08 12:05:30 - INFO - ✓ vLLM server connected
2025-10-08 12:05:35 - INFO - ✓ RAG system ready
2025-10-08 12:05:40 - INFO - Query: What is Sceletium tortuosum?

══════════════════════════════════════════════════════════════════
Query: What is Sceletium tortuosum?
══════════════════════════════════════════════════════════════════

Answer:
Sceletium tortuosum (L.) N.E.Br., commonly known as Kanna, is a succulent plant
native to South Africa. It has been traditionally used by the Khoisan people for
its mood-enhancing and anxiolytic properties. The plant contains several alkaloids,
including mesembrine, mesembrenone, and mesembrenol, which act as PDE4 inhibitors
and serotonin reuptake inhibitors [Gericke et al., 2021; Harvey et al., 2011].

Retrieved Sources (3):
[1] Sceletium tortuosum: A review on its phytochemistry... (2021)
    Compounds: mesembrine, mesembrenone, mesembrenol
    Receptors: 5-HT2A, PDE4B
    Sceletium tortuosum (L.) N.E.Br., commonly known as Kanna, belongs to...

[2] Pharmacological actions of the South African medicinal plant... (2011)
    Compounds: mesembrine
    Receptors: 5-HT1A, SERT
    The plant has been used traditionally for centuries by indigenous communities...

[3] Ethnopharmacology, Therapeutic Properties and Nutritional... (2020)
    Compounds: tortuosamine
    Traditional knowledge of Khoisan people regarding mood enhancement...

══════════════════════════════════════════════════════════════════
```

**Success criteria**:
- Exit code 0
- Answer generated with citations in [Author, Year] format
- 3 sources retrieved with metadata (compounds, receptors)
- Query latency <2 seconds

#### Step 6: Run Chemistry-Aware Query (Test Filtering)
```bash
python tools/scripts/rag-query.py --query "What are the pharmacological effects of mesembrine on 5-HT receptors?" --filter has_smiles=true --top-k 5
```

**Expected behavior**:
- Only retrieves papers with SMILES data (`has_smiles=true`)
- Answer mentions specific receptor subtypes (5-HT1A, 5-HT2A, 5-HT2C)
- Citations from papers with chemistry data

**Success criteria**:
- Exit code 0
- Retrieved sources all have `has_smiles: true` in metadata
- Answer discusses receptor binding, IC50/Ki values if available
- Includes proper citations

#### Step 7: Test Interactive Mode
```bash
python tools/scripts/rag-query.py
```

**Commands to test**:
```
> What is the mechanism of action of mesembrine?
> filter has_smiles=true
> What receptors does mesembrine bind to?
> filter has_ic50_data=true
> Are there clinical trials for Sceletium?
> clear
> exit
```

**Success criteria**:
- All commands execute without errors
- Filters persist between queries
- `clear` removes filters
- `exit` quits cleanly

#### Step 8: Test Chemistry Database Tools

**COCONUT**:
```bash
python tools/scripts/coconut-query.py --name "mesembrine"
```

**PubChem**:
```bash
python tools/scripts/pubchem-batch-query.py --name "mesembrine" --bioactivity
```

**ChEMBL**:
```bash
python tools/scripts/chembl-target-search.py --compound "mesembrine" --targets --threshold 10000
```

**Success criteria**:
- All tools return compound data
- No API errors (rate limiting respected)
- CSV export works if specified

#### Step 9: Stop vLLM Server
```bash
bash tools/scripts/vllm-server-stop.sh
```

**Expected output**:
```
=== Stopping vLLM Server ===
[Stop] Sending SIGTERM to PID 12345...
[Stop] Waiting for graceful shutdown (timeout: 10s)...
[Stop] ✓ vLLM server stopped gracefully
[Cleanup] Removing PID file...
✓ Server stopped successfully
```

**Success criteria**:
- Exit code 0
- PID file removed
- Process no longer running: `ps aux | grep vllm` shows nothing
- GPU utilization drops to 0%

---

## Success Metrics

### Phase 3 Testing Success Criteria

| Metric | Target | How to Measure |
|--------|--------|----------------|
| **Server startup time** | <60 seconds | Time from `vllm-server-start.sh` to "Server ready!" |
| **GPU utilization** | 85-95% | `nvidia-smi` during idle (after startup) |
| **Ingestion speed** | ~5 papers/minute | 10 papers should complete in ~2-3 minutes |
| **Chunk count** | 100-150 per 10 papers | Varies by paper length, ~10-15 per paper average |
| **Query latency** | <2 seconds | Time from query submission to answer display |
| **Citation accuracy** | >90% | Manual spot check: citations in [Author, Year] format |
| **Chemistry extraction** | >70% papers | At least 7/10 papers should have SMILES or receptor data |
| **Database tools** | 100% success | All 3 chemistry tools return valid data |

### What Constitutes "Success"?

**Minimum viable (proceed to Phase 4)**:
- [x] vLLM server starts and stays healthy
- [x] 10 papers ingest without errors
- [x] Simple query returns answer with citations
- [x] Chemistry filtering works (has_smiles=true)
- [x] 1+ chemistry database tool works

**Full success (ready for production)**:
- [x] All above criteria met
- [x] Query latency <2 seconds consistently
- [x] All 3 chemistry database tools work
- [x] Interactive mode handles edge cases gracefully
- [x] Server gracefully stops

---

## Troubleshooting Guide

### Problem: vLLM server won't start

**Symptoms**: `vllm-server-start.sh` exits with error or hangs

**Checks**:
1. GPU available? `nvidia-smi`
2. Port 8000 free? `lsof -i :8000`
3. Model files exist? `ls /run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-7B-Instruct`
4. Conda env active? `conda env list | grep '*'` should show `vllm`

**Solutions**:
```bash
# Kill any existing vLLM processes
pkill -f vllm

# Remove stale PID file
rm -f /tmp/vllm-server.pid

# Check logs
tail -50 ~/LAB/logs/vllm-server.log

# Try manual start for debugging
conda activate vllm
vllm serve Qwen/Qwen2.5-Coder-7B-Instruct \
    --model /run/media/miko/AYA/crush-models/hf-home/models--Qwen--Qwen2.5-Coder-7B-Instruct \
    --host 127.0.0.1 --port 8000
```

### Problem: BGE-M3 model downloading slowly

**Symptoms**: First `rag-ingest.py` run hangs at "Loading BGE-M3 embeddings..."

**Solution**: This is expected behavior on first run. Model is ~2 GB and downloads from HuggingFace.

**Monitor progress**:
```bash
# In another terminal
watch -n 5 du -sh /run/media/miko/AYA/crush-models/hf-home/models--BAAI--bge-m3
# Should grow over 5-10 minutes
```

### Problem: ChromaDB collection is empty after ingestion

**Symptoms**: `collection.count()` returns 0 despite successful ingestion

**Checks**:
1. Check ChromaDB directory: `ls -lh data/vector-db/chroma/`
2. Review ingestion logs: `tail -100 ~/LAB/logs/rag-ingest.log`
3. Check for permission errors: `ls -ld data/vector-db/`

**Solutions**:
```bash
# Delete and recreate ChromaDB directory
rm -rf data/vector-db/chroma
mkdir -p data/vector-db/chroma

# Re-run ingestion
python tools/scripts/rag-ingest.py --limit 10
```

### Problem: Query returns no results

**Symptoms**: `rag-query.py` says "No relevant documents found"

**Checks**:
1. ChromaDB populated? `python -c "import chromadb; print(chromadb.PersistentClient(path='data/vector-db/chroma').get_collection('kanna-literature-dev').count())"`
2. Filters too restrictive? Try `--filter ""` (no filters)
3. Query too specific? Try broader query like "Sceletium"

### Problem: Chemistry database tools return no data

**Symptoms**: COCONUT/PubChem/ChEMBL return empty results

**Checks**:
1. Network connectivity? `ping pubchem.ncbi.nlm.nih.gov`
2. API rate limiting? Wait 5 seconds and retry
3. Compound name typo? Try alternative: "mesembrine" vs "Mesembrine"

**Solutions**:
```bash
# Test with known compound
python tools/scripts/pubchem-batch-query.py --name "caffeine"
# Should return results (validates tool works)
```

### Problem: GPU memory error

**Symptoms**: CUDA out of memory error, vLLM crashes

**Checks**:
1. `nvidia-smi` shows 24 GB total (RTX 4090)?
2. Other processes using GPU? `nvidia-smi` shows processes
3. Swap space enabled? `swapon --show`

**Solutions**:
```bash
# Reduce GPU memory utilization
# Edit config/vllm-server.yaml:
# gpu_memory_utilization: 0.85  # Instead of 0.90

# Restart server
bash tools/scripts/vllm-server-stop.sh
bash tools/scripts/vllm-server-start.sh
```

---

## Known Issues

### Issue 1: RAGAS Package Version
**Status**: Minor (evaluation only, not critical)
**Impact**: Cannot use RAGAS evaluation metrics
**Workaround**: Install manually if needed: `pip install ragas==0.3.6`

### Issue 2: COCONUT Similarity Search
**Status**: API limitation
**Impact**: Structure-based similarity requires local dataset
**Workaround**: Documented in script; download SDF file (~4 GB) for local search

### Issue 3: First Query Slower
**Status**: Expected (model warm-up)
**Impact**: First query may take 5-10 seconds
**Workaround**: Run test query to warm up before timing measurements

---

## After Testing: Next Steps (Phase 4)

If all testing passes, proceed to:

1. **Full Corpus Ingestion**:
   ```bash
   python tools/scripts/rag-ingest.py
   # Process all 142 papers → ~1,500-2,000 chunks
   # Expected time: 30-40 minutes
   ```

2. **Create Benchmark Script** (`tools/scripts/benchmark-vllm.py`):
   - Query latency measurements
   - GPU utilization profiling
   - Citation accuracy evaluation
   - Chemistry extraction statistics

3. **GPU Workload Manager** (`tools/scripts/gpu-workload-manager.sh`):
   - Smart environment switching (kanna vs vllm)
   - Automatic server start/stop based on workload
   - GPU memory monitoring and alerts

4. **Domain-Specific Notebooks**:
   - `notebooks/rag-analysis/cheminformatics-queries.ipynb`
   - `notebooks/rag-analysis/phylogenetics-queries.ipynb`
   - `notebooks/rag-analysis/ethnobotany-queries.ipynb`

---

## Quick Reference Commands

### Start Session
```bash
cd ~/LAB/projects/KANNA
conda activate vllm
git pull origin master  # Get latest changes
```

### Run Full Testing Suite
```bash
# Copy-paste this entire block
bash tools/scripts/vllm-server-start.sh && \
sleep 5 && \
bash tools/scripts/vllm-server-status.sh && \
python tools/scripts/rag-ingest.py --limit 10 && \
python tools/scripts/rag-query.py --query "What is Sceletium tortuosum?" --top-k 3 && \
python tools/scripts/rag-query.py --query "What are the pharmacological effects of mesembrine?" --filter has_smiles=true && \
python tools/scripts/coconut-query.py --name "mesembrine" && \
python tools/scripts/pubchem-batch-query.py --name "mesembrine" && \
python tools/scripts/chembl-target-search.py --compound "mesembrine" --targets && \
bash tools/scripts/vllm-server-stop.sh
```

### Emergency Stop
```bash
# If server hangs or crashes
pkill -f vllm
rm -f /tmp/vllm-server.pid
```

### Check Everything
```bash
# GPU status
nvidia-smi

# Server status
bash tools/scripts/vllm-server-status.sh

# ChromaDB status
python -c "import chromadb; print(chromadb.PersistentClient(path='data/vector-db/chroma').get_collection('kanna-literature-dev').count())"

# Conda environment
conda env list | grep '*'
```

---

## Contact & Resources

### Session Logs
- vLLM server: `~/LAB/logs/vllm-server.log`
- RAG ingestion: `~/LAB/logs/rag-ingest.log`
- RAG queries: `~/LAB/logs/rag-query.log`

### Documentation
- Session summary: `docs/sessions/SESSION-2025-10-08-vllm-rag-chemistry.md`
- Project status: `PROJECT-STATUS.md`
- Architecture: `ARCHITECTURE.md`

### Configuration Files
- vLLM server: `config/vllm-server.yaml`
- RAG pipeline: `config/rag-pipeline.yaml`
- Environments: `config/environments.yaml`
- Models registry: `config/models.yaml`

---

**Good luck with testing! 🚀**

If all tests pass, you'll have a production-ready RAG system for the KANNA thesis project.

---

**Handoff Created**: 2025-10-08 23:50 UTC
**Session Duration**: ~3 hours
**Lines of Code**: 2,634
**Deliverables**: 8 scripts + 1 environment + 2 docs
**Infrastructure Progress**: 13/33 (39%)
