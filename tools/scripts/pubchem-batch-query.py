#!/usr/bin/env python3
"""
PubChem Batch Query Client
Batch property and bioactivity retrieval from PubChem
Last updated: 2025-10-08

PubChem: World's largest freely accessible chemical database
- 111+ million compounds
- Bioactivity data from 1.2+ million assays
- PUG REST API (no authentication)
- Rate limit: 5 requests/second

Usage:
    # Single compound lookup
    python tools/scripts/pubchem-batch-query.py --name "mesembrine"

    # Batch lookup from file
    python tools/scripts/pubchem-batch-query.py --batch compounds.txt --output results.csv

    # Get bioactivity data
    python tools/scripts/pubchem-batch-query.py --name "mesembrine" --bioactivity

    # Structure similarity search
    python tools/scripts/pubchem-batch-query.py --smiles "CN1CCC[C@H]1[C@H](OC)[C@H](C)c1cc2OCOc2cc1" --threshold 90

Requirements:
    pip install pubchempy pandas requests

API Documentation:
    https://pubchem.ncbi.nlm.nih.gov/docs/pug-rest
"""

import argparse
import json
import logging
import sys
import time
from pathlib import Path
from typing import Dict, List, Optional
from dataclasses import dataclass, asdict

import pubchempy as pcp
import pandas as pd
import requests

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

PUBCHEM_API_BASE = "https://pubchem.ncbi.nlm.nih.gov/rest/pug"
RATE_LIMIT_DELAY = 0.2  # 200ms between requests (5 req/sec)

# Cache directory
CACHE_DIR = Path.home() / "LAB" / "projects" / "KANNA" / "data" / "pubchem-cache"
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
class CompoundProperties:
    """PubChem compound properties"""
    cid: int
    name: str
    molecular_formula: str
    molecular_weight: float
    canonical_smiles: str
    inchi: str
    inchikey: str

    # Physicochemical
    xlogp: Optional[float] = None
    tpsa: Optional[float] = None  # Topological polar surface area
    complexity: Optional[float] = None
    h_bond_donor_count: Optional[int] = None
    h_bond_acceptor_count: Optional[int] = None
    rotatable_bond_count: Optional[int] = None

    # Identifiers
    iupac_name: Optional[str] = None
    synonyms: List[str] = None

    def __post_init__(self):
        if self.synonyms is None:
            self.synonyms = []

# ═══════════════════════════════════════════════════════════════
# PubChem API Client
# ═══════════════════════════════════════════════════════════════

