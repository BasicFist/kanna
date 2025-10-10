#!/usr/bin/env python3
"""
Enhanced Prompt Templates for Layer 2 Formula Validation

Adds statistical and clinical notation support to reduce LLM calls by 40%.

Based on Phase 3 diverse paper validation findings:
- Statistical errors: 6/15 remaining errors (40%)
- Clinical errors: 3/15 remaining errors (20%)
- Total new coverage: 9/15 errors (60%)

Author: KANNA Project - Phase 3 Production Enhancement
Date: 2025-10-10
"""

# Statistical Notation Error Patterns
# Examples from validation: ( < 5 0 \%, ( > 1 5 0 0, ( E = 0 . 9 \, ( > 8 0 \%
STATISTICAL_PATTERNS = {
    'percentage_comparison': {
        'pattern': r'\(\s*[<>=]+\s*\d+\s*\\%\s*$',
        'description': 'Percentage comparisons missing closing paren',
        'examples': [
            '( < 5 0 \\%',  # Missing )
            '( > 8 0 \\%',  # Missing )
        ],
        'fix': lambda f: f + ' )' if f.endswith('\\%') else f,
        'confidence': 0.85
    },
    'numeric_comparison': {
        'pattern': r'\(\s*[<>=]+\s*\d+\s*$',
        'description': 'Numeric comparisons missing closing paren',
        'examples': [
            '( > 1 5 0 0',  # Missing ) after species count
        ],
        'fix': lambda f: f + ' )' if not f.endswith(')') else f,
        'confidence': 0.80
    },
    'equation_parameter': {
        'pattern': r'\(\s*[A-Z]\s*=\s*[\d\.]+\s*\\?\s*$',
        'description': 'Statistical parameters with trailing backslash',
        'examples': [
            '( E = 0 . 9 \\',  # Trailing backslash
        ],
        'fix': lambda f: f.rstrip('\\').rstrip() + ' )' if '\\' in f else f + ' )',
        'confidence': 0.75
    }
}

# Clinical Notation Error Patterns
# Examples from validation: ( 1 / 1 2 ,, 2 3 . 1 \% ], 3 0 . 8 \%]
CLINICAL_PATTERNS = {
    'incidence_rate': {
        'pattern': r'\(\s*\d+\s*/\s*\d+\s*,\s*$',
        'description': 'Clinical incidence rates with trailing comma',
        'examples': [
            '( 1 / 1 2 ,',  # 1 out of 12 subjects
        ],
        'fix': lambda f: f.rstrip(',').rstrip() + ' )',
        'confidence': 0.80
    },
    'percentage_bracket_mismatch': {
        'pattern': r'^\s*\d+\s*\.\s*\d+\s*\\%\s*\]',
        'description': 'Percentage with mismatched ] instead of )',
        'examples': [
            '2 3 . 1 \\% ]',  # Should be ( 2 3 . 1 \% )
            '3 0 . 8 \\%]',   # Should be ( 3 0 . 8 \% )
        ],
        'fix': lambda f: '( ' + f.replace(']', ')').strip(),
        'confidence': 0.75
    },
    'subject_count': {
        'pattern': r'\(\s*\d+\s*/\s*\d+\s*[^)]*$',
        'description': 'Subject counts missing closing paren',
        'examples': [
            '( 3 / 1 3',  # 3 out of 13 subjects
        ],
        'fix': lambda f: f + ' )' if not f.endswith(')') else f,
        'confidence': 0.80
    }
}

# Experimental Data Enhancements
# Covers patterns discovered in diverse validation
EXPERIMENTAL_ENHANCEMENTS = {
    'unit_trailing_comma': {
        'pattern': r'\(\s*[\d\.]+\s*\\mathrm\s*\{[^}]+\}\s*,\s*$',
        'description': 'Measurements with unit and trailing comma',
        'examples': [
            '( 2 . 5 \\mathrm { m M } ,',  # Concentration
        ],
        'fix': lambda f: f.rstrip(',').rstrip() + ' )',
        'confidence': 0.85
    },
    'solvent_ratio_incomplete': {
        'pattern': r'\(\s*\d+\s*\{:\}\s*\d+\s*\{:\}\s*\d+\s*\\mathbf\s*\{\s*v\s*\}\s*/\s*$',
        'description': 'Solvent ratios missing v/v/v completion',
        'examples': [
            '( 1 { : } 1 { : } 3 \\ \\mathbf { v } /',  # Incomplete v/v/v
        ],
        'fix': lambda f: f + ' \\mathbf { v } / \\mathbf { v } )' if f.endswith('/') else f,
        'confidence': 0.80
    },
    'mass_spec_neutral_loss': {
        'pattern': r'\(\s*-\s*[\d\.]+\s*$',
        'description': 'Mass spectrometry neutral loss missing unit',
        'examples': [
            '( - 1 8 . 0 1 1 0',  # Water loss -18.0110 u
        ],
        'fix': lambda f: f + ' ~ \\mathrm { u } )' if f.startswith('( -') else f,
        'confidence': 0.90
    }
}


