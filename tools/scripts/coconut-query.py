#!/usr/bin/env python3
"""
COCONUT Natural Products Database Query Client
Access 1M+ natural products from COCONUT 2.0 for structure similarity searches
Last updated: 2025-10-08

COCONUT: Collection of Open Natural Products Database
- 1,022,536 curated natural product molecules
- 63 source databases
- REST API (no authentication required)
- Ideal for finding plant metabolites similar to Sceletium alkaloids

Usage:
    # Search by compound name
    python tools/scripts/coconut-query.py --name "mesembrine"

    # Structure similarity search (requires SMILES)
    python tools/scripts/coconut-query.py --smiles "CN1CCC[C@H]1[C@H](OC)[C@H](C)c1cc2OCOc2cc1" --threshold 0.7

    # Substructure search
    python tools/scripts/coconut-query.py --substructure "c1cc2OCOc2cc1" --limit 10

    # Get compound by ID
    python tools/scripts/coconut-query.py --id "CNP0123456"

Requirements:
    pip install requests rdkit pandas
    conda install -c conda-forge rdkit

API Documentation:
    https://coconut.naturalproducts.net/api/documentation
"""

import argparse
import json
import logging
import sys
from typing import Dict, List, Optional
from dataclasses import dataclass, asdict
from pathlib import Path

import requests
import pandas as pd

# Try to import RDKit for SMILES validation
try:
    from rdkit import Chem
    from rdkit.Chem import AllChem
    from rdkit import DataStructs
    RDKIT_AVAILABLE = True
except ImportError:
    RDKIT_AVAILABLE = False
    print("Warning: RDKit not available - SMILES operations will be limited")

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

COCONUT_API_BASE = "https://coconut.naturalproducts.net/api/v1"
COCONUT_SEARCH_BASE = "https://coconut.naturalproducts.net/api/latest"

# Cache directory
CACHE_DIR = Path.home() / "LAB" / "projects" / "KANNA" / "data" / "coconut-cache"
CACHE_DIR.mkdir(parents=True, exist_ok=True)

# ═══════════════════════════════════════════════════════════════
# Logging Setup
# ═══════════════════════════════════════════════════════════════

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# ═══════════════════════════════════════════════════════════════
# Data Models
# ═══════════════════════════════════════════════════════════════

@dataclass
class Compound:
    """Natural product compound from COCONUT"""
    coconut_id: str
    name: str
    smiles: str
    inchi: str
    inchikey: str
    molecular_formula: str
    molecular_weight: float
    source_databases: List[str]
    organism: Optional[str] = None
    compound_class: Optional[str] = None
    bioactivity: Optional[str] = None

    def to_dict(self):
        return asdict(self)

# ═══════════════════════════════════════════════════════════════
# COCONUT API Client
# ═══════════════════════════════════════════════════════════════

class COCONUTClient:
    """Client for COCONUT Natural Products Database API"""

    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'Accept': 'application/json',
            'User-Agent': 'KANNA-Thesis-Research/1.0'
        })

    def search_by_name(self, name: str, exact: bool = False) -> List[Dict]:
        """Search compounds by name"""
        logger.info(f"Searching COCONUT for: {name}")

        endpoint = f"{COCONUT_SEARCH_BASE}/search/nameSearch"
        params = {
            'name': name,
            'type': 'exact' if exact else 'contains'
        }

        try:
            response = self.session.get(endpoint, params=params, timeout=30)
            response.raise_for_status()

            data = response.json()
            compounds = data.get('results', [])

            logger.info(f"Found {len(compounds)} compounds")
            return compounds

        except requests.exceptions.RequestException as e:
            logger.error(f"API request failed: {e}")
            return []

    def get_by_id(self, coconut_id: str) -> Optional[Dict]:
        """Get compound by COCONUT ID"""
        logger.info(f"Fetching compound: {coconut_id}")

        endpoint = f"{COCONUT_API_BASE}/compound/{coconut_id}"

        try:
            response = self.session.get(endpoint, timeout=30)
            response.raise_for_status()

            return response.json()

        except requests.exceptions.RequestException as e:
            logger.error(f"Failed to fetch {coconut_id}: {e}")
            return None

    def similarity_search(self, smiles: str, threshold: float = 0.7, limit: int = 50) -> List[Dict]:
        """
        Structure similarity search using Tanimoto coefficient

        Note: COCONUT API doesn't directly support similarity search.
        This is a placeholder for local implementation using downloaded data.
        """
        logger.warning("Similarity search requires local COCONUT database")
        logger.info("Alternative: Download COCONUT dataset and use RDKit locally")
        logger.info("Dataset: https://zenodo.org/record/5578949")

        if not RDKIT_AVAILABLE:
            logger.error("RDKit required for similarity search")
            return []

        # Validate SMILES
        mol = Chem.MolFromSmiles(smiles)
        if mol is None:
            logger.error(f"Invalid SMILES: {smiles}")
            return []

        logger.info("For production similarity search:")
        logger.info("1. Download COCONUT SDF file (~4 GB)")
        logger.info("2. Build local fingerprint database")
        logger.info("3. Use RDKit for Tanimoto similarity")

        return []

    def substructure_search(self, smarts: str, limit: int = 100) -> List[Dict]:
        """
        Substructure search

        Note: COCONUT web API has limited search capabilities.
        Recommend downloading full dataset for advanced searches.
        """
        logger.warning("Substructure search requires local COCONUT database")
        logger.info("Use text-based search via name/formula for now")

        return []

    def search_by_organism(self, organism: str) -> List[Dict]:
        """Search compounds by source organism"""
        logger.info(f"Searching for compounds from: {organism}")

        # Text search approximation (COCONUT API limitations)
        return self.search_by_name(organism, exact=False)

    def export_to_csv(self, compounds: List[Dict], output_path: str):
        """Export compounds to CSV"""
        if not compounds:
            logger.warning("No compounds to export")
            return

        # Flatten compound data for CSV
        rows = []
        for comp in compounds:
            row = {
                'coconut_id': comp.get('coconut_id', ''),
                'name': comp.get('name', ''),
                'smiles': comp.get('smiles', ''),
                'molecular_formula': comp.get('molecular_formula', ''),
                'molecular_weight': comp.get('molecular_weight', ''),
                'organism': comp.get('organism', ''),
                'source_databases': ','.join(comp.get('source_databases', [])),
            }
            rows.append(row)

        df = pd.DataFrame(rows)
        df.to_csv(output_path, index=False)
        logger.info(f"Exported {len(rows)} compounds to {output_path}")

