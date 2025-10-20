#!/bin/bash
#
# Smart PDF Deduplication Script
# Generated: 2025-10-03T12:57:30.207797
#
# This script removes duplicate PDF files identified by the analyzer.
# Files are MOVED to an archive directory (not deleted) for safety.
#

set -e  # Exit on error

# Configuration
BASE_DIR="/home/miko/Documents/Sceletium_Thesis_PDFs"
ARCHIVE_DIR="${BASE_DIR}/duplicates_archive_20251003_125730"

echo "Creating archive directory..."
mkdir -p "$ARCHIVE_DIR"

echo "Processing 565 duplicate files..."
echo ""

# Move duplicate files to archive

# File 1/565: 0.0 B
# Keeping: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and1.pdf"

# File 2/565: 0.0 B
# Keeping: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0011257478/Neuroimmune mechanisms of psychostimulant and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0011257478/Neuroimmune mechanisms of psychostimulant and.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0011257478/Neuroimmune mechanisms of psychostimulant and.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0011257478/Neuroimmune mechanisms of psychostimulant and.pdf"

# File 3/565: 0.0 B
# Keeping: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1595173392/Neuroimmune mechanisms of psychostimulant and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1595173392/Neuroimmune mechanisms of psychostimulant and.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1595173392/Neuroimmune mechanisms of psychostimulant and.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1595173392/Neuroimmune mechanisms of psychostimulant and.pdf"

# File 4/565: 0.0 B
# Keeping: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3747073341/Neuroimmune mechanisms of psychostimulant and1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3747073341/Neuroimmune mechanisms of psychostimulant and1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3747073341/Neuroimmune mechanisms of psychostimulant and1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3747073341/Neuroimmune mechanisms of psychostimulant and1.pdf"

# File 5/565: 0.0 B
# Keeping: THESE_Main_Library/Neuroimmune mechanisms of psychostimulant and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4159203872/Neuroimmune mechanisms of psychostimulant and1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4159203872/Neuroimmune mechanisms of psychostimulant and1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4159203872/Neuroimmune mechanisms of psychostimulant and1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4159203872/Neuroimmune mechanisms of psychostimulant and1.pdf"

# File 6/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum_ A review on its phytochem.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3190254737/Sceletium tortuosum_ A review on its phytochem.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3190254737/Sceletium tortuosum_ A review on its phytochem.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3190254737/Sceletium tortuosum_ A review on its phytochem.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3190254737/Sceletium tortuosum_ A review on its phytochem.pdf"

# File 7/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum_ A review on its phytochem.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3297879003/Sceletium tortuosum_ A review on its phytochem.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3297879003/Sceletium tortuosum_ A review on its phytochem.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3297879003/Sceletium tortuosum_ A review on its phytochem.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3297879003/Sceletium tortuosum_ A review on its phytochem.pdf"

# File 8/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum_ A review on its phytochem.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Olatunji_2022_Sceletium tortuosum.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji_2022_Sceletium tortuosum.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olatunji_2022_Sceletium tortuosum.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji_2022_Sceletium tortuosum.pdf"

# File 9/565: 0.0 B
# Keeping: THESE_Main_Library/PDE inhibition in distinct cell types to recla.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0153840207/PDE inhibition in distinct cell types to recla.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0153840207/PDE inhibition in distinct cell types to recla.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0153840207/PDE inhibition in distinct cell types to recla.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0153840207/PDE inhibition in distinct cell types to recla.pdf"

# File 10/565: 0.0 B
# Keeping: THESE_Main_Library/PDE inhibition in distinct cell types to recla.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4104749933/PDE inhibition in distinct cell types to recla.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4104749933/PDE inhibition in distinct cell types to recla.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4104749933/PDE inhibition in distinct cell types to recla.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4104749933/PDE inhibition in distinct cell types to recla.pdf"

# File 11/565: 0.0 B
# Keeping: THESE_Main_Library/PDE inhibition in distinct cell types to recla.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Rombaut_2021_PDE inhibition in distinct cell types to reclaim the balance of synaptic.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Rombaut_2021_PDE inhibition in distinct cell types to reclaim the balance of synaptic.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Rombaut_2021_PDE inhibition in distinct cell types to reclaim the balance of synaptic.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Rombaut_2021_PDE inhibition in distinct cell types to reclaim the balance of synaptic.pdf"

# File 12/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Psychophysiological Effects of Zembrin&amp;lt;.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Psychophysiological Effects of Zembrin&amp;lt;.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Psychophysiological Effects of Zembrin&amp;lt;.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Psychophysiological Effects of Zembrin&amp;lt;.pdf"

# File 13/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0157707143/Psychophysiological Effects of Zembrin&amp;lt;.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0157707143/Psychophysiological Effects of Zembrin&amp;lt;.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0157707143/Psychophysiological Effects of Zembrin&amp;lt;.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0157707143/Psychophysiological Effects of Zembrin&amp;lt;.pdf"

# File 14/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1563078594/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1563078594/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1563078594/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1563078594/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf"

# File 15/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3353983694/Psychophysiological Effects of Zembrin&amp;lt;.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3353983694/Psychophysiological Effects of Zembrin&amp;lt;.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3353983694/Psychophysiological Effects of Zembrin&amp;lt;.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3353983694/Psychophysiological Effects of Zembrin&amp;lt;.pdf"

# File 16/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4214844280/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4214844280/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4214844280/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4214844280/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf"

# File 17/565: 0.0 B
# Keeping: THESE_Main_Library/18a11b7f-196b-4762-8c85-f7983b8e1ea9.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-2.pdf"

# File 18/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Emerging Roles of Complement in Psychiatric Di.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Emerging Roles of Complement in Psychiatric Di.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Emerging Roles of Complement in Psychiatric Di.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Emerging Roles of Complement in Psychiatric Di.pdf"

# File 19/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0169175131/Emerging Roles of Complement in Psychiatric D1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0169175131/Emerging Roles of Complement in Psychiatric D1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0169175131/Emerging Roles of Complement in Psychiatric D1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0169175131/Emerging Roles of Complement in Psychiatric D1.pdf"

# File 20/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1102530164/Emerging Roles of Complement in Psychiatric D1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1102530164/Emerging Roles of Complement in Psychiatric D1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1102530164/Emerging Roles of Complement in Psychiatric D1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1102530164/Emerging Roles of Complement in Psychiatric D1.pdf"

# File 21/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1852849437/Emerging Roles of Complement in Psychiatric Di.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1852849437/Emerging Roles of Complement in Psychiatric Di.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1852849437/Emerging Roles of Complement in Psychiatric Di.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1852849437/Emerging Roles of Complement in Psychiatric Di.pdf"

# File 22/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2250270795/Emerging Roles of Complement in Psychiatric Di.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2250270795/Emerging Roles of Complement in Psychiatric Di.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2250270795/Emerging Roles of Complement in Psychiatric Di.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2250270795/Emerging Roles of Complement in Psychiatric Di.pdf"

# File 23/565: 0.0 B
# Keeping: THESE_Main_Library/Emerging Roles of Complement in Psychiatric D1.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019.pdf"

# File 24/565: 0.0 B
# Keeping: THESE_Main_Library/An acute dose-ranging evaluation of the antide.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0190015188/An acute dose-ranging evaluation of the antide.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0190015188/An acute dose-ranging evaluation of the antide.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0190015188/An acute dose-ranging evaluation of the antide.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0190015188/An acute dose-ranging evaluation of the antide.pdf"

# File 25/565: 0.0 B
# Keeping: THESE_Main_Library/An acute dose-ranging evaluation of the antide.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2618122539/An acute dose-ranging evaluation of the antide.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2618122539/An acute dose-ranging evaluation of the antide.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2618122539/An acute dose-ranging evaluation of the antide.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2618122539/An acute dose-ranging evaluation of the antide.pdf"

# File 26/565: 0.0 B
# Keeping: THESE_Main_Library/An acute dose-ranging evaluation of the antide.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021.pdf"

# File 27/565: 0.0 B
# Keeping: THESE_Main_Library/2008GerickeViljoenSceletiumreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2008GerickeViljoenSceletiumreview1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2008GerickeViljoenSceletiumreview1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2008GerickeViljoenSceletiumreview1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2008GerickeViljoenSceletiumreview1.pdf"

# File 28/565: 0.0 B
# Keeping: THESE_Main_Library/2008GerickeViljoenSceletiumreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0193752256/2008GerickeViljoenSceletiumreview1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0193752256/2008GerickeViljoenSceletiumreview1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0193752256/2008GerickeViljoenSceletiumreview1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0193752256/2008GerickeViljoenSceletiumreview1.pdf"

# File 29/565: 0.0 B
# Keeping: THESE_Main_Library/2008GerickeViljoenSceletiumreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1215705939/2008GerickeViljoenSceletiumreview.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1215705939/2008GerickeViljoenSceletiumreview.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1215705939/2008GerickeViljoenSceletiumreview.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1215705939/2008GerickeViljoenSceletiumreview.pdf"

# File 30/565: 0.0 B
# Keeping: THESE_Main_Library/2008GerickeViljoenSceletiumreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2409573626/2008GerickeViljoenSceletiumreview1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2409573626/2008GerickeViljoenSceletiumreview1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2409573626/2008GerickeViljoenSceletiumreview1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2409573626/2008GerickeViljoenSceletiumreview1.pdf"

# File 31/565: 0.0 B
# Keeping: THESE_Main_Library/2008GerickeViljoenSceletiumreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3002231984/2008GerickeViljoenSceletiumreview.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3002231984/2008GerickeViljoenSceletiumreview.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3002231984/2008GerickeViljoenSceletiumreview.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3002231984/2008GerickeViljoenSceletiumreview.pdf"

# File 32/565: 0.0 B
# Keeping: THESE_Main_Library/Exploring Zembrin Extract Derived from South A.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0194930826/Exploring Zembrin Extract Derived from South A.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0194930826/Exploring Zembrin Extract Derived from South A.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0194930826/Exploring Zembrin Extract Derived from South A.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0194930826/Exploring Zembrin Extract Derived from South A.pdf"

# File 33/565: 0.0 B
# Keeping: THESE_Main_Library/Exploring Zembrin Extract Derived from South A.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2610555476/Exploring Zembrin Extract Derived from South A.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2610555476/Exploring Zembrin Extract Derived from South A.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2610555476/Exploring Zembrin Extract Derived from South A.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2610555476/Exploring Zembrin Extract Derived from South A.pdf"

# File 34/565: 0.0 B
# Keeping: THESE_Main_Library/Exploring Zembrin Extract Derived from South A.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015.pdf"

# File 35/565: 0.0 B
# Keeping: THESE_Main_Library/To ferment or not to ferment Sceletium tortuos.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0204215196/To ferment or not to ferment Sceletium tortuos.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0204215196/To ferment or not to ferment Sceletium tortuos.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0204215196/To ferment or not to ferment Sceletium tortuos.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0204215196/To ferment or not to ferment Sceletium tortuos.pdf"

# File 36/565: 0.0 B
# Keeping: THESE_Main_Library/To ferment or not to ferment Sceletium tortuos.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1758555640/To ferment or not to ferment Sceletium tortuos.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1758555640/To ferment or not to ferment Sceletium tortuos.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1758555640/To ferment or not to ferment Sceletium tortuos.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1758555640/To ferment or not to ferment Sceletium tortuos.pdf"

# File 37/565: 0.0 B
# Keeping: THESE_Main_Library/To ferment or not to ferment Sceletium tortuos.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019.pdf"

# File 38/565: 0.0 B
# Keeping: THESE_Main_Library/A broad review of commercially important south.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0265578321/A broad review of commercially important south.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0265578321/A broad review of commercially important south.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0265578321/A broad review of commercially important south.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0265578321/A broad review of commercially important south.pdf"

# File 39/565: 0.0 B
# Keeping: THESE_Main_Library/A broad review of commercially important south.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3820498015/A broad review of commercially important south.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3820498015/A broad review of commercially important south.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3820498015/A broad review of commercially important south.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3820498015/A broad review of commercially important south.pdf"

# File 40/565: 0.0 B
# Keeping: THESE_Main_Library/A broad review of commercially important south.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Van Wyk_2008_A broad review of commercially important southern African medicinal plants.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2008_A broad review of commercially important southern African medicinal plants.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk_2008_A broad review of commercially important southern African medicinal plants.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2008_A broad review of commercially important southern African medicinal plants.pdf"

# File 41/565: 0.0 B
# Keeping: THESE_Main_Library/Quantification of mesembrine and mesembrenone.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0272784946/Quantification of mesembrine and mesembrenone.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0272784946/Quantification of mesembrine and mesembrenone.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0272784946/Quantification of mesembrine and mesembrenone.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0272784946/Quantification of mesembrine and mesembrenone.pdf"

# File 42/565: 0.0 B
# Keeping: THESE_Main_Library/Quantification of mesembrine and mesembrenone.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0379546519/Quantification of mesembrine and mesembrenone.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0379546519/Quantification of mesembrine and mesembrenone.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0379546519/Quantification of mesembrine and mesembrenone.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0379546519/Quantification of mesembrine and mesembrenone.pdf"

# File 43/565: 0.0 B
# Keeping: THESE_Main_Library/Quantification of mesembrine and mesembrenone.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Manda_2017_Quantification of mesembrine and mesembrenone in mouse plasma using.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manda_2017_Quantification of mesembrine and mesembrenone in mouse plasma using.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manda_2017_Quantification of mesembrine and mesembrenone in mouse plasma using.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manda_2017_Quantification of mesembrine and mesembrenone in mouse plasma using.pdf"

# File 44/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Neurocircuitry of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Neurocircuitry of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Neurocircuitry of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Neurocircuitry of Addiction.pdf"

# File 45/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0282103650/Neurocircuitry of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0282103650/Neurocircuitry of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0282103650/Neurocircuitry of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0282103650/Neurocircuitry of Addiction.pdf"

# File 46/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0462847204/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0462847204/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0462847204/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0462847204/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"

# File 47/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1863608802/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1863608802/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1863608802/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1863608802/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"

# File 48/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2051115389/Neurocircuitry of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2051115389/Neurocircuitry of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2051115389/Neurocircuitry of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2051115389/Neurocircuitry of Addiction.pdf"

# File 49/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2363083852/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2363083852/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2363083852/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2363083852/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"

# File 50/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2416275944/Neurocircuitry of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2416275944/Neurocircuitry of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2416275944/Neurocircuitry of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2416275944/Neurocircuitry of Addiction.pdf"

# File 51/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2886308782/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2886308782/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2886308782/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2886308782/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf"

# File 52/565: 0.0 B
# Keeping: THESE_Main_Library/3a55c7f2-aa40-4f01-92fc-52a8e978c131.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3211028977/Neurocircuitry of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3211028977/Neurocircuitry of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3211028977/Neurocircuitry of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3211028977/Neurocircuitry of Addiction.pdf"

# File 53/565: 0.0 B
# Keeping: THESE_Main_Library/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0295136292/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0295136292/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0295136292/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0295136292/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf"

# File 54/565: 0.0 B
# Keeping: THESE_Main_Library/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3340504491/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3340504491/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3340504491/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3340504491/d65c7c2f-a589-466a-a592-a01bc789ce33.pdf"

# File 55/565: 0.0 B
# Keeping: THESE_Main_Library/Electropharmacogram of Sceletium tortuosum ext.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Modulation of glucocorticoid, mineralocorticoi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Modulation of glucocorticoid, mineralocorticoi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Modulation of glucocorticoid, mineralocorticoi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Modulation of glucocorticoid, mineralocorticoi.pdf"

# File 56/565: 0.0 B
# Keeping: THESE_Main_Library/Electropharmacogram of Sceletium tortuosum ext.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0322464179/Modulation of glucocorticoid, mineralocorticoi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0322464179/Modulation of glucocorticoid, mineralocorticoi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0322464179/Modulation of glucocorticoid, mineralocorticoi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0322464179/Modulation of glucocorticoid, mineralocorticoi.pdf"

# File 57/565: 0.0 B
# Keeping: THESE_Main_Library/Electropharmacogram of Sceletium tortuosum ext.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0465721003/Modulation of glucocorticoid, mineralocorticoi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0465721003/Modulation of glucocorticoid, mineralocorticoi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0465721003/Modulation of glucocorticoid, mineralocorticoi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0465721003/Modulation of glucocorticoid, mineralocorticoi.pdf"

# File 58/565: 0.0 B
# Keeping: THESE_Main_Library/Electropharmacogram of Sceletium tortuosum ext.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1905725130/Electropharmacogram of Sceletium tortuosum ext.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1905725130/Electropharmacogram of Sceletium tortuosum ext.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1905725130/Electropharmacogram of Sceletium tortuosum ext.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1905725130/Electropharmacogram of Sceletium tortuosum ext.pdf"

# File 59/565: 0.0 B
# Keeping: THESE_Main_Library/Electropharmacogram of Sceletium tortuosum ext.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4151994428/Electropharmacogram of Sceletium tortuosum ext.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4151994428/Electropharmacogram of Sceletium tortuosum ext.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4151994428/Electropharmacogram of Sceletium tortuosum ext.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4151994428/Electropharmacogram of Sceletium tortuosum ext.pdf"

# File 60/565: 0.0 B
# Keeping: THESE_Main_Library/Some ethnopharmacological notes on African hal.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0369340341/Some ethnopharmacological notes on African hal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0369340341/Some ethnopharmacological notes on African hal.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0369340341/Some ethnopharmacological notes on African hal.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0369340341/Some ethnopharmacological notes on African hal.pdf"

# File 61/565: 0.0 B
# Keeping: THESE_Main_Library/Some ethnopharmacological notes on African hal.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0417295614/Some ethnopharmacological notes on African hal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0417295614/Some ethnopharmacological notes on African hal.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0417295614/Some ethnopharmacological notes on African hal.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0417295614/Some ethnopharmacological notes on African hal.pdf"

# File 62/565: 0.0 B
# Keeping: THESE_Main_Library/Some ethnopharmacological notes on African hal.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2939492628/Some ethnopharmacological notes on African hal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2939492628/Some ethnopharmacological notes on African hal.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2939492628/Some ethnopharmacological notes on African hal.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2939492628/Some ethnopharmacological notes on African hal.pdf"

# File 63/565: 0.0 B
# Keeping: THESE_Main_Library/Some ethnopharmacological notes on African hal.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996.pdf"

# File 64/565: 0.0 B
# Keeping: THESE_Main_Library/nordling2018.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0377849273/nordling2018.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0377849273/nordling2018.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0377849273/nordling2018.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0377849273/nordling2018.pdf"

# File 65/565: 0.0 B
# Keeping: THESE_Main_Library/nordling2018.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3996477640/nordling2018.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3996477640/nordling2018.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3996477640/nordling2018.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3996477640/nordling2018.pdf"

# File 66/565: 0.0 B
# Keeping: THESE_Main_Library/nordling2018.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Nordling_2018_How decolonization could reshape South African science.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Nordling_2018_How decolonization could reshape South African science.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Nordling_2018_How decolonization could reshape South African science.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Nordling_2018_How decolonization could reshape South African science.pdf"

# File 67/565: 0.0 B
# Keeping: THESE_Main_Library/nordling2018.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Zembe-Mkabile_SAMANTHA REINDERS FOR NATURE.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Zembe-Mkabile_SAMANTHA REINDERS FOR NATURE.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Zembe-Mkabile_SAMANTHA REINDERS FOR NATURE.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Zembe-Mkabile_SAMANTHA REINDERS FOR NATURE.pdf"

# File 68/565: 0.0 B
# Keeping: THESE_Main_Library/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0394410959/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0394410959/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0394410959/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0394410959/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf"

# File 69/565: 0.0 B
# Keeping: THESE_Main_Library/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2593155741/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2593155741/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2593155741/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2593155741/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf"

# File 70/565: 0.0 B
# Keeping: THESE_Main_Library/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: ZOTPDF_References/Brunetti_2020_Pharmacology of Herbal Sexual Enhancers.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/ZOTPDF_References/Brunetti_2020_Pharmacology of Herbal Sexual Enhancers.pdf")"
mv "$BASE_DIR/ZOTPDF_References/Brunetti_2020_Pharmacology of Herbal Sexual Enhancers.pdf" "$ARCHIVE_DIR/ZOTPDF_References/Brunetti_2020_Pharmacology of Herbal Sexual Enhancers.pdf"

# File 71/565: 0.0 B
# Keeping: THESE_Main_Library/Brunetti-2020-Pharmacology of Herbal Sexual En.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020.pdf"

# File 72/565: 0.0 B
# Keeping: THESE_Main_Library/Zembrim 4 Alcaloids.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0403729504/Zembrim 4 Alcaloids.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0403729504/Zembrim 4 Alcaloids.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0403729504/Zembrim 4 Alcaloids.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0403729504/Zembrim 4 Alcaloids.pdf"

# File 73/565: 0.0 B
# Keeping: THESE_Main_Library/Zembrim 4 Alcaloids.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2652989453/Zembrim 4 Alcaloids.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2652989453/Zembrim 4 Alcaloids.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2652989453/Zembrim 4 Alcaloids.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2652989453/Zembrim 4 Alcaloids.pdf"

# File 74/565: 0.0 B
# Keeping: THESE_Main_Library/Zembrim 4 Alcaloids.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018.pdf"

# File 75/565: 0.0 B
# Keeping: THESE_Main_Library/Self-Medication and the Trade in Medicine with.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0406023391/Self-Medication and the Trade in Medicine with.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0406023391/Self-Medication and the Trade in Medicine with.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0406023391/Self-Medication and the Trade in Medicine with.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0406023391/Self-Medication and the Trade in Medicine with.pdf"

# File 76/565: 0.0 B
# Keeping: THESE_Main_Library/Self-Medication and the Trade in Medicine with.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1290959315/Self-Medication and the Trade in Medicine with.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1290959315/Self-Medication and the Trade in Medicine with.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1290959315/Self-Medication and the Trade in Medicine with.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1290959315/Self-Medication and the Trade in Medicine with.pdf"

# File 77/565: 0.0 B
# Keeping: THESE_Main_Library/Self-Medication and the Trade in Medicine with.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Self-Medication and the Trade in Medicine within aSocial History of MedicineDigby2005.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Self-Medication and the Trade in Medicine within aSocial History of MedicineDigby2005.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Self-Medication and the Trade in Medicine within aSocial History of MedicineDigby2005.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Self-Medication and the Trade in Medicine within aSocial History of MedicineDigby2005.pdf"

# File 78/565: 0.0 B
# Keeping: THESE_Main_Library/A randomized, double-blind, parallel-group, pl.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0521025725/A randomized, double-blind, parallel-group, pl.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0521025725/A randomized, double-blind, parallel-group, pl.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0521025725/A randomized, double-blind, parallel-group, pl.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0521025725/A randomized, double-blind, parallel-group, pl.pdf"

# File 79/565: 0.0 B
# Keeping: THESE_Main_Library/A randomized, double-blind, parallel-group, pl.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1536584630/A randomized, double-blind, parallel-group, pl.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1536584630/A randomized, double-blind, parallel-group, pl.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1536584630/A randomized, double-blind, parallel-group, pl.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1536584630/A randomized, double-blind, parallel-group, pl.pdf"

