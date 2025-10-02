#!/usr/bin/env python3
"""
=============================================================================
QSAR Modeling for Sceletium Alkaloids - PDE4/SERT Inhibition
=============================================================================
Purpose: Build predictive QSAR models for PDE4 and SERT inhibition

Target: Predict IC50 values for 32+ Sceletium alkaloids
Methods: Random Forest, XGBoost, Neural Networks

Reference: Chapter 4 - Pharmacology & Neurobiology

Author: [Your name]
Date: October 2025
=============================================================================
"""

import pandas as pd
import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt
import seaborn as sns

# RDKit for molecular descriptors
from rdkit import Chem
from rdkit.Chem import Descriptors, AllChem, DataStructs
from rdkit.ML.Descriptors import MoleculeDescriptors

# Machine learning
from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_error
import xgboost as xgb

# Feature selection
from sklearn.feature_selection import SelectKBest, f_regression, RFE

# Model interpretation
import shap

# Suppress warnings
import warnings
warnings.filterwarnings('ignore')

# =============================================================================
# CONFIGURATION
# =============================================================================

# Paths
DATA_PATH = Path("data/phytochemical/alkaloid-profiles/sert-ic50.csv")
OUTPUT_DIR = Path("analysis/python/ml-models/qsar-output")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# Random seed for reproducibility
RANDOM_STATE = 42
np.random.seed(RANDOM_STATE)

# =============================================================================
# 1. LOAD DATA
# =============================================================================

print("=" * 80)
print("QSAR Modeling Pipeline for Sceletium Alkaloids")
print("=" * 80)

print("\n1. Loading chemical data...")
df = pd.read_csv(DATA_PATH)

# Expected columns: 'compound', 'smiles', 'ic50_nm', 'target' (PDE4/SERT)
print(f"Loaded {len(df)} compounds")
print(f"Targets: {df['target'].value_counts().to_dict()}")

# Convert IC50 to pIC50 (-log10(IC50 in M))
# IC50 in nM → Convert to M first
df['pic50'] = -np.log10(df['ic50_nm'] * 1e-9)
print(f"\npIC50 range: {df['pic50'].min():.2f} - {df['pic50'].max():.2f}")

# =============================================================================
# 2. CALCULATE MOLECULAR DESCRIPTORS
# =============================================================================

print("\n2. Calculating molecular descriptors...")

def calculate_descriptors(smiles_list):
    """
    Calculate 200+ molecular descriptors using RDKit
    """
    # Get all available descriptor names
    descriptor_names = [desc[0] for desc in Descriptors._descList]
    calculator = MoleculeDescriptors.MolecularDescriptorCalculator(descriptor_names)

    descriptors_list = []
    valid_indices = []

    for idx, smiles in enumerate(smiles_list):
        mol = Chem.MolFromSmiles(smiles)
        if mol is not None:
            descriptors = calculator.CalcDescriptors(mol)
            descriptors_list.append(descriptors)
            valid_indices.append(idx)
        else:
            print(f"Warning: Invalid SMILES at index {idx}: {smiles}")

    # Create DataFrame
    desc_df = pd.DataFrame(descriptors_list, columns=descriptor_names, index=valid_indices)

    # Remove constant columns (zero variance)
    desc_df = desc_df.loc[:, desc_df.var() > 0.01]

    # Remove highly correlated features (>0.95 correlation)
    corr_matrix = desc_df.corr().abs()
    upper_triangle = corr_matrix.where(
        np.triu(np.ones(corr_matrix.shape), k=1).astype(bool)
    )
    to_drop = [col for col in upper_triangle.columns if any(upper_triangle[col] > 0.95)]
    desc_df = desc_df.drop(columns=to_drop)

    print(f"Calculated {desc_df.shape[1]} descriptors for {len(desc_df)} compounds")
    print(f"Removed {len(to_drop)} highly correlated features")

    return desc_df

# Calculate descriptors
descriptors_df = calculate_descriptors(df['smiles'])

# Merge with original data
df_valid = df.loc[descriptors_df.index].reset_index(drop=True)
descriptors_df = descriptors_df.reset_index(drop=True)

print(f"\nFinal dataset: {len(df_valid)} compounds × {descriptors_df.shape[1]} features")

