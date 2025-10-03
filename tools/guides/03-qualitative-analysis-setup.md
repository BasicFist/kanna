# Guide 3: Qualitative Analysis with MAXQDA

**Analyse Qualitative Ethnographique : MAXQDA pour Entretiens FPIC et Codage Thématique**

⏱️ **Temps d'installation** : 1-2 heures
💾 **Prérequis** : MAXQDA license (~$600/year student, check university access), interview transcripts
🎯 **Objectif** : Coder 50-100 entretiens ethnobotaniques, calculer inter-rater reliability (κ ≥ 0.70)

---

## Quick Start

### Step 1: Check University License

**Before purchasing**:
```bash
# Email Université de Paris IT department:
# "Does U-Paris have institutional MAXQDA license?"
# Many universities provide free access to students
```

**If no institutional license**:
- Student license: ~€600/year (50% academic discount)
- 14-day free trial: https://www.maxqda.com/trial

### Step 2: Install MAXQDA 2024

1. Download from https://www.maxqda.com/download
2. Choose: Windows or Mac version
3. Install (requires ~2GB disk space)
4. Activate with license key (sent by email)

### Step 3: Create KANNA Project

```
MAXQDA → New Project
Project Name: KANNA-Ethnobotany
Location: ~/LAB/projects/KANNA/analysis/maxqda/
Save
```

---

## Part A: Import Data

### Supported Formats

**Text**:
- `.txt`, `.docx`, `.rtf` (interview transcripts)
- `.pdf` (academic papers for literature review)

**Media**:
- `.mp3`, `.wav`, `.m4a` (audio interviews)
- `.mp4`, `.mov` (video recordings)
- `.jpg`, `.png` (field photos)

**Tabular**:
- `.csv`, `.xlsx` (SurveyCTO export for mixed methods)

### Import Interview Transcripts

**Structure**: One file per interview

**Naming Convention**:
```
INT-20250315-SC01-P007.txt
Format: INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.txt
```

**Import**:
1. Document System (left panel)
2. Right-click → Import Documents
3. Navigate to: `~/LAB/projects/KANNA/fieldwork/interviews-raw/`
4. Select all `.txt` files (50-100 interviews)
5. MAXQDA creates document list

### Organize by Document Groups

**Create Folder Structure**:
```
📁 KANNA Interviews
  📁 Community SC01 (San Community 1)
    - INT-20250315-SC01-P001.txt
    - INT-20250316-SC01-P002.txt
    - ...
  📁 Community SC02 (San Community 2)
    - INT-20250320-SC02-P015.txt
    - ...
  📁 Community KH01 (Khoekhoe Community 1)
    - INT-20250401-KH01-P030.txt
    - ...
```

**Drag-and-drop** interviews into appropriate folders.

### Import Audio Files (Optional)

**Link transcripts to audio**:
1. Select transcript document
2. Right-click → Link Media File
3. Select corresponding `.mp3` file
4. MAXQDA syncs transcript ↔ audio timeline

**Use case**: Verify translations, capture tone/emotion

---

## Part B: Develop Coding Framework

### Deductive Codes (From Literature)

**Based on existing ethnobotany research**:

```
📂 Traditional Uses
  📂 Medicinal
    - Anxiety/Depression
    - Pain Relief
    - Appetite Stimulation
  📂 Ritual
    - Hunting Preparation
    - Spiritual Ceremonies
    - Initiation Rites
  📂 Social
    - Relaxation
    - Social Bonding
    - Conflict Resolution
  📂 Food
    - Hunger Suppressant
    - Nutritional

📂 Preparation Methods
  📂 Fermentation
    - Traditional Process
    - Modern Variants
  📂 Fresh Plant
    - Chewing
    - Infusion/Tea
  📂 Dried Plant
    - Smoking
    - Powder

📂 Knowledge Transmission
  - Intergenerational (Elder → Youth)
  - Restricted Knowledge (Sacred/Taboo)
  - Erosion (Colonial Suppression)
  - Revival (Contemporary Resurgence)

📂 Efficacy & Dosing
  - Traditional Indicators
  - Individual Variation
  - Combination with Other Plants

📂 Conservation Concerns
  - Overharvesting
  - Habitat Loss
  - Cultivation Efforts
```

### Create Code System in MAXQDA

1. **Code System Panel** (top right)
2. Right-click → New Code
3. Enter code name: "Traditional Uses"
4. Right-click "Traditional Uses" → New Subcode → "Medicinal"
5. Continue building hierarchy