# File 80/565: 0.0 B
# Keeping: THESE_Main_Library/Manganyi-2019-Antibacterial activity of endoph.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0532993907/Manganyi-2019-Antibacterial activity of endoph.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0532993907/Manganyi-2019-Antibacterial activity of endoph.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0532993907/Manganyi-2019-Antibacterial activity of endoph.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0532993907/Manganyi-2019-Antibacterial activity of endoph.pdf"

# File 81/565: 0.0 B
# Keeping: THESE_Main_Library/Manganyi-2019-Antibacterial activity of endoph.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1090479875/Manganyi-2019-Antibacterial activity of endoph.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1090479875/Manganyi-2019-Antibacterial activity of endoph.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1090479875/Manganyi-2019-Antibacterial activity of endoph.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1090479875/Manganyi-2019-Antibacterial activity of endoph.pdf"

# File 82/565: 0.0 B
# Keeping: THESE_Main_Library/Faber-2020-Variabilities in alkaloid concentra.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0559378100/Faber-2020-Variabilities in alkaloid concentra.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0559378100/Faber-2020-Variabilities in alkaloid concentra.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0559378100/Faber-2020-Variabilities in alkaloid concentra.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0559378100/Faber-2020-Variabilities in alkaloid concentra.pdf"

# File 83/565: 0.0 B
# Keeping: THESE_Main_Library/Faber-2020-Variabilities in alkaloid concentra.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2386842634/Faber-2020-Variabilities in alkaloid concentra.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2386842634/Faber-2020-Variabilities in alkaloid concentra.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2386842634/Faber-2020-Variabilities in alkaloid concentra.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2386842634/Faber-2020-Variabilities in alkaloid concentra.pdf"

# File 84/565: 0.0 B
# Keeping: THESE_Main_Library/Faber-2020-Variabilities in alkaloid concentra.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020.pdf"

# File 85/565: 0.0 B
# Keeping: THESE_Main_Library/A review of Khoi-San and Cape Dutch medical et.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0569863110/A review of Khoi-San and Cape Dutch medical et.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0569863110/A review of Khoi-San and Cape Dutch medical et.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0569863110/A review of Khoi-San and Cape Dutch medical et.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0569863110/A review of Khoi-San and Cape Dutch medical et.pdf"

# File 86/565: 0.0 B
# Keeping: THESE_Main_Library/A review of Khoi-San and Cape Dutch medical et.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1218262266/A review of Khoi-San and Cape Dutch medical et.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1218262266/A review of Khoi-San and Cape Dutch medical et.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1218262266/A review of Khoi-San and Cape Dutch medical et.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1218262266/A review of Khoi-San and Cape Dutch medical et.pdf"

# File 87/565: 0.0 B
# Keeping: THESE_Main_Library/A review of Khoi-San and Cape Dutch medical et.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Van Wyk_2008_A review of Khoi-San and Cape Dutch medical ethnobotany.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2008_A review of Khoi-San and Cape Dutch medical ethnobotany.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk_2008_A review of Khoi-San and Cape Dutch medical ethnobotany.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2008_A review of Khoi-San and Cape Dutch medical ethnobotany.pdf"

# File 88/565: 0.0 B
# Keeping: THESE_Main_Library/Schifano-2015-Novel psychoactive substances of.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0632908320/Schifano-2015-Novel psychoactive substances of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0632908320/Schifano-2015-Novel psychoactive substances of.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0632908320/Schifano-2015-Novel psychoactive substances of.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0632908320/Schifano-2015-Novel psychoactive substances of.pdf"

# File 89/565: 0.0 B
# Keeping: THESE_Main_Library/Schifano-2015-Novel psychoactive substances of.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3871399262/Schifano-2015-Novel psychoactive substances of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3871399262/Schifano-2015-Novel psychoactive substances of.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3871399262/Schifano-2015-Novel psychoactive substances of.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3871399262/Schifano-2015-Novel psychoactive substances of.pdf"

# File 90/565: 0.0 B
# Keeping: THESE_Main_Library/Schifano-2015-Novel psychoactive substances of.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Schifano_2015_Novel psychoactive substances of interest for psychiatry.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Schifano_2015_Novel psychoactive substances of interest for psychiatry.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Schifano_2015_Novel psychoactive substances of interest for psychiatry.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Schifano_2015_Novel psychoactive substances of interest for psychiatry.pdf"

# File 91/565: 0.0 B
# Keeping: THESE_Main_Library/Immunomodulatory effects of Sceletium tortuosu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0638281960/Immunomodulatory effects of Sceletium tortuosu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0638281960/Immunomodulatory effects of Sceletium tortuosu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0638281960/Immunomodulatory effects of Sceletium tortuosu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0638281960/Immunomodulatory effects of Sceletium tortuosu.pdf"

# File 92/565: 0.0 B
# Keeping: THESE_Main_Library/Immunomodulatory effects of Sceletium tortuosu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2980506999/Immunomodulatory effects of Sceletium tortuosu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2980506999/Immunomodulatory effects of Sceletium tortuosu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2980506999/Immunomodulatory effects of Sceletium tortuosu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2980506999/Immunomodulatory effects of Sceletium tortuosu.pdf"

# File 93/565: 0.0 B
# Keeping: THESE_Main_Library/Alternative Models of Addiction.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0639324805/Alternative Models of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0639324805/Alternative Models of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0639324805/Alternative Models of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0639324805/Alternative Models of Addiction.pdf"

# File 94/565: 0.0 B
# Keeping: THESE_Main_Library/Alternative Models of Addiction.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2602985219/Alternative Models of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2602985219/Alternative Models of Addiction.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2602985219/Alternative Models of Addiction.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2602985219/Alternative Models of Addiction.pdf"

# File 95/565: 0.0 B
# Keeping: THESE_Main_Library/Alternative Models of Addiction.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Pickard_2015_Alternative Models of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pickard_2015_Alternative Models of Addiction.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pickard_2015_Alternative Models of Addiction.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pickard_2015_Alternative Models of Addiction.pdf"

# File 96/565: 0.0 B
# Keeping: THESE_Main_Library/In Silico Docking Analysis of Few Antidepressa.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0661539040/In Silico Docking Analysis of Few Antidepressa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0661539040/In Silico Docking Analysis of Few Antidepressa.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0661539040/In Silico Docking Analysis of Few Antidepressa.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0661539040/In Silico Docking Analysis of Few Antidepressa.pdf"

# File 97/565: 0.0 B
# Keeping: THESE_Main_Library/In Silico Docking Analysis of Few Antidepressa.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2056874247/In Silico Docking Analysis of Few Antidepressa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2056874247/In Silico Docking Analysis of Few Antidepressa.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2056874247/In Silico Docking Analysis of Few Antidepressa.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2056874247/In Silico Docking Analysis of Few Antidepressa.pdf"

# File 98/565: 0.0 B
# Keeping: THESE_Main_Library/In Silico Docking Analysis of Few Antidepressa.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Kotadiya_In Silico Docking Analysis of Few Antidepressant Phytoconstituents of South.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kotadiya_In Silico Docking Analysis of Few Antidepressant Phytoconstituents of South.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kotadiya_In Silico Docking Analysis of Few Antidepressant Phytoconstituents of South.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kotadiya_In Silico Docking Analysis of Few Antidepressant Phytoconstituents of South.pdf"

# File 99/565: 0.0 B
# Keeping: THESE_Main_Library/Review on plants with CNS-effects used in trad.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0681470934/Review on plants with CNS-effects used in trad.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0681470934/Review on plants with CNS-effects used in trad.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0681470934/Review on plants with CNS-effects used in trad.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0681470934/Review on plants with CNS-effects used in trad.pdf"

# File 100/565: 0.0 B
# Keeping: THESE_Main_Library/Review on plants with CNS-effects used in trad.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3012898459/Review on plants with CNS-effects used in trad.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3012898459/Review on plants with CNS-effects used in trad.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3012898459/Review on plants with CNS-effects used in trad.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3012898459/Review on plants with CNS-effects used in trad.pdf"

# File 101/565: 0.0 B
# Keeping: THESE_Main_Library/Review on plants with CNS-effects used in trad.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Stafford_2008_Review on plants with CNS-effects used in traditional South African medicine.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Stafford_2008_Review on plants with CNS-effects used in traditional South African medicine.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Stafford_2008_Review on plants with CNS-effects used in traditional South African medicine.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Stafford_2008_Review on plants with CNS-effects used in traditional South African medicine.pdf"

# File 102/565: 0.0 B
# Keeping: THESE_Main_Library/High-mesembrine Sceletium extract (Trimesemine.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0727216486/High-mesembrine Sceletium extract (Trimesemine.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0727216486/High-mesembrine Sceletium extract (Trimesemine.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0727216486/High-mesembrine Sceletium extract (Trimesemine.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0727216486/High-mesembrine Sceletium extract (Trimesemine.pdf"

# File 103/565: 0.0 B
# Keeping: THESE_Main_Library/High-mesembrine Sceletium extract (Trimesemine.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2836621497/High-mesembrine Sceletium extract (Trimesemine.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2836621497/High-mesembrine Sceletium extract (Trimesemine.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2836621497/High-mesembrine Sceletium extract (Trimesemine.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2836621497/High-mesembrine Sceletium extract (Trimesemine.pdf"

# File 104/565: 0.0 B
# Keeping: THESE_Main_Library/High-mesembrine Sceletium extract (Trimesemine.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016.pdf"

# File 105/565: 0.0 B
# Keeping: THESE_Main_Library/Terburg-2013-Acute effects of Sceletium tortuo.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0766600932/Terburg-2013-Acute effects of Sceletium tortuo.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0766600932/Terburg-2013-Acute effects of Sceletium tortuo.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0766600932/Terburg-2013-Acute effects of Sceletium tortuo.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0766600932/Terburg-2013-Acute effects of Sceletium tortuo.pdf"

# File 106/565: 0.0 B
# Keeping: THESE_Main_Library/Terburg-2013-Acute effects of Sceletium tortuo.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2944520568/Terburg-2013-Acute effects of Sceletium tortuo.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2944520568/Terburg-2013-Acute effects of Sceletium tortuo.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2944520568/Terburg-2013-Acute effects of Sceletium tortuo.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2944520568/Terburg-2013-Acute effects of Sceletium tortuo.pdf"

# File 107/565: 0.0 B
# Keeping: THESE_Main_Library/Terburg-2013-Acute effects of Sceletium tortuo.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Terburg_2013_Acute effects of Sceletium tortuosum (Zembrin), a dual 5-HT reuptake and PDE4.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Terburg_2013_Acute effects of Sceletium tortuosum (Zembrin), a dual 5-HT reuptake and PDE4.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Terburg_2013_Acute effects of Sceletium tortuosum (Zembrin), a dual 5-HT reuptake and PDE4.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Terburg_2013_Acute effects of Sceletium tortuosum (Zembrin), a dual 5-HT reuptake and PDE4.pdf"

# File 108/565: 0.0 B
# Keeping: THESE_Main_Library/Strengthening indigenous governance, benefit s.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0771922382/Strengthening indigenous governance, benefit s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0771922382/Strengthening indigenous governance, benefit s.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0771922382/Strengthening indigenous governance, benefit s.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0771922382/Strengthening indigenous governance, benefit s.pdf"

# File 109/565: 0.0 B
# Keeping: THESE_Main_Library/Strengthening indigenous governance, benefit s.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2537057753/Strengthening indigenous governance, benefit s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2537057753/Strengthening indigenous governance, benefit s.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2537057753/Strengthening indigenous governance, benefit s.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2537057753/Strengthening indigenous governance, benefit s.pdf"

# File 110/565: 0.0 B
# Keeping: THESE_Main_Library/Strengthening indigenous governance, benefit s.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Modise_2018_Strengthening indigenous governance, benefit sharing and capacity building for.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Modise_2018_Strengthening indigenous governance, benefit sharing and capacity building for.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Modise_2018_Strengthening indigenous governance, benefit sharing and capacity building for.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Modise_2018_Strengthening indigenous governance, benefit sharing and capacity building for.pdf"

# File 111/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnobotanical research in sub-Saharan Africa.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0787310714/Ethnobotanical research in sub-Saharan Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0787310714/Ethnobotanical research in sub-Saharan Africa.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0787310714/Ethnobotanical research in sub-Saharan Africa.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0787310714/Ethnobotanical research in sub-Saharan Africa.pdf"

# File 112/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnobotanical research in sub-Saharan Africa.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1919575985/Ethnobotanical research in sub-Saharan Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1919575985/Ethnobotanical research in sub-Saharan Africa.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1919575985/Ethnobotanical research in sub-Saharan Africa.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1919575985/Ethnobotanical research in sub-Saharan Africa.pdf"

# File 113/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnobotanical research in sub-Saharan Africa.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Van Wyk_Moteetee_2019_Ethnobotanical research in sub-Saharan Africa – documenting and analysing.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_Moteetee_2019_Ethnobotanical research in sub-Saharan Africa – documenting and analysing.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk_Moteetee_2019_Ethnobotanical research in sub-Saharan Africa – documenting and analysing.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_Moteetee_2019_Ethnobotanical research in sub-Saharan Africa – documenting and analysing.pdf"

# File 114/565: 0.0 B
# Keeping: THESE_Main_Library/A toxicological safety assessment of a standar.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0794564473/A toxicological safety assessment of a standar.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0794564473/A toxicological safety assessment of a standar.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0794564473/A toxicological safety assessment of a standar.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0794564473/A toxicological safety assessment of a standar.pdf"

# File 115/565: 0.0 B
# Keeping: THESE_Main_Library/A toxicological safety assessment of a standar.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4031344136/A toxicological safety assessment of a standar.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4031344136/A toxicological safety assessment of a standar.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4031344136/A toxicological safety assessment of a standar.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4031344136/A toxicological safety assessment of a standar.pdf"

# File 116/565: 0.0 B
# Keeping: THESE_Main_Library/A toxicological safety assessment of a standar.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: ZOTPDF_References/Murbach_2014_A toxicological safety assessment of a standardized extract of Sceletium.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/ZOTPDF_References/Murbach_2014_A toxicological safety assessment of a standardized extract of Sceletium.pdf")"
mv "$BASE_DIR/ZOTPDF_References/Murbach_2014_A toxicological safety assessment of a standardized extract of Sceletium.pdf" "$ARCHIVE_DIR/ZOTPDF_References/Murbach_2014_A toxicological safety assessment of a standardized extract of Sceletium.pdf"

# File 117/565: 0.0 B
# Keeping: THESE_Main_Library/A toxicological safety assessment of a standar.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Murbach et al. - 2014 - A toxicological safety assessment of a standardized extract of Sceletium tortuosum (Zembrin(R)) in r.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Murbach et al. - 2014 - A toxicological safety assessment of a standardized extract of Sceletium tortuosum (Zembrin(R)) in r.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Murbach et al. - 2014 - A toxicological safety assessment of a standardized extract of Sceletium tortuosum (Zembrin(R)) in r.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Murbach et al. - 2014 - A toxicological safety assessment of a standardized extract of Sceletium tortuosum (Zembrin(R)) in r.pdf"

# File 118/565: 0.0 B
# Keeping: THESE_Main_Library/Luo-2022-A network pharmacology-based approach.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0813132226/Luo-2022-A network pharmacology-based approach.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0813132226/Luo-2022-A network pharmacology-based approach.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0813132226/Luo-2022-A network pharmacology-based approach.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0813132226/Luo-2022-A network pharmacology-based approach.pdf"

# File 119/565: 0.0 B
# Keeping: THESE_Main_Library/Luo-2022-A network pharmacology-based approach.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3378809874/Luo-2022-A network pharmacology-based approach.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3378809874/Luo-2022-A network pharmacology-based approach.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3378809874/Luo-2022-A network pharmacology-based approach.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3378809874/Luo-2022-A network pharmacology-based approach.pdf"

# File 120/565: 0.0 B
# Keeping: THESE_Main_Library/Luo-2022-A network pharmacology-based approach.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Luo_2022_A network pharmacology-based approach to explore the therapeutic potential of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Luo_2022_A network pharmacology-based approach to explore the therapeutic potential of.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Luo_2022_A network pharmacology-based approach to explore the therapeutic potential of.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Luo_2022_A network pharmacology-based approach to explore the therapeutic potential of.pdf"

# File 121/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase 4 inhibitors and drugs of ab.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0819494367/Phosphodiesterase 4 inhibitors and drugs of ab.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0819494367/Phosphodiesterase 4 inhibitors and drugs of ab.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0819494367/Phosphodiesterase 4 inhibitors and drugs of ab.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0819494367/Phosphodiesterase 4 inhibitors and drugs of ab.pdf"

# File 122/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase 4 inhibitors and drugs of ab.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1832479405/Phosphodiesterase 4 inhibitors and drugs of ab.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1832479405/Phosphodiesterase 4 inhibitors and drugs of ab.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1832479405/Phosphodiesterase 4 inhibitors and drugs of ab.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1832479405/Phosphodiesterase 4 inhibitors and drugs of ab.pdf"

# File 123/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase 4 inhibitors and drugs of ab.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Olsen_Liu_2016_Phosphodiesterase 4 inhibitors and drugs of abuse.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olsen_Liu_2016_Phosphodiesterase 4 inhibitors and drugs of abuse.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olsen_Liu_2016_Phosphodiesterase 4 inhibitors and drugs of abuse.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olsen_Liu_2016_Phosphodiesterase 4 inhibitors and drugs of abuse.pdf"

# File 124/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum demonstrates in vitro anti.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0847735859/Sceletium tortuosum demonstrates in vitro anti.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0847735859/Sceletium tortuosum demonstrates in vitro anti.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0847735859/Sceletium tortuosum demonstrates in vitro anti.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0847735859/Sceletium tortuosum demonstrates in vitro anti.pdf"

# File 125/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum demonstrates in vitro anti.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2642234250/Sceletium tortuosum demonstrates in vitro anti.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2642234250/Sceletium tortuosum demonstrates in vitro anti.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2642234250/Sceletium tortuosum demonstrates in vitro anti.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2642234250/Sceletium tortuosum demonstrates in vitro anti.pdf"

# File 126/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum demonstrates in vitro anti.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Kapewangolo_2016_Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kapewangolo_2016_Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kapewangolo_2016_Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kapewangolo_2016_Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging.pdf"

# File 127/565: 0.0 B
# Keeping: THESE_Main_Library/Out of southern Africa_ Origin, biogeography a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0870410800/Out of southern Africa_ Origin, biogeography a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0870410800/Out of southern Africa_ Origin, biogeography a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0870410800/Out of southern Africa_ Origin, biogeography a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0870410800/Out of southern Africa_ Origin, biogeography a.pdf"

# File 128/565: 0.0 B
# Keeping: THESE_Main_Library/Out of southern Africa_ Origin, biogeography a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3731132666/Out of southern Africa_ Origin, biogeography a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3731132666/Out of southern Africa_ Origin, biogeography a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3731132666/Out of southern Africa_ Origin, biogeography a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3731132666/Out of southern Africa_ Origin, biogeography a.pdf"

# File 129/565: 0.0 B
# Keeping: THESE_Main_Library/Out of southern Africa_ Origin, biogeography a.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Klak_2017_Out of southern Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Klak_2017_Out of southern Africa.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Klak_2017_Out of southern Africa.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Klak_2017_Out of southern Africa.pdf"

# File 130/565: 0.0 B
# Keeping: THESE_Main_Library/Patnala-2013-Chemotaxonomic studies of mesembr.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0888432512/Patnala-2013-Chemotaxonomic studies of mesembr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0888432512/Patnala-2013-Chemotaxonomic studies of mesembr.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0888432512/Patnala-2013-Chemotaxonomic studies of mesembr.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0888432512/Patnala-2013-Chemotaxonomic studies of mesembr.pdf"

# File 131/565: 0.0 B
# Keeping: THESE_Main_Library/Patnala-2013-Chemotaxonomic studies of mesembr.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3010839109/Patnala-2013-Chemotaxonomic studies of mesembr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3010839109/Patnala-2013-Chemotaxonomic studies of mesembr.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3010839109/Patnala-2013-Chemotaxonomic studies of mesembr.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3010839109/Patnala-2013-Chemotaxonomic studies of mesembr.pdf"

# File 132/565: 0.0 B
# Keeping: THESE_Main_Library/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0909666207/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0909666207/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0909666207/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0909666207/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf"

# File 133/565: 0.0 B
# Keeping: THESE_Main_Library/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1752637606/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1752637606/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1752637606/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1752637606/Manganyi-2021-A Chewable Cure _Kanna__ Biologi.pdf"

# File 134/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant Effects of South African Plants.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0914581282/Antidepressant Effects of South African Plants.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0914581282/Antidepressant Effects of South African Plants.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0914581282/Antidepressant Effects of South African Plants.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0914581282/Antidepressant Effects of South African Plants.pdf"

# File 135/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant Effects of South African Plants.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1842792262/Antidepressant Effects of South African Plants.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1842792262/Antidepressant Effects of South African Plants.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1842792262/Antidepressant Effects of South African Plants.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1842792262/Antidepressant Effects of South African Plants.pdf"

# File 136/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant Effects of South African Plants.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Bonokwane_2022_Antidepressant Effects of South African Plants.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane_2022_Antidepressant Effects of South African Plants.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bonokwane_2022_Antidepressant Effects of South African Plants.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane_2022_Antidepressant Effects of South African Plants.pdf"

# File 137/565: 0.0 B
# Keeping: THESE_Main_Library/The potential of South African plants in the d.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0941418020/The potential of South African plants in the d.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0941418020/The potential of South African plants in the d.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0941418020/The potential of South African plants in the d.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0941418020/The potential of South African plants in the d.pdf"

# File 138/565: 0.0 B
# Keeping: THESE_Main_Library/The potential of South African plants in the d.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3051318042/The potential of South African plants in the d.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3051318042/The potential of South African plants in the d.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3051318042/The potential of South African plants in the d.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3051318042/The potential of South African plants in the d.pdf"

# File 139/565: 0.0 B
# Keeping: THESE_Main_Library/The potential of South African plants in the d.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Van Wyk_2011_The potential of South African plants in the development of new medicinal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2011_The potential of South African plants in the development of new medicinal.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk_2011_The potential of South African plants in the development of new medicinal.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk_2011_The potential of South African plants in the development of new medicinal.pdf"

# File 140/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4 inhibitors_ current status.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/0999385710/PDE4 inhibitors_ current status.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/0999385710/PDE4 inhibitors_ current status.pdf")"
mv "$BASE_DIR/THESE_Main_Library/0999385710/PDE4 inhibitors_ current status.pdf" "$ARCHIVE_DIR/THESE_Main_Library/0999385710/PDE4 inhibitors_ current status.pdf"

# File 141/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4 inhibitors_ current status.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4011596746/PDE4 inhibitors_ current status.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4011596746/PDE4 inhibitors_ current status.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4011596746/PDE4 inhibitors_ current status.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4011596746/PDE4 inhibitors_ current status.pdf"

