# Guide 4: QSAR Modeling Pipeline

**Modélisation QSAR : RDKit → scikit-learn → SHAP pour Prédiction IC50 SERT/PDE4**

⏱️ **Temps d'installation** : 1 hour (environment already set up)
💻 **Prérequis** : Conda environment with RDKit, Python 3.10+
🎯 **Objectif** : R² ≥ 0.80 pour publication, prédire IC50 pour 32 alcaloïdes

---

## Quick Verification

```bash
# Verify environment
cd ~/LAB/projects/KANNA
conda activate kanna  # or: source venv/bin/activate

# Test imports
python -c "from rdkit import Chem; print('✓ RDKit OK')"
python -c "import sklearn, xgboost, shap; print('✓ ML libs OK')"
```

**If RDKit fails**: Must install via conda
```bash
conda install -c conda-forge rdkit
```

---

## Part A: Data Preparation

### Step 1: Download Structures from PubChem

**Target Alkaloids** (32 total):
```
Major (4):
- Mesembrine (PubChem CID: 72311)
- Mesembrenone (CID: 73431)
- Mesembrenol (CID: 5281392)
- Δ7-mesembrenone (CID: not in PubChem, find in literature)

Minor (28+):
- Tortuosamine, Joubertiamine, Sceletium A4, etc.
```

**Download SMILES**:
1. Visit https://pubchem.ncbi.nlm.nih.gov/
2. Search: "mesembrine"
3. Click compound → Copy "Isomeric SMILES"
4. Repeat for all 32 alkaloids

**Create CSV**: `data/phytochemical/alkaloid-profiles/sert-ic50.csv`

```csv
compound,smiles,ic50_nm,target,reference
Mesembrine,CN1CCC2C(C1)Cc3ccc(cc3C2)OC,27,SERT,Harvey2011
Mesembrenone,CN1CCC2=CC(=O)C=C3C2C1Cc4c3cccc4O,386,SERT,Harvey2011
Δ7-mesembrenone,CN1CCC2C(=C1)C=CC3=C2C(=CC=C3)O,15,PDE4,Harvey2011
Mesembrenol,CN1CCC2C(C1)Cc3ccc(cc3C2)O,1500,SERT,Estimated
```

**Notes**:
- IC50 in nM (nanomolar)
- Target: SERT or PDE4B
- Reference: Paper where IC50 measured (or "Estimated" if predicted)

### Step 2: Validate SMILES

**Check all molecules are valid**:

```python
from rdkit import Chem
import pandas as pd

df = pd.read_csv('data/phytochemical/alkaloid-profiles/sert-ic50.csv')

# Validate
invalid = []
for idx, row in df.iterrows():
    mol = Chem.MolFromSmiles(row['smiles'])
    if mol is None:
        invalid.append((idx, row['compound']))

if invalid:
    print(f"❌ Invalid SMILES: {invalid}")
else:
    print(f"✓ All {len(df)} SMILES valid")
```

**Fix issues**:
- Typos in SMILES → Re-copy from PubChem
- Sterochemistry missing → Add @/@@

---

## Part B: Descriptor Calculation

### RDKit Descriptors (200+)

**Script**: Already exists at `analysis/python/cheminformatics/qsar-modeling.py`

**Key Section**:

```python
from rdkit import Chem
from rdkit.Chem import Descriptors
from rdkit.ML.Descriptors import MoleculeDescriptors

# Get all descriptor names
descriptor_names = [desc[0] for desc in Descriptors._descList]
# Returns: ['MolWt', 'LogP', 'NumHDonors', 'NumHAcceptors', 'TPSA', ...]

calculator = MoleculeDescriptors.MolecularDescriptorCalculator(descriptor_names)

# Calculate for one molecule
mol = Chem.MolFromSmiles('CN1CCC2C(C1)Cc3ccc(cc3C2)OC')  # Mesembrine
descriptors = calculator.CalcDescriptors(mol)

print(f"Molecular Weight: {descriptors[0]:.2f}")
print(f"LogP: {descriptors[1]:.2f}")
# ... 200+ descriptors total
```