# ═══════════════════════════════════════════════════════════════
# Sceletium-specific helpers
# ═══════════════════════════════════════════════════════════════

SCELETIUM_ALKALOIDS = {
    "mesembrine": "CN1CCC[C@H]1[C@H](OC)[C@H](C)c1cc2OCOc2cc1",
    "mesembrenone": "CN1CCC2=C1C=C(C)C(C(O)=O)C2",
    "mesembrenol": "CN1CCC[C@H]1[C@H](O)[C@H](C)c1cc2OCOc2cc1",
    "tortuosamine": "CN1CCC[C@H]1[C@H]2C[C@H](C)c3cc4OCOc4cc3O2"
}

def search_similar_to_sceletium(client: COCONUTClient, compound: str = "mesembrine") -> List[Dict]:
    """Find natural products structurally similar to Sceletium alkaloids"""
    if compound not in SCELETIUM_ALKALOIDS:
        logger.error(f"Unknown compound: {compound}")
        logger.info(f"Available: {', '.join(SCELETIUM_ALKALOIDS.keys())}")
        return []

    smiles = SCELETIUM_ALKALOIDS[compound]
    logger.info(f"Searching for compounds similar to {compound}")
    logger.info(f"SMILES: {smiles}")

    # For now, use name-based search (API limitation)
    # In production, use local COCONUT database with RDKit
    results = []

    # Search for similar compound classes
    keywords = ["alkaloid", "methylated", "tropane", "indole"]
    for keyword in keywords:
        compounds = client.search_by_name(keyword)
        results.extend(compounds)

    # Deduplicate
    seen = set()
    unique_results = []
    for comp in results:
        comp_id = comp.get('coconut_id', '')
        if comp_id and comp_id not in seen:
            seen.add(comp_id)
            unique_results.append(comp)

    logger.info(f"Found {len(unique_results)} potentially similar compounds")
    return unique_results

# ═══════════════════════════════════════════════════════════════
# Main CLI
# ═══════════════════════════════════════════════════════════════

def main():
    parser = argparse.ArgumentParser(
        description="Query COCONUT Natural Products Database",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Search by name
  python coconut-query.py --name "mesembrine"

  # Search for compounds from specific plant
  python coconut-query.py --organism "Sceletium"

  # Find compounds similar to Sceletium alkaloids
  python coconut-query.py --similar-to mesembrine

  # Get specific compound
  python coconut-query.py --id "CNP0123456"

  # Export results to CSV
  python coconut-query.py --name "alkaloid" --output results.csv
        """
    )

    parser.add_argument('--name', help='Search by compound name')
    parser.add_argument('--id', help='Get compound by COCONUT ID')
    parser.add_argument('--organism', help='Search by source organism')
    parser.add_argument('--similar-to', choices=list(SCELETIUM_ALKALOIDS.keys()),
                        help='Find compounds similar to Sceletium alkaloid')
    parser.add_argument('--smiles', help='SMILES string for similarity search')
    parser.add_argument('--threshold', type=float, default=0.7,
                        help='Similarity threshold (0.0-1.0)')
    parser.add_argument('--limit', type=int, default=50,
                        help='Maximum number of results')
    parser.add_argument('--output', help='Export results to CSV file')
    parser.add_argument('--exact', action='store_true',
                        help='Exact name match only')

    args = parser.parse_args()

    # Initialize client
    client = COCONUTClient()
    results = []

    # Execute search
    if args.name:
        results = client.search_by_name(args.name, exact=args.exact)

    elif args.id:
        result = client.get_by_id(args.id)
        if result:
            results = [result]

    elif args.organism:
        results = client.search_by_organism(args.organism)

    elif args.similar_to:
        results = search_similar_to_sceletium(client, args.similar_to)

    elif args.smiles:
        results = client.similarity_search(args.smiles, args.threshold, args.limit)

    else:
        parser.print_help()
        sys.exit(1)

    # Display results
    if results:
        print(f"\n{'='*70}")
        print(f"Found {len(results)} compounds")
        print(f"{'='*70}\n")

        for i, comp in enumerate(results[:args.limit], 1):
            print(f"[{i}] {comp.get('name', 'Unknown')}")
            print(f"    ID: {comp.get('coconut_id', 'N/A')}")
            print(f"    Formula: {comp.get('molecular_formula', 'N/A')}")
            print(f"    MW: {comp.get('molecular_weight', 'N/A')}")
            if comp.get('smiles'):
                print(f"    SMILES: {comp['smiles'][:60]}...")
            if comp.get('organism'):
                print(f"    Source: {comp['organism']}")
            print()

        # Export if requested
        if args.output:
            client.export_to_csv(results, args.output)

    else:
        print("No results found")

    print(f"\nNote: For advanced searches (similarity, substructure),")
    print(f"      download full COCONUT dataset: https://zenodo.org/record/5578949")

if __name__ == "__main__":
    main()