# File 142/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4 inhibitors_ current status.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Spina_2008_PDE4 inhibitors.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Spina_2008_PDE4 inhibitors.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Spina_2008_PDE4 inhibitors.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Spina_2008_PDE4 inhibitors.pdf"

# File 143/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf")"
mv "$BASE_DIR/THESE_Main_Library/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf" "$ARCHIVE_DIR/THESE_Main_Library/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"

# File 144/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1008361187/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1008361187/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1008361187/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1008361187/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf"

# File 145/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1754163916/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1754163916/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1754163916/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1754163916/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"

# File 146/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3337579196/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3337579196/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3337579196/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3337579196/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf"

# File 147/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4283983086/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4283983086/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4283983086/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4283983086/The Phosphodiesterase-4 (PDE4) Inhibitor Rolip.pdf"

# File 148/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-1.pdf"

# File 149/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-2.pdf"

# File 150/565: 0.0 B
# Keeping: THESE_Main_Library/133c4148-299a-4b10-9bbb-ab0c5df8102c.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012.pdf"

# File 151/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembrine alkaloids_ Review of their occurren.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1057384820/Mesembrine alkaloids_ Review of their occurren.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1057384820/Mesembrine alkaloids_ Review of their occurren.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1057384820/Mesembrine alkaloids_ Review of their occurren.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1057384820/Mesembrine alkaloids_ Review of their occurren.pdf"

# File 152/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembrine alkaloids_ Review of their occurren.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4061902602/Mesembrine alkaloids_ Review of their occurren.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4061902602/Mesembrine alkaloids_ Review of their occurren.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4061902602/Mesembrine alkaloids_ Review of their occurren.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4061902602/Mesembrine alkaloids_ Review of their occurren.pdf"

# File 153/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembrine alkaloids_ Review of their occurren.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Krstenansky_2017_Mesembrine alkaloids.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Krstenansky_2017_Mesembrine alkaloids.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Krstenansky_2017_Mesembrine alkaloids.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Krstenansky_2017_Mesembrine alkaloids.pdf"

# File 154/565: 0.0 B
# Keeping: THESE_Main_Library/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1147561669/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1147561669/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1147561669/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1147561669/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf"

# File 155/565: 0.0 B
# Keeping: THESE_Main_Library/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3037983055/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3037983055/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3037983055/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3037983055/(52) KH-001 BUT NOT OTHER TESTED ALKALOIDS DER.pdf"

# File 156/565: 0.0 B
# Keeping: THESE_Main_Library/Pharmacological actions of the South African m.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1155286638/Pharmacological actions of the South African m.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1155286638/Pharmacological actions of the South African m.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1155286638/Pharmacological actions of the South African m.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1155286638/Pharmacological actions of the South African m.pdf"

# File 157/565: 0.0 B
# Keeping: THESE_Main_Library/Pharmacological actions of the South African m.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1780968077/Pharmacological actions of the South African m.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1780968077/Pharmacological actions of the South African m.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1780968077/Pharmacological actions of the South African m.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1780968077/Pharmacological actions of the South African m.pdf"

# File 158/565: 0.0 B
# Keeping: THESE_Main_Library/Pharmacological actions of the South African m.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011.pdf"

# File 159/565: 0.0 B
# Keeping: THESE_Main_Library/Royal pharmaceuticals_ Bioprospecting, rights.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1208445925/Royal pharmaceuticals_ Bioprospecting, rights.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1208445925/Royal pharmaceuticals_ Bioprospecting, rights.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1208445925/Royal pharmaceuticals_ Bioprospecting, rights.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1208445925/Royal pharmaceuticals_ Bioprospecting, rights.pdf"

# File 160/565: 0.0 B
# Keeping: THESE_Main_Library/Royal pharmaceuticals_ Bioprospecting, rights.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4238560424/Royal pharmaceuticals_ Bioprospecting, rights.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4238560424/Royal pharmaceuticals_ Bioprospecting, rights.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4238560424/Royal pharmaceuticals_ Bioprospecting, rights.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4238560424/Royal pharmaceuticals_ Bioprospecting, rights.pdf"

# File 161/565: 0.0 B
# Keeping: THESE_Main_Library/Royal pharmaceuticals_ Bioprospecting, rights.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016.pdf"

# File 162/565: 0.0 B
# Keeping: THESE_Main_Library/Dopamine_serotonin releasers as medications fo.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1261594621/Dopamine_serotonin releasers as medications fo.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1261594621/Dopamine_serotonin releasers as medications fo.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1261594621/Dopamine_serotonin releasers as medications fo.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1261594621/Dopamine_serotonin releasers as medications fo.pdf"

# File 163/565: 0.0 B
# Keeping: THESE_Main_Library/Dopamine_serotonin releasers as medications fo.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3464237584/Dopamine_serotonin releasers as medications fo.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3464237584/Dopamine_serotonin releasers as medications fo.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3464237584/Dopamine_serotonin releasers as medications fo.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3464237584/Dopamine_serotonin releasers as medications fo.pdf"

# File 164/565: 0.0 B
# Keeping: THESE_Main_Library/Dopamine_serotonin releasers as medications fo.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Rothman_2008_Dopamine-serotonin releasers as medications for stimulant addictions.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Rothman_2008_Dopamine-serotonin releasers as medications for stimulant addictions.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Rothman_2008_Dopamine-serotonin releasers as medications for stimulant addictions.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Rothman_2008_Dopamine-serotonin releasers as medications for stimulant addictions.pdf"

# File 165/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf")"
mv "$BASE_DIR/THESE_Main_Library/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf" "$ARCHIVE_DIR/THESE_Main_Library/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"

# File 166/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1285217423/Neurobiology of addiction_ a neurocircuitry an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1285217423/Neurobiology of addiction_ a neurocircuitry an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1285217423/Neurobiology of addiction_ a neurocircuitry an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1285217423/Neurobiology of addiction_ a neurocircuitry an.pdf"

# File 167/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2679466450/Neurobiology of addiction_ a neurocircuitry an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2679466450/Neurobiology of addiction_ a neurocircuitry an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2679466450/Neurobiology of addiction_ a neurocircuitry an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2679466450/Neurobiology of addiction_ a neurocircuitry an.pdf"

# File 168/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2472793685/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2472793685/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2472793685/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2472793685/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"

# File 169/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3132320210/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3132320210/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3132320210/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3132320210/7cc3ca81-2861-4f5b-a90d-50b78bedba44.pdf"

# File 170/565: 0.0 B
# Keeping: THESE_Main_Library/Neurobiology of addiction_ a neurocircuitry an.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Koob_Volkow_2016_Neurobiology of addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Koob_Volkow_2016_Neurobiology of addiction.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Koob_Volkow_2016_Neurobiology of addiction.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Koob_Volkow_2016_Neurobiology of addiction.pdf"

# File 171/565: 0.0 B
# Keeping: THESE_Main_Library/Biopiracy_ Crying wolf or a lever for equity a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1353290175/Biopiracy_ Crying wolf or a lever for equity a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1353290175/Biopiracy_ Crying wolf or a lever for equity a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1353290175/Biopiracy_ Crying wolf or a lever for equity a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1353290175/Biopiracy_ Crying wolf or a lever for equity a.pdf"

# File 172/565: 0.0 B
# Keeping: THESE_Main_Library/Biopiracy_ Crying wolf or a lever for equity a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2628937522/Biopiracy_ Crying wolf or a lever for equity a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2628937522/Biopiracy_ Crying wolf or a lever for equity a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2628937522/Biopiracy_ Crying wolf or a lever for equity a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2628937522/Biopiracy_ Crying wolf or a lever for equity a.pdf"

# File 173/565: 0.0 B
# Keeping: THESE_Main_Library/Biopiracy_ Crying wolf or a lever for equity a.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Wynberg_2023_Biopiracy.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg_2023_Biopiracy.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Wynberg_2023_Biopiracy.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg_2023_Biopiracy.pdf"

# File 174/565: 0.0 B
# Keeping: THESE_Main_Library/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1370975236/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1370975236/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1370975236/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1370975236/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf"

# File 175/565: 0.0 B
# Keeping: THESE_Main_Library/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2392064702/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2392064702/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2392064702/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2392064702/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf"

# File 176/565: 0.0 B
# Keeping: THESE_Main_Library/0a4de12f-574e-4e82-85b8-bd1c399b605e.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species.pdf"

# File 177/565: 0.0 B
# Keeping: THESE_Main_Library/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1388336285/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1388336285/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1388336285/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1388336285/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf"

# File 178/565: 0.0 B
# Keeping: THESE_Main_Library/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4100155717/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4100155717/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4100155717/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4100155717/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf"

# File 179/565: 0.0 B
# Keeping: THESE_Main_Library/Kabbo’s !Kwaiń_ The Past, Present and Possible.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Gericke_2018_Kabbo’s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Gericke_2018_Kabbo’s.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Gericke_2018_Kabbo’s.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Gericke_2018_Kabbo’s.pdf"

# File 180/565: 0.0 B
# Keeping: THESE_Main_Library/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1389324895/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1389324895/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1389324895/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1389324895/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf"

# File 181/565: 0.0 B
# Keeping: THESE_Main_Library/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4081874354/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4081874354/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4081874354/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4081874354/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf"

# File 182/565: 0.0 B
# Keeping: THESE_Main_Library/The PDE4 cAMP-Specific Phosphodiesterases_ Tar.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Bolger_2017_The PDE4 cAMP-Specific Phosphodiesterases.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bolger_2017_The PDE4 cAMP-Specific Phosphodiesterases.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bolger_2017_The PDE4 cAMP-Specific Phosphodiesterases.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bolger_2017_The PDE4 cAMP-Specific Phosphodiesterases.pdf"

# File 183/565: 0.0 B
# Keeping: THESE_Main_Library/Traditional perinatal plant knowledge in Sub-S.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1436458428/Traditional perinatal plant knowledge in Sub-S.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1436458428/Traditional perinatal plant knowledge in Sub-S.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1436458428/Traditional perinatal plant knowledge in Sub-S.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1436458428/Traditional perinatal plant knowledge in Sub-S.pdf"

# File 184/565: 0.0 B
# Keeping: THESE_Main_Library/Traditional perinatal plant knowledge in Sub-S.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2862640773/Traditional perinatal plant knowledge in Sub-S.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2862640773/Traditional perinatal plant knowledge in Sub-S.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2862640773/Traditional perinatal plant knowledge in Sub-S.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2862640773/Traditional perinatal plant knowledge in Sub-S.pdf"

# File 185/565: 0.0 B
# Keeping: THESE_Main_Library/Traditional perinatal plant knowledge in Sub-S.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Sibeko_2023_Traditional perinatal plant knowledge in Sub-Saharan Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko_2023_Traditional perinatal plant knowledge in Sub-Saharan Africa.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sibeko_2023_Traditional perinatal plant knowledge in Sub-Saharan Africa.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko_2023_Traditional perinatal plant knowledge in Sub-Saharan Africa.pdf"

# File 186/565: 0.0 B
# Keeping: THESE_Main_Library/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Proof-of-Concept Randomized Controlled Study o.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Proof-of-Concept Randomized Controlled Study o.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Proof-of-Concept Randomized Controlled Study o.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Proof-of-Concept Randomized Controlled Study o.pdf"

# File 187/565: 0.0 B
# Keeping: THESE_Main_Library/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1482976073/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1482976073/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1482976073/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1482976073/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf"

# File 188/565: 0.0 B
# Keeping: THESE_Main_Library/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2996988745/Proof-of-Concept Randomized Controlled Study o.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2996988745/Proof-of-Concept Randomized Controlled Study o.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2996988745/Proof-of-Concept Randomized Controlled Study o.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2996988745/Proof-of-Concept Randomized Controlled Study o.pdf"

# File 189/565: 0.0 B
# Keeping: THESE_Main_Library/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3780407774/Proof-of-Concept Randomized Controlled Study o.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3780407774/Proof-of-Concept Randomized Controlled Study o.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3780407774/Proof-of-Concept Randomized Controlled Study o.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3780407774/Proof-of-Concept Randomized Controlled Study o.pdf"

# File 190/565: 0.0 B
# Keeping: THESE_Main_Library/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4062345334/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4062345334/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4062345334/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4062345334/2bbc572e-bdcb-4ebb-9f67-22fd35aa92fe.pdf"

# File 191/565: 0.0 B
# Keeping: THESE_Main_Library/Brendler-2021-Sceletium for Managing Anxiety.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1493527525/Brendler-2021-Sceletium for Managing Anxiety.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1493527525/Brendler-2021-Sceletium for Managing Anxiety.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1493527525/Brendler-2021-Sceletium for Managing Anxiety.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1493527525/Brendler-2021-Sceletium for Managing Anxiety.pdf"

# File 192/565: 0.0 B
# Keeping: THESE_Main_Library/Brendler-2021-Sceletium for Managing Anxiety.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2842747878/Brendler-2021-Sceletium for Managing Anxiety.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2842747878/Brendler-2021-Sceletium for Managing Anxiety.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2842747878/Brendler-2021-Sceletium for Managing Anxiety.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2842747878/Brendler-2021-Sceletium for Managing Anxiety.pdf"

# File 193/565: 0.0 B
# Keeping: THESE_Main_Library/Brendler-2021-Sceletium for Managing Anxiety.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Brendler_2021_Sceletium for Managing Anxiety, Depression and Cognitive Impairment.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Brendler_2021_Sceletium for Managing Anxiety, Depression and Cognitive Impairment.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Brendler_2021_Sceletium for Managing Anxiety, Depression and Cognitive Impairment.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Brendler_2021_Sceletium for Managing Anxiety, Depression and Cognitive Impairment.pdf"

# File 194/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1523280143/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1523280143/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1523280143/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1523280143/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf"

# File 195/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1546414812/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1546414812/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1546414812/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1546414812/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf"

# File 196/565: 0.0 B
# Keeping: THESE_Main_Library/Phosphodiesterase-4 enzyme as a therapeutic ta.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020.pdf"

# File 197/565: 0.0 B
# Keeping: THESE_Main_Library/UCreview.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1595398980/UCreview.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1595398980/UCreview.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1595398980/UCreview.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1595398980/UCreview.pdf"

# File 198/565: 0.0 B
# Keeping: THESE_Main_Library/UCreview.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013.pdf"

# File 199/565: 0.0 B
# Keeping: THESE_Main_Library/The effects of Sceletium tortuosum in an in vi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1646290972/The effects of Sceletium tortuosum in an in vi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1646290972/The effects of Sceletium tortuosum in an in vi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1646290972/The effects of Sceletium tortuosum in an in vi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1646290972/The effects of Sceletium tortuosum in an in vi.pdf"

# File 200/565: 0.0 B
# Keeping: THESE_Main_Library/The effects of Sceletium tortuosum in an in vi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2514912302/The effects of Sceletium tortuosum in an in vi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2514912302/The effects of Sceletium tortuosum in an in vi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2514912302/The effects of Sceletium tortuosum in an in vi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2514912302/The effects of Sceletium tortuosum in an in vi.pdf"

# File 201/565: 0.0 B
# Keeping: THESE_Main_Library/Addiction and the Brain_ Development, Not Dise.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1704358372/Addiction and the Brain_ Development, Not Dise.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1704358372/Addiction and the Brain_ Development, Not Dise.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1704358372/Addiction and the Brain_ Development, Not Dise.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1704358372/Addiction and the Brain_ Development, Not Dise.pdf"

# File 202/565: 0.0 B
# Keeping: THESE_Main_Library/Addiction and the Brain_ Development, Not Dise.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2689230580/Addiction and the Brain_ Development, Not Dise.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2689230580/Addiction and the Brain_ Development, Not Dise.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2689230580/Addiction and the Brain_ Development, Not Dise.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2689230580/Addiction and the Brain_ Development, Not Dise.pdf"

# File 203/565: 0.0 B
# Keeping: THESE_Main_Library/Addiction and the Brain_ Development, Not Dise.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Lewis_2017_Addiction and the Brain.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Lewis_2017_Addiction and the Brain.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Lewis_2017_Addiction and the Brain.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Lewis_2017_Addiction and the Brain.pdf"

# File 204/565: 0.0 B
# Keeping: THESE_Main_Library/JPBMS_Pei Yu_06_20_151_160.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1775370468/JPBMS_Pei Yu_06_20_151_160.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1775370468/JPBMS_Pei Yu_06_20_151_160.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1775370468/JPBMS_Pei Yu_06_20_151_160.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1775370468/JPBMS_Pei Yu_06_20_151_160.pdf"

# File 205/565: 0.0 B
# Keeping: THESE_Main_Library/JPBMS_Pei Yu_06_20_151_160.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020.pdf"

# File 206/565: 0.0 B
# Keeping: THESE_Main_Library/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1809913732/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1809913732/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1809913732/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1809913732/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf"

# File 207/565: 0.0 B
# Keeping: THESE_Main_Library/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3684985454/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3684985454/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3684985454/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3684985454/3131abeb-fb7f-4c6c-b347-0e8eea5f3701.pdf"

# File 208/565: 0.0 B
# Keeping: THESE_Main_Library/Reddy-2023-Skeletons in the closet_ – Using a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1838227138/Reddy-2023-Skeletons in the closet_ – Using a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1838227138/Reddy-2023-Skeletons in the closet_ – Using a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1838227138/Reddy-2023-Skeletons in the closet_ – Using a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1838227138/Reddy-2023-Skeletons in the closet_ – Using a.pdf"

# File 209/565: 0.0 B
# Keeping: THESE_Main_Library/Journal of HIGH.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1892447738/Journal of HIGH.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1892447738/Journal of HIGH.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1892447738/Journal of HIGH.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1892447738/Journal of HIGH.pdf"

# File 210/565: 0.0 B
# Keeping: THESE_Main_Library/Journal of HIGH.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2135292275/Journal of HIGH.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2135292275/Journal of HIGH.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2135292275/Journal of HIGH.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2135292275/Journal of HIGH.pdf"

# File 211/565: 0.0 B
# Keeping: THESE_Main_Library/Journal of HIGH.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3784075089/Journal of HIGH.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3784075089/Journal of HIGH.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3784075089/Journal of HIGH.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3784075089/Journal of HIGH.pdf"

# File 212/565: 0.0 B
# Keeping: THESE_Main_Library/Journal of HIGH.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970.pdf"

# File 213/565: 0.0 B
# Keeping: THESE_Main_Library/boj12117.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1985870475/boj12117.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1985870475/boj12117.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1985870475/boj12117.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1985870475/boj12117.pdf"

# File 214/565: 0.0 B
# Keeping: THESE_Main_Library/boj12117.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4170934191/boj12117.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4170934191/boj12117.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4170934191/boj12117.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4170934191/boj12117.pdf"

# File 215/565: 0.0 B
# Keeping: THESE_Main_Library/Skeletons in the closet_ – Using a bibliometri.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1994878191/Skeletons in the closet_ – Using a bibliometri.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1994878191/Skeletons in the closet_ – Using a bibliometri.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1994878191/Skeletons in the closet_ – Using a bibliometri.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1994878191/Skeletons in the closet_ – Using a bibliometri.pdf"

# File 216/565: 0.0 B
# Keeping: THESE_Main_Library/Skeletons in the closet_ – Using a bibliometri.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3963954027/Skeletons in the closet_ – Using a bibliometri.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3963954027/Skeletons in the closet_ – Using a bibliometri.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3963954027/Skeletons in the closet_ – Using a bibliometri.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3963954027/Skeletons in the closet_ – Using a bibliometri.pdf"

# File 217/565: 0.0 B
# Keeping: THESE_Main_Library/In Vitro Permeation of Mesembrine Alkaloids fr.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/1999726917/In Vitro Permeation of Mesembrine Alkaloids fr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/1999726917/In Vitro Permeation of Mesembrine Alkaloids fr.pdf")"
mv "$BASE_DIR/THESE_Main_Library/1999726917/In Vitro Permeation of Mesembrine Alkaloids fr.pdf" "$ARCHIVE_DIR/THESE_Main_Library/1999726917/In Vitro Permeation of Mesembrine Alkaloids fr.pdf"

# File 218/565: 0.0 B
# Keeping: THESE_Main_Library/In Vitro Permeation of Mesembrine Alkaloids fr.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4181869316/In Vitro Permeation of Mesembrine Alkaloids fr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4181869316/In Vitro Permeation of Mesembrine Alkaloids fr.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4181869316/In Vitro Permeation of Mesembrine Alkaloids fr.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4181869316/In Vitro Permeation of Mesembrine Alkaloids fr.pdf"

# File 219/565: 0.0 B
# Keeping: THESE_Main_Library/Learning to forget_ manipulating extinction an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2012119272/Learning to forget_ manipulating extinction an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2012119272/Learning to forget_ manipulating extinction an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2012119272/Learning to forget_ manipulating extinction an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2012119272/Learning to forget_ manipulating extinction an.pdf"

# File 220/565: 0.0 B
# Keeping: THESE_Main_Library/Learning to forget_ manipulating extinction an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3223808357/Learning to forget_ manipulating extinction an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3223808357/Learning to forget_ manipulating extinction an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3223808357/Learning to forget_ manipulating extinction an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3223808357/Learning to forget_ manipulating extinction an.pdf"

# File 221/565: 0.0 B
# Keeping: THESE_Main_Library/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2018732076/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2018732076/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2018732076/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2018732076/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf"

# File 222/565: 0.0 B
# Keeping: THESE_Main_Library/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4006505401/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4006505401/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4006505401/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4006505401/Berry-2021-Effects of Zembrin® (Sceletium tort.pdf"

# File 223/565: 0.0 B
# Keeping: THESE_Main_Library/Treatment of anxiety and depression_ medicinal.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2026453812/Treatment of anxiety and depression_ medicinal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2026453812/Treatment of anxiety and depression_ medicinal.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2026453812/Treatment of anxiety and depression_ medicinal.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2026453812/Treatment of anxiety and depression_ medicinal.pdf"

# File 224/565: 0.0 B
# Keeping: THESE_Main_Library/Treatment of anxiety and depression_ medicinal.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3124522660/Treatment of anxiety and depression_ medicinal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3124522660/Treatment of anxiety and depression_ medicinal.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3124522660/Treatment of anxiety and depression_ medicinal.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3124522660/Treatment of anxiety and depression_ medicinal.pdf"

# File 225/565: 0.0 B
# Keeping: THESE_Main_Library/Treatment of anxiety and depression_ medicinal.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016.pdf"

# File 226/565: 0.0 B
# Keeping: THESE_Main_Library/Medicinal Plants for Treatment of Prevalent Di.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2037803365/Medicinal Plants for Treatment of Prevalent Di.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2037803365/Medicinal Plants for Treatment of Prevalent Di.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2037803365/Medicinal Plants for Treatment of Prevalent Di.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2037803365/Medicinal Plants for Treatment of Prevalent Di.pdf"

# File 227/565: 0.0 B
# Keeping: THESE_Main_Library/Medicinal Plants for Treatment of Prevalent Di.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3049735082/Medicinal Plants for Treatment of Prevalent Di.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3049735082/Medicinal Plants for Treatment of Prevalent Di.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3049735082/Medicinal Plants for Treatment of Prevalent Di.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3049735082/Medicinal Plants for Treatment of Prevalent Di.pdf"

