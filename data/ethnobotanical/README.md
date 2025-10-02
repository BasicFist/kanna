# Ethnobotanical Data

## Directory Purpose

This directory contains all ethnobotanical data collected from Khoisan communities, including interviews, surveys, and FPIC protocols.

## Subdirectories

### `interviews/`
**SENSITIVE - Gitignored**
- Raw interview transcripts (anonymized)
- Coded thematic analyses (MAXQDA exports)
- Inter-rater reliability data

**File naming convention**: `INT-{YYYYMMDD}-{CommunityCode}-{ParticipantID}.{ext}`
- Example: `INT-20250315-SC01-P007.txt`

### `surveys/`
- Ethnobotanical survey forms (CSV, Excel)
- BEI (Botanical Ethnobotanical Index) calculations
- ICF (Informant Consensus Factor) data
- CUDI (Cultural Diversity Index) results

**Key analyses**:
- Use `analysis/r-scripts/ethnobotany/calculate-bei.R`
- See `ethnobotanyR` package documentation

### `fpic-protocols/`
- Free, Prior, and Informed Consent documentation
- Community agreements (signed versions stored securely offline)
- Ethics approvals & IRB clearances
- Communication logs with community partners

## Data Collection Standards

### FPIC Requirements
- ✅ Explain research purpose in local languages
- ✅ Obtain ongoing consent (not one-time)
- ✅ Allow withdrawal at any time
- ✅ Share findings before publication
- ✅ Respect traditional protocols

### Anonymization Protocol
1. Assign participant IDs (never use real names in digital files)
2. Remove GPS coordinates < 10km precision
3. Redact identifying details from transcripts
4. Store consent forms separately (encrypted offline)

### Data Quality Checks
- Triangulation: Cross-validate with multiple informants
- Member checking: Verify interpretations with participants
- Community validation: Review findings with elders
- Inter-rater reliability: κ ≥ 0.70 for coded themes

## Key Metrics to Calculate

### Botanical Ethnobotanical Index (BEI)
```
BEI = (Number of taxa used) / (Total number of informants)
```

### Informant Consensus Factor (ICF)
```
ICF = (Nur - Nt) / (Nur - 1)
where:
- Nur = Number of use reports
- Nt = Number of taxa used
```

### Cultural Diversity Index (CUDI)
```
CUDI = 1 - Σ(pi²)
where pi = proportion of informants citing use i
```

## Privacy & Ethics

**⚠️ CRITICAL REMINDERS:**
- Never commit raw interview data to Git
- Always use pseudonyms in publications
- Store audio/video recordings on encrypted drives only
- Obtain community approval before sharing any findings
- Respect sacred/restricted knowledge (do not publish)

## Analysis Workflow

1. **Collect data** (fieldwork)
2. **Transcribe & anonymize** (24h after collection)
3. **Code thematically** (MAXQDA, NVivo, or manual)
4. **Calculate indices** (BEI, ICF, CUDI via R scripts)
5. **Validate with community** (member checking)
6. **Publish** (only after community approval)

## Related Files

- Analysis scripts: `analysis/r-scripts/ethnobotany/`
- Interview protocols: `fieldwork/protocols/interview-guide.md`
- FPIC templates: `tools/templates/fpic-template.docx`
- Ethics approvals: `collaboration/ethics-approvals/`

---
*Last updated: October 2025*
