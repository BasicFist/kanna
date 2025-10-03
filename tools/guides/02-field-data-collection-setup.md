# Guide 2: Field Data Collection Setup

**Collecte de Données de Terrain : SurveyCTO pour Recherche Ethnobotanique FPIC**

⏱️ **Temps d'installation** : 2-3 heures
📱 **Prérequis** : Tablet Android/iOS, compte SurveyCTO, protocoles FPIC approuvés
🎯 **Objectif** : Collecte offline de données BEI/ICF avec conformité FPIC/GDPR

---

## Table des Matières

1. [SurveyCTO Account Setup](#part-a-surveycto-account-setup)
2. [BEI Survey Form Design](#part-b-bei-survey-form-design)
3. [Mobile App Configuration](#part-c-mobile-app-configuration)
4. [Offline Data Collection Protocol](#part-d-offline-data-collection-protocol)
5. [Data Export to R Analysis](#part-e-data-export-to-r-analysis)
6. [FPIC Compliance](#fpic-compliance-checklist)

---

## Part A: SurveyCTO Account Setup

### Step 1: Create Academic Account

**Pricing Check**:
- Academic: ~$49/month (check for educational discounts)
- Alternative: KoboToolbox (free for nonprofits)

**Registration**:
1. Visit https://www.surveycto.com/
2. Click "Try SurveyCTO Free" (14-day trial)
3. Use academic email (@u-paris.fr)
4. Organization: "Université de Paris - KANNA Thesis"
5. Research focus: "Ethnobotany / Traditional Knowledge"

**Verify Account**:
- Email confirmation link
- Login to SurveyCTO Console

### Step 2: Configure Server Settings

**Server Dashboard** (https://[your-server].surveycto.com):

1. **Users & Permissions**:
   - Add team members (if collaborating)
   - Roles: Data Collector, Data Viewer, Admin
   - For solo work: Admin role only

2. **Offline Mode**:
   - Settings → Data Collection → ✅ Enable offline submissions
   - Cache duration: 30 days (for remote fieldwork)

3. **Security**:
   - ✅ Encrypt data at rest
   - ✅ Require authentication
   - ✅ Enable audit logs (FPIC compliance)

### Step 3: Download SurveyCTO Desktop

**Why Desktop App?**
- Form design easier on computer
- Test forms before deploying to mobile
- Offline form deployment

**Installation**:
1. Download from https://www.surveycto.com/downloads/
2. Install SurveyCTO Desktop (Windows/Mac)
3. Login with server credentials

---

## Part B: BEI Survey Form Design

### Overview: Ethnobotanical Survey Structure

**Purpose**: Collect data for BEI and ICF calculations

**Expected Fields**:
- Informant demographics (age, gender, community)
- Plant taxa cited (Sceletium varieties, other medicinals)
- Use categories (medicinal, ritual, food)
- Preparation methods (fermentation, infusion, chewing)
- GPS coordinates (collection sites)
- FPIC consent (audio recording)

### Step 1: Create New Form

**In SurveyCTO Desktop**:
1. File → New Form
2. Form ID: `kanna_bei_survey`
3. Form Title: "KANNA Ethnobotanical Survey - BEI/ICF Data"

### Step 2: Form Structure (XLSForm)

SurveyCTO uses **XLSForm** format (Excel-based).

**Download Template**: Create Excel file with 3 sheets:
1. `survey` (questions)
2. `choices` (multiple choice options)
3. `settings` (form metadata)

#### Sheet 1: Survey

| type | name | label (français) | label (english) | required | constraint | hint |
|------|------|-----------------|-----------------|----------|------------|------|
| start | start_time | | | | | |
| text | informant_id | ID Informateur | Informant ID | yes | regex(., '^INF-\d{3}$') | Format: INF-001 |
| select_one communities | community_code | Code Communauté | Community Code | yes | | Ex: SC01, SC02 |
| geopoint | gps_location | Localisation GPS | GPS Location | yes | | Précision <10m |
| integer | age | Âge | Age | yes | . >= 18 | Adultes 18+ |
| select_one gender | gender | Genre | Gender | no | | |
| audio | fpic_consent | Consentement FPIC (audio) | FPIC Consent (audio) | yes | | Enregistrer consentement oral |
| begin repeat | taxa_cited | | Taxa Cited | | | |
| text | taxon_name | Nom de la plante | Plant name | yes | | Nom vernaculaire |
| select_one use_categories | use_category | Catégorie d'usage | Use category | yes | | |
| text | preparation_method | Méthode de préparation | Preparation method | no | | Fermentation, infusion, etc. |
| integer | n_uses | Nombre d'usages | Number of uses | no | | Combien d'usages pour cette plante? |
| end repeat | | | | | | |
| image | photo_specimen | Photo specimen (optionnel) | Photo specimen (optional) | no | | |
| text | notes | Notes de terrain | Field notes | no | | Observations additionnelles |
| end | end_time | | | | | |

#### Sheet 2: Choices

| list_name | name | label (français) | label (english) |
|-----------|------|-----------------|-----------------|
| communities | SC01 | San Community 1 | San Community 1 |
| communities | SC02 | San Community 2 | San Community 2 |
| communities | SC03 | San Community 3 | San Community 3 |
| communities | KH01 | Khoekhoe Community 1 | Khoekhoe Community 1 |
| gender | male | Masculin | Male |
| gender | female | Féminin | Female |
| gender | other | Autre | Other |
| gender | prefer_not_say | Préfère ne pas dire | Prefer not to say |
| use_categories | medicinal | Médicinal | Medicinal |
| use_categories | ritual | Rituel | Ritual |
| use_categories | food | Alimentation | Food |
| use_categories | social | Social (relaxation) | Social (relaxation) |
| use_categories | hunting | Chasse | Hunting |
| use_categories | other | Autre | Other |

#### Sheet 3: Settings

| form_title | form_id | version | default_language |
|------------|---------|---------|------------------|
| KANNA Ethnobotanical Survey | kanna_bei_survey | 2025-10-v1 | français |

### Step 3: Upload Form to Server

**In SurveyCTO Desktop**:
1. Design → Upload Form to Server
2. Select Excel file (`kanna_bei_survey.xlsx`)
3. Preview form (check all questions render correctly)
4. Deploy to server

**Verify**:
- Login to web console: https://[server].surveycto.com
- Forms → kanna_bei_survey should appear

### Step 4: Test Form on Web

**Before deploying to mobile, test**:
1. Web Console → Forms → kanna_bei_survey → "Try form"
2. Fill out sample data:
   - Informant ID: `INF-001`
   - Community: `SC01`
   - Add 3 taxa (Sceletium tortuosum, other medicinals)
   - Record test audio consent
3. Submit → Verify data appears in "Review and Correct"

---

## Part C: Mobile App Configuration

### Step 1: Install SurveyCTO Collect on Tablet

**Android**:
1. Google Play Store → Search "SurveyCTO Collect"
2. Install (free app)

**iOS**:
1. App Store → "SurveyCTO Collect"
2. Install

### Step 2: Configure Server Connection

**Open SurveyCTO Collect**:
1. Settings (⚙️ icon)
2. Server Settings:
   - Server URL: `https://[your-server].surveycto.com`
   - Username: [your email]
   - Password: [your password]
3. Save

**Test Connection**:
1. Tap "Get Blank Form"
2. Should see `kanna_bei_survey` (version 2025-10-v1)
3. Download form (stores locally for offline use)

### Step 3: Enable Offline Mode

**Critical for Remote Fieldwork**:

1. Settings → Form Management
   - ✅ Auto-send when WiFi available
   - ✅ Auto-update forms weekly
   - ✅ Delete after send: No (keep 30 days for backup)

2. Settings → User Interface
   - Language: Français
   - Font size: Large (for outdoor visibility)

3. Settings → Maps
   - ✅ Download offline maps (OpenStreetMap)
   - Region: Northern Cape, South Africa
   - Zoom levels: 5-15

### Step 4: Pre-Load Baseline Data

**Why Pre-Load?**
- Faster data entry (no typing repetitive info)
- Consistency (standardized community codes, taxa spellings)

**Create CSV** (`data/ethnobotanical/baseline/communities.csv`):
```csv
community_code,community_name,gps_latitude,gps_longitude
SC01,San Community Richtersveld,-28.5,17.2
SC02,San Community Namaqualand,-29.1,17.8
KH01,Khoekhoe Community Springbok,-29.7,17.9
```

**Upload to SurveyCTO**:
1. Web Console → Datasets → Upload CSV
2. Link to form field: `community_code`
3. Sync to mobile → Settings → Download datasets

### Step 5: Test GPS Accuracy

**GPS Requirements for FPIC**:
- Precision: <10m (to protect exact locations)
- Round coordinates to 0.01° (~1km) before publishing

**Test**:
1. Open form on mobile
2. Navigate to GPS question
3. Wait for accuracy <10m (may take 30-60s outdoors)
4. Record location
5. Verify coordinates look correct (Northern Cape region)

**Troubleshooting GPS**:
- Ensure location services enabled (Settings → Privacy → Location)
- Use outdoor location (buildings block satellites)
- Wait 2-3 minutes for initial fix

---

## Part D: Offline Data Collection Protocol

### Pre-Fieldwork Checklist

**1 Week Before**:
- [ ] FPIC protocols approved by ethics committee
- [ ] Community elders consent to research
- [ ] Translator arranged (if needed for Khoekhoe/Ju languages)
- [ ] Tablet charged, offline maps downloaded
- [ ] Backup battery pack (solar charger for multi-day trips)
- [ ] SurveyCTO forms updated, tested

**1 Day Before**:
- [ ] Download latest form version
- [ ] Test audio recording quality
- [ ] GPS accuracy verified (<10m)
- [ ] Backup plan if tech fails (paper forms as backup)

### FPIC Consent Protocol

**Before Each Interview**:

1. **Explain Research** (in local language):
   - Purpose: Document traditional knowledge of *Sceletium tortuosum*
   - How data will be used: PhD thesis, potential publications
   - Data storage: De-identified, encrypted
   - Right to withdraw: At any time, no penalty
   - Benefit-sharing: Results shared with community before publication

2. **Record Oral Consent** (audio):
   - "Do you consent to participate in this research?"
   - "Do you understand you can withdraw at any time?"
   - "Do you consent to audio recording this interview?"
   - Save audio file with informant ID: `FPIC-INF-001.mp3`

3. **Assign Participant ID**:
   - Never use real names in digital files
   - Format: `INF-001`, `INF-002`, etc.
   - Keep name ↔ ID mapping in encrypted offline notebook (not digital)

### Interview Workflow

**Step 1: Open Form**
```
SurveyCTO Collect → Fill Blank Form → kanna_bei_survey
```

**Step 2: Basic Information**
- Informant ID: `INF-005`
- Community: Select `SC01`
- GPS: Wait for <10m accuracy, tap "Record"
- Age, Gender (if willing to share)

**Step 3: FPIC Consent**
- Tap audio recorder
- Explain in local language
- Record consent (30-60 seconds)
- Save

**Step 4: Taxa Cited** (Repeating Group)
- "Which plants do you use for health/wellbeing?"
- For each plant:
  - Vernacular name: "kanna", "channa", "kougoed"
  - Use category: Medicinal, Ritual, Social, etc.
  - Preparation: Fermentation process, chewing fresh, etc.
  - Number of uses: How many different uses for this plant?

**Repeat** until all taxa cited

**Step 5: Field Notes**
- Any contextual observations
- Weather, time of day
- Community events happening
- Informant's mood/openness

**Step 6: Save Locally**
- Tap "Finalize Form"
- Data saved to tablet (encrypted)
- Will auto-sync when WiFi available

### Post-Interview Protocol

**Same Day**:
- [ ] Review data quality (all required fields filled?)
- [ ] Backup tablet data to laptop (if accessible)
- [ ] Update field log (handwritten: date, location, informant count)

**End of Field Mission**:
- [ ] Sync all submissions to SurveyCTO server (WiFi/cellular)
- [ ] Verify all data uploaded (count submissions)
- [ ] Backup audio files separately (encrypted USB drive)
- [ ] Delete data from tablet after verified upload

---

## Part E: Data Export to R Analysis

### Step 1: Download Data from Server

**Web Console**:
1. Login: https://[server].surveycto.com
2. Export → Export Data
3. Options:
   - Format: **CSV (long)**
   - Include: All submissions
   - Decrypt: Yes (uses your password)
4. Download ZIP file

**Extract**:
```bash
cd ~/LAB/projects/KANNA/data/ethnobotanical/surveys/
unzip surveycto-export-kanna-bei-2025-10.zip
# Creates: kanna_bei_survey.csv
```

### Step 2: Verify Data Structure

**Expected Columns** (for BEI calculation):
```
informant_id, community_code, taxon_name, use_category, n_uses, gps_location
```

**Check CSV**:
```bash
head -5 kanna_bei_survey.csv
```

**Expected Output**:
```csv
informant_id,community_code,taxon_name,use_category,n_uses,gps_latitude,gps_longitude
INF-001,SC01,Sceletium tortuosum,medicinal,3,-28.5123,17.2456
INF-001,SC01,Hoodia gordonii,food,1,-28.5123,17.2456
INF-002,SC01,Sceletium tortuosum,ritual,2,-28.5089,17.2401
```

### Step 3: Data Cleaning

**Anonymize GPS Coordinates**:
```r
# Round to 0.01° (~1km precision) to protect exact locations
library(tidyverse)

data <- read_csv("kanna_bei_survey.csv")

data_clean <- data %>%
  mutate(
    gps_latitude = round(gps_latitude, 2),
    gps_longitude = round(gps_longitude, 2)
  )

write_csv(data_clean, "survey-2025-anonymized.csv")
```

**Check for Duplicates**:
```r
# Ensure no duplicate informant IDs
duplicates <- data_clean %>%
  count(informant_id) %>%
  filter(n > 1)

if(nrow(duplicates) > 0) {
  warning("Duplicate informant IDs found!")
}
```

### Step 4: Run BEI Analysis

**Already have script**: `analysis/r-scripts/ethnobotany/calculate-bei.R`

```bash
# Make sure CSV path matches script expectations
# Script expects: data/ethnobotanical/surveys/survey-2025.csv

cp survey-2025-anonymized.csv survey-2025.csv

# Run analysis
Rscript ~/LAB/projects/KANNA/analysis/r-scripts/ethnobotany/calculate-bei.R
```

**Expected Output**:
```
analysis/r-scripts/ethnobotany/output/bei/
├── bei-by-community.png
├── icf-by-category.png
├── taxa-distribution-by-community.png
├── bei-results.csv
├── icf-results.csv
└── statistical-tests.txt
```

### Step 5: Verify Results

**Check BEI Values**:
```r
# Load results
bei <- read_csv("analysis/r-scripts/ethnobotany/output/bei/bei-results.csv")

print(bei)
# Expected:
#   community  n_informants  n_taxa   bei
#   SC01       25            18       0.72
#   SC02       30            22       0.73
```

**Interpretation**:
- BEI = 0.72 means 0.72 taxa per informant on average
- Higher BEI = more diverse plant knowledge
- Compare across communities (ANOVA in R script)

### Step 6: Export Figures for Thesis

```bash
# Already automated in export script
Rscript ~/LAB/projects/KANNA/tools/scripts/export-all-figures.R

# Figures copied to:
ls -lh ~/LAB/projects/KANNA/assets/figures/chapter-03/
# bei-by-community.png
# icf-by-category.png
# taxa-distribution-by-community.png
```

---

## FPIC Compliance Checklist

### Ethical Requirements ✅

**Free** (No coercion):
- [ ] Participants understand participation is voluntary
- [ ] No payment offered (can offer symbolic gift, not payment)
- [ ] Can decline to answer specific questions

**Prior** (Before data collection):
- [ ] Community elders consulted before individual interviews
- [ ] FPIC protocols explained in community meeting
- [ ] Ethics approval from Université de Paris IRB

**Informed** (Full understanding):
- [ ] Explained in local language (Khoekhoe, Ju, Afrikaans)
- [ ] Written consent form (if literate) or oral consent (if not)
- [ ] Participants understand how data will be used

**Consent** (Ongoing, not one-time):
- [ ] Can withdraw at any time (even after data collected)
- [ ] Can request data deletion
- [ ] Results shared before publication (member checking)

### Data Protection (GDPR/POPIA Compliance)

**Anonymization**:
- [ ] No real names in digital files (use INF-001 format)
- [ ] GPS rounded to 1km precision
- [ ] Audio consent stored separately, encrypted
- [ ] Name ↔ ID mapping in encrypted offline notebook only

**Data Storage**:
- [ ] SurveyCTO uses AES-256 encryption
- [ ] Backups encrypted (VeraCrypt, 7-Zip with password)
- [ ] Audio files never uploaded to cloud (offline only)
- [ ] Data deleted from tablet after server upload verified

**Data Access**:
- [ ] Only PhD student + supervisors have access
- [ ] No third-party sharing without community approval
- [ ] Published data aggregated (no individual responses)

### Benefit-Sharing

**Community Rights**:
- [ ] Traditional knowledge remains community property
- [ ] PhD thesis includes acknowledgment of Khoisan knowledge holders
- [ ] Results shared in community language before publication
- [ ] Community co-authors on publications (if desired)

**Outputs**:
- [ ] Plain-language summary (French + English + local language)
- [ ] Presentations at community meetings
- [ ] Copies of published papers provided to community
- [ ] Potential collaboration on conservation efforts

---

## Troubleshooting

### Issue 1: GPS Not Achieving <10m Accuracy

**Symptom**: GPS stuck at 50m accuracy, won't record

**Solution**:
1. Move outdoors (away from buildings, trees)
2. Wait 2-3 minutes (initial satellite acquisition slow)
3. Enable high-accuracy mode:
   - Android: Settings → Location → Mode → High accuracy
4. If still >10m: Record best available, note in field log

### Issue 2: Audio Recording Fails

**Symptom**: "Error: Cannot record audio"

**Solution**:
1. Check microphone permissions:
   - Settings → Apps → SurveyCTO → Permissions → Microphone → Allow
2. Test audio in another app (Voice Recorder)
3. Restart tablet
4. Fallback: Use external audio recorder, link filename in notes

### Issue 3: Form Won't Submit

**Symptom**: "Submission failed" error

**Solution**:
1. Check all required fields filled (red asterisk *)
2. Verify constraints met:
   - Informant ID format: `INF-\d{3}` (e.g., INF-001, not INF-1)
   - Age >= 18
3. Review validation errors (SurveyCTO shows specific field)

### Issue 4: Tablet Runs Out of Storage

**Symptom**: "Insufficient storage" when saving forms

**Solution**:
1. Delete old submissions (after verified server upload):
   - Settings → Delete Saved Forms
2. Offload audio files to laptop daily:
   ```bash
   # Connect tablet via USB
   # Copy from: /storage/emulated/0/Android/data/com.surveycto.collect.android/files/
   cp -r /media/tablet/surveycto-audio/ ~/LAB/fieldwork/audio-backup/
   ```
3. Increase storage: SD card (if tablet supports)

### Issue 5: Data Not Syncing to Server

**Symptom**: Submissions stuck in "Sent" queue

**Solution**:
1. Check internet connection (WiFi/cellular)
2. Manual send:
   - Tap "Send Finalized Forms"
   - Select all → Send
3. Check server status: https://status.surveycto.com/
4. Fallback: Export to CSV locally, email to yourself

---

## Best Practices

### Field Research
- **Test everything** before leaving for remote site (no tech support in field)
- **Bring paper backup** forms (tech fails happen)
- **Charge daily** (solar charger essential for multi-day trips)
- **Backup immediately** (don't wait until end of mission)

### Data Quality
- **Review daily** (catch errors while memory fresh)
- **Inter-rater reliability** (2 researchers code 10% of interviews independently)
- **Member checking** (validate interpretations with participants)
- **Document decisions** (field log explains any deviations from protocol)

### Ethical Research
- **Respect "no"** (if participant declines, thank them and move on)
- **Sacred knowledge** (some knowledge is restricted, don't record)
- **Community pace** (don't rush, build trust over time)
- **Give back** (share findings, support community priorities)

---

## Next Steps

**Week 1**: Configure SurveyCTO, design form
**Week 2**: Test with mock data (pilot with colleagues)
**Week 3**: First field mission (1 community, 5-10 interviews)
**Week 4**: Refine form based on pilot feedback

**Goal**: 50-100 interviews across 6-8 communities by Month 12

---

## Alternative: KoboToolbox (Free Option)

If SurveyCTO budget is a constraint, **KoboToolbox** is a free alternative:

**Pros**:
- Free for nonprofits/academics
- Similar features (offline, GPS, audio)
- Open-source

**Cons**:
- Less polished UI
- Forum support only (no 24/7 expert support)
- More technical setup (self-hosting option)

**Setup**: Visit https://www.kobotoolbox.org/ → Create free account

**Recommendation**: Try SurveyCTO 14-day trial first. If budget allows, keep SurveyCTO for reliability + support. If not, migrate to KoboToolbox.

---

## Further Resources

**SurveyCTO**:
- Help center: https://support.surveycto.com/
- XLSForm tutorial: https://xlsform.org/
- Case studies: https://www.surveycto.com/case-studies/

**FPIC**:
- UN FPIC guidelines: https://www.un.org/development/desa/indigenouspeoples/publications/2016/10/free-prior-and-informed-consent-an-indigenous-peoples-right-and-a-good-practice-for-local-communities-fao/
- Nagoya Protocol: https://www.cbd.int/abs/

**Ethnobotany Methods**:
- Martin, G. J. (1995). *Ethnobotany: A Methods Manual*
- Alexiades, M. N. (1996). *Selected Guidelines for Ethnobotanical Research*

---

**Last Updated**: October 2025
**Next Review**: After first field mission
**Questions**: Document in `tools/guides/FAQ.md`