**Shortcut**: Import from file
```
Tools → Import Code System → Select CSV
```

**CSV Format**:
```csv
Code,Parent
Traditional Uses,
Medicinal,Traditional Uses
Anxiety/Depression,Medicinal
Ritual,Traditional Uses
```

### Inductive Codes (From Data)

**Emerge during coding**:
- Read 5-10 interviews
- Note unexpected themes
- Add new codes as needed
- Example: "Gender-Specific Knowledge" (if patterns emerge)

---

## Part C: Coding Workflow

### Coding Interface

**4-Panel Layout**:
1. **Document System** (left): List of interviews
2. **Document Browser** (center): Text being coded
3. **Code System** (right top): Code hierarchy
4. **Retrieved Segments** (right bottom): Coded passages

### Code an Interview

**Step-by-Step**:
1. Open interview: Double-click `INT-20250315-SC01-P001.txt`
2. Read full transcript first (no coding, just understand)
3. **Second pass**: Code paragraph-by-paragraph

**Coding Technique**:
```
1. Highlight relevant text passage
2. Drag to code (or right-click → Code with...)
3. Apply multiple codes if needed (one passage can have 3+ codes)
4. Add memo for insights
```

**Example**:
```
[Transcript excerpt]
"We ferment kanna for 7 days, then chew it before hunting.
It helps with focus and hunger."

[Codes applied]
✓ Preparation Methods → Fermentation → Traditional Process
✓ Traditional Uses → Hunting Preparation
✓ Efficacy & Dosing → Traditional Indicators (focus, hunger)
```

### Memos & Annotations

**Add Context**:
- Right-click coded segment → Create Memo
- Write: "Informant emphasized 7-day fermentation (exact timing important)"

**Use Cases**:
- Surprising findings
- Contradictions with literature
- Questions for follow-up

---

## Part D: Inter-Rater Reliability

### Why IRR Matters

**Publication Requirement**:
- Demonstrates coding consistency
- Target: **Cohen's Kappa ≥ 0.70** (good agreement)

### Protocol

**Step 1: Select Sample** (10% of interviews)
```
50 interviews total → Code 5 independently
```

**Step 2: Independent Coding**
- You code 5 interviews
- Co-researcher (or supervisor) codes same 5
- No discussion before coding

**Step 3: Calculate Kappa in MAXQDA**

```
Analysis → Inter-Coder Agreement
Select Coder 1: [Your name]
Select Coder 2: [Co-researcher name]
Documents: [5 test interviews]
Method: Cohen's Kappa
Calculate
```

**Interpret Results**:
```
κ < 0.40: Poor agreement (revise code definitions)
κ = 0.40-0.59: Fair (needs improvement)
κ = 0.60-0.79: Good (acceptable for publication)
κ ≥ 0.80: Excellent
```

**If κ < 0.70**:
1. Review disagreements (which codes differ?)
2. Clarify code definitions (write codebook)
3. Re-code 5 new interviews
4. Recalculate until κ ≥ 0.70

---

## Part E: Analysis & Visualization

### Code Frequencies

**How often is each code used?**

```
Analysis → Code Frequencies
Export → CSV
```

**Example Output**:
```csv
Code,Frequency,% of Segments
Traditional Uses,287,45%
  Medicinal,156,24%
    Anxiety/Depression,89,14%
  Ritual,78,12%
```

**Interpretation**: Anxiety/Depression most common medicinal use (89 mentions)

### Code Matrix Browser

**Cross-tabulate**: Codes × Communities

```
Visual Tools → Code Matrix Browser
Rows: Codes (Traditional Uses → Medicinal → Anxiety)
Columns: Document Groups (SC01, SC02, KH01)
Display: Frequency
```

**Example**:
|                      | SC01 | SC02 | KH01 |
|----------------------|------|------|------|
| Anxiety/Depression   | 35   | 28   | 26   |
| Pain Relief          | 12   | 18   | 9    |

**Insight**: SC02 mentions pain relief more than others (cultural variation?)

### Code Relations Browser

**Find Co-Occurring Codes**:

```
Visual Tools → Code Relations Browser
Select codes: "Fermentation" + "Anxiety/Depression"
```

**Question**: Do informants who mention fermentation also mention anxiety treatment?

**Output**: Overlap diagram (Venn diagram style)

### MAXMaps: Concept Mapping

**Visualize Relationships**:
```
Visual Tools → MAXMaps → New Map
Drag codes onto canvas
Draw connections (arrows)
Annotate relationships
```

