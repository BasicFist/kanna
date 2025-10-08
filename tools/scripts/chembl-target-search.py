#!/usr/bin/env python3
"""
ChEMBL Target Search Client
Query ChEMBL database for compound bioactivity and target predictions
Last updated: 2025-10-08

ChEMBL: Database of bioactive molecules with drug-like properties
- 36 million+ bioactivity measurements
- 2.4 million+ compounds
- 15,000+ targets
- Python client (no API key required)

Usage:
    # Search compound by name
    python tools/scripts/chembl-target-search.py --compound "mesembrine"

    # Search by ChEMBL ID
    python tools/scripts/chembl-target-search.py --chembl-id "CHEMBL123456"

    # Search by target (receptor)
    python tools/scripts/chembl-target-search.py --target "5-HT2A"

    # Get activities for specific compound-target pair
    python tools/scripts/chembl-target-search.py --compound "mesembrine" --target "PDE4"

    # Export to CSV
    python tools/scripts/chembl-target-search.py --compound "mesembrine" --output activities.csv

Requirements:
    pip install chembl_webresource_client pandas

Documentation:
    https://github.com/chembl/chembl_webresource_client
"""

import argparse
import logging
import sys
from typing import Dict, List, Optional
from pathlib import Path

import pandas as pd

try:
    from chembl_webresource_client.new_client import new_client
    CHEMBL_AVAILABLE = True
except ImportError:
    CHEMBL_AVAILABLE = False
    print("Error: ChEMBL client not installed")
    print("Install with: pip install chembl_webresource_client")
    sys.exit(1)

# ═══════════════════════════════════════════════════════════════
# Configuration
# ═══════════════════════════════════════════════════════════════

# Cache directory
CACHE_DIR = Path.home() / "LAB" / "projects" / "KANNA" / "data" / "chembl-cache"
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
# ChEMBL API Client
# ═══════════════════════════════════════════════════════════════

