#!/usr/bin/env python3
"""
RAG Query Interface for KANNA Thesis Project
Chemistry-aware scientific literature search with hybrid retrieval
Connects to vLLM server for answer generation with citations
Last updated: 2025-10-08

Usage:
    # Interactive mode
    python tools/scripts/rag-query.py

    # Single query
    python tools/scripts/rag-query.py --query "What are the pharmacological effects of mesembrine?"

    # Chemistry query with filtering
    python tools/scripts/rag-query.py --query "5-HT2A binding" --filter has_smiles=true

Requirements:
    conda activate vllm
    vLLM server running: bash tools/scripts/vllm-server-start.sh
"""

import argparse
import logging
import os
import sys
import yaml
from pathlib import Path
from typing import Dict, List, Optional
from dataclasses import dataclass

# RAG stack
import chromadb
from chromadb.config import Settings
from sentence_transformers import SentenceTransformer
import requests

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

# Colors for terminal output
class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

# ═══════════════════════════════════════════════════════════════
# Logging Setup
# ═══════════════════════════════════════════════════════════════

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(os.path.expanduser('~/LAB/logs/rag-query.log')),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Suppress sentence-transformers info logs
logging.getLogger('sentence_transformers').setLevel(logging.WARNING)

# ═══════════════════════════════════════════════════════════════
# RAG Query System
# ═══════════════════════════════════════════════════════════════