# File 228/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant effects of inhibitors of cAMP p.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2130011923/Antidepressant effects of inhibitors of cAMP p.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2130011923/Antidepressant effects of inhibitors of cAMP p.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2130011923/Antidepressant effects of inhibitors of cAMP p.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2130011923/Antidepressant effects of inhibitors of cAMP p.pdf"

# File 229/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant effects of inhibitors of cAMP p.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3248330876/Antidepressant effects of inhibitors of cAMP p.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3248330876/Antidepressant effects of inhibitors of cAMP p.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3248330876/Antidepressant effects of inhibitors of cAMP p.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3248330876/Antidepressant effects of inhibitors of cAMP p.pdf"

# File 230/565: 0.0 B
# Keeping: THESE_Main_Library/Antidepressant effects of inhibitors of cAMP p.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/O'Donnell_Zhang_2004_Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/O'Donnell_Zhang_2004_Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf")"
mv "$BASE_DIR/DRAFTSS_Working/O'Donnell_Zhang_2004_Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf" "$ARCHIVE_DIR/DRAFTSS_Working/O'Donnell_Zhang_2004_Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf"

# File 231/565: 0.0 B
# Keeping: THESE_Main_Library/Valente-2014-Correlates of hyperdiversity in s.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2146500633/Valente-2014-Correlates of hyperdiversity in s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2146500633/Valente-2014-Correlates of hyperdiversity in s.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2146500633/Valente-2014-Correlates of hyperdiversity in s.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2146500633/Valente-2014-Correlates of hyperdiversity in s.pdf"

# File 232/565: 0.0 B
# Keeping: THESE_Main_Library/Valente-2014-Correlates of hyperdiversity in s.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2197448639/Valente-2014-Correlates of hyperdiversity in s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2197448639/Valente-2014-Correlates of hyperdiversity in s.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2197448639/Valente-2014-Correlates of hyperdiversity in s.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2197448639/Valente-2014-Correlates of hyperdiversity in s.pdf"

# File 233/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembryanthemum tortuosum L. alkaloids modify.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2147157566/Mesembryanthemum tortuosum L. alkaloids modify.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2147157566/Mesembryanthemum tortuosum L. alkaloids modify.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2147157566/Mesembryanthemum tortuosum L. alkaloids modify.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2147157566/Mesembryanthemum tortuosum L. alkaloids modify.pdf"

# File 234/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembryanthemum tortuosum L. alkaloids modify.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4076890515/Mesembryanthemum tortuosum L. alkaloids modify.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4076890515/Mesembryanthemum tortuosum L. alkaloids modify.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4076890515/Mesembryanthemum tortuosum L. alkaloids modify.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4076890515/Mesembryanthemum tortuosum L. alkaloids modify.pdf"

# File 235/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembryanthemum tortuosum L. alkaloids modify.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Maphanga_2022_Mesembryanthemum tortuosum L.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Maphanga_2022_Mesembryanthemum tortuosum L.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Maphanga_2022_Mesembryanthemum tortuosum L.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Maphanga_2022_Mesembryanthemum tortuosum L.pdf"

# File 236/565: 0.0 B
# Keeping: THESE_Main_Library/The chemotypic variation of Sceletium tortuosu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2162907227/The chemotypic variation of Sceletium tortuosu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2162907227/The chemotypic variation of Sceletium tortuosu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2162907227/The chemotypic variation of Sceletium tortuosu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2162907227/The chemotypic variation of Sceletium tortuosu.pdf"

# File 237/565: 0.0 B
# Keeping: THESE_Main_Library/The chemotypic variation of Sceletium tortuosu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3258410896/The chemotypic variation of Sceletium tortuosu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3258410896/The chemotypic variation of Sceletium tortuosu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3258410896/The chemotypic variation of Sceletium tortuosu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3258410896/The chemotypic variation of Sceletium tortuosu.pdf"

# File 238/565: 0.0 B
# Keeping: THESE_Main_Library/The chemotypic variation of Sceletium tortuosu.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Shikanga_2012_The chemotypic variation of Sceletium tortuosum alkaloids and commercial.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga_2012_The chemotypic variation of Sceletium tortuosum alkaloids and commercial.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Shikanga_2012_The chemotypic variation of Sceletium tortuosum alkaloids and commercial.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga_2012_The chemotypic variation of Sceletium tortuosum alkaloids and commercial.pdf"

# File 239/565: 0.0 B
# Keeping: THESE_Main_Library/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2183096411/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2183096411/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2183096411/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2183096411/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf"

# File 240/565: 0.0 B
# Keeping: THESE_Main_Library/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2665949036/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2665949036/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2665949036/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2665949036/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf"

# File 241/565: 0.0 B
# Keeping: THESE_Main_Library/Ergogenic Effects of 8 Days of Sceletium Tortu.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020.pdf"

# File 242/565: 0.0 B
# Keeping: THESE_Main_Library/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2321378574/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2321378574/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2321378574/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2321378574/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf"

# File 243/565: 0.0 B
# Keeping: THESE_Main_Library/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2843909590/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2843909590/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2843909590/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2843909590/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf"

# File 244/565: 0.0 B
# Keeping: THESE_Main_Library/Alvaro Viljoen, Maxleene Sandasi, Gerda Fouche.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Alvaro Viljoen_2023_The South African Herbal Pharmacopoeia.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Alvaro Viljoen_2023_The South African Herbal Pharmacopoeia.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Alvaro Viljoen_2023_The South African Herbal Pharmacopoeia.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Alvaro Viljoen_2023_The South African Herbal Pharmacopoeia.pdf"

# File 245/565: 0.0 B
# Keeping: THESE_Main_Library/low2007.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2383707266/low2007.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2383707266/low2007.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2383707266/low2007.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2383707266/low2007.pdf"

# File 246/565: 0.0 B
# Keeping: THESE_Main_Library/low2007.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2480302077/low2007.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2480302077/low2007.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2480302077/low2007.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2480302077/low2007.pdf"

# File 247/565: 0.0 B
# Keeping: THESE_Main_Library/low2007.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Low_2007_Different Histories of Buchu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Low_2007_Different Histories of Buchu.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Low_2007_Different Histories of Buchu.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Low_2007_Different Histories of Buchu.pdf"

# File 248/565: 0.0 B
# Keeping: THESE_Main_Library/Kaylan-2023-Skeletons in the closet_ – Using a.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2416739987/Kaylan-2023-Skeletons in the closet_ – Using a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2416739987/Kaylan-2023-Skeletons in the closet_ – Using a.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2416739987/Kaylan-2023-Skeletons in the closet_ – Using a.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2416739987/Kaylan-2023-Skeletons in the closet_ – Using a.pdf"

# File 249/565: 0.0 B
# Keeping: THESE_Main_Library/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2446979709/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2446979709/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2446979709/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2446979709/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf"

# File 250/565: 0.0 B
# Keeping: THESE_Main_Library/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3689506985/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3689506985/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3689506985/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3689506985/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf"

# File 251/565: 0.0 B
# Keeping: THESE_Main_Library/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Meyer_2015_GC-MS, LC-MS(n), LC-high resolution-MS(n), and NMR studies on the metabolism.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Meyer_2015_GC-MS, LC-MS(n), LC-high resolution-MS(n), and NMR studies on the metabolism.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Meyer_2015_GC-MS, LC-MS(n), LC-high resolution-MS(n), and NMR studies on the metabolism.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Meyer_2015_GC-MS, LC-MS(n), LC-high resolution-MS(n), and NMR studies on the metabolism.pdf"

# File 252/565: 0.0 B
# Keeping: THESE_Main_Library/GC-MS, LC-MS(n), LC-high resolution-MS(n), and.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Swart_Smith_2016_Modulation of glucocorticoid, mineralocorticoid and androgen production in H295.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Swart_Smith_2016_Modulation of glucocorticoid, mineralocorticoid and androgen production in H295.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Swart_Smith_2016_Modulation of glucocorticoid, mineralocorticoid and androgen production in H295.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Swart_Smith_2016_Modulation of glucocorticoid, mineralocorticoid and androgen production in H295.pdf"

# File 253/565: 0.0 B
# Keeping: THESE_Main_Library/Plant-based Medicines (Phytoceuticals) in the.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2459265787/Plant-based Medicines (Phytoceuticals) in the.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2459265787/Plant-based Medicines (Phytoceuticals) in the.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2459265787/Plant-based Medicines (Phytoceuticals) in the.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2459265787/Plant-based Medicines (Phytoceuticals) in the.pdf"

# File 254/565: 0.0 B
# Keeping: THESE_Main_Library/Plant-based Medicines (Phytoceuticals) in the.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2466533921/Plant-based Medicines (Phytoceuticals) in the.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2466533921/Plant-based Medicines (Phytoceuticals) in the.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2466533921/Plant-based Medicines (Phytoceuticals) in the.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2466533921/Plant-based Medicines (Phytoceuticals) in the.pdf"

# File 255/565: 0.0 B
# Keeping: THESE_Main_Library/James Faber-2022-The Importance ofSceletium to.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2501994743/James Faber-2022-The Importance ofSceletium to.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2501994743/James Faber-2022-The Importance ofSceletium to.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2501994743/James Faber-2022-The Importance ofSceletium to.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2501994743/James Faber-2022-The Importance ofSceletium to.pdf"

# File 256/565: 0.0 B
# Keeping: THESE_Main_Library/James Faber-2022-The Importance ofSceletium to.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2971516196/James Faber-2022-The Importance ofSceletium to.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2971516196/James Faber-2022-The Importance ofSceletium to.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2971516196/James Faber-2022-The Importance ofSceletium to.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2971516196/James Faber-2022-The Importance ofSceletium to.pdf"

# File 257/565: 0.0 B
# Keeping: THESE_Main_Library/James Faber-2022-The Importance ofSceletium to.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022.pdf"

# File 258/565: 0.0 B
# Keeping: THESE_Main_Library/HPLC analysis of mesembrine-type alkaloids in.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2518938779/HPLC analysis of mesembrine-type alkaloids in.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2518938779/HPLC analysis of mesembrine-type alkaloids in.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2518938779/HPLC analysis of mesembrine-type alkaloids in.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2518938779/HPLC analysis of mesembrine-type alkaloids in.pdf"

# File 259/565: 0.0 B
# Keeping: THESE_Main_Library/HPLC analysis of mesembrine-type alkaloids in.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2736220376/HPLC analysis of mesembrine-type alkaloids in.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2736220376/HPLC analysis of mesembrine-type alkaloids in.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2736220376/HPLC analysis of mesembrine-type alkaloids in.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2736220376/HPLC analysis of mesembrine-type alkaloids in.pdf"

# File 260/565: 0.0 B
# Keeping: THESE_Main_Library/HPLC analysis of mesembrine-type alkaloids in.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Patnala_Kanfer_2010_HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2010_HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala_Kanfer_2010_HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2010_HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as.pdf"

# File 261/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium Plant Species_ Alkaloidal Components.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2525887026/Sceletium Plant Species_ Alkaloidal Components.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2525887026/Sceletium Plant Species_ Alkaloidal Components.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2525887026/Sceletium Plant Species_ Alkaloidal Components.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2525887026/Sceletium Plant Species_ Alkaloidal Components.pdf"

# File 262/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium Plant Species_ Alkaloidal Components.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2897767444/Sceletium Plant Species_ Alkaloidal Components.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2897767444/Sceletium Plant Species_ Alkaloidal Components.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2897767444/Sceletium Plant Species_ Alkaloidal Components.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2897767444/Sceletium Plant Species_ Alkaloidal Components.pdf"

# File 263/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium Plant Species_ Alkaloidal Components.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala_Kanfer_2017_Sceletium Plant Species-1.pdf"

# File 264/565: 0.0 B
# Keeping: THESE_Main_Library/Wind, Life, Health Anthropological and Histori.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2565843494/Wind, Life, Health Anthropological and Histori.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2565843494/Wind, Life, Health Anthropological and Histori.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2565843494/Wind, Life, Health Anthropological and Histori.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2565843494/Wind, Life, Health Anthropological and Histori.pdf"

# File 265/565: 0.0 B
# Keeping: THESE_Main_Library/Wind, Life, Health Anthropological and Histori.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2598431911/Wind, Life, Health Anthropological and Histori.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2598431911/Wind, Life, Health Anthropological and Histori.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2598431911/Wind, Life, Health Anthropological and Histori.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2598431911/Wind, Life, Health Anthropological and Histori.pdf"

# File 266/565: 0.0 B
# Keeping: THESE_Main_Library/Wind, Life, Health Anthropological and Histori.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Chris Low_Wind, Life, Health Anthropological and Historical.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Chris Low_Wind, Life, Health Anthropological and Historical.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Chris Low_Wind, Life, Health Anthropological and Historical.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Chris Low_Wind, Life, Health Anthropological and Historical.pdf"

# File 267/565: 0.0 B
# Keeping: THESE_Main_Library/Wind, Life, Health Anthropological and Histori.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Low_2007_Khoisan Wind.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Low_2007_Khoisan Wind.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Low_2007_Khoisan Wind.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Low_2007_Khoisan Wind.pdf"

# File 268/565: 0.0 B
# Keeping: THESE_Main_Library/Psychoactive Plants_ A Neglected Area of Ethno.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2657839961/Psychoactive Plants_ A Neglected Area of Ethno.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2657839961/Psychoactive Plants_ A Neglected Area of Ethno.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2657839961/Psychoactive Plants_ A Neglected Area of Ethno.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2657839961/Psychoactive Plants_ A Neglected Area of Ethno.pdf"

# File 269/565: 0.0 B
# Keeping: THESE_Main_Library/Psychoactive Plants_ A Neglected Area of Ethno.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3874422476/Psychoactive Plants_ A Neglected Area of Ethno.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3874422476/Psychoactive Plants_ A Neglected Area of Ethno.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3874422476/Psychoactive Plants_ A Neglected Area of Ethno.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3874422476/Psychoactive Plants_ A Neglected Area of Ethno.pdf"

# File 270/565: 0.0 B
# Keeping: THESE_Main_Library/Avchalumov-2021-Plasticity in the Hippocampus.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Plasticity in the Hippocampus, Neurogenesis an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Plasticity in the Hippocampus, Neurogenesis an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Plasticity in the Hippocampus, Neurogenesis an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Plasticity in the Hippocampus, Neurogenesis an.pdf"

# File 271/565: 0.0 B
# Keeping: THESE_Main_Library/Avchalumov-2021-Plasticity in the Hippocampus.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2689781939/Plasticity in the Hippocampus, Neurogenesis an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2689781939/Plasticity in the Hippocampus, Neurogenesis an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2689781939/Plasticity in the Hippocampus, Neurogenesis an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2689781939/Plasticity in the Hippocampus, Neurogenesis an.pdf"

# File 272/565: 0.0 B
# Keeping: THESE_Main_Library/Avchalumov-2021-Plasticity in the Hippocampus.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2752005042/Avchalumov-2021-Plasticity in the Hippocampus.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2752005042/Avchalumov-2021-Plasticity in the Hippocampus.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2752005042/Avchalumov-2021-Plasticity in the Hippocampus.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2752005042/Avchalumov-2021-Plasticity in the Hippocampus.pdf"

# File 273/565: 0.0 B
# Keeping: THESE_Main_Library/Avchalumov-2021-Plasticity in the Hippocampus.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3422055178/Plasticity in the Hippocampus, Neurogenesis an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3422055178/Plasticity in the Hippocampus, Neurogenesis an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3422055178/Plasticity in the Hippocampus, Neurogenesis an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3422055178/Plasticity in the Hippocampus, Neurogenesis an.pdf"

# File 274/565: 0.0 B
# Keeping: THESE_Main_Library/Avchalumov-2021-Plasticity in the Hippocampus.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Avchalumov_Mandyam_2021_Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov_Mandyam_2021_Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Avchalumov_Mandyam_2021_Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov_Mandyam_2021_Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf"

# File 275/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4-inhibitors A novel targeted therapy for obstructive airways disease.pdf
# Reason: More descriptive filename
echo "Moving: THESE_Main_Library/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf")"
mv "$BASE_DIR/THESE_Main_Library/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf" "$ARCHIVE_DIR/THESE_Main_Library/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"

# File 276/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4-inhibitors A novel targeted therapy for obstructive airways disease.pdf
# Reason: More descriptive filename
echo "Moving: THESE_Main_Library/2714645415/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2714645415/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2714645415/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2714645415/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"

# File 277/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4-inhibitors A novel targeted therapy for obstructive airways disease.pdf
# Reason: More descriptive filename
echo "Moving: THESE_Main_Library/3108268670/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3108268670/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3108268670/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3108268670/a7aefbcd-29d6-4673-b76e-4327840c23fc.pdf"

# File 278/565: 0.0 B
# Keeping: THESE_Main_Library/PDE4-inhibitors A novel targeted therapy for obstructive airways disease.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011.pdf"

# File 279/565: 0.0 B
# Keeping: THESE_Main_Library/Reay-2020-Sceletium tortuosum (Zembrin((R)) ).pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2716825154/Reay-2020-Sceletium tortuosum (Zembrin((R)) ).pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2716825154/Reay-2020-Sceletium tortuosum (Zembrin((R)) ).pdf")"
mv "$BASE_DIR/THESE_Main_Library/2716825154/Reay-2020-Sceletium tortuosum (Zembrin((R)) ).pdf" "$ARCHIVE_DIR/THESE_Main_Library/2716825154/Reay-2020-Sceletium tortuosum (Zembrin((R)) ).pdf"

# File 280/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum (Zembrin((R)) ) ameliorate.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2793761710/Sceletium tortuosum (Zembrin((R)) ) ameliorate.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2793761710/Sceletium tortuosum (Zembrin((R)) ) ameliorate.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2793761710/Sceletium tortuosum (Zembrin((R)) ) ameliorate.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2793761710/Sceletium tortuosum (Zembrin((R)) ) ameliorate.pdf"

# File 281/565: 0.0 B
# Keeping: THESE_Main_Library/In vitro and ex vivo vegetative propagation an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2926460303/In vitro and ex vivo vegetative propagation an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2926460303/In vitro and ex vivo vegetative propagation an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2926460303/In vitro and ex vivo vegetative propagation an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2926460303/In vitro and ex vivo vegetative propagation an.pdf"

# File 282/565: 0.0 B
# Keeping: THESE_Main_Library/In vitro and ex vivo vegetative propagation an.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2929617174/In vitro and ex vivo vegetative propagation an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2929617174/In vitro and ex vivo vegetative propagation an.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2929617174/In vitro and ex vivo vegetative propagation an.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2929617174/In vitro and ex vivo vegetative propagation an.pdf"

# File 283/565: 0.0 B
# Keeping: THESE_Main_Library/In vitro and ex vivo vegetative propagation an.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Sreekissoon_2021_In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon_2021_In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sreekissoon_2021_In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon_2021_In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium.pdf"

# File 284/565: 0.0 B
# Keeping: THESE_Main_Library/Prasad-2013-Role of Traditional and Alternativ.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2958115612/Prasad-2013-Role of Traditional and Alternativ.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2958115612/Prasad-2013-Role of Traditional and Alternativ.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2958115612/Prasad-2013-Role of Traditional and Alternativ.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2958115612/Prasad-2013-Role of Traditional and Alternativ.pdf"

# File 285/565: 0.0 B
# Keeping: THESE_Main_Library/Prasad-2013-Role of Traditional and Alternativ.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-1.pdf"

# File 286/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/Neuroimmune Mechanisms as Novel Treatment Targ.pdf")"
mv "$BASE_DIR/THESE_Main_Library/Neuroimmune Mechanisms as Novel Treatment Targ.pdf" "$ARCHIVE_DIR/THESE_Main_Library/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"

# File 287/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2972507366/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2972507366/Neuroimmune Mechanisms as Novel Treatment Targ.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2972507366/Neuroimmune Mechanisms as Novel Treatment Targ.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2972507366/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"

# File 288/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3417008641/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3417008641/Neuroimmune Mechanisms as Novel Treatment Targ.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3417008641/Neuroimmune Mechanisms as Novel Treatment Targ.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3417008641/Neuroimmune Mechanisms as Novel Treatment Targ.pdf"

# File 289/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3637938295/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3637938295/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3637938295/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3637938295/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf"

# File 290/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: ZOTPDF_References/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/ZOTPDF_References/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf")"
mv "$BASE_DIR/ZOTPDF_References/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf" "$ARCHIVE_DIR/ZOTPDF_References/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf"

# File 291/565: 0.0 B
# Keeping: THESE_Main_Library/Namba-2021-Neuroimmune Mechanisms as Novel Tre.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Namba_2021_Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders.pdf"

# File 292/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum-derived mesembrine signifi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2981701698/Sceletium tortuosum-derived mesembrine signifi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2981701698/Sceletium tortuosum-derived mesembrine signifi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2981701698/Sceletium tortuosum-derived mesembrine signifi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2981701698/Sceletium tortuosum-derived mesembrine signifi.pdf"

# File 293/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum-derived mesembrine signifi.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3500436563/Sceletium tortuosum-derived mesembrine signifi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3500436563/Sceletium tortuosum-derived mesembrine signifi.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3500436563/Sceletium tortuosum-derived mesembrine signifi.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3500436563/Sceletium tortuosum-derived mesembrine signifi.pdf"

# File 294/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum-derived mesembrine signifi.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024.pdf"

# File 295/565: 0.0 B
# Keeping: THESE_Main_Library/e3a96035-9753-40de-a666-8a92a5c6216b.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3150408021/e3a96035-9753-40de-a666-8a92a5c6216b.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3150408021/e3a96035-9753-40de-a666-8a92a5c6216b.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3150408021/e3a96035-9753-40de-a666-8a92a5c6216b.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3150408021/e3a96035-9753-40de-a666-8a92a5c6216b.pdf"

# File 296/565: 0.0 B
# Keeping: THESE_Main_Library/e3a96035-9753-40de-a666-8a92a5c6216b.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3424159397/e3a96035-9753-40de-a666-8a92a5c6216b.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3424159397/e3a96035-9753-40de-a666-8a92a5c6216b.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3424159397/e3a96035-9753-40de-a666-8a92a5c6216b.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3424159397/e3a96035-9753-40de-a666-8a92a5c6216b.pdf"

# File 297/565: 0.0 B
# Keeping: THESE_Main_Library/e3a96035-9753-40de-a666-8a92a5c6216b.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Torregrossa_Taylor_2013_Learning to forget.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Torregrossa_Taylor_2013_Learning to forget.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Torregrossa_Taylor_2013_Learning to forget.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Torregrossa_Taylor_2013_Learning to forget.pdf"

# File 298/565: 0.0 B
# Keeping: THESE_Main_Library/Corrigendum to “Sceletium tortuosum_ A review.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3152539394/Corrigendum to “Sceletium tortuosum_ A review.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3152539394/Corrigendum to “Sceletium tortuosum_ A review.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3152539394/Corrigendum to “Sceletium tortuosum_ A review.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3152539394/Corrigendum to “Sceletium tortuosum_ A review.pdf"