class PubChemClient:
    """Client for PubChem PUG REST API"""

    def __init__(self, rate_limit_delay: float = RATE_LIMIT_DELAY):
        self.rate_limit_delay = rate_limit_delay
        self.last_request_time = 0

    def _rate_limit(self):
        """Enforce rate limit (5 requests/second)"""
        elapsed = time.time() - self.last_request_time
        if elapsed < self.rate_limit_delay:
            time.sleep(self.rate_limit_delay - elapsed)
        self.last_request_time = time.time()

    def get_compound_by_name(self, name: str) -> Optional[CompoundProperties]:
        """Get compound properties by name"""
        logger.info(f"Searching PubChem for: {name}")
        self._rate_limit()

        try:
            compounds = pcp.get_compounds(name, 'name')
            if not compounds:
                logger.warning(f"No compounds found for: {name}")
                return None

            comp = compounds[0]  # Take first match

            # Get properties
            props = CompoundProperties(
                cid=comp.cid,
                name=name,
                molecular_formula=comp.molecular_formula,
                molecular_weight=comp.molecular_weight,
                canonical_smiles=comp.canonical_smiles,
                inchi=comp.inchi,
                inchikey=comp.inchikey,
                xlogp=comp.xlogp,
                tpsa=comp.tpsa,
                complexity=comp.complexity,
                h_bond_donor_count=comp.h_bond_donor_count,
                h_bond_acceptor_count=comp.h_bond_acceptor_count,
                rotatable_bond_count=comp.rotatable_bond_count,
                iupac_name=comp.iupac_name,
                synonyms=comp.synonyms[:10] if comp.synonyms else []  # Limit synonyms
            )

            logger.info(f"Found: CID {comp.cid}")
            return props

        except Exception as e:
            logger.error(f"Failed to retrieve {name}: {e}")
            return None

    def get_compound_by_cid(self, cid: int) -> Optional[CompoundProperties]:
        """Get compound properties by CID"""
        logger.info(f"Fetching CID: {cid}")
        self._rate_limit()

        try:
            comp = pcp.Compound.from_cid(cid)

            props = CompoundProperties(
                cid=comp.cid,
                name=comp.synonyms[0] if comp.synonyms else f"CID{cid}",
                molecular_formula=comp.molecular_formula,
                molecular_weight=comp.molecular_weight,
                canonical_smiles=comp.canonical_smiles,
                inchi=comp.inchi,
                inchikey=comp.inchikey,
                xlogp=comp.xlogp,
                tpsa=comp.tpsa,
                complexity=comp.complexity,
                h_bond_donor_count=comp.h_bond_donor_count,
                h_bond_acceptor_count=comp.h_bond_acceptor_count,
                rotatable_bond_count=comp.rotatable_bond_count,
                iupac_name=comp.iupac_name,
                synonyms=comp.synonyms[:10] if comp.synonyms else []
            )

            return props

        except Exception as e:
            logger.error(f"Failed to retrieve CID {cid}: {e}")
            return None

    def get_bioactivity(self, cid: int, limit: int = 10) -> List[Dict]:
        """
        Get bioactivity data for compound

        Returns assays where compound was tested
        """
        logger.info(f"Fetching bioactivity for CID {cid}")
        self._rate_limit()

        endpoint = f"{PUBCHEM_API_BASE}/compound/cid/{cid}/assaysummary/JSON"

        try:
            response = requests.get(endpoint, timeout=30)
            response.raise_for_status()

            data = response.json()
            assays = data.get('Table', {}).get('Row', [])

            logger.info(f"Found {len(assays)} bioassays")
            return assays[:limit]

        except Exception as e:
            logger.error(f"Bioactivity query failed: {e}")
            return []

    def similarity_search(self, smiles: str, threshold: int = 90, max_results: int = 100) -> List[int]:
        """
        Structure similarity search

        Args:
            smiles: Query SMILES string
            threshold: Tanimoto similarity threshold (0-100)
            max_results: Maximum results to return

        Returns:
            List of CIDs of similar compounds
        """
        logger.info(f"Similarity search (threshold={threshold}%)")
        self._rate_limit()

        try:
            # PubChem similarity search
            results = pcp.get_compounds(smiles, 'smiles', searchtype='similarity', Threshold=threshold, MaxRecords=max_results)

            cids = [comp.cid for comp in results]
            logger.info(f"Found {len(cids)} similar compounds")
            return cids

        except Exception as e:
            logger.error(f"Similarity search failed: {e}")
            return []

    def batch_query(self, names: List[str]) -> pd.DataFrame:
        """Batch query multiple compounds"""
        logger.info(f"Batch querying {len(names)} compounds")

        results = []
        for i, name in enumerate(names, 1):
            logger.info(f"[{i}/{len(names)}] {name}")
            props = self.get_compound_by_name(name)

            if props:
                results.append(asdict(props))
            else:
                results.append({'name': name, 'error': 'Not found'})

        df = pd.DataFrame(results)
        return df

# ═══════════════════════════════════════════════════════════════
# Sceletium alkaloids helper
# ═══════════════════════════════════════════════════════════════

SCELETIUM_ALKALOIDS = [
    "mesembrine",
    "mesembrenone",
    "mesembrenol",
    "tortuosamine",
    "4'-O-demethylmesembrenone",
    "mesembranol",
    "joubertiamine"
]

def query_sceletium_alkaloids(client: PubChemClient, output_file: Optional[str] = None) -> pd.DataFrame:
    """Query PubChem for all known Sceletium alkaloids"""
    logger.info("Querying all Sceletium alkaloids")

    df = client.batch_query(SCELETIUM_ALKALOIDS)

    if output_file:
        df.to_csv(output_file, index=False)
        logger.info(f"Results saved to {output_file}")

    return df