class RAGQuerySystem:
    """Chemistry-aware RAG query interface"""

    def __init__(self, config_path: str):
        self.config = self.load_config(config_path)
        self.embedding_model = None
        self.chroma_client = None
        self.collection = None
        self.vllm_endpoint = "http://127.0.0.1:8000/v1/completions"
        self.model_name = "Qwen/Qwen2.5-Coder-7B-Instruct"

    def load_config(self, config_path: str) -> Dict:
        """Load RAG pipeline configuration"""
        with open(config_path, 'r') as f:
            return yaml.safe_load(f)

    def initialize(self):
        """Initialize all components"""
        logger.info("Initializing RAG query system...")

        # Load embeddings
        self.initialize_embeddings()

        # Connect to ChromaDB
        self.initialize_chromadb()

        # Test vLLM connection
        self.test_vllm_connection()

        logger.info("✓ RAG system ready")

    def initialize_embeddings(self):
        """Initialize BGE-M3 embedding model"""
        logger.info("Loading BGE-M3 embeddings...")
        model_path = self.config['embeddings']['local_path']

        try:
            self.embedding_model = SentenceTransformer(model_path)
            logger.info(f"✓ BGE-M3 loaded")
        except Exception as e:
            logger.warning(f"Local model not found, downloading from HuggingFace...")
            self.embedding_model = SentenceTransformer("BAAI/bge-m3")

    def initialize_chromadb(self):
        """Connect to ChromaDB collection"""
        logger.info("Connecting to ChromaDB...")
        persist_dir = self.config['vector_db']['development']['persist_directory']
        collection_name = self.config['vector_db']['development']['collection_name']

        self.chroma_client = chromadb.PersistentClient(
            path=persist_dir,
            settings=Settings(anonymized_telemetry=False)
        )

        try:
            self.collection = self.chroma_client.get_collection(name=collection_name)
            doc_count = self.collection.count()
            logger.info(f"✓ Connected to '{collection_name}' ({doc_count} documents)")

            if doc_count == 0:
                logger.warning("Collection is empty! Run rag-ingest.py first")
        except Exception as e:
            logger.error(f"Failed to connect to ChromaDB: {e}")
            logger.error("Run: python tools/scripts/rag-ingest.py")
            sys.exit(1)

    def test_vllm_connection(self):
        """Test connection to vLLM server"""
        logger.info("Testing vLLM connection...")
        try:
            response = requests.get("http://127.0.0.1:8000/health", timeout=5)
            if response.status_code == 200:
                logger.info("✓ vLLM server connected")
            else:
                logger.warning("vLLM server not healthy")
        except requests.exceptions.ConnectionError:
            logger.warning("vLLM server not running - answers will be unavailable")
            logger.info("Start server: bash tools/scripts/vllm-server-start.sh")
        except Exception as e:
            logger.warning(f"vLLM connection test failed: {e}")

    def parse_filters(self, filter_str: Optional[str]) -> Dict:
        """Parse filter string into metadata filters"""
        if not filter_str:
            return {}

        filters = {}
        for pair in filter_str.split(','):
            if '=' in pair:
                key, value = pair.split('=', 1)
                key = key.strip()
                value = value.strip()

                # Convert value types
                if value.lower() == 'true':
                    filters[key] = True
                elif value.lower() == 'false':
                    filters[key] = False
                elif value.isdigit():
                    filters[key] = int(value)
                else:
                    filters[key] = value

        return filters

    def retrieve_documents(self, query: str, filters: Dict = None, top_k: int = 5) -> List[Dict]:
        """Retrieve relevant documents from ChromaDB"""
        # Generate query embedding
        query_embedding = self.embedding_model.encode(query)

        # Build where clause
        where = None
        if filters:
            where = {}
            for key, value in filters.items():
                # ChromaDB where clause format
                if isinstance(value, bool):
                    where[key] = {"$eq": value}
                elif isinstance(value, int):
                    where[key] = {"$eq": value}
                elif isinstance(value, str):
                    # Check if value is in comma-separated list
                    where[key] = {"$contains": value}

        # Query ChromaDB
        results = self.collection.query(
            query_embeddings=[query_embedding.tolist()],
            n_results=top_k,
            where=where
        )

        # Format results
        documents = []
        if results['documents'] and results['documents'][0]:
            for i in range(len(results['documents'][0])):
                documents.append({
                    'content': results['documents'][0][i],
                    'metadata': results['metadatas'][0][i],
                    'distance': results['distances'][0][i] if 'distances' in results else None
                })

        return documents

    def format_context(self, documents: List[Dict]) -> str:
        """Format retrieved documents into context string"""
        context_parts = []

        for i, doc in enumerate(documents, 1):
            meta = doc['metadata']
            title = meta.get('title', 'Unknown')
            authors = meta.get('authors', '')
            year = meta.get('year', '')

            citation = f"[{authors[:50]}, {year}]" if authors else f"[{year}]"

            context_parts.append(
                f"[Source {i}] {citation}\n{doc['content']}\n"
            )

        return "\n".join(context_parts)

    def generate_answer(self, query: str, context: str, max_tokens: int = 500) -> str:
        """Generate answer using vLLM server"""
        # Construct prompt
        prompt = f"""You are a scientific research assistant specialized in ethnobotany and pharmacology.

Based on the following context from scientific papers, answer the question with proper citations.

Context:
{context}

Question: {query}

Answer (include citations in [Author, Year] format):"""

        # Call vLLM API
        try:
            response = requests.post(
                self.vllm_endpoint,
                json={
                    "model": self.model_name,
                    "prompt": prompt,
                    "max_tokens": max_tokens,
                    "temperature": 0.7,
                    "top_p": 0.9,
                    "stop": ["\n\nQuestion:", "\n\n---"]
                },
                timeout=30
            )

            if response.status_code == 200:
                result = response.json()
                return result['choices'][0]['text'].strip()
            else:
                return f"Error: vLLM returned status {response.status_code}"

        except requests.exceptions.ConnectionError:
            return "Error: vLLM server not running. Start with: bash tools/scripts/vllm-server-start.sh"
        except Exception as e:
            return f"Error generating answer: {e}"

    def query(self, query_text: str, filters: Dict = None, top_k: int = 5) -> Dict:
        """Execute full RAG query"""
        logger.info(f"Query: {query_text}")

        # Retrieve documents
        documents = self.retrieve_documents(query_text, filters, top_k)

        if not documents:
            return {
                'query': query_text,
                'documents': [],
                'answer': "No relevant documents found. Try different query terms or filters.",
                'num_results': 0
            }

        # Format context
        context = self.format_context(documents)

        # Generate answer
        answer = self.generate_answer(query_text, context)

        return {
            'query': query_text,
            'documents': documents,
            'answer': answer,
            'num_results': len(documents)
        }

    def display_results(self, results: Dict):
        """Display query results with formatting"""
        print(f"\n{Colors.HEADER}{'='*70}{Colors.ENDC}")
        print(f"{Colors.BOLD}Query:{Colors.ENDC} {results['query']}")
        print(f"{Colors.HEADER}{'='*70}{Colors.ENDC}\n")

        # Display answer
        print(f"{Colors.OKGREEN}{Colors.BOLD}Answer:{Colors.ENDC}")
        print(f"{results['answer']}\n")

        # Display sources
        print(f"{Colors.OKCYAN}{Colors.BOLD}Retrieved Sources ({results['num_results']}):{Colors.ENDC}")
        for i, doc in enumerate(results['documents'], 1):
            meta = doc['metadata']
            title = meta.get('title', 'Unknown')[:80]
            year = meta.get('year', '')
            compounds = meta.get('chemical_compounds', '')
            receptors = meta.get('receptor_targets', '')

            print(f"\n{Colors.OKBLUE}[{i}]{Colors.ENDC} {title} ({year})")

            if compounds:
                print(f"    Compounds: {compounds}")
            if receptors:
                print(f"    Receptors: {receptors}")

            # Show snippet
            content_preview = doc['content'][:200].replace('\n', ' ')
            print(f"    {content_preview}...")

        print(f"\n{Colors.HEADER}{'='*70}{Colors.ENDC}\n")

    def interactive_mode(self):
        """Interactive query loop"""
        print(f"{Colors.HEADER}{Colors.BOLD}")
        print("╔═══════════════════════════════════════════════════════════════════╗")
        print("║           KANNA RAG - Chemistry-Aware Literature Search          ║")
        print("╚═══════════════════════════════════════════════════════════════════╝")
        print(f"{Colors.ENDC}")
        print(f"Corpus: {self.collection.count()} documents")
        print(f"Model: {self.model_name}")
        print("\nCommands:")
        print("  Type your question to search")
        print("  'filter <key>=<value>' to set filters (e.g., 'filter has_smiles=true')")
        print("  'clear' to clear filters")
        print("  'exit' or 'quit' to exit\n")

        current_filters = {}

        while True:
            try:
                # Get user input
                user_input = input(f"{Colors.BOLD}> {Colors.ENDC}").strip()

                if not user_input:
                    continue

                if user_input.lower() in ['exit', 'quit']:
                    print("Goodbye!")
                    break

                if user_input.lower() == 'clear':
                    current_filters = {}
                    print(f"{Colors.OKGREEN}Filters cleared{Colors.ENDC}")
                    continue

                if user_input.lower().startswith('filter '):
                    filter_str = user_input[7:]
                    current_filters = self.parse_filters(filter_str)
                    print(f"{Colors.OKGREEN}Filters set: {current_filters}{Colors.ENDC}")
                    continue

                # Execute query
                results = self.query(user_input, filters=current_filters)
                self.display_results(results)

            except KeyboardInterrupt:
                print("\n\nGoodbye!")
                break
            except Exception as e:
                print(f"{Colors.FAIL}Error: {e}{Colors.ENDC}")
                logger.exception("Query error")

# ═══════════════════════════════════════════════════════════════
# Main
# ═══════════════════════════════════════════════════════════════

def main():
    parser = argparse.ArgumentParser(description="Query KANNA literature corpus")
    parser.add_argument('--config', default='config/rag-pipeline.yaml', help='Path to config file')
    parser.add_argument('--query', help='Single query mode')
    parser.add_argument('--filter', help='Metadata filters (e.g., has_smiles=true,year=2020)')
    parser.add_argument('--top-k', type=int, default=5, help='Number of results to retrieve')
    args = parser.parse_args()

    # Initialize system
    system = RAGQuerySystem(args.config)
    system.initialize()

    if args.query:
        # Single query mode
        filters = system.parse_filters(args.filter) if args.filter else {}
        results = system.query(args.query, filters=filters, top_k=args.top_k)
        system.display_results(results)
    else:
        # Interactive mode
        system.interactive_mode()

if __name__ == "__main__":
    main()