# File 299/565: 0.0 B
# Keeping: THESE_Main_Library/Corrigendum to “Sceletium tortuosum_ A review.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3307366350/Corrigendum to “Sceletium tortuosum_ A review.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3307366350/Corrigendum to “Sceletium tortuosum_ A review.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3307366350/Corrigendum to “Sceletium tortuosum_ A review.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3307366350/Corrigendum to “Sceletium tortuosum_ A review.pdf"

# File 300/565: 0.0 B
# Keeping: THESE_Main_Library/Corrigendum to “Sceletium tortuosum_ A review.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Olatunji_2022_Corrigendum to “Sceletium tortuosum.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji_2022_Corrigendum to “Sceletium tortuosum.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olatunji_2022_Corrigendum to “Sceletium tortuosum.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji_2022_Corrigendum to “Sceletium tortuosum.pdf"

# File 301/565: 0.0 B
# Keeping: THESE_Main_Library/Screening selected medicinal plants for potent.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3267299618/Screening selected medicinal plants for potent.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3267299618/Screening selected medicinal plants for potent.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3267299618/Screening selected medicinal plants for potent.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3267299618/Screening selected medicinal plants for potent.pdf"

# File 302/565: 0.0 B
# Keeping: THESE_Main_Library/Screening selected medicinal plants for potent.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3378867408/Screening selected medicinal plants for potent.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3378867408/Screening selected medicinal plants for potent.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3378867408/Screening selected medicinal plants for potent.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3378867408/Screening selected medicinal plants for potent.pdf"

# File 303/565: 0.0 B
# Keeping: THESE_Main_Library/Screening selected medicinal plants for potent.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020.pdf"

# File 304/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum may delay chronic disease.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3273593370/Sceletium tortuosum may delay chronic disease.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3273593370/Sceletium tortuosum may delay chronic disease.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3273593370/Sceletium tortuosum may delay chronic disease.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3273593370/Sceletium tortuosum may delay chronic disease.pdf"

# File 305/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum may delay chronic disease.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4099370051/Sceletium tortuosum may delay chronic disease.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4099370051/Sceletium tortuosum may delay chronic disease.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4099370051/Sceletium tortuosum may delay chronic disease.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4099370051/Sceletium tortuosum may delay chronic disease.pdf"

# File 306/565: 0.0 B
# Keeping: THESE_Main_Library/Sceletium tortuosum may delay chronic disease.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018.pdf"

# File 307/565: 0.0 B
# Keeping: THESE_Main_Library/DETERMINANTS OF ADDICTION.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3363858398/DETERMINANTS OF ADDICTION.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3363858398/DETERMINANTS OF ADDICTION.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3363858398/DETERMINANTS OF ADDICTION.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3363858398/DETERMINANTS OF ADDICTION.pdf"

# File 308/565: 0.0 B
# Keeping: THESE_Main_Library/DETERMINANTS OF ADDICTION.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3904430881/DETERMINANTS OF ADDICTION.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3904430881/DETERMINANTS OF ADDICTION.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3904430881/DETERMINANTS OF ADDICTION.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3904430881/DETERMINANTS OF ADDICTION.pdf"

# File 309/565: 0.0 B
# Keeping: THESE_Main_Library/DETERMINANTS OF ADDICTION.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Yates_2023_Determinants of addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Yates_2023_Determinants of addiction.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Yates_2023_Determinants of addiction.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Yates_2023_Determinants of addiction.pdf"

# File 310/565: 0.0 B
# Keeping: THESE_Main_Library/The future is written_ Impact of scripts on th.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3364317337/The future is written_ Impact of scripts on th.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3364317337/The future is written_ Impact of scripts on th.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3364317337/The future is written_ Impact of scripts on th.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3364317337/The future is written_ Impact of scripts on th.pdf"

# File 311/565: 0.0 B
# Keeping: THESE_Main_Library/The future is written_ Impact of scripts on th.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3451592334/The future is written_ Impact of scripts on th.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3451592334/The future is written_ Impact of scripts on th.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3451592334/The future is written_ Impact of scripts on th.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3451592334/The future is written_ Impact of scripts on th.pdf"

# File 312/565: 0.0 B
# Keeping: THESE_Main_Library/The future is written_ Impact of scripts on th.pdf
# Reason: Preferred directory: THESE_Main_Library; More descriptive filename
echo "Moving: DRAFTSS_Working/Leonti_2011_The future is written.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Leonti_2011_The future is written.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Leonti_2011_The future is written.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Leonti_2011_The future is written.pdf"

# File 313/565: 0.0 B
# Keeping: THESE_Main_Library/THE-LOST-HISTORY-OF-KHOI-SAN.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3475156585/THE-LOST-HISTORY-OF-KHOI-SAN.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3475156585/THE-LOST-HISTORY-OF-KHOI-SAN.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3475156585/THE-LOST-HISTORY-OF-KHOI-SAN.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3475156585/THE-LOST-HISTORY-OF-KHOI-SAN.pdf"

# File 314/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnopharmacology and biological activities of.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3673708749/Ethnopharmacology and biological activities of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3673708749/Ethnopharmacology and biological activities of.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3673708749/Ethnopharmacology and biological activities of.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3673708749/Ethnopharmacology and biological activities of.pdf"

# File 315/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnopharmacology and biological activities of.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4148979834/Ethnopharmacology and biological activities of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4148979834/Ethnopharmacology and biological activities of.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4148979834/Ethnopharmacology and biological activities of.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4148979834/Ethnopharmacology and biological activities of.pdf"

# File 316/565: 0.0 B
# Keeping: THESE_Main_Library/Ethnopharmacology and biological activities of.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Kalicharan_2023_Ethnopharmacology and biological activities of the Aizoaceae.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kalicharan_2023_Ethnopharmacology and biological activities of the Aizoaceae.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kalicharan_2023_Ethnopharmacology and biological activities of the Aizoaceae.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kalicharan_2023_Ethnopharmacology and biological activities of the Aizoaceae.pdf"

# File 317/565: 0.0 B
# Keeping: THESE_Main_Library/1098 J.C.S. Perkin I1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/3888992697/1098 J.C.S. Perkin I1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/3888992697/1098 J.C.S. Perkin I1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/3888992697/1098 J.C.S. Perkin I1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/3888992697/1098 J.C.S. Perkin I1.pdf"

# File 318/565: 0.0 B
# Keeping: THESE_Main_Library/1098 J.C.S. Perkin I1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4105170100/1098 J.C.S. Perkin I1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4105170100/1098 J.C.S. Perkin I1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4105170100/1098 J.C.S. Perkin I1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4105170100/1098 J.C.S. Perkin I1.pdf"

# File 319/565: 0.0 B
# Keeping: THESE_Main_Library/1098 J.C.S. Perkin I1.pdf
# Reason: Preferred directory: THESE_Main_Library
echo "Moving: DRAFTSS_Working/Capps_1977_Sceletium alkaloids.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Capps_1977_Sceletium alkaloids.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Capps_1977_Sceletium alkaloids.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Capps_1977_Sceletium alkaloids.pdf"

# File 320/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembrine_ The archetypal psycho-active Scele.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4068276964/Mesembrine_ The archetypal psycho-active Scele.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4068276964/Mesembrine_ The archetypal psycho-active Scele.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4068276964/Mesembrine_ The archetypal psycho-active Scele.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4068276964/Mesembrine_ The archetypal psycho-active Scele.pdf"

# File 321/565: 0.0 B
# Keeping: THESE_Main_Library/Mesembrine_ The archetypal psycho-active Scele.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4177226116/Mesembrine_ The archetypal psycho-active Scele.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4177226116/Mesembrine_ The archetypal psycho-active Scele.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4177226116/Mesembrine_ The archetypal psycho-active Scele.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4177226116/Mesembrine_ The archetypal psycho-active Scele.pdf"

# File 322/565: 0.0 B
# Keeping: THESE_Main_Library/64420-1.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/4123289578/64420-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/4123289578/64420-1.pdf")"
mv "$BASE_DIR/THESE_Main_Library/4123289578/64420-1.pdf" "$ARCHIVE_DIR/THESE_Main_Library/4123289578/64420-1.pdf"

# File 323/565: 0.0 B
# Keeping: THESE_Main_Library/0093216941/Sceletium tortuosum_ A review on its phytochem.pdf
# Reason: Higher overall score
echo "Moving: THESE_Main_Library/2018339954/Sceletium tortuosum_ A review on its phytochem.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/THESE_Main_Library/2018339954/Sceletium tortuosum_ A review on its phytochem.pdf")"
mv "$BASE_DIR/THESE_Main_Library/2018339954/Sceletium tortuosum_ A review on its phytochem.pdf" "$ARCHIVE_DIR/THESE_Main_Library/2018339954/Sceletium tortuosum_ A review on its phytochem.pdf"

# File 324/565: 0.0 B
# Keeping: ZOTPDF_References/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Kabbos Kwain The Past Present and Possible.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Kabbos Kwain The Past Present and Possible.pdf")"
mv "$BASE_DIR/Other_Collections/Kabbos Kwain The Past Present and Possible.pdf" "$ARCHIVE_DIR/Other_Collections/Kabbos Kwain The Past Present and Possible.pdf"

# File 325/565: 0.0 B
# Keeping: ZOTPDF_References/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/2018 - Ethnopharmacologic search for psychoactive drugs 50 years of research 1967-2017.pdf"

# File 326/565: 0.0 B
# Keeping: ZOTPDF_References/Akinyede et al. - 2020 - Ethnopharmacology, Therapeutic Properties and Nutritional Potentials of Carpobrotus edulis A Compre.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Akinyede et al. - 2020 - Ethnopharmacology, Therapeutic Properties and Nutritional Potentials of Carpobrotus edulis A Compre.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Akinyede et al. - 2020 - Ethnopharmacology, Therapeutic Properties and Nutritional Potentials of Carpobrotus edulis A Compre.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Akinyede et al. - 2020 - Ethnopharmacology, Therapeutic Properties and Nutritional Potentials of Carpobrotus edulis A Compre.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Akinyede et al. - 2020 - Ethnopharmacology, Therapeutic Properties and Nutritional Potentials of Carpobrotus edulis A Compre.pdf"

# File 327/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2022 - An acute dose-ranging evaluation of the antidepressant properties of Sceletium tortuosum (Zembrin®).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Gericke et al An acute doseranging evaluation of the antidepres.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Gericke et al An acute doseranging evaluation of the antidepres.pdf")"
mv "$BASE_DIR/Other_Collections/Gericke et al An acute doseranging evaluation of the antidepres.pdf" "$ARCHIVE_DIR/Other_Collections/Gericke et al An acute doseranging evaluation of the antidepres.pdf"

# File 328/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2022 - An acute dose-ranging evaluation of the antidepressant properties of Sceletium tortuosum (Zembrin®).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-1.pdf"

# File 329/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2022 - An acute dose-ranging evaluation of the antidepressant properties of Sceletium tortuosum (Zembrin®)-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/An acute dose-ranging evaluation of the antidepresJ EthnopharmacolGerickeEtAl2021-2.pdf"

# File 330/565: 0.0 B
# Keeping: ZOTPDF_References/Youssif et al. - 2019 - A Phytochemical and Biological Review on Plants of The family Aizoaceae.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/A Phytochemical and Biological Review on Plants ofJournal of Advanced Pharmacy RYoussifEtAl2019.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/A Phytochemical and Biological Review on Plants ofJournal of Advanced Pharmacy RYoussifEtAl2019.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/A Phytochemical and Biological Review on Plants ofJournal of Advanced Pharmacy RYoussifEtAl2019.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/A Phytochemical and Biological Review on Plants ofJournal of Advanced Pharmacy RYoussifEtAl2019.pdf"

# File 331/565: 0.0 B
# Keeping: ZOTPDF_References/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse-1.pdf"

# File 332/565: 0.0 B
# Keeping: ZOTPDF_References/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Avchalumov and Mandyam Plasticity in the Hippocampus Neurogenesis and Dr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Avchalumov and Mandyam Plasticity in the Hippocampus Neurogenesis and Dr.pdf")"
mv "$BASE_DIR/Other_Collections/Avchalumov and Mandyam Plasticity in the Hippocampus Neurogenesis and Dr.pdf" "$ARCHIVE_DIR/Other_Collections/Avchalumov and Mandyam Plasticity in the Hippocampus Neurogenesis and Dr.pdf"

# File 333/565: 0.0 B
# Keeping: ZOTPDF_References/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Avchalumov et Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Drugs of Abuse.pdf"

# File 334/565: 0.0 B
# Keeping: ZOTPDF_References/Bank_2004_1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Strengthening indigenous governance benefit s.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Strengthening indigenous governance benefit s.pdf")"
mv "$BASE_DIR/Other_Collections/Strengthening indigenous governance benefit s.pdf" "$ARCHIVE_DIR/Other_Collections/Strengthening indigenous governance benefit s.pdf"

# File 335/565: 0.0 B
# Keeping: ZOTPDF_References/Bank_2004_1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Bank_2004_1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bank_2004_1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bank_2004_1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bank_2004_1.pdf"

# File 336/565: 0.0 B
# Keeping: ZOTPDF_References/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Bolger The PDE cAMPSpecific Phosphodiesterases Targets.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Bolger The PDE cAMPSpecific Phosphodiesterases Targets.pdf")"
mv "$BASE_DIR/Other_Collections/Bolger The PDE cAMPSpecific Phosphodiesterases Targets.pdf" "$ARCHIVE_DIR/Other_Collections/Bolger The PDE cAMPSpecific Phosphodiesterases Targets.pdf"

# File 337/565: 0.0 B
# Keeping: ZOTPDF_References/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bolger - 2017 - The PDE4 cAMP-Specific Phosphodiesterases Targets for Drugs with Antidepressant and Memory-Enhancin.pdf"

# File 338/565: 0.0 B
# Keeping: ZOTPDF_References/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac-1.pdf"

# File 339/565: 0.0 B
# Keeping: ZOTPDF_References/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Bonokwane et al Antidepressant Effects of South African Plants An.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Bonokwane et al Antidepressant Effects of South African Plants An.pdf")"
mv "$BASE_DIR/Other_Collections/Bonokwane et al Antidepressant Effects of South African Plants An.pdf" "$ARCHIVE_DIR/Other_Collections/Bonokwane et al Antidepressant Effects of South African Plants An.pdf"

# File 340/565: 0.0 B
# Keeping: ZOTPDF_References/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Bonokwane et al. - 2022 - Antidepressant Effects of South African Plants An Appraisal of Ethnobotanical Surveys, Ethnopharmac.pdf"

# File 341/565: 0.0 B
# Keeping: ZOTPDF_References/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Brendler et al Sceletium for Managing Anxiety Depression and Cog.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Brendler et al Sceletium for Managing Anxiety Depression and Cog.pdf")"
mv "$BASE_DIR/Other_Collections/Brendler et al Sceletium for Managing Anxiety Depression and Cog.pdf" "$ARCHIVE_DIR/Other_Collections/Brendler et al Sceletium for Managing Anxiety Depression and Cog.pdf"

# File 342/565: 0.0 B
# Keeping: ZOTPDF_References/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cognitive Impairment A Traditional Herbal Medicine i.pdf"

# File 343/565: 0.0 B
# Keeping: ZOTPDF_References/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Capps et al Sceletium alkaloids Part Structure and absolut.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Capps et al Sceletium alkaloids Part Structure and absolut.pdf")"
mv "$BASE_DIR/Other_Collections/Capps et al Sceletium alkaloids Part Structure and absolut.pdf" "$ARCHIVE_DIR/Other_Collections/Capps et al Sceletium alkaloids Part Structure and absolut.pdf"

# File 344/565: 0.0 B
# Keeping: ZOTPDF_References/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Capps et al. - 1977 - 1098 J.C.S. Perkin II Sceletium Alkaloids. Part 7.1 Structure and Absolute Stereochemistry of (-)-Me.pdf"

# File 345/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2018 - Effect of Zembrin ® and four of its alkaloid constituents on electric excitability of the rat hippoc.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Dimpfel et al Effect of Zembrin and four of its alkaloid const.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Effect of Zembrin and four of its alkaloid const.pdf")"
mv "$BASE_DIR/Other_Collections/Dimpfel et al Effect of Zembrin and four of its alkaloid const.pdf" "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Effect of Zembrin and four of its alkaloid const.pdf"

# File 346/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2018 - Effect of Zembrin ® and four of its alkaloid constituents on electric excitability of the rat hippoc.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-1.pdf"

# File 347/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2018 - Effect of Zembrin ® and four of its alkaloid constituents on electric excitability of the rat hippoc-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Effect of Zembrin((R)) and four of its alkaloid coJ EthnopharmacolDimpfelEtAl2018-2.pdf"

# File 348/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Electropharmacogram of Sceletium tortuosum extract based on spectral local field power in conscious-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016-1.pdf"

# File 349/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Electropharmacogram of Sceletium tortuosum extract based on spectral local field power in conscious.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Dimpfel et al Electropharmacogram of Sceletium tortuosum extract.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Electropharmacogram of Sceletium tortuosum extract.pdf")"
mv "$BASE_DIR/Other_Collections/Dimpfel et al Electropharmacogram of Sceletium tortuosum extract.pdf" "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Electropharmacogram of Sceletium tortuosum extract.pdf"

# File 350/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Electropharmacogram of Sceletium tortuosum extract based on spectral local field power in conscious.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Electropharmacogram of Sceletium tortuosum extractJ EthnopharmacolDimpfelEtAl2016.pdf"

# File 351/565: 0.0 B
# Keeping: ZOTPDF_References/El-Raouf - 2021 - Taxonomic significance of leaves in family Aizoaceae.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/El-Raouf - 2021 - Taxonomic significance of leaves in family Aizoaceae.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/El-Raouf - 2021 - Taxonomic significance of leaves in family Aizoaceae.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/El-Raouf - 2021 - Taxonomic significance of leaves in family Aizoaceae.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/El-Raouf - 2021 - Taxonomic significance of leaves in family Aizoaceae.pdf"

# File 352/565: 0.0 B
# Keeping: ZOTPDF_References/Druart et Le Magueresse - 2019 - Emerging Roles of Complement in Psychiatric Disorders.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-1.pdf"

# File 353/565: 0.0 B
# Keeping: ZOTPDF_References/Druart et Le Magueresse - 2019 - Emerging Roles of Complement in Psychiatric Disorders-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Druart and Le Magueresse Emerging Roles of Complement in Psychiatric Disord.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Druart and Le Magueresse Emerging Roles of Complement in Psychiatric Disord.pdf")"
mv "$BASE_DIR/Other_Collections/Druart and Le Magueresse Emerging Roles of Complement in Psychiatric Disord.pdf" "$ARCHIVE_DIR/Other_Collections/Druart and Le Magueresse Emerging Roles of Complement in Psychiatric Disord.pdf"

# File 354/565: 0.0 B
# Keeping: ZOTPDF_References/Druart et Le Magueresse - 2019 - Emerging Roles of Complement in Psychiatric Disorders-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Emerging Roles of Complement in Psychiatric DisordFront PsychiatryDruartEtAl2019-2.pdf"

# File 355/565: 0.0 B
# Keeping: ZOTPDF_References/Hoffman et al. - 2020 - Ergogenic Effects of 8 Days of Sceletium Tortuosum Supplementation on Mood, Visual Tracking, and Rea.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Hoffman et al Ergogenic Effects of Days of Sceletium Tortuosum.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Hoffman et al Ergogenic Effects of Days of Sceletium Tortuosum.pdf")"
mv "$BASE_DIR/Other_Collections/Hoffman et al Ergogenic Effects of Days of Sceletium Tortuosum.pdf" "$ARCHIVE_DIR/Other_Collections/Hoffman et al Ergogenic Effects of Days of Sceletium Tortuosum.pdf"

# File 356/565: 0.0 B
# Keeping: ZOTPDF_References/Hoffman et al. - 2020 - Ergogenic Effects of 8 Days of Sceletium Tortuosum Supplementation on Mood, Visual Tracking, and Rea.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Ergogenic Effects of 8 Days of Sceletium TortuosumJ Strength Cond ResHoffmanEtAl2020-1.pdf"

# File 357/565: 0.0 B
# Keeping: ZOTPDF_References/Chiu et Raheb - 2015 - Exploring Zembrin Extract Derived from South African Plant, Sceletium tortuosum in Targeting cAMP-dr.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Chiu and Raheb Exploring Zembrin Extract Derived from South Afric.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Chiu and Raheb Exploring Zembrin Extract Derived from South Afric.pdf")"
mv "$BASE_DIR/Other_Collections/Chiu and Raheb Exploring Zembrin Extract Derived from South Afric.pdf" "$ARCHIVE_DIR/Other_Collections/Chiu and Raheb Exploring Zembrin Extract Derived from South Afric.pdf"

# File 358/565: 0.0 B
# Keeping: ZOTPDF_References/Chiu et Raheb - 2015 - Exploring Zembrin Extract Derived from South African Plant, Sceletium tortuosum in Targeting cAMP-dr.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Exploring Zembrin Extract Derived from South AfricInternational Journal of MentaChiuEtAl2015-1.pdf"

# File 359/565: 0.0 B
# Keeping: ZOTPDF_References/Güldemann et Fehn - 2014 - Beyond Khoisan historical relations in the Kalahari basin.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Güldemann et Fehn - 2014 - Beyond Khoisan historical relations in the Kalahari basin.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Güldemann et Fehn - 2014 - Beyond Khoisan historical relations in the Kalahari basin.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Güldemann et Fehn - 2014 - Beyond Khoisan historical relations in the Kalahari basin.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Güldemann et Fehn - 2014 - Beyond Khoisan historical relations in the Kalahari basin.pdf"

# File 360/565: 0.0 B
# Keeping: ZOTPDF_References/Güldemann_unknown.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Güldemann_unknown.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Güldemann_unknown.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Güldemann_unknown.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Güldemann_unknown.pdf"

# File 361/565: 0.0 B
# Keeping: ZOTPDF_References/HARTMANN_2000.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/HARTMANN_2000.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/HARTMANN_2000.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/HARTMANN_2000.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/HARTMANN_2000.pdf"

# File 362/565: 0.0 B
# Keeping: ZOTPDF_References/Coetzee et al. - 2016 - High-mesembrine Sceletium extract (Trimesemine™) is a monoamine releasing agent, rather than only a.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Coetzee et al Highmesembrine Sceletium extract Trimesemine.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Coetzee et al Highmesembrine Sceletium extract Trimesemine.pdf")"
mv "$BASE_DIR/Other_Collections/Coetzee et al Highmesembrine Sceletium extract Trimesemine.pdf" "$ARCHIVE_DIR/Other_Collections/Coetzee et al Highmesembrine Sceletium extract Trimesemine.pdf"

# File 363/565: 0.0 B
# Keeping: ZOTPDF_References/Coetzee et al. - 2016 - High-mesembrine Sceletium extract (Trimesemine™) is a monoamine releasing agent, rather than only a.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/High-mesembrine Sceletium extract (Trimesemine) isJ EthnopharmacolCoetzeeEtAl2016-1.pdf"

