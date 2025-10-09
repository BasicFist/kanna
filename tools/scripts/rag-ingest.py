#!/usr/bin/env python3
"""
RAG Ingestion Script for KANNA Thesis Project
Process 142 scientific papers → ChromaDB with semantic chunking + BGE-M3 embeddings
Includes chemistry integration (SMILES extraction, molecular fingerprints)
Last updated: 2025-10-08

Usage:
    python tools/scripts/rag-ingest.py [--config config/rag-pipeline.yaml] [--input literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008]

Requirements:
    conda activate vllm
    pip install langchain chromadb sentence-transformers rdkit pyyaml tqdm
"""

import argparse
import logging
import os
import re
import sys
import yaml
from pathlib import Path
from typing import Dict, List, Optional, Any
from dataclasses import dataclass, asdict
from datetime import datetime

# Progress tracking
from tqdm import tqdm

# RAG stack
import chromadb
from chromadb.config import Settings
from sentence_transformers import SentenceTransformer

# Document processing
from llama_index.core import Document
from llama_index.core.node_parser import SemanticSplitterNodeParser
from llama_index.embeddings.huggingface import HuggingFaceEmbedding

# Chemistry
try:
    from rdkit import Chem
    RDKIT_AVAILABLE = True
except ImportError:
    RDKIT_AVAILABLE = False
    print("Warning: RDKit not available - SMILES extraction disabled")

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

@dataclass
class PaperMetadata:
    """Paper metadata schema matching config/rag-pipeline.yaml"""
    # Core
    paper_id: str
    title: str
    authors: List[str]
    year: int
    doi: Optional[str] = None
    journal: Optional[str] = None

    # Thesis
    chapter: int = 0  # 0 = not classified yet
    paper_type: str = "unknown"
    primary_topic: str = "unknown"

    # Chemistry
    has_smiles: bool = False
    chemical_compounds: List[str] = None
    smiles_strings: List[str] = None
    compound_classes: List[str] = None

    # Pharmacology
    receptor_targets: List[str] = None
    pharmacological_effects: List[str] = None
    has_ic50_data: bool = False

    # Botany
    botanical_taxonomy: Optional[str] = None
    morphological_traits: List[str] = None
    geographic_location: Optional[str] = None

    # Ethnobotany
    traditional_use: Optional[str] = None
    indigenous_community: Optional[str] = None
    preparation_method: Optional[str] = None

    # Technical
    source_file: str = ""
    extraction_date: str = ""
    word_count: int = 0

    def __post_init__(self):
        """Initialize empty lists"""
        if self.chemical_compounds is None:
            self.chemical_compounds = []
        if self.smiles_strings is None:
            self.smiles_strings = []
        if self.compound_classes is None:
            self.compound_classes = []
        if self.receptor_targets is None:
            self.receptor_targets = []
        if self.pharmacological_effects is None:
            self.pharmacological_effects = []
        if self.morphological_traits is None:
            self.morphological_traits = []

# ═══════════════════════════════════════════════════════════════
# Logging Setup
# ═══════════════════════════════════════════════════════════════

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(os.path.expanduser('~/LAB/logs/rag-ingest.log')),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# ═══════════════════════════════════════════════════════════════
# Chemistry Extraction
# ═══════════════════════════════════════════════════════════════