class ChEMBLClient:
    """Client for ChEMBL Web Resource API"""

    def __init__(self):
        self.molecule = new_client.molecule
        self.target = new_client.target
        self.activity = new_client.activity
        self.assay = new_client.assay

    def search_compound(self, name: str) -> List[Dict]:
        """Search compounds by name"""
        logger.info(f"Searching ChEMBL for compound: {name}")

        try:
            results = self.molecule.search(name)
            compounds = []

            for mol in results:
                compound = {
                    'chembl_id': mol['molecule_chembl_id'],
                    'name': mol.get('pref_name', name),
                    'smiles': mol.get('molecule_structures', {}).get('canonical_smiles'),
                    'molecular_formula': mol.get('molecule_properties', {}).get('full_mwt'),
                    'max_phase': mol.get('max_phase'),  # Clinical trial phase
                    'molecule_type': mol.get('molecule_type')
                }
                compounds.append(compound)

            logger.info(f"Found {len(compounds)} compounds")
            return compounds

        except Exception as e:
            logger.error(f"Search failed: {e}")
            return []

    def get_compound_by_id(self, chembl_id: str) -> Optional[Dict]:
        """Get compound by ChEMBL ID"""
        logger.info(f"Fetching: {chembl_id}")

        try:
            mol = self.molecule.get(chembl_id)
            if not mol:
                return None

            compound = {
                'chembl_id': mol['molecule_chembl_id'],
                'name': mol.get('pref_name'),
                'smiles': mol.get('molecule_structures', {}).get('canonical_smiles'),
                'inchi': mol.get('molecule_structures', {}).get('standard_inchi'),
                'molecular_formula': mol.get('molecule_properties', {}).get('full_molformula'),
                'molecular_weight': mol.get('molecule_properties', {}).get('full_mwt'),
                'alogp': mol.get('molecule_properties', {}).get('alogp'),
                'psa': mol.get('molecule_properties', {}).get('psa'),
                'hba': mol.get('molecule_properties', {}).get('hba'),  # H-bond acceptors
                'hbd': mol.get('molecule_properties', {}).get('hbd'),  # H-bond donors
                'max_phase': mol.get('max_phase'),
                'molecule_type': mol.get('molecule_type')
            }

            return compound

        except Exception as e:
            logger.error(f"Failed to fetch {chembl_id}: {e}")
            return None

    def search_target(self, target_name: str) -> List[Dict]:
        """Search targets by name (e.g., receptor, enzyme)"""
        logger.info(f"Searching for target: {target_name}")

        try:
            results = self.target.search(target_name)
            targets = []

            for tgt in results[:20]:  # Limit to 20
                target = {
                    'target_chembl_id': tgt['target_chembl_id'],
                    'pref_name': tgt.get('pref_name'),
                    'target_type': tgt.get('target_type'),
                    'organism': tgt.get('organism'),
                    'target_components': tgt.get('target_components', [])
                }
                targets.append(target)

            logger.info(f"Found {len(targets)} targets")
            return targets

        except Exception as e:
            logger.error(f"Target search failed: {e}")
            return []

    def get_activities(self, compound_chembl_id: str, target_chembl_id: Optional[str] = None, limit: int = 100) -> List[Dict]:
        """
        Get bioactivity data for compound

        Args:
            compound_chembl_id: ChEMBL ID of compound
            target_chembl_id: Optional target filter
            limit: Maximum number of activities
        """
        logger.info(f"Fetching activities for {compound_chembl_id}")

        try:
            # Build filter
            filters = {'molecule_chembl_id': compound_chembl_id}
            if target_chembl_id:
                filters['target_chembl_id'] = target_chembl_id

            results = self.activity.filter(**filters).only([
                'activity_id',
                'assay_chembl_id',
                'target_chembl_id',
                'target_pref_name',
                'standard_type',  # e.g., IC50, Ki, EC50
                'standard_value',
                'standard_units',
                'standard_relation',  # =, <, >, etc.
                'activity_comment'
            ])[:limit]

            activities = []
            for act in results:
                activity = {
                    'activity_id': act.get('activity_id'),
                    'assay': act.get('assay_chembl_id'),
                    'target_id': act.get('target_chembl_id'),
                    'target_name': act.get('target_pref_name'),
                    'type': act.get('standard_type'),
                    'value': act.get('standard_value'),
                    'units': act.get('standard_units'),
                    'relation': act.get('standard_relation'),
                    'comment': act.get('activity_comment')
                }
                activities.append(activity)

            logger.info(f"Found {len(activities)} activities")
            return activities

        except Exception as e:
            logger.error(f"Activity query failed: {e}")
            return []

    def get_compound_targets(self, compound_chembl_id: str, activity_threshold: float = 10000) -> List[Dict]:
        """
        Get all targets for compound with significant activity

        Args:
            compound_chembl_id: ChEMBL ID
            activity_threshold: Maximum IC50/Ki in nM (default: 10 µM)
        """
        logger.info(f"Finding targets for {compound_chembl_id} (threshold: {activity_threshold} nM)")

        activities = self.get_activities(compound_chembl_id, limit=1000)

        # Filter for significant activities
        significant = []
        for act in activities:
            if act['type'] in ['IC50', 'Ki', 'Kd', 'EC50']:
                try:
                    value = float(act['value'])
                    if value <= activity_threshold:
                        significant.append(act)
                except (TypeError, ValueError):
                    continue

        # Group by target
        targets = {}
        for act in significant:
            target_id = act['target_id']
            if target_id not in targets:
                targets[target_id] = {
                    'target_id': target_id,
                    'target_name': act['target_name'],
                    'activities': []
                }
            targets[target_id]['activities'].append({
                'type': act['type'],
                'value': act['value'],
                'units': act['units']
            })

        logger.info(f"Found {len(targets)} active targets")
        return list(targets.values())

    def export_to_csv(self, data: List[Dict], output_path: str):
        """Export data to CSV"""
        if not data:
            logger.warning("No data to export")
            return

        df = pd.DataFrame(data)
        df.to_csv(output_path, index=False)
        logger.info(f"Exported {len(data)} records to {output_path}")

# ═══════════════════════════════════════════════════════════════
# Sceletium helpers
# ═══════════════════════════════════════════════════════════════

SCELETIUM_TARGETS = [
    "5-HT1A receptor",
    "5-HT2A receptor",
    "5-HT2C receptor",
    "PDE4A",
    "PDE4B",
    "PDE4D",
    "Serotonin transporter"
]

def analyze_sceletium_pharmacology(client: ChEMBLClient, compound: str = "mesembrine") -> pd.DataFrame:
    """Comprehensive pharmacology analysis of Sceletium compound"""
    logger.info(f"Analyzing pharmacology of {compound}")

    # Search compound
    compounds = client.search_compound(compound)
    if not compounds:
        logger.error(f"Compound not found: {compound}")
        return pd.DataFrame()

    chembl_id = compounds[0]['chembl_id']
    logger.info(f"Found: {chembl_id}")

    # Get activities
    activities = client.get_activities(chembl_id, limit=500)

    # Filter for relevant targets
    relevant = []
    for act in activities:
        target_name = act.get('target_name', '').lower()
        if any(tgt.lower() in target_name for tgt in ['5-ht', 'serotonin', 'pde4']):
            relevant.append(act)

    df = pd.DataFrame(relevant)
    logger.info(f"Found {len(relevant)} relevant activities")

    return df