# File 364/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et Smith - 2018 - Immunomodulatory effects of Sceletium tortuosum (Trimesemine™) elucidated in vitro  Implications fo-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018-1.pdf"

# File 365/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et Smith - 2018 - Immunomodulatory effects of Sceletium tortuosum (Trimesemine™) elucidated in vitro  Implications fo.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Bennett and Smith Immunomodulatory effects of Sceletium tortuosum T.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Bennett and Smith Immunomodulatory effects of Sceletium tortuosum T.pdf")"
mv "$BASE_DIR/Other_Collections/Bennett and Smith Immunomodulatory effects of Sceletium tortuosum T.pdf" "$ARCHIVE_DIR/Other_Collections/Bennett and Smith Immunomodulatory effects of Sceletium tortuosum T.pdf"

# File 366/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et Smith - 2018 - Immunomodulatory effects of Sceletium tortuosum (Trimesemine™) elucidated in vitro  Implications fo.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Immunomodulatory effects of Sceletium tortuosum (TJ EthnopharmacolBennettEtAl2018.pdf"

# File 367/565: 0.0 B
# Keeping: ZOTPDF_References/Johansen et M. Bauer - 2024 - Reconceptualizing the Archaeology of Southern India Beyond Periodization and Toward a Politics of P.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Johansen et M. Bauer - 2024 - Reconceptualizing the Archaeology of Southern India Beyond Periodization and Toward a Politics of P.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Johansen et M. Bauer - 2024 - Reconceptualizing the Archaeology of Southern India Beyond Periodization and Toward a Politics of P.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Johansen et M. Bauer - 2024 - Reconceptualizing the Archaeology of Southern India Beyond Periodization and Toward a Politics of P.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Johansen et M. Bauer - 2024 - Reconceptualizing the Archaeology of Southern India Beyond Periodization and Toward a Politics of P.pdf"

# File 368/565: 0.0 B
# Keeping: ZOTPDF_References/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Kalicharan et al Ethnopharmacology and biological activities of the.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Kalicharan et al Ethnopharmacology and biological activities of the.pdf")"
mv "$BASE_DIR/Other_Collections/Kalicharan et al Ethnopharmacology and biological activities of the.pdf" "$ARCHIVE_DIR/Other_Collections/Kalicharan et al Ethnopharmacology and biological activities of the.pdf"

# File 369/565: 0.0 B
# Keeping: ZOTPDF_References/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kalicharan et al. - 2023 - Ethnopharmacology and biological activities of the Aizoaceae.pdf"

# File 370/565: 0.0 B
# Keeping: ZOTPDF_References/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Kapewangolo et al Sceletium tortuosum demonstrates in vitro antiHIV.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Kapewangolo et al Sceletium tortuosum demonstrates in vitro antiHIV.pdf")"
mv "$BASE_DIR/Other_Collections/Kapewangolo et al Sceletium tortuosum demonstrates in vitro antiHIV.pdf" "$ARCHIVE_DIR/Other_Collections/Kapewangolo et al Sceletium tortuosum demonstrates in vitro antiHIV.pdf"

# File 371/565: 0.0 B
# Keeping: ZOTPDF_References/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kapewangolo et al. - 2016 - Sceletium tortuosum demonstrates in vitro anti-HIV and free radical scavenging activity.pdf"

# File 372/565: 0.0 B
# Keeping: ZOTPDF_References/A_2023.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Royston A et al Kh but Not Other Tested Alkaloids Derived.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Royston A et al Kh but Not Other Tested Alkaloids Derived.pdf")"
mv "$BASE_DIR/Other_Collections/Royston A et al Kh but Not Other Tested Alkaloids Derived.pdf" "$ARCHIVE_DIR/Other_Collections/Royston A et al Kh but Not Other Tested Alkaloids Derived.pdf"

# File 373/565: 0.0 B
# Keeping: ZOTPDF_References/A_2023.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/KH-001 BUT NOT OTHER TESTED ALKALOIDS DERIVED FROM.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/KH-001 BUT NOT OTHER TESTED ALKALOIDS DERIVED FROM.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/KH-001 BUT NOT OTHER TESTED ALKALOIDS DERIVED FROM.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/KH-001 BUT NOT OTHER TESTED ALKALOIDS DERIVED FROM.pdf"

# File 374/565: 0.0 B
# Keeping: ZOTPDF_References/King - 2019 - Outlaws, Anxiety, and Disorder in Southern Africa Material Histories of the Maloti-Drakensberg.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/King - 2019 - Outlaws, Anxiety, and Disorder in Southern Africa Material Histories of the Maloti-Drakensberg.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/King - 2019 - Outlaws, Anxiety, and Disorder in Southern Africa Material Histories of the Maloti-Drakensberg.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/King - 2019 - Outlaws, Anxiety, and Disorder in Southern Africa Material Histories of the Maloti-Drakensberg.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/King - 2019 - Outlaws, Anxiety, and Disorder in Southern Africa Material Histories of the Maloti-Drakensberg.pdf"

# File 375/565: 0.0 B
# Keeping: ZOTPDF_References/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae)-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae)-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae)-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae)-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae)-1.pdf"

# File 376/565: 0.0 B
# Keeping: ZOTPDF_References/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Klak et al Out of southern Africa Origin biogeography and a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Klak et al Out of southern Africa Origin biogeography and a.pdf")"
mv "$BASE_DIR/Other_Collections/Klak et al Out of southern Africa Origin biogeography and a.pdf" "$ARCHIVE_DIR/Other_Collections/Klak et al Out of southern Africa Origin biogeography and a.pdf"

# File 377/565: 0.0 B
# Keeping: ZOTPDF_References/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Klak et al. - 2017 - Out of southern Africa Origin, biogeography and age of the Aizooideae (Aizoaceae).pdf"

# File 378/565: 0.0 B
# Keeping: ZOTPDF_References/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Koob and Volkow Neurobiology of addiction a neurocircuitry analys.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Koob and Volkow Neurobiology of addiction a neurocircuitry analys.pdf")"
mv "$BASE_DIR/Other_Collections/Koob and Volkow Neurobiology of addiction a neurocircuitry analys.pdf" "$ARCHIVE_DIR/Other_Collections/Koob and Volkow Neurobiology of addiction a neurocircuitry analys.pdf"

# File 379/565: 0.0 B
# Keeping: ZOTPDF_References/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Koob et Volkow - 2016 - Neurobiology of addiction a neurocircuitry analysis.pdf"

# File 380/565: 0.0 B
# Keeping: ZOTPDF_References/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf")"
mv "$BASE_DIR/Other_Collections/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf" "$ARCHIVE_DIR/Other_Collections/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf"

# File 381/565: 0.0 B
# Keeping: ZOTPDF_References/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Kotadiya et al In Silico Docking Analysis of Few Antidepressant P.pdf"

# File 382/565: 0.0 B
# Keeping: ZOTPDF_References/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Krstenansky Mesembrine alkaloids Review of their occurrence.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Krstenansky Mesembrine alkaloids Review of their occurrence.pdf")"
mv "$BASE_DIR/Other_Collections/Krstenansky Mesembrine alkaloids Review of their occurrence.pdf" "$ARCHIVE_DIR/Other_Collections/Krstenansky Mesembrine alkaloids Review of their occurrence.pdf"

# File 383/565: 0.0 B
# Keeping: ZOTPDF_References/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Krstenansky - 2017 - Mesembrine alkaloids Review of their occurrence, chemistry, and pharmacology.pdf"

# File 384/565: 0.0 B
# Keeping: ZOTPDF_References/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Leonti The future is written Impact of scripts on the co.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Leonti The future is written Impact of scripts on the co.pdf")"
mv "$BASE_DIR/Other_Collections/Leonti The future is written Impact of scripts on the co.pdf" "$ARCHIVE_DIR/Other_Collections/Leonti The future is written Impact of scripts on the co.pdf"

# File 385/565: 0.0 B
# Keeping: ZOTPDF_References/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Leonti - 2011 - The future is written Impact of scripts on the cognition, selection, knowledge and transmission of.pdf"

# File 386/565: 0.0 B
# Keeping: ZOTPDF_References/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Lewis Addiction and the Brain Development Not Disease.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Lewis Addiction and the Brain Development Not Disease.pdf")"
mv "$BASE_DIR/Other_Collections/Lewis Addiction and the Brain Development Not Disease.pdf" "$ARCHIVE_DIR/Other_Collections/Lewis Addiction and the Brain Development Not Disease.pdf"

# File 387/565: 0.0 B
# Keeping: ZOTPDF_References/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Lewis - 2017 - Addiction and the Brain Development, Not Disease.pdf"

# File 388/565: 0.0 B
# Keeping: ZOTPDF_References/Low - 2007 - Different Histories of Buchu Euro-American Appropriation of San and Khoekhoe Knowledge of Buchu Pla.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Low - 2007 - Different Histories of Buchu Euro-American Appropriation of San and Khoekhoe Knowledge of Buchu Pla.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Different Histories of Buchu Euro-American Appropriation of San and Khoekhoe Knowledge of Buchu Pla.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Low - 2007 - Different Histories of Buchu Euro-American Appropriation of San and Khoekhoe Knowledge of Buchu Pla.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Different Histories of Buchu Euro-American Appropriation of San and Khoekhoe Knowledge of Buchu Pla.pdf"

# File 389/565: 0.0 B
# Keeping: ZOTPDF_References/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Chris Low Wind Life Health Anthropological and Historical.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Chris Low Wind Life Health Anthropological and Historical.pdf")"
mv "$BASE_DIR/Other_Collections/Chris Low Wind Life Health Anthropological and Historical.pdf" "$ARCHIVE_DIR/Other_Collections/Chris Low Wind Life Health Anthropological and Historical.pdf"

# File 390/565: 0.0 B
# Keeping: ZOTPDF_References/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing-1.pdf"

# File 391/565: 0.0 B
# Keeping: ZOTPDF_References/Low - 2007 - Khoisan Wind Hunting and Healing.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Low Khoisan Wind Hunting and Healing.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Low Khoisan Wind Hunting and Healing.pdf")"
mv "$BASE_DIR/Other_Collections/Low Khoisan Wind Hunting and Healing.pdf" "$ARCHIVE_DIR/Other_Collections/Low Khoisan Wind Hunting and Healing.pdf"

# File 392/565: 0.0 B
# Keeping: ZOTPDF_References/Low - 2007 - Khoisan Wind Hunting and Healing.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Low - 2007 - Khoisan Wind Hunting and Healing.pdf"

# File 393/565: 0.0 B
# Keeping: ZOTPDF_References/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Luo et al A network pharmacologybased approach to explore t.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Luo et al A network pharmacologybased approach to explore t.pdf")"
mv "$BASE_DIR/Other_Collections/Luo et al A network pharmacologybased approach to explore t.pdf" "$ARCHIVE_DIR/Other_Collections/Luo et al A network pharmacologybased approach to explore t.pdf"

# File 394/565: 0.0 B
# Keeping: ZOTPDF_References/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Luo et al. - 2022 - A network pharmacology-based approach to explore the therapeutic potential of Sceletium tortuosum in.pdf"

# File 395/565: 0.0 B
# Keeping: ZOTPDF_References/Magill et al. - 1981 - Bryophyta.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Magill et al. - 1981 - Bryophyta.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Magill et al. - 1981 - Bryophyta.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Magill et al. - 1981 - Bryophyta.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Magill et al. - 1981 - Bryophyta.pdf"

# File 396/565: 0.0 B
# Keeping: ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi-1.pdf
# Reason: Higher overall score
echo "Moving: ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf")"
mv "$BASE_DIR/ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf" "$ARCHIVE_DIR/ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf"

# File 397/565: 0.0 B
# Keeping: ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi.pdf"

# File 398/565: 0.0 B
# Keeping: ZOTPDF_References/Mahlatsi et al. - 2021 - A conceptual framework for psychosocial health management grounded in the therapeutic merits of indi-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-1.pdf"

# File 399/565: 0.0 B
# Keeping: ZOTPDF_References/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid-1.pdf"

# File 400/565: 0.0 B
# Keeping: ZOTPDF_References/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Makolo et al Mesembrine The archetypal psychoactive Sceletium.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Makolo et al Mesembrine The archetypal psychoactive Sceletium.pdf")"
mv "$BASE_DIR/Other_Collections/Makolo et al Mesembrine The archetypal psychoactive Sceletium.pdf" "$ARCHIVE_DIR/Other_Collections/Makolo et al Mesembrine The archetypal psychoactive Sceletium.pdf"

# File 401/565: 0.0 B
# Keeping: ZOTPDF_References/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Makolo et al. - 2019 - Mesembrine The archetypal psycho-active Sceletium alkaloid.pdf"

# File 402/565: 0.0 B
# Keeping: ZOTPDF_References/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Manda et al Quantification of mesembrine and mesembrenone in m.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Manda et al Quantification of mesembrine and mesembrenone in m.pdf")"
mv "$BASE_DIR/Other_Collections/Manda et al Quantification of mesembrine and mesembrenone in m.pdf" "$ARCHIVE_DIR/Other_Collections/Manda et al Quantification of mesembrine and mesembrenone in m.pdf"

# File 403/565: 0.0 B
# Keeping: ZOTPDF_References/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manda et al. - 2017 - Quantification of mesembrine and mesembrenone in mouse plasma using UHPLC‐QToF‐MS Application to a.pdf"

# File 404/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Manganyi et al Antibacterial activity of endophytic fungi isolate.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Manganyi et al Antibacterial activity of endophytic fungi isolate.pdf")"
mv "$BASE_DIR/Other_Collections/Manganyi et al Antibacterial activity of endophytic fungi isolate.pdf" "$ARCHIVE_DIR/Other_Collections/Manganyi et al Antibacterial activity of endophytic fungi isolate.pdf"

# File 405/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed)-1.pdf"

# File 406/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed).pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed).pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed).pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed).pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2019 - Antibacterial activity of endophytic fungi isolated from Sceletium tortuosum L. (Kougoed).pdf"

# File 407/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Manganyi et al A Chewable Cure Kanna Biological and Pharmaceut.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Manganyi et al A Chewable Cure Kanna Biological and Pharmaceut.pdf")"
mv "$BASE_DIR/Other_Collections/Manganyi et al A Chewable Cure Kanna Biological and Pharmaceut.pdf" "$ARCHIVE_DIR/Other_Collections/Manganyi et al A Chewable Cure Kanna Biological and Pharmaceut.pdf"

# File 408/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum-1.pdf"

# File 409/565: 0.0 B
# Keeping: ZOTPDF_References/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Manganyi et al. - 2021 - A Chewable Cure “Kanna” Biological and Pharmaceutical Properties of Sceletium tortuosum.pdf"

# File 410/565: 0.0 B
# Keeping: ZOTPDF_References/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Maphanga et al Mesembryanthemum tortuosum L alkaloids modify anx.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Maphanga et al Mesembryanthemum tortuosum L alkaloids modify anx.pdf")"
mv "$BASE_DIR/Other_Collections/Maphanga et al Mesembryanthemum tortuosum L alkaloids modify anx.pdf" "$ARCHIVE_DIR/Other_Collections/Maphanga et al Mesembryanthemum tortuosum L alkaloids modify anx.pdf"

# File 411/565: 0.0 B
# Keeping: ZOTPDF_References/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Maphanga et al. - 2022 - Mesembryanthemum tortuosum L. alkaloids modify anxiety-like behaviour in a zebrafish model.pdf"

# File 412/565: 0.0 B
# Keeping: ZOTPDF_References/Martorell et Ezcurra - 2007 - The narrow-leaf syndrome a functional and evolutionary approach to the form of fog-harvesting roset.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Martorell et Ezcurra - 2007 - The narrow-leaf syndrome a functional and evolutionary approach to the form of fog-harvesting roset.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Martorell et Ezcurra - 2007 - The narrow-leaf syndrome a functional and evolutionary approach to the form of fog-harvesting roset.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Martorell et Ezcurra - 2007 - The narrow-leaf syndrome a functional and evolutionary approach to the form of fog-harvesting roset.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Martorell et Ezcurra - 2007 - The narrow-leaf syndrome a functional and evolutionary approach to the form of fog-harvesting roset.pdf"

# File 413/565: 0.0 B
# Keeping: ZOTPDF_References/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Swart and Smith Modulation of glucocorticoid mineralocorticoid an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Swart and Smith Modulation of glucocorticoid mineralocorticoid an.pdf")"
mv "$BASE_DIR/Other_Collections/Swart and Smith Modulation of glucocorticoid mineralocorticoid an.pdf" "$ARCHIVE_DIR/Other_Collections/Swart and Smith Modulation of glucocorticoid mineralocorticoid an.pdf"

# File 414/565: 0.0 B
# Keeping: ZOTPDF_References/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection-1.pdf"

# File 415/565: 0.0 B
# Keeping: ZOTPDF_References/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Meyer et al GCMS LCMSn LChigh resolutionMSn and NMR stu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Meyer et al GCMS LCMSn LChigh resolutionMSn and NMR stu.pdf")"
mv "$BASE_DIR/Other_Collections/Meyer et al GCMS LCMSn LChigh resolutionMSn and NMR stu.pdf" "$ARCHIVE_DIR/Other_Collections/Meyer et al GCMS LCMSn LChigh resolutionMSn and NMR stu.pdf"

# File 416/565: 0.0 B
# Keeping: ZOTPDF_References/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Meyer et al. - 2015 - GC-MS, LC-MSn, LC-high resolution-MSn, and NMR studies on the metabolism and toxicological detection.pdf"

# File 417/565: 0.0 B
# Keeping: ZOTPDF_References/Mitchell_2022_1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Mitchell_2022_1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Mitchell_2022_1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Mitchell_2022_1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Mitchell_2022_1.pdf"

# File 418/565: 0.0 B
# Keeping: ZOTPDF_References/Morris_2009.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Morris_2009.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Morris_2009.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Morris_2009.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Morris_2009.pdf"

# File 419/565: 0.0 B
# Keeping: ZOTPDF_References/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Nell et al A Randomized DoubleBlind ParallelGroup Placeb.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Nell et al A Randomized DoubleBlind ParallelGroup Placeb.pdf")"
mv "$BASE_DIR/Other_Collections/Nell et al A Randomized DoubleBlind ParallelGroup Placeb.pdf" "$ARCHIVE_DIR/Other_Collections/Nell et al A Randomized DoubleBlind ParallelGroup Placeb.pdf"

# File 420/565: 0.0 B
# Keeping: ZOTPDF_References/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos-1.pdf"

# File 421/565: 0.0 B
# Keeping: ZOTPDF_References/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Nell et al. - 2013 - A Randomized, Double-Blind, Parallel-Group, Placebo-Controlled Trial of Extract Sceletium tortuos.pdf"

# File 422/565: 0.0 B
# Keeping: ZOTPDF_References/Hofford et al. - 2019 - Neuroimmune mechanisms of psychostimulant and opioid use disorders.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Hofford et al Neuroimmune mechanisms of psychostimulant and opio.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Hofford et al Neuroimmune mechanisms of psychostimulant and opio.pdf")"
mv "$BASE_DIR/Other_Collections/Hofford et al Neuroimmune mechanisms of psychostimulant and opio.pdf" "$ARCHIVE_DIR/Other_Collections/Hofford et al Neuroimmune mechanisms of psychostimulant and opio.pdf"

# File 423/565: 0.0 B
# Keeping: ZOTPDF_References/Hofford et al. - 2019 - Neuroimmune mechanisms of psychostimulant and opioid use disorders.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Neuroimmune mechanisms of psychostimulant and opioEuropean Journal of NeuroscienHoffordEtAl2019.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Neuroimmune mechanisms of psychostimulant and opioEuropean Journal of NeuroscienHoffordEtAl2019.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Neuroimmune mechanisms of psychostimulant and opioEuropean Journal of NeuroscienHoffordEtAl2019.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Neuroimmune mechanisms of psychostimulant and opioEuropean Journal of NeuroscienHoffordEtAl2019.pdf"

# File 424/565: 0.0 B
# Keeping: ZOTPDF_References/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/ODonnell and Zhang Antidepressant effects of inhibitors of cAMP phosp.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/ODonnell and Zhang Antidepressant effects of inhibitors of cAMP phosp.pdf")"
mv "$BASE_DIR/Other_Collections/ODonnell and Zhang Antidepressant effects of inhibitors of cAMP phosp.pdf" "$ARCHIVE_DIR/Other_Collections/ODonnell and Zhang Antidepressant effects of inhibitors of cAMP phosp.pdf"

# File 425/565: 0.0 B
# Keeping: ZOTPDF_References/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf")"
mv "$BASE_DIR/DRAFTSS_Working/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf" "$ARCHIVE_DIR/DRAFTSS_Working/O'Donnell et Zhang - 2004 - Antidepressant effects of inhibitors of cAMP phosphodiesterase (PDE4).pdf"

# File 426/565: 0.0 B
# Keeping: ZOTPDF_References/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Olatunji et al Corrigendum to Sceletium tortuosum A review on i.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Olatunji et al Corrigendum to Sceletium tortuosum A review on i.pdf")"
mv "$BASE_DIR/Other_Collections/Olatunji et al Corrigendum to Sceletium tortuosum A review on i.pdf" "$ARCHIVE_DIR/Other_Collections/Olatunji et al Corrigendum to Sceletium tortuosum A review on i.pdf"

# File 427/565: 0.0 B
# Keeping: ZOTPDF_References/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Corrigendum to “Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological an.pdf"

# File 428/565: 0.0 B
# Keeping: ZOTPDF_References/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Olatunji et al Sceletium tortuosum A review on its phytochemistr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Olatunji et al Sceletium tortuosum A review on its phytochemistr.pdf")"
mv "$BASE_DIR/Other_Collections/Olatunji et al Sceletium tortuosum A review on its phytochemistr.pdf" "$ARCHIVE_DIR/Other_Collections/Olatunji et al Sceletium tortuosum A review on its phytochemistr.pdf"

# File 429/565: 0.0 B
# Keeping: ZOTPDF_References/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olatunji et al. - 2022 - Sceletium tortuosum A review on its phytochemistry, pharmacokinetics, biological, pre-clinical and.pdf"

# File 430/565: 0.0 B
# Keeping: ZOTPDF_References/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Olsen and Liu Phosphodiesterase inhibitors and drugs of abuse.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Olsen and Liu Phosphodiesterase inhibitors and drugs of abuse.pdf")"
mv "$BASE_DIR/Other_Collections/Olsen and Liu Phosphodiesterase inhibitors and drugs of abuse.pdf" "$ARCHIVE_DIR/Other_Collections/Olsen and Liu Phosphodiesterase inhibitors and drugs of abuse.pdf"

# File 431/565: 0.0 B
# Keeping: ZOTPDF_References/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities-1.pdf"

# File 432/565: 0.0 B
# Keeping: ZOTPDF_References/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Olsen et Liu - 2016 - Phosphodiesterase 4 inhibitors and drugs of abuse current knowledge and therapeutic opportunities.pdf"

# File 433/565: 0.0 B
# Keeping: ZOTPDF_References/One_2023.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/One_2023.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/One_2023.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/One_2023.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/One_2023.pdf"