# ═══════════════════════════════════════════════════════════════
# Main CLI
# ═══════════════════════════════════════════════════════════════

def main():
    parser = argparse.ArgumentParser(
        description="Query PubChem for compound properties",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Single compound
  python pubchem-batch-query.py --name "mesembrine"

  # With bioactivity
  python pubchem-batch-query.py --name "mesembrine" --bioactivity

  # Batch from file
  python pubchem-batch-query.py --batch compounds.txt --output results.csv

  # Query all Sceletium alkaloids
  python pubchem-batch-query.py --sceletium --output sceletium-properties.csv

  # Similarity search
  python pubchem-batch-query.py --smiles "CN1CCC[C@H]1[C@H](OC)[C@H](C)c1cc2OCOc2cc1" --threshold 90
        """
    )

    parser.add_argument('--name', help='Compound name')
    parser.add_argument('--cid', type=int, help='PubChem CID')
    parser.add_argument('--batch', help='File with compound names (one per line)')
    parser.add_argument('--sceletium', action='store_true',
                        help='Query all Sceletium alkaloids')
    parser.add_argument('--smiles', help='SMILES for similarity search')
    parser.add_argument('--threshold', type=int, default=90,
                        help='Similarity threshold (0-100)')
    parser.add_argument('--bioactivity', action='store_true',
                        help='Include bioactivity data')
    parser.add_argument('--output', help='Output CSV file')
    parser.add_argument('--limit', type=int, default=100,
                        help='Maximum results for similarity search')

    args = parser.parse_args()

    # Initialize client
    client = PubChemClient()

    # Execute query
    if args.name:
        props = client.get_compound_by_name(args.name)
        if props:
            print(f"\n{'='*70}")
            print(f"Compound: {props.name}")
            print(f"{'='*70}")
            print(f"CID:              {props.cid}")
            print(f"Formula:          {props.molecular_formula}")
            print(f"MW:               {props.molecular_weight:.2f}")
            print(f"SMILES:           {props.canonical_smiles}")
            print(f"XLogP:            {props.xlogp}")
            print(f"TPSA:             {props.tpsa}")
            print(f"H-bond donors:    {props.h_bond_donor_count}")
            print(f"H-bond acceptors: {props.h_bond_acceptor_count}")
            print(f"Rotatable bonds:  {props.rotatable_bond_count}")
            print(f"Complexity:       {props.complexity}")

            if args.bioactivity:
                print(f"\nBioactivity assays:")
                assays = client.get_bioactivity(props.cid)
                for i, assay in enumerate(assays, 1):
                    print(f"  [{i}] AID {assay.get('AID')}: {assay.get('Activity Outcome')}")

    elif args.cid:
        props = client.get_compound_by_cid(args.cid)
        if props:
            print(f"Retrieved: {props.name} (CID {props.cid})")

    elif args.batch:
        with open(args.batch, 'r') as f:
            names = [line.strip() for line in f if line.strip()]

        df = client.batch_query(names)
        print(f"\nRetrieved {len(df)} compounds")

        if args.output:
            df.to_csv(args.output, index=False)
            print(f"Saved to: {args.output}")
        else:
            print(df)

    elif args.sceletium:
        df = query_sceletium_alkaloids(client, args.output)
        print(f"\nSceletium alkaloids ({len(df)}):")
        print(df[['name', 'cid', 'molecular_formula', 'molecular_weight']])

    elif args.smiles:
        cids = client.similarity_search(args.smiles, args.threshold, args.limit)
        print(f"\nFound {len(cids)} similar compounds:")
        for cid in cids[:10]:
            print(f"  CID {cid}")

        if args.output:
            pd.DataFrame({'cid': cids}).to_csv(args.output, index=False)
            print(f"Saved to: {args.output}")

    else:
        parser.print_help()

if __name__ == "__main__":
    main()