# =============================================================================
# 3. FEATURE SELECTION
# =============================================================================

print("\n3. Performing feature selection...")

# Prepare X and y
X = descriptors_df.values
y = df_valid['pic50'].values

# Method 1: SelectKBest (ANOVA F-test)
k_best = 50  # Select top 50 features
selector_univariate = SelectKBest(f_regression, k=k_best)
X_selected = selector_univariate.fit_transform(X, y)

selected_features = descriptors_df.columns[selector_univariate.get_support()].tolist()
print(f"Selected {len(selected_features)} features using SelectKBest")
print(f"Top 10 features: {selected_features[:10]}")

# Create reduced DataFrame
X_df = pd.DataFrame(X_selected, columns=selected_features)

# =============================================================================
# 4. TRAIN-TEST SPLIT
# =============================================================================

print("\n4. Splitting data into train/test sets...")

X_train, X_test, y_train, y_test = train_test_split(
    X_df, y, test_size=0.2, random_state=RANDOM_STATE
)

print(f"Training set: {len(X_train)} compounds")
print(f"Test set: {len(X_test)} compounds")

# Standardize features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# =============================================================================
# 5. TRAIN RANDOM FOREST MODEL
# =============================================================================

print("\n5. Training Random Forest model...")

# Hyperparameter tuning with GridSearchCV
param_grid_rf = {
    'n_estimators': [100, 200, 300],
    'max_depth': [10, 20, 30, None],
    'min_samples_split': [2, 5, 10],
    'min_samples_leaf': [1, 2, 4]
}

rf_model = RandomForestRegressor(random_state=RANDOM_STATE)
grid_search_rf = GridSearchCV(
    rf_model, param_grid_rf, cv=5, scoring='r2', n_jobs=-1, verbose=1
)
grid_search_rf.fit(X_train_scaled, y_train)

best_rf = grid_search_rf.best_estimator_
print(f"\nBest RF parameters: {grid_search_rf.best_params_}")

# Evaluate on test set
y_pred_rf_train = best_rf.predict(X_train_scaled)
y_pred_rf_test = best_rf.predict(X_test_scaled)

r2_train_rf = r2_score(y_train, y_pred_rf_train)
r2_test_rf = r2_score(y_test, y_pred_rf_test)
rmse_test_rf = np.sqrt(mean_squared_error(y_test, y_pred_rf_test))
mae_test_rf = mean_absolute_error(y_test, y_pred_rf_test)

print(f"\nRandom Forest Performance:")
print(f"  R² (train): {r2_train_rf:.3f}")
print(f"  R² (test):  {r2_test_rf:.3f}")
print(f"  RMSE (test): {rmse_test_rf:.3f}")
print(f"  MAE (test):  {mae_test_rf:.3f}")

# =============================================================================
# 6. TRAIN XGBOOST MODEL
# =============================================================================

print("\n6. Training XGBoost model...")

param_grid_xgb = {
    'n_estimators': [100, 200, 300],
    'max_depth': [3, 5, 7],
    'learning_rate': [0.01, 0.05, 0.1],
    'subsample': [0.7, 0.8, 0.9]
}

xgb_model = xgb.XGBRegressor(random_state=RANDOM_STATE, objective='reg:squarederror')
grid_search_xgb = GridSearchCV(
    xgb_model, param_grid_xgb, cv=5, scoring='r2', n_jobs=-1, verbose=1
)
grid_search_xgb.fit(X_train_scaled, y_train)

best_xgb = grid_search_xgb.best_estimator_
print(f"\nBest XGBoost parameters: {grid_search_xgb.best_params_}")

# Evaluate on test set
y_pred_xgb_train = best_xgb.predict(X_train_scaled)
y_pred_xgb_test = best_xgb.predict(X_test_scaled)

r2_train_xgb = r2_score(y_train, y_pred_xgb_train)
r2_test_xgb = r2_score(y_test, y_pred_xgb_test)
rmse_test_xgb = np.sqrt(mean_squared_error(y_test, y_pred_xgb_test))
mae_test_xgb = mean_absolute_error(y_test, y_pred_xgb_test)

print(f"\nXGBoost Performance:")
print(f"  R² (train): {r2_train_xgb:.3f}")
print(f"  R² (test):  {r2_test_xgb:.3f}")
print(f"  RMSE (test): {rmse_test_xgb:.3f}")
print(f"  MAE (test):  {mae_test_xgb:.3f}")