# File 434/565: 0.0 B
# Keeping: ZOTPDF_References/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Oteng Mintah et al Medicinal Plants for Treatment of Prevalent Diseas.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Oteng Mintah et al Medicinal Plants for Treatment of Prevalent Diseas.pdf")"
mv "$BASE_DIR/Other_Collections/Oteng Mintah et al Medicinal Plants for Treatment of Prevalent Diseas.pdf" "$ARCHIVE_DIR/Other_Collections/Oteng Mintah et al Medicinal Plants for Treatment of Prevalent Diseas.pdf"

# File 435/565: 0.0 B
# Keeping: ZOTPDF_References/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Oteng Mintah et al. - 2019 - Medicinal Plants for Treatment of Prevalent Diseases.pdf"

# File 436/565: 0.0 B
# Keeping: ZOTPDF_References/Mvimi - 2022 - Past Environments and Plant Use in Holocene Southern Africa.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Past Environments and Plant Use in Holocene SoutheMvimi2022.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Past Environments and Plant Use in Holocene SoutheMvimi2022.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Past Environments and Plant Use in Holocene SoutheMvimi2022.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Past Environments and Plant Use in Holocene SoutheMvimi2022.pdf"

# File 437/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona-1.pdf"

# File 438/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Patnala and Kanfer HPLC Analysis of MesembrineType Alkaloids in Scel.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer HPLC Analysis of MesembrineType Alkaloids in Scel.pdf")"
mv "$BASE_DIR/Other_Collections/Patnala and Kanfer HPLC Analysis of MesembrineType Alkaloids in Scel.pdf" "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer HPLC Analysis of MesembrineType Alkaloids in Scel.pdf"

# File 439/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2010 - HPLC Analysis of Mesembrine-Type Alkaloids in Sceletium Plant Material Used as An African Traditiona.pdf"

# File 440/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Patnala and Kanfer Chemotaxonomic studies of mesembrinetype alkaloid.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer Chemotaxonomic studies of mesembrinetype alkaloid.pdf")"
mv "$BASE_DIR/Other_Collections/Patnala and Kanfer Chemotaxonomic studies of mesembrinetype alkaloid.pdf" "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer Chemotaxonomic studies of mesembrinetype alkaloid.pdf"

# File 441/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2013 - Chemotaxonomic studies of mesembrine-type alkaloids in Sceletium plant species.pdf"

# File 442/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Patnala and Kanfer Sceletium Plant Species Alkaloidal Components Ch.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer Sceletium Plant Species Alkaloidal Components Ch.pdf")"
mv "$BASE_DIR/Other_Collections/Patnala and Kanfer Sceletium Plant Species Alkaloidal Components Ch.pdf" "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer Sceletium Plant Species Alkaloidal Components Ch.pdf"

# File 443/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology-1.pdf"

# File 444/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Patnala and Kanfer 2017 Sceletium Plant Species Alkaloidal Components Ch.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer 2017 Sceletium Plant Species Alkaloidal Components Ch.pdf")"
mv "$BASE_DIR/Other_Collections/Patnala and Kanfer 2017 Sceletium Plant Species Alkaloidal Components Ch.pdf" "$ARCHIVE_DIR/Other_Collections/Patnala and Kanfer 2017 Sceletium Plant Species Alkaloidal Components Ch.pdf"

# File 445/565: 0.0 B
# Keeping: ZOTPDF_References/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Patnala et Kanfer - 2017 - Sceletium Plant Species Alkaloidal Components, Chemistry and Ethnopharmacology.pdf"

# File 446/565: 0.0 B
# Keeping: ZOTPDF_References/Diamant et Spina - 2011 - PDE4-inhibitors A novel, targeted therapy for obstructive airways disease.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-1.pdf"

# File 447/565: 0.0 B
# Keeping: ZOTPDF_References/Diamant et Spina - 2011 - PDE4-inhibitors A novel, targeted therapy for obstructive airways disease-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Diamant and Spina PDEinhibitors A novel targeted therapy for obs.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Diamant and Spina PDEinhibitors A novel targeted therapy for obs.pdf")"
mv "$BASE_DIR/Other_Collections/Diamant and Spina PDEinhibitors A novel targeted therapy for obs.pdf" "$ARCHIVE_DIR/Other_Collections/Diamant and Spina PDEinhibitors A novel targeted therapy for obs.pdf"

# File 448/565: 0.0 B
# Keeping: ZOTPDF_References/Diamant et Spina - 2011 - PDE4-inhibitors A novel, targeted therapy for obstructive airways disease-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/PDE4-inhibitors_ A novel, targeted therapy for obsPulmonary Pharmacology & TheraDiamantEtAl2011-2.pdf"

# File 449/565: 0.0 B
# Keeping: ZOTPDF_References/Harvey et al. - 2011 - Pharmacological actions of the South African medicinal and functional food plant Sceletium tortuosum.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Harvey et al Pharmacological actions of the South African medic.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Harvey et al Pharmacological actions of the South African medic.pdf")"
mv "$BASE_DIR/Other_Collections/Harvey et al Pharmacological actions of the South African medic.pdf" "$ARCHIVE_DIR/Other_Collections/Harvey et al Pharmacological actions of the South African medic.pdf"

# File 450/565: 0.0 B
# Keeping: ZOTPDF_References/Harvey et al. - 2011 - Pharmacological actions of the South African medicinal and functional food plant Sceletium tortuosum.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacological actions of the South African medicJ EthnopharmacolHarveyEtAl2011-1.pdf"

# File 451/565: 0.0 B
# Keeping: ZOTPDF_References/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review of Psychiatric and Neurological Adverse Effects.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pharmacology of Herbal Sexual Enhancers_ A Review Pharmaceuticals (Basel)BrunettiEtAl2020-1.pdf"

# File 452/565: 0.0 B
# Keeping: ZOTPDF_References/Bhat et al. - 2020 - Phosphodiesterase-4 enzyme as a therapeutic target in neurological disorders.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-1.pdf"

# File 453/565: 0.0 B
# Keeping: ZOTPDF_References/Bhat et al. - 2020 - Phosphodiesterase-4 enzyme as a therapeutic target in neurological disorders-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Bhat et al Phosphodiesterase enzyme as a therapeutic target.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Bhat et al Phosphodiesterase enzyme as a therapeutic target.pdf")"
mv "$BASE_DIR/Other_Collections/Bhat et al Phosphodiesterase enzyme as a therapeutic target.pdf" "$ARCHIVE_DIR/Other_Collections/Bhat et al Phosphodiesterase enzyme as a therapeutic target.pdf"

# File 454/565: 0.0 B
# Keeping: ZOTPDF_References/Bhat et al. - 2020 - Phosphodiesterase-4 enzyme as a therapeutic target in neurological disorders-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Phosphodiesterase-4 enzyme as a therapeutic targetPharmacological ResearchBhatEtAl2020-2.pdf"

# File 455/565: 0.0 B
# Keeping: ZOTPDF_References/Pickard et al. - 2015 - Alternative Models of Addiction.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Pickard et al Alternative Models of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Pickard et al Alternative Models of Addiction.pdf")"
mv "$BASE_DIR/Other_Collections/Pickard et al Alternative Models of Addiction.pdf" "$ARCHIVE_DIR/Other_Collections/Pickard et al Alternative Models of Addiction.pdf"

# File 456/565: 0.0 B
# Keeping: ZOTPDF_References/Pickard et al. - 2015 - Alternative Models of Addiction.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Pickard et al. - 2015 - Alternative Models of Addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pickard et al. - 2015 - Alternative Models of Addiction.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pickard et al. - 2015 - Alternative Models of Addiction.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pickard et al. - 2015 - Alternative Models of Addiction.pdf"

# File 457/565: 0.0 B
# Keeping: ZOTPDF_References/Pickrell et al. - 2012 - The genetic prehistory of southern Africa.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Pickrell et al. - 2012 - The genetic prehistory of southern Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Pickrell et al. - 2012 - The genetic prehistory of southern Africa.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Pickrell et al. - 2012 - The genetic prehistory of southern Africa.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Pickrell et al. - 2012 - The genetic prehistory of southern Africa.pdf"

# File 458/565: 0.0 B
# Keeping: ZOTPDF_References/Chiu et al. - 2014 - Proof‐of‐Concept Randomized Controlled Study of Cognition Effects of the Proprietary Extract Scel.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Chiu et al ProofofConcept Randomized Controlled Study of Co.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Chiu et al ProofofConcept Randomized Controlled Study of Co.pdf")"
mv "$BASE_DIR/Other_Collections/Chiu et al ProofofConcept Randomized Controlled Study of Co.pdf" "$ARCHIVE_DIR/Other_Collections/Chiu et al ProofofConcept Randomized Controlled Study of Co.pdf"

# File 459/565: 0.0 B
# Keeping: ZOTPDF_References/Chiu et al. - 2014 - Proof‐of‐Concept Randomized Controlled Study of Cognition Effects of the Proprietary Extract Scel.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Proof-of-Concept Randomized Controlled Study of CoEvidence-Based Complementary aChiuEtAl2014.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Proof-of-Concept Randomized Controlled Study of CoEvidence-Based Complementary aChiuEtAl2014.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Proof-of-Concept Randomized Controlled Study of CoEvidence-Based Complementary aChiuEtAl2014.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Proof-of-Concept Randomized Controlled Study of CoEvidence-Based Complementary aChiuEtAl2014.pdf"

# File 460/565: 0.0 B
# Keeping: ZOTPDF_References/Jean-Francois - 2014 - Psychoactive Plants A Neglected Area of Ethnobotanical Research in Southern Africa (Review)-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014-1.pdf"

# File 461/565: 0.0 B
# Keeping: ZOTPDF_References/Jean-Francois - 2014 - Psychoactive Plants A Neglected Area of Ethnobotanical Research in Southern Africa (Review).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/JeanFrancois Psychoactive Plants A Neglected Area of Ethnobota.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/JeanFrancois Psychoactive Plants A Neglected Area of Ethnobota.pdf")"
mv "$BASE_DIR/Other_Collections/JeanFrancois Psychoactive Plants A Neglected Area of Ethnobota.pdf" "$ARCHIVE_DIR/Other_Collections/JeanFrancois Psychoactive Plants A Neglected Area of Ethnobota.pdf"

# File 462/565: 0.0 B
# Keeping: ZOTPDF_References/Jean-Francois - 2014 - Psychoactive Plants A Neglected Area of Ethnobotanical Research in Southern Africa (Review).pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Psychoactive Plants_ A Neglected Area of EthnobotaStudies on Ethno-MedicineJean-Francois2014.pdf"

# File 463/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Psychophysiological Effects of Zembrin&lt;sup&gt;&#174;&lt;sup&gt;Using Quantitative EEG Source Den-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Dimpfel et al Psychophysiological Effects of Zembrinltsupgt.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Psychophysiological Effects of Zembrinltsupgt.pdf")"
mv "$BASE_DIR/Other_Collections/Dimpfel et al Psychophysiological Effects of Zembrinltsupgt.pdf" "$ARCHIVE_DIR/Other_Collections/Dimpfel et al Psychophysiological Effects of Zembrinltsupgt.pdf"

# File 464/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Psychophysiological Effects of Zembrin&lt;sup&gt;&#174;&lt;sup&gt;Using Quantitative EEG Source Den-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016-1.pdf"

# File 465/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Psychophysiological Effects of Zembrin&lt;sup&gt;&#174;&lt;sup&gt;Using Quantitative EEG Source Den.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Dimpfel et al 2016 Psychophysiological Effects of Zembrinltsupgt 3.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Dimpfel et al 2016 Psychophysiological Effects of Zembrinltsupgt 3.pdf")"
mv "$BASE_DIR/Other_Collections/Dimpfel et al 2016 Psychophysiological Effects of Zembrinltsupgt 3.pdf" "$ARCHIVE_DIR/Other_Collections/Dimpfel et al 2016 Psychophysiological Effects of Zembrinltsupgt 3.pdf"

# File 466/565: 0.0 B
# Keeping: ZOTPDF_References/Dimpfel et al. - 2016 - Psychophysiological Effects of Zembrin&lt;sup&gt;&#174;&lt;sup&gt;Using Quantitative EEG Source Den.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Psychophysiological Effects of Zembrin&lt;sup&gt;&Neuroscience and MedicineDimpfelEtAl2016.pdf"

# File 467/565: 0.0 B
# Keeping: ZOTPDF_References/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Reay et al Sceletium tortuosum Zembrin.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Reay et al Sceletium tortuosum Zembrin.pdf")"
mv "$BASE_DIR/Other_Collections/Reay et al Sceletium tortuosum Zembrin.pdf" "$ARCHIVE_DIR/Other_Collections/Reay et al Sceletium tortuosum Zembrin.pdf"

# File 468/565: 0.0 B
# Keeping: ZOTPDF_References/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Reay et al. - 2020 - Sceletium tortuosum (Zembrin® ) ameliorates experimentally induced anxiety in heal.pdf"

# File 469/565: 0.0 B
# Keeping: ZOTPDF_References/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Stafford Skeletons in the closet Using a bibliometric le.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Stafford Skeletons in the closet Using a bibliometric le.pdf")"
mv "$BASE_DIR/Other_Collections/Stafford Skeletons in the closet Using a bibliometric le.pdf" "$ARCHIVE_DIR/Other_Collections/Stafford Skeletons in the closet Using a bibliometric le.pdf"

# File 470/565: 0.0 B
# Keeping: ZOTPDF_References/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Reddy et al. - 2024 - Skeletons in the closet Using a bibliometric lens to visualise phytochemical and pharmacological ac.pdf"

# File 471/565: 0.0 B
# Keeping: ZOTPDF_References/Prasad et al. - 2013 - Role of Traditional and Alternative Medicine in Treatment of Ulcerative Colitis.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Prasad et al Role of Traditional and Alternative Medicine in Tr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Prasad et al Role of Traditional and Alternative Medicine in Tr.pdf")"
mv "$BASE_DIR/Other_Collections/Prasad et al Role of Traditional and Alternative Medicine in Tr.pdf" "$ARCHIVE_DIR/Other_Collections/Prasad et al Role of Traditional and Alternative Medicine in Tr.pdf"

# File 472/565: 0.0 B
# Keeping: ZOTPDF_References/Prasad et al. - 2013 - Role of Traditional and Alternative Medicine in Treatment of Ulcerative Colitis.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-3.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-3.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-3.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Role of Traditional and Alternative Medicine in TrMEDS Chinese MedicinePrasadEtAl2013-3.pdf"

# File 473/565: 0.0 B
# Keeping: ZOTPDF_References/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Rombaut et al PDE inhibition in distinct cell types to reclaim t.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Rombaut et al PDE inhibition in distinct cell types to reclaim t.pdf")"
mv "$BASE_DIR/Other_Collections/Rombaut et al PDE inhibition in distinct cell types to reclaim t.pdf" "$ARCHIVE_DIR/Other_Collections/Rombaut et al PDE inhibition in distinct cell types to reclaim t.pdf"

# File 474/565: 0.0 B
# Keeping: ZOTPDF_References/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Rombaut et al. - 2021 - PDE inhibition in distinct cell types to reclaim the balance of synaptic plasticity.pdf"

# File 475/565: 0.0 B
# Keeping: ZOTPDF_References/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Rothman et al Dopamineserotonin releasers as medications for st.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Rothman et al Dopamineserotonin releasers as medications for st.pdf")"
mv "$BASE_DIR/Other_Collections/Rothman et al Dopamineserotonin releasers as medications for st.pdf" "$ARCHIVE_DIR/Other_Collections/Rothman et al Dopamineserotonin releasers as medications for st.pdf"

# File 476/565: 0.0 B
# Keeping: ZOTPDF_References/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Rothman et al. - 2008 - Dopamineserotonin releasers as medications for stimulant addictions.pdf"

# File 477/565: 0.0 B
# Keeping: ZOTPDF_References/Morris - 2016 - Royal pharmaceuticals Bioprospecting, rights, and traditional authority in South Africa.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Morris Royal pharmaceuticals Bioprospecting rights and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Morris Royal pharmaceuticals Bioprospecting rights and.pdf")"
mv "$BASE_DIR/Other_Collections/Morris Royal pharmaceuticals Bioprospecting rights and.pdf" "$ARCHIVE_DIR/Other_Collections/Morris Royal pharmaceuticals Bioprospecting rights and.pdf"

# File 478/565: 0.0 B
# Keeping: ZOTPDF_References/Morris - 2016 - Royal pharmaceuticals Bioprospecting, rights, and traditional authority in South Africa.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Royal pharmaceuticals_ Bioprospecting, rights, andAmerican EthnologistMorris2016-1.pdf"

# File 479/565: 0.0 B
# Keeping: ZOTPDF_References/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Sarris et al Plantbased Medicines Phytoceuticals in the Trea.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Sarris et al Plantbased Medicines Phytoceuticals in the Trea.pdf")"
mv "$BASE_DIR/Other_Collections/Sarris et al Plantbased Medicines Phytoceuticals in the Trea.pdf" "$ARCHIVE_DIR/Other_Collections/Sarris et al Plantbased Medicines Phytoceuticals in the Trea.pdf"

# File 480/565: 0.0 B
# Keeping: ZOTPDF_References/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sarris et al. - 2021 - Plant-based Medicines (Phytoceuticals) in the Treatment of Psychiatric Disorders A Meta-review of M.pdf"

# File 481/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et Viljoen - 2008 - Sceletium—A review update-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Gericke and Viljoen SceletiumA review update.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Gericke and Viljoen SceletiumA review update.pdf")"
mv "$BASE_DIR/Other_Collections/Gericke and Viljoen SceletiumA review update.pdf" "$ARCHIVE_DIR/Other_Collections/Gericke and Viljoen SceletiumA review update.pdf"

# File 482/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et Viljoen - 2008 - Sceletium—A review update-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008-1.pdf"

# File 483/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et Viljoen - 2008 - Sceletium—A review update.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium—A review updateJournal of EthnopharmacologyGerickeEtAl2008.pdf"

# File 484/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2024 - Sceletium tortuosum-derived mesembrine significantly contributes to the anxiolytic effect of Zembrin.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Gericke et al Sceletium tortuosumderived mesembrine significant.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Gericke et al Sceletium tortuosumderived mesembrine significant.pdf")"
mv "$BASE_DIR/Other_Collections/Gericke et al Sceletium tortuosumderived mesembrine significant.pdf" "$ARCHIVE_DIR/Other_Collections/Gericke et al Sceletium tortuosumderived mesembrine significant.pdf"

# File 485/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2024 - Sceletium tortuosum-derived mesembrine significantly contributes to the anxiolytic effect of Zembrin.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-1.pdf"

# File 486/565: 0.0 B
# Keeping: ZOTPDF_References/Gericke et al. - 2024 - Sceletium tortuosum-derived mesembrine significantly contributes to the anxiolytic effect of Zembrin-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum-derived mesembrine significantJ EthnopharmacolGerickeEtAl2024-2.pdf"

# File 487/565: 0.0 B
# Keeping: ZOTPDF_References/Wen et al. - 2020 - Sceletium Tortuosum Effects on Central Nervous System and Related Disease.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-1.pdf"

# File 488/565: 0.0 B
# Keeping: ZOTPDF_References/Wen et al. - 2020 - Sceletium Tortuosum Effects on Central Nervous System and Related Disease-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Wen et al Sceletium Tortuosum Effects on Central Nervous Sy.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Wen et al Sceletium Tortuosum Effects on Central Nervous Sy.pdf")"
mv "$BASE_DIR/Other_Collections/Wen et al Sceletium Tortuosum Effects on Central Nervous Sy.pdf" "$ARCHIVE_DIR/Other_Collections/Wen et al Sceletium Tortuosum Effects on Central Nervous Sy.pdf"

# File 489/565: 0.0 B
# Keeping: ZOTPDF_References/Wen et al. - 2020 - Sceletium Tortuosum Effects on Central Nervous System and Related Disease-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium Tortuosum_ Effects on Central Nervous SyPLOS ONEWenEtAl2020-2.pdf"

# File 490/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et al. - 2018 - Sceletium tortuosum may delay chronic disease progression via alkaloid-dependent antioxidant or anti.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-1.pdf"

# File 491/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et al. - 2018 - Sceletium tortuosum may delay chronic disease progression via alkaloid-dependent antioxidant or anti-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Bennett et al Sceletium tortuosum may delay chronic disease prog.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Bennett et al Sceletium tortuosum may delay chronic disease prog.pdf")"
mv "$BASE_DIR/Other_Collections/Bennett et al Sceletium tortuosum may delay chronic disease prog.pdf" "$ARCHIVE_DIR/Other_Collections/Bennett et al Sceletium tortuosum may delay chronic disease prog.pdf"

# File 492/565: 0.0 B
# Keeping: ZOTPDF_References/Bennett et al. - 2018 - Sceletium tortuosum may delay chronic disease progression via alkaloid-dependent antioxidant or anti-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sceletium tortuosum may delay chronic disease progJ Physiol BiochemBennettEtAl2018-2.pdf"

# File 493/565: 0.0 B
# Keeping: ZOTPDF_References/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Schifano et al Novel psychoactive substances of interest for psyc.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Schifano et al Novel psychoactive substances of interest for psyc.pdf")"
mv "$BASE_DIR/Other_Collections/Schifano et al Novel psychoactive substances of interest for psyc.pdf" "$ARCHIVE_DIR/Other_Collections/Schifano et al Novel psychoactive substances of interest for psyc.pdf"

# File 494/565: 0.0 B
# Keeping: ZOTPDF_References/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry-1.pdf"

# File 495/565: 0.0 B
# Keeping: ZOTPDF_References/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Schifano et al. - 2015 - Novel psychoactive substances of interest for psychiatry.pdf"

# File 496/565: 0.0 B
# Keeping: ZOTPDF_References/Maphanga et al. - 2020 - Screening selected medicinal plants for potential anxiolytic activity using an in vivo zebrafish mod.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Maphanga et al Screening selected medicinal plants for potential.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Maphanga et al Screening selected medicinal plants for potential.pdf")"
mv "$BASE_DIR/Other_Collections/Maphanga et al Screening selected medicinal plants for potential.pdf" "$ARCHIVE_DIR/Other_Collections/Maphanga et al Screening selected medicinal plants for potential.pdf"

# File 497/565: 0.0 B
# Keeping: ZOTPDF_References/Maphanga et al. - 2020 - Screening selected medicinal plants for potential anxiolytic activity using an in vivo zebrafish mod.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Screening selected medicinal plants for potential PsychopharmacologyMaphangaEtAl2020-2.pdf"

# File 498/565: 0.0 B
# Keeping: ZOTPDF_References/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Shikanga et al In Vitro Permeation of Mesembrine Alkaloids.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Shikanga et al In Vitro Permeation of Mesembrine Alkaloids.pdf")"
mv "$BASE_DIR/Other_Collections/Shikanga et al In Vitro Permeation of Mesembrine Alkaloids.pdf" "$ARCHIVE_DIR/Other_Collections/Shikanga et al In Vitro Permeation of Mesembrine Alkaloids.pdf"