def categorize_error_enhanced(formula: str, context: str) -> str:
    """
    Enhanced error categorization with statistical and clinical support.

    Args:
        formula: LaTeX formula (without $ delimiters)
        context: Surrounding text (±100 chars)

    Returns:
        Error category string
    """
    import re

    ctx_lower = context.lower()

    # Priority 1: Statistical notation
    if any(keyword in ctx_lower for keyword in ['%', 'percent', 'species', 'genera', 'sampling', 'parameter', 'extinction', 'threshold']):
        # Check percentage patterns
        if re.search(r'[<>=].*\d+.*%', formula) or re.search(r'[<>=].*\d+\s*$', formula):
            return "statistical_notation"
        # Check equation parameters (handles "E = 0.9")
        if re.search(r'[A-Z]\s*=\s*[\d\.\s]+', formula):
            return "statistical_notation"

    # Priority 2: Clinical notation
    if any(keyword in ctx_lower for keyword in ['subject', 'patient', 'incidence', 'trial', 'placebo']):
        # Check fraction patterns (subject counts)
        if re.search(r'\d+\s*/\s*\d+', formula):
            return "clinical_notation"
        # Check percentage with bracket mismatch
        if ']' in formula and '%' in formula:
            return "clinical_notation"

    # Priority 3: Mass spectrometry
    if 'm/e' in ctx_lower or 'mass spectrum' in ctx_lower or 'neutral loss' in ctx_lower:
        return "mass_spectrometry"

    # Priority 4: NMR spectroscopy
    if 'nmr' in ctx_lower or any(x in ctx_lower for x in ['δ', 'delta', 'ppm']):
        return "nmr_spectroscopy"

    # Priority 5: X-ray crystallography
    if any(x in ctx_lower for x in ['cu-k', 'mo-k', 'x-ray', 'crystal', 'melting point', 'mp']):
        return "xray_crystallography"

    # Priority 6: Experimental data
    if 'yield' in ctx_lower or 'mg' in ctx_lower or 'ml' in ctx_lower or 'solvent' in ctx_lower:
        return "experimental_data"

    # Default: General chemistry
    return "general_chemistry"