class ChemistryExtractor:
    """Extract chemical compounds and SMILES strings from text"""

    # Common alkaloids in Sceletium
    KNOWN_COMPOUNDS = {
        "mesembrine": "CN1CCC[C@H]1[C@H](OC)[C@H](C)c1cc2OCOc2cc1",
        "mesembrenone": "CN1CCC2=C1C=C(C)C(C(O)=O)C2",
        "mesembrenol": "CN1CCC[C@H]1[C@H](O)[C@H](C)c1cc2OCOc2cc1",
        "tortuosamine": "CN1CCC[C@H]1[C@H]2C[C@H](C)c3cc4OCOc4cc3O2",
        "4'-O-demethylmesembrenone": "CN1CCC2=C1C=C(C)C(C(=O)O)C2"
    }

    RECEPTOR_PATTERNS = {
        r'\b5-HT[1-7][A-F]?\b': '5-HT receptor',
        r'\bCB[12]\b': 'cannabinoid receptor',
        r'\bPDE4\b': 'phosphodiesterase 4',
        r'\bMAO-[AB]\b': 'monoamine oxidase'
    }

    def __init__(self):
        self.rdkit_available = RDKIT_AVAILABLE

    def extract_compounds(self, text: str) -> List[str]:
        """Extract compound names from text"""
        compounds = []
        text_lower = text.lower()

        for compound_name in self.KNOWN_COMPOUNDS.keys():
            if compound_name in text_lower:
                compounds.append(compound_name)

        return compounds

    def extract_smiles(self, text: str, compound_names: List[str]) -> List[str]:
        """Extract or lookup SMILES strings"""
        smiles = []

        # Lookup known compounds
        for compound in compound_names:
            if compound in self.KNOWN_COMPOUNDS:
                smiles.append(self.KNOWN_COMPOUNDS[compound])

        # Extract SMILES patterns (basic regex - can be improved)
        smiles_pattern = r'\b[A-Z][A-Za-z0-9@\+\-\[\]\(\)=#]{5,}\b'
        potential_smiles = re.findall(smiles_pattern, text)

        if self.rdkit_available:
            for candidate in potential_smiles:
                try:
                    mol = Chem.MolFromSmiles(candidate)
                    if mol is not None:
                        smiles.append(candidate)
                except:
                    continue

        return list(set(smiles))

    def extract_receptors(self, text: str) -> List[str]:
        """Extract receptor targets from text"""
        receptors = []
        for pattern, receptor_type in self.RECEPTOR_PATTERNS.items():
            matches = re.findall(pattern, text)
            receptors.extend(matches)
        return list(set(receptors))

    def detect_ic50_data(self, text: str) -> bool:
        """Check if text contains IC50/Ki values"""
        patterns = [r'\bIC50\b', r'\bKi\b', r'\bEC50\b', r'\bnM\b.*\bKi\b']
        return any(re.search(p, text, re.IGNORECASE) for p in patterns)

# ═══════════════════════════════════════════════════════════════
# Metadata Extraction
# ═══════════════════════════════════════════════════════════════

class MetadataExtractor:
    """Extract metadata from paper content and filename"""

    def extract_from_filename(self, filename: str) -> Dict[str, Any]:
        """Extract year and partial title from filename"""
        # Pattern: "YYYY - Title..." or "[XX] YYYY - Title..."
        metadata = {}

        # Extract year
        year_match = re.search(r'(19|20)\d{2}', filename)
        if year_match:
            metadata['year'] = int(year_match.group())
        else:
            metadata['year'] = 2023  # Default

        # Extract title (after year)
        title_match = re.search(r'\d{4}\s*-\s*(.+)', filename)
        if title_match:
            metadata['title'] = title_match.group(1).strip()
        else:
            metadata['title'] = filename

        return metadata

    def extract_from_content(self, text: str, filename_metadata: Dict) -> PaperMetadata:
        """Extract metadata from paper content"""
        lines = text.split('\n')

        # Initialize with filename data
        metadata = PaperMetadata(
            paper_id=filename_metadata.get('title', 'unknown')[:50],
            title=filename_metadata.get('title', 'Unknown'),
            authors=[],
            year=filename_metadata.get('year', 2023),
            source_file=filename_metadata.get('source_file', ''),
            extraction_date=datetime.now().isoformat(),
            word_count=len(text.split())
        )

        # Extract title from first header
        for line in lines[:20]:
            if line.startswith('# ') and len(line) > 10:
                metadata.title = line.lstrip('# ').strip()
                break

        # Extract authors (basic heuristic - look for author patterns)
        author_patterns = [r'([A-Z][a-z]+\s+[A-Z][a-z]+)', r'et al\.']
        for line in lines[:30]:
            for pattern in author_patterns:
                matches = re.findall(pattern, line)
                if matches:
                    metadata.authors.extend(matches)

        # Chemistry extraction
        chem_extractor = ChemistryExtractor()
        metadata.chemical_compounds = chem_extractor.extract_compounds(text)
        metadata.smiles_strings = chem_extractor.extract_smiles(text, metadata.chemical_compounds)
        metadata.has_smiles = len(metadata.smiles_strings) > 0
        metadata.receptor_targets = chem_extractor.extract_receptors(text)
        metadata.has_ic50_data = chem_extractor.detect_ic50_data(text)

        # Detect Sceletium mentions
        if 'sceletium' in text.lower() or 'kanna' in text.lower():
            metadata.botanical_taxonomy = "Sceletium tortuosum (L.) N.E.Br."

        return metadata