# File 499/565: 0.0 B
# Keeping: ZOTPDF_References/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - In Vitro Permeation of Mesembrine Alkaloids from Sceletium tortuosum across Porcine Bu.pdf"

# File 500/565: 0.0 B
# Keeping: ZOTPDF_References/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations-1.pdf"

# File 501/565: 0.0 B
# Keeping: ZOTPDF_References/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Shikanga et al The chemotypic variation of Sceletium tortuosum al.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Shikanga et al The chemotypic variation of Sceletium tortuosum al.pdf")"
mv "$BASE_DIR/Other_Collections/Shikanga et al The chemotypic variation of Sceletium tortuosum al.pdf" "$ARCHIVE_DIR/Other_Collections/Shikanga et al The chemotypic variation of Sceletium tortuosum al.pdf"

# File 502/565: 0.0 B
# Keeping: ZOTPDF_References/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Shikanga et al. - 2012 - The chemotypic variation of Sceletium tortuosum alkaloids and commercial product formulations.pdf"

# File 503/565: 0.0 B
# Keeping: ZOTPDF_References/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Sibeko et al Traditional perinatal plant knowledge in SubSahar.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Sibeko et al Traditional perinatal plant knowledge in SubSahar.pdf")"
mv "$BASE_DIR/Other_Collections/Sibeko et al Traditional perinatal plant knowledge in SubSahar.pdf" "$ARCHIVE_DIR/Other_Collections/Sibeko et al Traditional perinatal plant knowledge in SubSahar.pdf"

# File 504/565: 0.0 B
# Keeping: ZOTPDF_References/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary-1.pdf"

# File 505/565: 0.0 B
# Keeping: ZOTPDF_References/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sibeko et al. - 2023 - Traditional perinatal plant knowledge in Sub-Saharan Africa Comprehensive compilation and secondary.pdf"

# File 506/565: 0.0 B
# Keeping: ZOTPDF_References/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Smith The effects of Sceletium tortuosum in an in vivo m.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Smith The effects of Sceletium tortuosum in an in vivo m.pdf")"
mv "$BASE_DIR/Other_Collections/Smith The effects of Sceletium tortuosum in an in vivo m.pdf" "$ARCHIVE_DIR/Other_Collections/Smith The effects of Sceletium tortuosum in an in vivo m.pdf"

# File 507/565: 0.0 B
# Keeping: ZOTPDF_References/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Smith - 2011 - The effects of Sceletium tortuosum in an in vivo model of psychological stress.pdf"

# File 508/565: 0.0 B
# Keeping: ZOTPDF_References/Smith_unknown.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/THELOSTHISTORYOFKHOISAN.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/THELOSTHISTORYOFKHOISAN.pdf")"
mv "$BASE_DIR/Other_Collections/THELOSTHISTORYOFKHOISAN.pdf" "$ARCHIVE_DIR/Other_Collections/THELOSTHISTORYOFKHOISAN.pdf"

# File 509/565: 0.0 B
# Keeping: ZOTPDF_References/Smith_unknown.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Smith_unknown.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Smith_unknown.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Smith_unknown.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Smith_unknown.pdf"

# File 510/565: 0.0 B
# Keeping: ZOTPDF_References/De Smet - 1996 - Some ethnopharmacological notes on African hallucinogens.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/De Smet Some ethnopharmacological notes on African halluci.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/De Smet Some ethnopharmacological notes on African halluci.pdf")"
mv "$BASE_DIR/Other_Collections/De Smet Some ethnopharmacological notes on African halluci.pdf" "$ARCHIVE_DIR/Other_Collections/De Smet Some ethnopharmacological notes on African halluci.pdf"

# File 511/565: 0.0 B
# Keeping: ZOTPDF_References/De Smet - 1996 - Some ethnopharmacological notes on African hallucinogens.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Some ethnopharmacological notes on African halluciJournal of EthnopharmacologyDe Smet1996-1.pdf"

# File 512/565: 0.0 B
# Keeping: ZOTPDF_References/Nordling_2018.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/ZembeMkabile SAMANTHA REINDERS FOR NATURE.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/ZembeMkabile SAMANTHA REINDERS FOR NATURE.pdf")"
mv "$BASE_DIR/Other_Collections/ZembeMkabile SAMANTHA REINDERS FOR NATURE.pdf" "$ARCHIVE_DIR/Other_Collections/ZembeMkabile SAMANTHA REINDERS FOR NATURE.pdf"

# File 513/565: 0.0 B
# Keeping: ZOTPDF_References/Nordling_2018.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/SOUTH  AFRICAN  SCIENCE  FACES  ITS  FUTURE.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/SOUTH  AFRICAN  SCIENCE  FACES  ITS  FUTURE.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/SOUTH  AFRICAN  SCIENCE  FACES  ITS  FUTURE.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/SOUTH  AFRICAN  SCIENCE  FACES  ITS  FUTURE.pdf"

# File 514/565: 0.0 B
# Keeping: ZOTPDF_References/Spina - 2008 - PDE4 inhibitors current status-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status-1.pdf"

# File 515/565: 0.0 B
# Keeping: ZOTPDF_References/Spina - 2008 - PDE4 inhibitors current status.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: Other_Collections/Spina PDE inhibitors current status.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Spina PDE inhibitors current status.pdf")"
mv "$BASE_DIR/Other_Collections/Spina PDE inhibitors current status.pdf" "$ARCHIVE_DIR/Other_Collections/Spina PDE inhibitors current status.pdf"

# File 516/565: 0.0 B
# Keeping: ZOTPDF_References/Spina - 2008 - PDE4 inhibitors current status.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Spina - 2008 - PDE4 inhibitors current status.pdf"

# File 517/565: 0.0 B
# Keeping: ZOTPDF_References/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Sreekissoon et al In vitro and ex vivo vegetative propagation and cy.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Sreekissoon et al In vitro and ex vivo vegetative propagation and cy.pdf")"
mv "$BASE_DIR/Other_Collections/Sreekissoon et al In vitro and ex vivo vegetative propagation and cy.pdf" "$ARCHIVE_DIR/Other_Collections/Sreekissoon et al In vitro and ex vivo vegetative propagation and cy.pdf"

# File 518/565: 0.0 B
# Keeping: ZOTPDF_References/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E.-1.pdf"

# File 519/565: 0.0 B
# Keeping: ZOTPDF_References/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E..pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E..pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E..pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E..pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Sreekissoon et al. - 2021 - In vitro and ex vivo vegetative propagation and cytokinin profiles of Sceletium tortuosum (L.) N. E..pdf"

# File 520/565: 0.0 B
# Keeping: ZOTPDF_References/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Stafford et al Review on plants with CNSeffects used in traditio.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Stafford et al Review on plants with CNSeffects used in traditio.pdf")"
mv "$BASE_DIR/Other_Collections/Stafford et al Review on plants with CNSeffects used in traditio.pdf" "$ARCHIVE_DIR/Other_Collections/Stafford et al Review on plants with CNSeffects used in traditio.pdf"

# File 521/565: 0.0 B
# Keeping: ZOTPDF_References/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases-1.pdf"

# File 522/565: 0.0 B
# Keeping: ZOTPDF_References/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Stafford et al. - 2008 - Review on plants with CNS-effects used in traditional South African medicine against mental diseases.pdf"

# File 523/565: 0.0 B
# Keeping: ZOTPDF_References/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma-1.pdf"

# File 524/565: 0.0 B
# Keeping: ZOTPDF_References/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Terburg et al Acute effects of Sceletium tortuosum Zembrin a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Terburg et al Acute effects of Sceletium tortuosum Zembrin a.pdf")"
mv "$BASE_DIR/Other_Collections/Terburg et al Acute effects of Sceletium tortuosum Zembrin a.pdf" "$ARCHIVE_DIR/Other_Collections/Terburg et al Acute effects of Sceletium tortuosum Zembrin a.pdf"

# File 525/565: 0.0 B
# Keeping: ZOTPDF_References/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Terburg et al. - 2013 - Acute Effects of Sceletium tortuosum (Zembrin), a Dual 5-HT Reuptake and PDE4 Inhibitor, in the Huma.pdf"

# File 526/565: 0.0 B
# Keeping: ZOTPDF_References/Schultes - 1970 - The Botanical and Chemical Distribution of Hallucinogens.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Schultes The Botanical and Chemical Distribution of Halluci.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Schultes The Botanical and Chemical Distribution of Halluci.pdf")"
mv "$BASE_DIR/Other_Collections/Schultes The Botanical and Chemical Distribution of Halluci.pdf" "$ARCHIVE_DIR/Other_Collections/Schultes The Botanical and Chemical Distribution of Halluci.pdf"

# File 527/565: 0.0 B
# Keeping: ZOTPDF_References/Schultes - 1970 - The Botanical and Chemical Distribution of Hallucinogens.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The Botanical and Chemical Distribution of HalluciAnnual Review of Plant PhysiolSchultes1970-1.pdf"

# File 528/565: 0.0 B
# Keeping: ZOTPDF_References/Hall - The Changing Past.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/The Changing PastA Companion to Creative WritinHall.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The Changing PastA Companion to Creative WritinHall.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The Changing PastA Companion to Creative WritinHall.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The Changing PastA Companion to Creative WritinHall.pdf"

# File 529/565: 0.0 B
# Keeping: ZOTPDF_References/The ecology and management of biological invasions in Southern Africa.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/The ecology and management of biological invasions in Southern Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The ecology and management of biological invasions in Southern Africa.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The ecology and management of biological invasions in Southern Africa.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The ecology and management of biological invasions in Southern Africa.pdf"

# File 530/565: 0.0 B
# Keeping: ZOTPDF_References/James Faber et al. - 2022 - The Importance of Sceletium tortuosum (L.) N.E. Brown and Its Viability as a Traditional Afri.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/James Faber et al The Importance of Sceletium tortuosum L.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/James Faber et al The Importance of Sceletium tortuosum L.pdf")"
mv "$BASE_DIR/Other_Collections/James Faber et al The Importance of Sceletium tortuosum L.pdf" "$ARCHIVE_DIR/Other_Collections/James Faber et al The Importance of Sceletium tortuosum L.pdf"

# File 531/565: 0.0 B
# Keeping: ZOTPDF_References/James Faber et al. - 2022 - The Importance of Sceletium tortuosum (L.) N.E. Brown and Its Viability as a Traditional Afri.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The Importance of _i_Sceletium tortuosum_i_ (L.) A. El-ShemyEtAl2022-1.pdf"

# File 532/565: 0.0 B
# Keeping: ZOTPDF_References/Wen et al. - 2012 - The Phosphodiesterase‐4 ( PDE 4) Inhibitor Rolipram De.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Wen et al The Phosphodiesterase span stylefontvarian.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Wen et al The Phosphodiesterase span stylefontvarian.pdf")"
mv "$BASE_DIR/Other_Collections/Wen et al The Phosphodiesterase span stylefontvarian.pdf" "$ARCHIVE_DIR/Other_Collections/Wen et al The Phosphodiesterase span stylefontvarian.pdf"

# File 533/565: 0.0 B
# Keeping: ZOTPDF_References/Wen et al. - 2012 - The Phosphodiesterase‐4 ( PDE 4) Inhibitor Rolipram De.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-3.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-3.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-3.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/The phosphodiesterase-4 (PDE4) inhibitor rolipram Alcohol Clin Exp ResWenEtAl2012-3.pdf"

# File 534/565: 0.0 B
# Keeping: ZOTPDF_References/Chen et Viljoen - 2019 - To ferment or not to ferment Sceletium tortuosum – Do our ancestors hold the answer.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Chen and Viljoen To ferment or not to ferment Sceletium tortuosum.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Chen and Viljoen To ferment or not to ferment Sceletium tortuosum.pdf")"
mv "$BASE_DIR/Other_Collections/Chen and Viljoen To ferment or not to ferment Sceletium tortuosum.pdf" "$ARCHIVE_DIR/Other_Collections/Chen and Viljoen To ferment or not to ferment Sceletium tortuosum.pdf"

# File 535/565: 0.0 B
# Keeping: ZOTPDF_References/Chen et Viljoen - 2019 - To ferment or not to ferment Sceletium tortuosum – Do our ancestors hold the answer.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/To ferment or not to ferment Sceletium tortuosum –South African Journal of BotanChenEtAl2019-1.pdf"

# File 536/565: 0.0 B
# Keeping: ZOTPDF_References/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Torregrossa and Taylor Learning to forget manipulating extinction and re.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Torregrossa and Taylor Learning to forget manipulating extinction and re.pdf")"
mv "$BASE_DIR/Other_Collections/Torregrossa and Taylor Learning to forget manipulating extinction and re.pdf" "$ARCHIVE_DIR/Other_Collections/Torregrossa and Taylor Learning to forget manipulating extinction and re.pdf"

# File 537/565: 0.0 B
# Keeping: ZOTPDF_References/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Torregrossa et Taylor - 2013 - Learning to forget manipulating extinction and reconsolidation processes to treat addiction.pdf"

# File 538/565: 0.0 B
# Keeping: ZOTPDF_References/Fajemiroye et al. - 2016 - Treatment of anxiety and depression medicinal plants in retrospect.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Fajemiroye et al Treatment of anxiety and depression medicinal pla.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Fajemiroye et al Treatment of anxiety and depression medicinal pla.pdf")"
mv "$BASE_DIR/Other_Collections/Fajemiroye et al Treatment of anxiety and depression medicinal pla.pdf" "$ARCHIVE_DIR/Other_Collections/Fajemiroye et al Treatment of anxiety and depression medicinal pla.pdf"

# File 539/565: 0.0 B
# Keeping: ZOTPDF_References/Fajemiroye et al. - 2016 - Treatment of anxiety and depression medicinal plants in retrospect.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Treatment of anxiety and depression_ medicinal plaFundamental & Clinical PharmacFajemiroyeEtAl2016-1.pdf"

# File 540/565: 0.0 B
# Keeping: ZOTPDF_References/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Valente et al Correlates of hyperdiversity in southern African i.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Valente et al Correlates of hyperdiversity in southern African i.pdf")"
mv "$BASE_DIR/Other_Collections/Valente et al Correlates of hyperdiversity in southern African i.pdf" "$ARCHIVE_DIR/Other_Collections/Valente et al Correlates of hyperdiversity in southern African i.pdf"

# File 541/565: 0.0 B
# Keeping: ZOTPDF_References/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea-1.pdf"

# File 542/565: 0.0 B
# Keeping: ZOTPDF_References/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Valente et al. - 2014 - Correlates of hyperdiversity in southern African ice plants (Aizoaceae) Diversification in Aizoacea.pdf"

# File 543/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Van Wyk A broad review of commercially important southern.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Van Wyk A broad review of commercially important southern.pdf")"
mv "$BASE_DIR/Other_Collections/Van Wyk A broad review of commercially important southern.pdf" "$ARCHIVE_DIR/Other_Collections/Van Wyk A broad review of commercially important southern.pdf"

# File 544/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A broad review of commercially important southern African medicinal plants.pdf"

# File 545/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Van Wyk A review of KhoiSan and Cape Dutch medical ethnob.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Van Wyk A review of KhoiSan and Cape Dutch medical ethnob.pdf")"
mv "$BASE_DIR/Other_Collections/Van Wyk A review of KhoiSan and Cape Dutch medical ethnob.pdf" "$ARCHIVE_DIR/Other_Collections/Van Wyk A review of KhoiSan and Cape Dutch medical ethnob.pdf"

# File 546/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2008 - A review of Khoi-San and Cape Dutch medical ethnobotany.pdf"

# File 547/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Van Wyk The potential of South African plants in the devel.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Van Wyk The potential of South African plants in the devel.pdf")"
mv "$BASE_DIR/Other_Collections/Van Wyk The potential of South African plants in the devel.pdf" "$ARCHIVE_DIR/Other_Collections/Van Wyk The potential of South African plants in the devel.pdf"

# File 548/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk - 2011 - The potential of South African plants in the development of new medicinal products.pdf"

# File 549/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Van Wyk and Moteetee Ethnobotanical research in subSaharan Africa.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Van Wyk and Moteetee Ethnobotanical research in subSaharan Africa.pdf")"
mv "$BASE_DIR/Other_Collections/Van Wyk and Moteetee Ethnobotanical research in subSaharan Africa.pdf" "$ARCHIVE_DIR/Other_Collections/Van Wyk and Moteetee Ethnobotanical research in subSaharan Africa.pdf"

# File 550/565: 0.0 B
# Keeping: ZOTPDF_References/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Van Wyk et Moteetee - 2019 - Ethnobotanical research in sub-Saharan Africa – documenting and analysing indigenous knowledge about.pdf"

# File 551/565: 0.0 B
# Keeping: ZOTPDF_References/Faber et al. - 2020 - Variabilities in alkaloid concentration of Sceletium tortuosum (L.) N.E. Br in response to different.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Faber et al Variabilities in alkaloid concentration of Sceleti.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Faber et al Variabilities in alkaloid concentration of Sceleti.pdf")"
mv "$BASE_DIR/Other_Collections/Faber et al Variabilities in alkaloid concentration of Sceleti.pdf" "$ARCHIVE_DIR/Other_Collections/Faber et al Variabilities in alkaloid concentration of Sceleti.pdf"

# File 552/565: 0.0 B
# Keeping: ZOTPDF_References/Faber et al. - 2020 - Variabilities in alkaloid concentration of Sceletium tortuosum (L.) N.E. Br in response to different.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-1.pdf"

# File 553/565: 0.0 B
# Keeping: ZOTPDF_References/Faber et al. - 2020 - Variabilities in alkaloid concentration of Sceletium tortuosum (L.) N.E. Br in response to different-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-2.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-2.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Variabilities in alkaloid concentration of SceletiHeliyonFaberEtAl2020-2.pdf"

# File 554/565: 0.0 B
# Keeping: ZOTPDF_References/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation-1.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation-1.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation-1.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation-1.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation-1.pdf"

# File 555/565: 0.0 B
# Keeping: ZOTPDF_References/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Wynberg Biopiracy Crying wolf or a lever for equity and.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Wynberg Biopiracy Crying wolf or a lever for equity and.pdf")"
mv "$BASE_DIR/Other_Collections/Wynberg Biopiracy Crying wolf or a lever for equity and.pdf" "$ARCHIVE_DIR/Other_Collections/Wynberg Biopiracy Crying wolf or a lever for equity and.pdf"

# File 556/565: 0.0 B
# Keeping: ZOTPDF_References/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Wynberg - 2023 - Biopiracy Crying wolf or a lever for equity and conservation.pdf"

# File 557/565: 0.0 B
# Keeping: ZOTPDF_References/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Yates Determinants of addiction neurobiological behavi.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Yates Determinants of addiction neurobiological behavi.pdf")"
mv "$BASE_DIR/Other_Collections/Yates Determinants of addiction neurobiological behavi.pdf" "$ARCHIVE_DIR/Other_Collections/Yates Determinants of addiction neurobiological behavi.pdf"

# File 558/565: 0.0 B
# Keeping: ZOTPDF_References/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf
# Reason: Preferred directory: ZOTPDF_References
echo "Moving: DRAFTSS_Working/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/DRAFTSS_Working/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf")"
mv "$BASE_DIR/DRAFTSS_Working/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf" "$ARCHIVE_DIR/DRAFTSS_Working/Yates - 2023 - Determinants of addiction neurobiological, behavioral, cognitive, and sociocultural factors.pdf"

# File 559/565: 0.0 B
# Keeping: ZOTPDF_References/Digby - 2005 - Self-Medication and the Trade in Medicine within a Multi-Ethnic Context A Case Study of South Afric.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Digby SelfMedication and the Trade in Medicine within a.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Digby SelfMedication and the Trade in Medicine within a.pdf")"
mv "$BASE_DIR/Other_Collections/Digby SelfMedication and the Trade in Medicine within a.pdf" "$ARCHIVE_DIR/Other_Collections/Digby SelfMedication and the Trade in Medicine within a.pdf"

# File 560/565: 0.0 B
# Keeping: ZOTPDF_References/Murbach et al. - 2014 - A toxicological safety assessment of a standardized extract of Sceletium tortuosum (Zembrin®) in rat.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Murbach et al A toxicological safety assessment of a standardize.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Murbach et al A toxicological safety assessment of a standardize.pdf")"
mv "$BASE_DIR/Other_Collections/Murbach et al A toxicological safety assessment of a standardize.pdf" "$ARCHIVE_DIR/Other_Collections/Murbach et al A toxicological safety assessment of a standardize.pdf"

# File 561/565: 0.0 B
# Keeping: ZOTPDF_References/Namba et al. - 2021 - Neuroimmune Mechanisms as Novel Treatment Targets for Substance Use Disorders and Associated Comorbi-1.pdf
# Reason: Preferred directory: ZOTPDF_References; More descriptive filename
echo "Moving: Other_Collections/Namba et al Neuroimmune Mechanisms as Novel Treatment Targets.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Namba et al Neuroimmune Mechanisms as Novel Treatment Targets.pdf")"
mv "$BASE_DIR/Other_Collections/Namba et al Neuroimmune Mechanisms as Novel Treatment Targets.pdf" "$ARCHIVE_DIR/Other_Collections/Namba et al Neuroimmune Mechanisms as Novel Treatment Targets.pdf"

# File 562/565: 0.0 B
# Keeping: Other_Collections/Avchalumov and Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Dr 2.pdf
# Reason: Higher overall score
echo "Moving: Other_Collections/Avchalumov and Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Dr.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Avchalumov and Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Dr.pdf")"
mv "$BASE_DIR/Other_Collections/Avchalumov and Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Dr.pdf" "$ARCHIVE_DIR/Other_Collections/Avchalumov and Mandyam - 2021 - Plasticity in the Hippocampus, Neurogenesis and Dr.pdf"

# File 563/565: 0.0 B
# Keeping: Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2-1.pdf
# Reason: Higher overall score
echo "Moving: Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2.pdf")"
mv "$BASE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2.pdf" "$ARCHIVE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2.pdf"

# File 564/565: 0.0 B
# Keeping: Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog 2-1.pdf
# Reason: Higher overall score
echo "Moving: Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog.pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog.pdf")"
mv "$BASE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog.pdf" "$ARCHIVE_DIR/Other_Collections/Brendler et al. - 2021 - Sceletium for Managing Anxiety, Depression and Cog.pdf"

# File 565/565: 0.0 B
# Keeping: Other_Collections/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review  2-1.pdf
# Reason: Higher overall score
echo "Moving: Other_Collections/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review .pdf"
mkdir -p "$(dirname "$ARCHIVE_DIR/Other_Collections/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review .pdf")"
mv "$BASE_DIR/Other_Collections/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review .pdf" "$ARCHIVE_DIR/Other_Collections/Brunetti et al. - 2020 - Pharmacology of Herbal Sexual Enhancers A Review .pdf"


echo ""
echo "✓ Deduplication complete!"
echo "✓ Moved 565 files to archive"
echo ""
echo "Archive location: $ARCHIVE_DIR"
echo ""
echo "To verify results, check the remaining files in:"
echo "  $BASE_DIR"
echo ""
echo "If everything looks good, you can delete the archive with:"
echo "  rm -rf $ARCHIVE_DIR"