**Use Case**: Show how traditional preparation methods → specific efficacies

---

## Part F: Mixed Methods (Integrate with BEI/ICF)

### Export Coded Segments

**Quantitative Data from Qualitative Codes**:

```
Analysis → Code Frequencies → Export to Excel
```

**Calculate ICF from MAXQDA Data**:

**ICF Formula**:
```
ICF = (Nur - Nt) / (Nur - 1)
Nur = Number of use reports (code frequency)
Nt = Number of taxa mentioned
```

**In R** (using MAXQDA export):
```r
library(tidyverse)

# Import MAXQDA frequencies
maxqda_data <- read_csv("maxqda-export-use-categories.csv")

# Calculate ICF
icf <- maxqda_data %>%
  group_by(use_category) %>%
  summarise(
    n_use_reports = sum(frequency),
    n_taxa = n_distinct(taxon),  # From survey data
    icf = (n_use_reports - n_taxa) / (n_use_reports - 1)
  )

print(icf)
```

### Cross-Validate with SurveyCTO

**Compare**:
- SurveyCTO quantitative BEI → 0.72 taxa per informant
- MAXQDA qualitative themes → "High diversity of traditional uses"

**Triangulation**: Do qualitative and quantitative data agree?

---

## Part G: Reporting & Export

### Create Summary Report

```
Reports → Overview of Codes and Documents
Include:
  ✓ Code system with frequencies
  ✓ Most frequent codes
  ✓ Code distribution across document groups
Export → PDF
```

**Save to**: `analysis/maxqda/reports/kanna-ethnobotany-summary.pdf`

### Export for Publications

**Tables for Chapter 3**:

**Table 1: ICF by Use Category**
```
Analysis → Code Frequencies → Export Excel
Format for LaTeX table
```

**Table 2: Representative Quotes**
```
Retrieved Segments → Filter by code
Select best quotes (1-2 per theme)
Export → Word document
```

**Anonymization**:
```
Replace: "Informant 007 said..." → "One informant stated..."
Never use real names in publications
```

---

## Troubleshooting

### Issue 1: MAXQDA Slows Down with 100+ Documents

**Solution**:
- Analyze by document group (one community at a time)
- Close Retrieved Segments panel when not needed
- Increase RAM allocation: Settings → Performance → Max memory

### Issue 2: Codes Overlap Too Much

**Problem**: Every segment has 5+ codes (overly complex)

**Solution**:
- Simplify code system (merge similar codes)
- Use parent codes only for overview
- Detailed subcodes only for primary analysis

### Issue 3: Cannot Calculate Kappa (Different Code Sets)

**Problem**: You used codes A, B, C; co-researcher used A, D, E

**Solution**:
- Create shared codebook before independent coding
- Define each code precisely (with examples)
- Train co-researcher with 2 practice interviews first

---

## Best Practices

### Coding Quality
- **Code consistently**: Define clear inclusion/exclusion criteria
- **Memo frequently**: Document why you coded something
- **Review weekly**: Re-read coded segments, refine codes

### Ethical Coding
- **Respect restricted knowledge**: Don't code/publish sacred information
- **Anonymize quotes**: Never identify participants in outputs
- **Member check**: Validate interpretations with informants

### Efficiency
- **Use keyboard shortcuts**: F4 (last used code), F3 (search codes)
- **Code in batches**: 5-10 interviews per session (2-3 hours)
- **Save frequently**: MAXQDA auto-saves, but manual save recommended

---

## Next Steps

**Week 1**: Import interviews, build code system
**Week 2**: Code first 20 interviews
**Week 3**: Calculate inter-rater reliability (κ ≥ 0.70)
**Week 4**: Complete all interviews, generate visualizations

**Goal**: Fully coded corpus (50-100 interviews) by Month 18

---

## Alternative: ATLAS.ti

**If MAXQDA unavailable**:
- ATLAS.ti: Similar features, ~$800/year
- NVivo: $1,400 academic (expensive but powerful)
- Free option: **Taguette** (basic, open-source)

**Recommendation**: Stick with MAXQDA for ethnobotany (best balance features/cost)

---

## Further Resources

- MAXQDA Manual: https://www.maxqda.com/help-mx20
- Thematic Analysis Guide: https://www.maxqda.com/research-guides/thematic-analysis
- Inter-coder Agreement: https://www.maxqda.com/help-mx20/teamwork/intercoder-agreement

---

**Last Updated**: October 2025
**Workflow Integration**: Export to R for BEI/ICF calculations