# =============================================================================
# 7. MODEL INTERPRETATION WITH SHAP
# =============================================================================

print("\n7. Interpreting model with SHAP values...")

# SHAP explanation for XGBoost
explainer = shap.TreeExplainer(best_xgb)
shap_values = explainer.shap_values(X_test_scaled)

# Summary plot
plt.figure(figsize=(10, 8))
shap.summary_plot(shap_values, X_test, feature_names=selected_features, show=False)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "shap-summary-plot.png", dpi=300)
print(f"SHAP summary plot saved to {OUTPUT_DIR / 'shap-summary-plot.png'}")

# =============================================================================
# 8. VISUALIZATIONS
# =============================================================================

print("\n8. Generating visualizations...")

# 1. Actual vs Predicted plot (XGBoost)
fig, ax = plt.subplots(figsize=(8, 8))
ax.scatter(y_test, y_pred_xgb_test, alpha=0.6, edgecolors='k')
ax.plot([y_test.min(), y_test.max()], [y_test.min(), y_test.max()],
        'r--', lw=2, label='Perfect prediction')
ax.set_xlabel('Actual pIC50', fontsize=12)
ax.set_ylabel('Predicted pIC50', fontsize=12)
ax.set_title(f'XGBoost QSAR Model\nR² = {r2_test_xgb:.3f}, RMSE = {rmse_test_xgb:.3f}',
             fontsize=14)
ax.legend()
ax.grid(alpha=0.3)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "actual-vs-predicted-xgb.png", dpi=300)

# 2. Feature importance
feature_importance = pd.DataFrame({
    'feature': selected_features,
    'importance': best_xgb.feature_importances_
}).sort_values('importance', ascending=False)

plt.figure(figsize=(10, 8))
sns.barplot(data=feature_importance.head(20), x='importance', y='feature', palette='viridis')
plt.title('Top 20 Most Important Molecular Descriptors', fontsize=14)
plt.xlabel('Importance Score', fontsize=12)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "feature-importance-xgb.png", dpi=300)

print(f"Visualizations saved to {OUTPUT_DIR}")

# =============================================================================
# 9. EXPORT RESULTS
# =============================================================================

print("\n9. Exporting results...")

# Save models
import joblib
joblib.dump(best_xgb, OUTPUT_DIR / "xgb-model.pkl")
joblib.dump(best_rf, OUTPUT_DIR / "rf-model.pkl")
joblib.dump(scaler, OUTPUT_DIR / "scaler.pkl")

# Save feature list
pd.DataFrame({'feature': selected_features}).to_csv(
    OUTPUT_DIR / "selected-features.csv", index=False
)

# Save predictions
results_df = pd.DataFrame({
    'compound': df_valid.loc[X_test.index, 'compound'].values,
    'actual_pic50': y_test,
    'predicted_pic50_xgb': y_pred_xgb_test,
    'predicted_pic50_rf': y_pred_rf_test,
    'error_xgb': y_test - y_pred_xgb_test
})
results_df.to_csv(OUTPUT_DIR / "predictions.csv", index=False)

# Save performance metrics
metrics_df = pd.DataFrame({
    'model': ['Random Forest', 'XGBoost'],
    'r2_train': [r2_train_rf, r2_train_xgb],
    'r2_test': [r2_test_rf, r2_test_xgb],
    'rmse_test': [rmse_test_rf, rmse_test_xgb],
    'mae_test': [mae_test_rf, mae_test_xgb]
})
metrics_df.to_csv(OUTPUT_DIR / "model-performance.csv", index=False)

print("\n" + "=" * 80)
print("QSAR MODELING COMPLETE")
print("=" * 80)
print(f"\nResults saved to: {OUTPUT_DIR}")
print("\nBest model: XGBoost")
print(f"  R² = {r2_test_xgb:.3f}")
print(f"  RMSE = {rmse_test_xgb:.3f} pIC50 units")
print("\nNext steps:")
print("1. Validate on external test set if available")
print("2. Use model to predict IC50 for untested alkaloids")
print("3. Interpret SHAP values to understand SAR")
print("4. Write up methods & results for Chapter 4")
