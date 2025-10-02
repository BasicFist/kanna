# Phytochemical Data

## Directory Purpose

Chemical characterization data for *Sceletium tortuosum* alkaloids, including LC-MS/MS profiles, QSAR models, and molecular descriptors.

## Subdirectories

### `lc-ms/`
LC-MS/MS (Liquid Chromatography - Mass Spectrometry) data for alkaloid profiling.

**File types**:
- `.raw` - Vendor raw data (Thermo, Agilent, Waters)
- `.mzXML`, `.mzML` - Converted open formats
- `.csv` - Peak lists, integration results
- `.xlsx` - Quantification tables

**Workflow**:
1. Raw data → MassHunter/Xcalibur/MassLynx
2. Convert to `.mzML` using MSConvert
3. Process with MZmine3 or XCMS
4. Export to GNPS for molecular networking
5. Annotate alkaloids using spectral libraries

**Key datasets**:
- `alkaloid-standards/` - Pure reference compounds
- `plant-extracts/` - Field-collected samples
- `fermented-samples/` - Traditional fermentation products
- `cultivar-comparison/` - Different *Sceletium* varieties

### `alkaloid-profiles/`
Characterized alkaloid data for 32+ compounds.

**Major alkaloids** (see Chapter 4):
1. **Mesembrine** (most abundant, SERT inhibitor)
2. **Mesembrenone** (PDE4 inhibitor)
3. **Δ7-Mesembrenone** (dual action)
4. **Mesembrenol**
5. **Tortuosamine**

**Minor alkaloids** (understudied):
- Joubertiamine, Sceletium A4, hordenine, candicine, etc.

**File structure**:
```
{AlkaloidName}/
  ├── structure.mol2          # 3D structure
  ├── nmr-spectra/           # 1H, 13C NMR data
  ├── ms-fragmentation.png   # MS/MS fragmentation pattern
  ├── quantification.csv     # Concentrations across samples
  └── properties.json        # Molecular descriptors (MW, logP, TPSA, etc.)
```

### `qsar-models/`
Quantitative Structure-Activity Relationship models.

**Target activities**:
- SERT inhibition (IC50 values)
- PDE4 inhibition (IC50 values)
- Blood-brain barrier (BBB) permeability
- CYP450 metabolism predictions

**Modeling workflow**:
1. Calculate descriptors (RDKit, ChemAxon)
2. Feature selection (correlation analysis, PCA)
3. Train models (Random Forest, XGBoost, Neural Nets)
4. Validate (cross-validation, external test set)
5. Interpret (SHAP values, feature importance)

**Key scripts**: `analysis/python/cheminformatics/qsar-modeling.py`

## Chemical Analysis Standards

### LC-MS/MS Validation (ICH Q14)
- **Linearity**: R² ≥ 0.995 over 3 orders of magnitude
- **Precision**: RSD ≤ 15% (≤20% at LLOQ)
- **Accuracy**: 85-115% recovery
- **LOD**: Signal-to-noise ≥ 3:1
- **LOQ**: Signal-to-noise ≥ 10:1

### Molecular Networking (GNPS)
- **Platform**: https://gnps.ucsd.edu
- **Workflow**: Feature-Based Molecular Networking (FBMN)
- **Parameters**:
  - Parent mass tolerance: 0.02 Da
  - MS/MS fragment tolerance: 0.02 Da
  - Min matched peaks: 6
  - Cosine score: ≥ 0.7

### QSAR Model Requirements
- **Dataset size**: ≥50 compounds per target
- **Descriptor space**: >100 features initially
- **Train/test split**: 80/20 stratified
- **Cross-validation**: 5-fold or 10-fold
- **Performance metrics**: R² ≥ 0.70, Q² ≥ 0.60

## Data Integration

### Correlating Chemical & Biological Data
```
Chemical profile → Bioactivity → Clinical effects
   (LC-MS)         (IC50, Ki)    (RCT outcomes)
```

**Example analysis**:
- Do high-mesembrenone cultivars show stronger PDE4 inhibition?
- Does fermentation increase anxiolytic potency?
- Can QSAR predict clinical responders?

## Key Tools & Software

### Open Source
- **MZmine3**: LC-MS data processing
- **RDKit**: Cheminformatics (Python)
- **ChemoSpec**: Spectroscopic data analysis (R)
- **XCMS**: Metabolomics workflows (R/Bioconductor)

### Commercial (if available)
- **MassHunter/Xcalibur**: Vendor software
- **ChemAxon Suite**: Descriptor calculation
- **GraphPad Prism**: Statistics & visualization

### Web Tools
- **GNPS**: Molecular networking
- **SwissADME**: ADMET predictions
- **pkCSM**: Pharmacokinetics predictions
- **ChemSpider**: Structure searching

## Related Files

- Analysis scripts: `analysis/python/cheminformatics/`
- Molecular structures: `data/molecular-modeling/structures/`
- QSAR models: `analysis/python/ml-models/`
- Thesis chapter: `writing/thesis-chapters/ch04-pharmacology/`

---
*Last updated: October 2025*