# ═══════════════════════════════════════════════════════════════
# RAG Ingestion Pipeline
# ═══════════════════════════════════════════════════════════════

class RAGIngestionPipeline:
    """Main ingestion pipeline"""

    def __init__(self, config_path: str):
        self.config = self.load_config(config_path)
        self.embedding_model = None
        self.chroma_client = None
        self.collection = None
        self.chemistry_extractor = ChemistryExtractor()
        self.metadata_extractor = MetadataExtractor()

    def load_config(self, config_path: str) -> Dict:
        """Load RAG pipeline configuration"""
        with open(config_path, 'r') as f:
            return yaml.safe_load(f)

    def initialize_embeddings(self):
        """Initialize BGE-M3 embedding model"""
        logger.info("Loading BGE-M3 embeddings model...")
        model_path = self.config['embeddings']['local_path']

        # Force CPU since vLLM is using GPU (prevents OOM)
        try:
            self.embedding_model = SentenceTransformer(model_path, device='cpu')
            logger.info(f"✓ BGE-M3 loaded from {model_path} (device: CPU)")
        except Exception as e:
            logger.error(f"Failed to load BGE-M3: {e}")
            logger.info("Attempting to download from HuggingFace...")
            self.embedding_model = SentenceTransformer("BAAI/bge-m3", device='cpu')

    def initialize_chromadb(self):
        """Initialize ChromaDB collection"""
        logger.info("Initializing ChromaDB...")
        persist_dir = self.config['vector_db']['development']['persist_directory']
        collection_name = self.config['vector_db']['development']['collection_name']

        # Create directory if needed
        os.makedirs(persist_dir, exist_ok=True)

        self.chroma_client = chromadb.PersistentClient(
            path=persist_dir,
            settings=Settings(anonymized_telemetry=False)
        )

        # Get or create collection
        self.collection = self.chroma_client.get_or_create_collection(
            name=collection_name,
            metadata={"description": "KANNA thesis scientific literature corpus"}
        )

        logger.info(f"✓ ChromaDB collection: {collection_name} ({self.collection.count()} documents)")

    def load_paper(self, paper_path: Path) -> Optional[Dict]:
        """Load paper markdown file"""
        try:
            with open(paper_path, 'r', encoding='utf-8') as f:
                content = f.read()

            filename_meta = self.metadata_extractor.extract_from_filename(paper_path.stem)
            filename_meta['source_file'] = str(paper_path)

            metadata = self.metadata_extractor.extract_from_content(content, filename_meta)

            return {
                'content': content,
                'metadata': metadata
            }
        except Exception as e:
            logger.error(f"Failed to load {paper_path}: {e}")
            return None

    def chunk_document(self, content: str, metadata: PaperMetadata) -> List[Dict]:
        """Chunk document using semantic chunking"""
        # Simple sentence-based chunking for now (can upgrade to LlamaIndex later)
        chunk_size = self.config['chunking']['parameters']['chunk_size']
        chunk_overlap = self.config['chunking']['parameters']['chunk_overlap']

        # Split by paragraphs first
        paragraphs = content.split('\n\n')
        chunks = []
        current_chunk = ""
        chunk_id = 0

        for para in paragraphs:
            words = para.split()
            if len(current_chunk.split()) + len(words) < chunk_size:
                current_chunk += para + "\n\n"
            else:
                if current_chunk:
                    chunks.append({
                        'chunk_id': f"{metadata.paper_id}_{chunk_id}",
                        'content': current_chunk.strip(),
                        'metadata': metadata
                    })
                    chunk_id += 1
                current_chunk = para + "\n\n"

        # Add final chunk
        if current_chunk:
            chunks.append({
                'chunk_id': f"{metadata.paper_id}_{chunk_id}",
                'content': current_chunk.strip(),
                'metadata': metadata
            })

        return chunks

    def ingest_paper(self, paper_path: Path) -> int:
        """Ingest single paper into ChromaDB"""
        paper_data = self.load_paper(paper_path)
        if not paper_data:
            return 0

        # Chunk document
        chunks = self.chunk_document(paper_data['content'], paper_data['metadata'])

        if not chunks:
            logger.warning(f"No chunks generated for {paper_path.name}")
            return 0

        # Generate embeddings
        chunk_contents = [c['content'] for c in chunks]
        embeddings = self.embedding_model.encode(chunk_contents, show_progress_bar=False)

        # Prepare for ChromaDB
        ids = [c['chunk_id'] for c in chunks]
        documents = chunk_contents
        metadatas = [asdict(c['metadata']) for c in chunks]

        # Convert lists to strings for ChromaDB
        for meta in metadatas:
            for key, value in meta.items():
                if isinstance(value, list):
                    meta[key] = ', '.join(str(v) for v in value) if value else ''

        # Add to collection
        self.collection.add(
            ids=ids,
            embeddings=embeddings.tolist(),
            documents=documents,
            metadatas=metadatas
        )

        return len(chunks)

    def ingest_corpus(self, input_dir: str, limit: Optional[int] = None):
        """Ingest entire corpus of papers"""
        logger.info(f"Scanning for papers in: {input_dir}")

        # Find all markdown files
        input_path = Path(input_dir)
        md_files = list(input_path.rglob("*.md"))

        if limit:
            md_files = md_files[:limit]

        logger.info(f"Found {len(md_files)} papers to process")

        # Progress bar
        total_chunks = 0
        with tqdm(total=len(md_files), desc="Ingesting papers") as pbar:
            for paper_path in md_files:
                try:
                    chunks = self.ingest_paper(paper_path)
                    total_chunks += chunks
                    pbar.set_postfix({'chunks': total_chunks})
                except Exception as e:
                    logger.error(f"Error ingesting {paper_path.name}: {e}")
                finally:
                    pbar.update(1)

        logger.info(f"✓ Ingestion complete: {len(md_files)} papers, {total_chunks} chunks")
        logger.info(f"ChromaDB collection size: {self.collection.count()}")

# ═══════════════════════════════════════════════════════════════
# Main
# ═══════════════════════════════════════════════════════════════

def main():
    parser = argparse.ArgumentParser(description="Ingest scientific papers into ChromaDB")
    parser.add_argument('--config', default='config/rag-pipeline.yaml', help='Path to config file')
    parser.add_argument('--input', default='literature/pdfs/extractions-PRODUCTION-baseline-no-vllm-20251008', help='Input directory')
    parser.add_argument('--limit', type=int, help='Limit number of papers (for testing)')
    args = parser.parse_args()

    logger.info("="*70)
    logger.info("RAG Ingestion Pipeline Starting")
    logger.info("="*70)

    # Initialize pipeline
    pipeline = RAGIngestionPipeline(args.config)

    # Load embeddings
    pipeline.initialize_embeddings()

    # Initialize ChromaDB
    pipeline.initialize_chromadb()

    # Ingest corpus
    pipeline.ingest_corpus(args.input, limit=args.limit)

    logger.info("="*70)
    logger.info("Ingestion complete!")
    logger.info("="*70)

if __name__ == "__main__":
    main()