def repair_formula_enhanced(formula: str, error_type: str) -> tuple[str, float]:
    """
    Enhanced formula repair with statistical and clinical support.

    Args:
        formula: LaTeX formula to repair
        error_type: Category from categorize_error_enhanced()

    Returns:
        Tuple of (corrected_formula, confidence_score)
    """
    import re

    original = formula
    confidence = 0.0

    # Statistical notation repairs
    if error_type == "statistical_notation":
        # Pattern 1: Percentage comparison missing ) (handles spaced numbers like "5 0")
        if re.search(r'\(\s*[<>=]+\s*[\d\s]+\s*\\%\s*$', formula):
            formula = formula.rstrip() + ' )'
            confidence = 0.85
        # Pattern 2: Numeric comparison missing ) (handles spaced numbers like "1 5 0 0")
        elif re.search(r'\(\s*[<>=]+\s*[\d\s]+\s*$', formula):
            formula = formula.rstrip() + ' )'
            confidence = 0.80
        # Pattern 3: Equation parameter with trailing backslash (handles "0 . 9")
        elif re.search(r'\(\s*[A-Z]\s*=\s*[\d\.\s]+\s*\\', formula):
            formula = formula.rstrip('\\').rstrip() + ' )'
            confidence = 0.75

    # Clinical notation repairs
    elif error_type == "clinical_notation":
        # Pattern 1: Incidence rate with trailing comma (handles spaced numbers like "1 / 1 2")
        if re.search(r'\(\s*[\d\s]+\s*/\s*[\d\s]+\s*,\s*$', formula):
            formula = formula.rstrip(',').rstrip() + ' )'
            confidence = 0.80
        # Pattern 2: Percentage with ] instead of ) (handles "2 3 . 1")
        elif re.search(r'[\d\s]+\s*\.\s*[\d\s]+\s*\\%\s*\]', formula):
            formula = '( ' + formula.replace(']', ')').strip()
            confidence = 0.75
        # Pattern 3: Subject count missing ) (handles spaced fractions)
        elif re.search(r'\(\s*[\d\s]+\s*/\s*[\d\s]+\s*$', formula):
            formula = formula.rstrip() + ' )'
            confidence = 0.80

    # Mass spectrometry repairs
    elif error_type == "mass_spectrometry":
        # Neutral loss missing unit (handles spaced numbers like "1 8 . 0 1 1 0")
        if re.search(r'\(\s*-\s*[\d\.\s]+\s*$', formula):
            formula = formula.rstrip() + ' ~ \\mathrm { u } )'
            confidence = 0.90
        # Missing opening paren (M - fragment))
        elif formula.count(')') > formula.count('(') and ('M -' in formula or 'M ^' in formula):
            formula = '( ' + formula
            confidence = 0.90

    # NMR spectroscopy repairs
    elif error_type == "nmr_spectroscopy":
        if formula.count('(') > formula.count(')'):
            formula = formula + ' )'
            confidence = 0.85

    # X-ray crystallography repairs
    elif error_type == "xray_crystallography":
        # Melting point notation with tilde
        if '\\tilde' in formula:
            formula = formula.replace('\\tilde { \\ m p }', '\\mathrm { m p ~')
            if formula.count('(') > formula.count(')'):
                formula = '( ' + formula if not formula.startswith('(') else formula
                formula = formula + ' )' if not formula.endswith(')') else formula
            confidence = 0.95
        elif formula.count('(') > formula.count(')'):
            formula = formula + ' )'
            confidence = 0.90

    # Experimental data repairs
    elif error_type == "experimental_data":
        # Unit with trailing comma
        if re.search(r'\\mathrm\s*\{[^}]+\}\s*,\s*$', formula):
            formula = formula.rstrip(',').rstrip() + ' )'
            confidence = 0.85
        # Solvent ratio incomplete v/v/v
        elif re.search(r'\\mathbf\s*\{\s*v\s*\}\s*/\s*$', formula):
            formula = formula + ' \\mathbf { v } / \\mathbf { v } )'
            confidence = 0.80
        # Missing closing paren (general)
        elif formula.count('(') > formula.count(')'):
            formula = formula + ' )'
            confidence = 0.85

    # General chemistry repairs
    elif error_type == "general_chemistry":
        if formula.count('(') > formula.count(')'):
            if formula.endswith(' H ') or formula.endswith(' N '):
                formula = formula + ' )'
                confidence = 0.70
        elif formula.count(')') > formula.count('('):
            formula = '( ' + formula
            confidence = 0.70

    # Validate correction
    if formula != original:
        # Check if still has structural errors
        if (formula.count('(') != formula.count(')') or
            formula.count('{') != formula.count('}') or
            formula.count('[') != formula.count(']')):
            return None, 0.0
        return formula, confidence

    return None, 0.0


# Confidence thresholds by error type
CONFIDENCE_THRESHOLDS = {
    'statistical_notation': 0.70,
    'clinical_notation': 0.70,
    'mass_spectrometry': 0.85,
    'nmr_spectroscopy': 0.80,
    'xray_crystallography': 0.85,
    'experimental_data': 0.80,
    'general_chemistry': 0.70
}


if __name__ == "__main__":
    # Test cases from Phase 3 diverse validation
    test_cases = [
        # Statistical notation
        ('( < 5 0 \\%', 'sampling threshold (>80%)', 'statistical_notation'),
        ('( > 1 5 0 0', 'species count >1500', 'statistical_notation'),
        ('( E = 0 . 9 \\', 'extinction parameter E = 0.9', 'statistical_notation'),

        # Clinical notation
        ('( 1 / 1 2 ,', 'incidence rate (1/12 subjects)', 'clinical_notation'),
        ('2 3 . 1 \\% ]', 'adverse events 3/13 subjects (23.1%)', 'clinical_notation'),

        # Mass spectrometry
        ('( - 1 8 . 0 1 1 0', 'neutral loss of water', 'mass_spectrometry'),

        # Experimental
        ('( 2 . 5 \\mathrm { m M } ,', 'MgCl2 concentration (2.5 mM)', 'experimental_data'),
    ]

    print("Enhanced Prompt Template Test Suite")
    print("=" * 60)

    for formula, context, expected_type in test_cases:
        detected_type = categorize_error_enhanced(formula, context)
        corrected, confidence = repair_formula_enhanced(formula, detected_type)

        print(f"\nFormula:  {formula}")
        print(f"Context:  {context}")
        print(f"Expected: {expected_type}")
        print(f"Detected: {detected_type}")
        print(f"Result:   {corrected if corrected else 'No correction'}")
        print(f"Confidence: {confidence:.2f}" if confidence > 0 else "N/A")
        print(f"Status:   {'✓ PASS' if detected_type == expected_type and corrected else '✗ FAIL'}")