**Important Descriptors for QSAR**:
- **MolWt**: Molecular weight (Lipinski's rule: <500 Da)
- **LogP**: Lipophilicity (BBB permeability)
- **TPSA**: Topological polar surface area (absorption)
- **NumHDonors/HAcceptors**: Hydrogen bonding
- **NumRotatableBonds**: Flexibility
- **NumAromaticRings**: Aromaticity

### Feature Engineering

**Convert IC50 to pIC50** (better for ML):

```python
import numpy as np

# IC50 in nM → Convert to M, then -log10
df['pic50'] = -np.log10(df['ic50_nm'] * 1e-9)

# Example:
# IC50 = 27 nM → pIC50 = 7.57
# IC50 = 1500 nM → pIC50 = 5.82
# Higher pIC50 = more potent
```

**Remove Low-Variance Features**:

```python
# Drop descriptors with near-zero variance
desc_df = desc_df.loc[:, desc_df.var() > 0.01]
```

**Remove Correlated Features** (>0.95):

```python
corr_matrix = desc_df.corr().abs()
upper_tri = np.triu(np.ones(corr_matrix.shape), k=1).astype(bool)
to_drop = [col for col in corr_matrix.columns if any(corr_matrix.loc[col, upper_tri[idx]]) > 0.95 for idx in range(len(upper_tri))]

desc_df = desc_df.drop(columns=to_drop)
```

---

## Part C: Feature Selection

### SelectKBest (ANOVA F-test)

**Select top 50 features**:

```python
from sklearn.feature_selection import SelectKBest, f_regression

X = desc_df.values
y = df['pic50'].values

selector = SelectKBest(f_regression, k=50)
X_selected = selector.fit_transform(X, y)

selected_features = desc_df.columns[selector.get_support()].tolist()
print(f"Top 10 features: {selected_features[:10]}")
```

**Alternative**: Recursive Feature Elimination (RFE)

```python
from sklearn.feature_selection import RFE
from sklearn.ensemble import RandomForestRegressor

rf = RandomForestRegressor(n_estimators=100, random_state=42)
rfe = RFE(estimator=rf, n_features_to_select=50)
X_selected = rfe.fit_transform(X, y)
```

---

## Part D: Model Training

### Train-Test Split

```python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X_selected, y, test_size=0.2, random_state=42
)

print(f"Train: {len(X_train)}, Test: {len(X_test)}")
```

**Stratified Split** (if imbalanced):
```python
# Group by target (SERT vs PDE4)
from sklearn.model_selection import StratifiedShuffleSplit

stratify_by = df['target']  # SERT or PDE4
```

### Standardize Features

**Critical for ML**:

```python
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# Save scaler for predictions
import joblib
joblib.dump(scaler, 'analysis/python/ml-models/qsar-output/scaler.pkl')
```

### Random Forest

```python
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import GridSearchCV

param_grid = {
    'n_estimators': [100, 200, 300],
    'max_depth': [10, 20, 30, None],
    'min_samples_split': [2, 5, 10]
}

rf = RandomForestRegressor(random_state=42)
grid_search = GridSearchCV(rf, param_grid, cv=5, scoring='r2', n_jobs=-1)
grid_search.fit(X_train_scaled, y_train)

best_rf = grid_search.best_estimator_
print(f"Best R² (CV): {grid_search.best_score_:.3f}")
```

### XGBoost (Often Better)

```python
import xgboost as xgb

param_grid_xgb = {
    'n_estimators': [100, 200, 300],
    'max_depth': [3, 5, 7],
    'learning_rate': [0.01, 0.05, 0.1],
    'subsample': [0.7, 0.8, 0.9]
}

xgb_model = xgb.XGBRegressor(random_state=42, objective='reg:squarederror')
grid_search_xgb = GridSearchCV(xgb_model, param_grid_xgb, cv=5, scoring='r2')
grid_search_xgb.fit(X_train_scaled, y_train)

best_xgb = grid_search_xgb.best_estimator_
```

### Evaluate

```python
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error

y_pred_test = best_xgb.predict(X_test_scaled)

r2 = r2_score(y_test, y_pred_test)
rmse = np.sqrt(mean_squared_error(y_test, y_pred_test))
mae = mean_absolute_error(y_test, y_pred_test)

print(f"R² = {r2:.3f}")
print(f"RMSE = {rmse:.3f} pIC50 units")
print(f"MAE = {mae:.3f}")
```

**Target**: R² ≥ 0.80 for publication

---

## Part E: Model Interpretation (SHAP)

### Why SHAP?

- **Explains predictions**: Which descriptors drive high/low IC50?
- **Publication-ready**: Journals require interpretability
- **SAR insights**: Structure-Activity Relationships

### Calculate SHAP Values

```python
import shap

explainer = shap.TreeExplainer(best_xgb)
shap_values = explainer.shap_values(X_test_scaled)

# Summary plot (top 20 features)
shap.summary_plot(shap_values, X_test_scaled,
                  feature_names=selected_features,
                  max_display=20)

plt.savefig('analysis/python/ml-models/qsar-output/shap-summary.png', dpi=300)
```

### Interpret Results

**Summary Plot Shows**:
- **Feature Importance**: Top features ranked vertically
- **Impact**: Red = high feature value, Blue = low
- **Effect**: Right of 0 = increases pIC50 (more potent)

**Example Insight**:
```
LogP (high, red) → Right of 0 = Positive SHAP
→ Higher lipophilicity → Higher potency (SERT inhibition)
```

### Individual Predictions

**Explain why mesembrine has IC50 = 27 nM**:

```python
# Get one molecule
idx = 0  # Mesembrine
shap.waterfall_plot(shap.Explanation(
    values=shap_values[idx],
    base_values=explainer.expected_value,
    data=X_test_scaled[idx],
    feature_names=selected_features
))
```

---

## Part F: Improve Model (If R² < 0.80)

### Strategy 1: Add Mordred Descriptors

**Mordred = 1800+ descriptors** (vs RDKit's 200):

```bash
conda install -c conda-forge mordred
```

```python
from mordred import Calculator, descriptors

calc = Calculator(descriptors, ignore_3D=False)

mol = Chem.MolFromSmiles('CN1CCC2C(C1)Cc3ccc(cc3C2)OC')
mordred_desc = calc(mol)  # pandas Series with 1800+ values
```

**Combine RDKit + Mordred** → More features → Better R²

### Strategy 2: Add 3D Descriptors

**Generate 3D conformers**:

```python
from rdkit.Chem import AllChem

mol = Chem.MolFromSmiles(smiles)
mol = Chem.AddHs(mol)  # Add hydrogens
AllChem.EmbedMolecule(mol)  # Generate 3D coordinates
AllChem.UFFOptimizeMolecule(mol)  # Optimize geometry

# Now calculate 3D descriptors
# Example: Radius of gyration, moments of inertia
```

### Strategy 3: Ensemble Stacking

**Combine RF + XGBoost + LightGBM**:

```python
from sklearn.ensemble import StackingRegressor
from lightgbm import LGBMRegressor

estimators = [
    ('rf', best_rf),
    ('xgb', best_xgb),
    ('lgbm', LGBMRegressor(n_estimators=100))
]

stacking = StackingRegressor(estimators=estimators,
                              final_estimator=Ridge())
stacking.fit(X_train_scaled, y_train)

r2_stack = stacking.score(X_test_scaled, y_test)
print(f"Stacking R² = {r2_stack:.3f}")
```

### Strategy 4: Hyperparameter Tuning

**Use Bayesian Optimization** (smarter than GridSearch):

```bash
pip install optuna
```

```python
import optuna

def objective(trial):
    params = {
        'n_estimators': trial.suggest_int('n_estimators', 100, 500),
        'max_depth': trial.suggest_int('max_depth', 3, 10),
        'learning_rate': trial.suggest_float('learning_rate', 0.001, 0.1),
        'subsample': trial.suggest_float('subsample', 0.6, 1.0)
    }

    model = xgb.XGBRegressor(**params, random_state=42)
    model.fit(X_train_scaled, y_train)
    return r2_score(y_test, model.predict(X_test_scaled))

study = optuna.create_study(direction='maximize')
study.optimize(objective, n_trials=100)

print(f"Best R² = {study.best_value:.3f}")
print(f"Best params: {study.best_params}")
```

---

## Part G: Predictions for Untested Alkaloids

### Predict IC50

```python
# Load trained model
model = joblib.load('analysis/python/ml-models/qsar-output/xgb-model.pkl')
scaler = joblib.load('analysis/python/ml-models/qsar-output/scaler.pkl')

# New alkaloid (e.g., Tortuosamine, no IC50 data)
new_smiles = 'CN1CCC2C(C1)C=Cc3c2cccc3O'  # Example

# Calculate descriptors
new_mol = Chem.MolFromSmiles(new_smiles)
new_desc = calculator.CalcDescriptors(new_mol)

# Select same features as training
new_X = pd.DataFrame([new_desc], columns=descriptor_names)
new_X_selected = new_X[selected_features]
new_X_scaled = scaler.transform(new_X_selected)

# Predict
predicted_pic50 = model.predict(new_X_scaled)[0]
predicted_ic50_nm = 10**(-predicted_pic50) * 1e9

print(f"Predicted IC50 = {predicted_ic50_nm:.1f} nM")
```

**Experimental Validation**:
- Test top 5 predicted potent alkaloids in lab
- Compare predicted vs measured IC50
- Refine model

---

## Part H: Molecular Docking (Validation)

### AutoDock Vina Setup

**Install**:
```bash
# Linux
sudo apt install autodock-vina

# Mac
brew install autodock-vina

# Or via conda
conda install -c conda-forge vina
```

### Prepare Protein (SERT: PDB 6DZZ)

```bash
# Download PDB
wget https://files.rcsb.org/download/6DZZ.pdb

# Prepare with PyMOL or AutoDockTools
# Remove waters, add hydrogens, save as PDBQT
```

### Prepare Ligand (Mesembrine)

```python
from rdkit import Chem
from rdkit.Chem import AllChem

# SMILES → 3D SDF
mol = Chem.MolFromSmiles('CN1CCC2C(C1)Cc3ccc(cc3C2)OC')
mol = Chem.AddHs(mol)
AllChem.EmbedMolecule(mol)
AllChem.UFFOptimizeMolecule(mol)

# Save
writer = Chem.SDWriter('mesembrine.sdf')
writer.write(mol)
writer.close()

# Convert SDF → PDBQT (use Open Babel or MGLTools)
```

### Run Docking

```bash
vina --receptor 6DZZ.pdbqt \
     --ligand mesembrine.pdbqt \
     --center_x 12.5 --center_y -8.3 --center_z 23.1 \
     --size_x 20 --size_y 20 --size_z 20 \
     --out mesembrine_docked.pdbqt \
     --log docking.log
```

**Output**: Binding affinity (kcal/mol)

**Correlation**:
- More negative affinity → Higher binding → Lower IC50
- Compare QSAR predictions vs docking scores

---

## Troubleshooting

### R² < 0.70

**Solutions**:
1. More data (50+ compounds minimum)
2. Add Mordred descriptors
3. Try ensemble methods
4. Remove outliers (check for experimental errors)

### Overfitting (Train R² >> Test R²)

**Solutions**:
1. Reduce features (use RFE)
2. Increase regularization (Ridge, Lasso)
3. More cross-validation folds (10-fold)
4. Simpler model (Linear regression baseline)

### SHAP Slow for Large Models

**Solution**:
```python
# Use sample of data for SHAP
X_sample = shap.sample(X_test_scaled, 100)
shap_values = explainer.shap_values(X_sample)
```

---

## Best Practices

- **Target**: R² ≥ 0.80, RMSE < 0.5 pIC50
- **Validate**: External test set (not used in training)
- **Y-randomization**: Shuffle y, refit → R² should be ~0 (proves model not random)
- **Applicability Domain**: Don't predict for molecules too different from training set

---

## Publication Checklist

- [ ] R² ≥ 0.80 (test set)
- [ ] External validation (5-10 compounds)
- [ ] SHAP interpretation figure
- [ ] Feature importance table
- [ ] Predicted vs Actual plot
- [ ] Code deposited on GitHub/Zenodo

---

**Last Updated**: October 2025
**Script**: `analysis/python/cheminformatics/qsar-modeling.py`
**Output**: `analysis/python/ml-models/qsar-output/`