# ═══════════════════════════════════════════════════════════════
# Main CLI
# ═══════════════════════════════════════════════════════════════

def main():
    parser = argparse.ArgumentParser(
        description="Query ChEMBL for compound bioactivity and targets",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Search compound
  python chembl-target-search.py --compound "mesembrine"

  # Get compound by ChEMBL ID
  python chembl-target-search.py --chembl-id "CHEMBL123456"

  # Search target
  python chembl-target-search.py --target "5-HT2A"

  # Get activities for compound
  python chembl-target-search.py --compound "mesembrine" --activities

  # Get targets for compound
  python chembl-target-search.py --compound "mesembrine" --targets

  # Sceletium pharmacology analysis
  python chembl-target-search.py --sceletium --output mesembrine-pharmacology.csv
        """
    )

    parser.add_argument('--compound', help='Compound name')
    parser.add_argument('--chembl-id', help='ChEMBL compound ID')
    parser.add_argument('--target', help='Target name (receptor, enzyme)')
    parser.add_argument('--activities', action='store_true',
                        help='Get bioactivity data')
    parser.add_argument('--targets', action='store_true',
                        help='Get active targets for compound')
    parser.add_argument('--sceletium', action='store_true',
                        help='Analyze Sceletium compound pharmacology')
    parser.add_argument('--threshold', type=float, default=10000,
                        help='Activity threshold in nM (default: 10000)')
    parser.add_argument('--output', help='Output CSV file')
    parser.add_argument('--limit', type=int, default=100,
                        help='Maximum results')

    args = parser.parse_args()

    # Initialize client
    client = ChEMBLClient()

    # Execute query
    if args.compound:
        compounds = client.search_compound(args.compound)

        if not compounds:
            print(f"No compounds found for: {args.compound}")
            sys.exit(1)

        # Display results
        print(f"\n{'='*70}")
        print(f"Compounds matching '{args.compound}':")
        print(f"{'='*70}\n")

        for i, comp in enumerate(compounds, 1):
            print(f"[{i}] {comp['name']} ({comp['chembl_id']})")
            print(f"    SMILES: {comp.get('smiles', 'N/A')[:60]}...")
            print(f"    Phase: {comp['max_phase']}")
            print()

        # Get activities if requested
        if args.activities and compounds:
            chembl_id = compounds[0]['chembl_id']
            activities = client.get_activities(chembl_id, limit=args.limit)

            print(f"\nBioactivities for {compounds[0]['name']}:")
            for act in activities[:20]:
                print(f"  {act['target_name']}: {act['type']} = {act['value']} {act['units']}")

            if args.output:
                client.export_to_csv(activities, args.output)

        # Get targets if requested
        if args.targets and compounds:
            chembl_id = compounds[0]['chembl_id']
            targets = client.get_compound_targets(chembl_id, args.threshold)

            print(f"\nActive targets (IC50/Ki < {args.threshold} nM):")
            for tgt in targets:
                print(f"  {tgt['target_name']} ({len(tgt['activities'])} activities)")
                for act in tgt['activities'][:3]:
                    print(f"    - {act['type']}: {act['value']} {act['units']}")

    elif args.chembl_id:
        compound = client.get_compound_by_id(args.chembl_id)
        if compound:
            print(f"\n{compound['name']} ({compound['chembl_id']})")
            print(f"Formula: {compound['molecular_formula']}")
            print(f"MW: {compound['molecular_weight']}")
            print(f"AlogP: {compound['alogp']}")

    elif args.target:
        targets = client.search_target(args.target)

        print(f"\nTargets matching '{args.target}':")
        for tgt in targets:
            print(f"  {tgt['pref_name']} ({tgt['target_chembl_id']})")
            print(f"    Type: {tgt['target_type']}, Organism: {tgt['organism']}")

    elif args.sceletium:
        df = analyze_sceletium_pharmacology(client)

        if not df.empty:
            print(f"\nSceletium pharmacology ({len(df)} activities):")
            print(df[['target_name', 'type', 'value', 'units']].head(20))

            if args.output:
                df.to_csv(args.output, index=False)
                print(f"\nSaved to: {args.output}")

    else:
        parser.print_help()

if __name__ == "__main__":
    main()
