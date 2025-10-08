#!/usr/bin/env bash
# Setup vLLM Conda Environment for KANNA Thesis Project
# Creates production RAG environment with vLLM, LangChain, ChromaDB, BGE-M3, RDKit
# Last updated: 2025-10-08
#
# Usage: bash tools/scripts/setup-vllm-env.sh
# Estimated time: 15-20 minutes
# Disk space required: ~8 GB

set -Eeuo pipefail

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

PROJECT_ROOT="${LAB_HOME:-$HOME/LAB}/projects/KANNA"
CONDA_ENV_NAME="vllm"
PYTHON_VERSION="3.10"
MODELS_DIR="/run/media/miko/AYA/crush-models/hf-home"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ═══════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log_error "$1 not found in PATH"
        return 1
    fi
    return 0
}

# ═══════════════════════════════════════════════════════════════
# Preflight Checks
# ═══════════════════════════════════════════════════════════════

log_info "Running preflight checks..."

# Check conda
if ! check_command conda; then
    log_error "conda not installed. Install Miniconda/Anaconda first."
    exit 1
fi

# Check CUDA (optional, but recommended)
if ! command -v nvidia-smi &> /dev/null; then
    log_warning "nvidia-smi not found. GPU support may not work."
else
    log_info "CUDA available: $(nvidia-smi --query-gpu=name --format=csv,noheader)"
fi

# Check disk space
AVAILABLE_SPACE=$(df -BG "$HOME" | tail -1 | awk '{print $4}' | sed 's/G//')
if [ "$AVAILABLE_SPACE" -lt 10 ]; then
    log_warning "Low disk space: ${AVAILABLE_SPACE}GB available. Need at least 10GB."
fi

# Check if environment already exists
if conda env list | grep -q "^${CONDA_ENV_NAME} "; then
    log_warning "Conda environment '${CONDA_ENV_NAME}' already exists."
    read -p "Do you want to remove and recreate it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "Removing existing environment..."
        conda env remove -n "${CONDA_ENV_NAME}" -y
    else
        log_info "Exiting. Activate existing environment with: conda activate ${CONDA_ENV_NAME}"
        exit 0
    fi
fi

log_success "Preflight checks passed"

# ═══════════════════════════════════════════════════════════════
# Step 1: Create Conda Environment
# ═══════════════════════════════════════════════════════════════

log_info "Step 1/5: Creating conda environment '${CONDA_ENV_NAME}' with Python ${PYTHON_VERSION}..."

conda create -n "${CONDA_ENV_NAME}" python="${PYTHON_VERSION}" -y

if [ $? -ne 0 ]; then
    log_error "Failed to create conda environment"
    exit 1
fi

log_success "Conda environment created"

# ═══════════════════════════════════════════════════════════════
# Step 2: Install Conda Packages
# ═══════════════════════════════════════════════════════════════

log_info "Step 2/5: Installing conda packages (this may take 5-10 minutes)..."

# CRITICAL: RDKit MUST be installed via conda (not pip)
conda install -n "${CONDA_ENV_NAME}" -c conda-forge -y \
    rdkit \
    biopython \
    numpy \
    pandas \
    scikit-learn \
    scipy \
    matplotlib \
    seaborn \
    jupyter \
    jupyterlab \
    ipywidgets \
    spacy \
    nltk \
    beautifulsoup4 \
    lxml \
    requests \
    pyyaml \
    tqdm \
    xgboost

if [ $? -ne 0 ]; then
    log_error "Failed to install conda packages"
    exit 1
fi

# Install IQ-TREE (optional, for phylogenetics)
log_info "Installing IQ-TREE from bioconda (optional)..."
conda install -n "${CONDA_ENV_NAME}" -c bioconda iqtree -y || log_warning "IQ-TREE installation failed (optional)"

log_success "Conda packages installed"

# ═══════════════════════════════════════════════════════════════
# Step 3: Install Pip Packages
# ═══════════════════════════════════════════════════════════════

log_info "Step 3/5: Installing pip packages..."

# Activate environment for pip installs
eval "$(conda shell.bash hook)"
conda activate "${CONDA_ENV_NAME}"

# Core vLLM + transformers (CRITICAL: transformers >=4.57.0)
log_info "Installing vLLM and transformers..."
pip install vllm==0.11.0
pip install "transformers>=4.57.0"

# RAG Stack
log_info "Installing RAG stack (LangChain, ChromaDB)..."
pip install langchain langchain-community langchain-openai
pip install "llama-index>=0.9.0"
pip install "chromadb>=0.6.0"
pip install "sentence-transformers>=2.2.0"

# Chemistry APIs
log_info "Installing chemistry tools..."
pip install "pubchempy>=1.0.5"
pip install "chembl_webresource_client>=0.10.0"

# ML & Evaluation
log_info "Installing ML and evaluation tools..."
pip install "shap>=0.42.0"
pip install "ragas>=0.5.0"

# Utilities
log_info "Installing utilities..."
pip install python-dotenv pydantic "fastapi>=0.104.0" "uvicorn>=0.24.0"
pip install prometheus-client loguru

if [ $? -ne 0 ]; then
    log_error "Failed to install pip packages"
    exit 1
fi

log_success "Pip packages installed"

# ═══════════════════════════════════════════════════════════════
# Step 4: Download Models
# ═══════════════════════════════════════════════════════════════

log_info "Step 4/5: Downloading models..."

# Download BGE-M3 embeddings (~2 GB)
log_info "Downloading BGE-M3 embeddings (this may take 5-10 minutes)..."

BGE_M3_DIR="${MODELS_DIR}/models--BAAI--bge-m3"

if [ -d "$BGE_M3_DIR" ]; then
    log_info "BGE-M3 already exists at $BGE_M3_DIR"
else
    if check_command huggingface-cli; then
        huggingface-cli download BAAI/bge-m3 --local-dir "$BGE_M3_DIR"
    else
        log_warning "huggingface-cli not found. Install with: pip install huggingface-hub"
        log_warning "Skipping BGE-M3 download. You can download manually later."
    fi
fi

# Download spaCy English model
log_info "Downloading spaCy English model..."
python -m spacy download en_core_web_sm || log_warning "spaCy model download failed (optional)"

log_success "Models downloaded"

# ═══════════════════════════════════════════════════════════════
# Step 5: Verification
# ═══════════════════════════════════════════════════════════════

log_info "Step 5/5: Verifying installation..."

VERIFY_SCRIPT=$(cat <<'EOF'
import sys

def check(name, import_stmt, version_attr=None):
    try:
        exec(import_stmt)
        if version_attr:
            version = eval(version_attr)
            print(f"✓ {name}: {version}")
        else:
            print(f"✓ {name}: OK")
        return True
    except Exception as e:
        print(f"✗ {name}: FAILED ({e})")
        return False

print("Verifying critical packages:")
print("-" * 50)

results = []

# Core ML/AI
results.append(check("vLLM", "import vllm", "vllm.__version__"))
results.append(check("Transformers", "import transformers", "transformers.__version__"))
results.append(check("PyTorch", "import torch", "torch.__version__"))

# RAG Stack
results.append(check("LangChain", "import langchain", "langchain.__version__"))
results.append(check("ChromaDB", "import chromadb", "chromadb.__version__"))
results.append(check("Sentence Transformers", "import sentence_transformers"))

# Chemistry
results.append(check("RDKit", "from rdkit import Chem; mol = Chem.MolFromSmiles('CCO')"))
results.append(check("PubChemPy", "import pubchempy"))
results.append(check("ChEMBL Client", "from chembl_webresource_client.new_client import new_client"))

# Bioinformatics
results.append(check("BioPython", "from Bio import Phylo"))

# Scientific
results.append(check("NumPy", "import numpy", "numpy.__version__"))
results.append(check("Pandas", "import pandas", "pandas.__version__"))
results.append(check("Scikit-learn", "import sklearn", "sklearn.__version__"))

# Evaluation
results.append(check("RAGAS", "import ragas"))
results.append(check("SHAP", "import shap"))

print("-" * 50)
success = sum(results)
total = len(results)
print(f"\nResults: {success}/{total} packages verified")

if success == total:
    print("✓ All packages working correctly!")
    sys.exit(0)
else:
    print("✗ Some packages failed. Review errors above.")
    sys.exit(1)
EOF
)

echo "$VERIFY_SCRIPT" | python

VERIFY_EXIT_CODE=$?

if [ $VERIFY_EXIT_CODE -eq 0 ]; then
    log_success "Verification passed!"
else
    log_warning "Some packages failed verification. Check errors above."
fi

# ═══════════════════════════════════════════════════════════════
# Transformers Version Check (CRITICAL)
# ═══════════════════════════════════════════════════════════════

log_info "Verifying transformers version (CRITICAL for vLLM)..."

TRANSFORMERS_VERSION=$(python -c "import transformers; print(transformers.__version__)")
MAJOR=$(echo "$TRANSFORMERS_VERSION" | cut -d. -f1)
MINOR=$(echo "$TRANSFORMERS_VERSION" | cut -d. -f2)

if [ "$MAJOR" -lt 4 ] || { [ "$MAJOR" -eq 4 ] && [ "$MINOR" -lt 57 ]; }; then
    log_error "Transformers version $TRANSFORMERS_VERSION is too old (need >=4.57.0)"
    log_error "This will cause vLLM failures. Reinstall with: pip install --upgrade transformers"
    exit 1
else
    log_success "Transformers version $TRANSFORMERS_VERSION is compatible with vLLM"
fi

# ═══════════════════════════════════════════════════════════════
# Summary & Next Steps
# ═══════════════════════════════════════════════════════════════

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  vLLM Environment Setup Complete!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Environment: ${CONDA_ENV_NAME}"
echo "Python: $(python --version)"
echo "Conda packages: $(conda list | wc -l) installed"
echo "Pip packages: $(pip list | wc -l) installed"
echo ""
echo "Next steps:"
echo "  1. Activate environment:      conda activate ${CONDA_ENV_NAME}"
echo "  2. Start vLLM server:          bash tools/scripts/vllm-server-start.sh"
echo "  3. Ingest papers:              python tools/scripts/rag-ingest.py"
echo "  4. Query RAG:                  python tools/scripts/rag-query.py"
echo ""
echo "Configuration files:"
echo "  - config/vllm-server.yaml      (vLLM server settings)"
echo "  - config/rag-pipeline.yaml     (RAG configuration)"
echo "  - config/models.yaml           (Model registry)"
echo ""
echo "Documentation:"
echo "  - docs/VLLM-INFRASTRUCTURE.md"
echo "  - docs/RAG-PIPELINE.md"
echo ""
echo "Troubleshooting:"
echo "  - Check logs: tail -f ~/LAB/logs/vllm-server.log"
echo "  - GPU status: nvidia-smi"
echo "  - Test server: curl http://127.0.0.1:8000/health"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""

log_success "Setup script completed successfully!"

# Deactivate conda environment
conda deactivate
