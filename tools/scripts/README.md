# KANNA Automation Scripts

Utility scripts for automating repetitive tasks in the thesis workflow.

## Available Scripts

### 1. `daily-backup.sh`

**Purpose**: Automated 3-2-1 backup (3 copies, 2 media types, 1 off-site)

**Features**:
- Backs up to external HDD (rsync)
- Syncs to encrypted cloud (rclone)
- Auto-commits uncommitted Git changes
- Logs all operations to `~/LAB/logs/kanna-backup.log`
- Verifies backup completion

**Usage**:
```bash
# Manual run
./tools/scripts/daily-backup.sh

# Schedule with cron (daily at 2 AM)
crontab -e
# Add:
0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh
```

**Requirements**:
- External HDD mounted at `/media/backup/KANNA` (optional)
- `rclone` configured with `tresorit:KANNA` remote (optional)

**Configuration**:
Edit variables at top of script:
```bash
BACKUP_DIR="/media/backup/KANNA"  # External HDD path
CLOUD_REMOTE="tresorit:KANNA"     # Rclone remote name
```

---

### 2. `export-all-figures.R`

**Purpose**: Export all analysis figures to `assets/figures/` for thesis inclusion

**Features**:
- Collects figures from R scripts (BEI, meta-analysis)
- Collects figures from Python outputs (QSAR, ADMET)
- Collects figures from Jupyter notebooks
- Organizes by chapter automatically
- Generates summary report

**Usage**:
```bash
# Run from KANNA root directory
Rscript tools/scripts/export-all-figures.R

# Or make executable and run directly
chmod +x tools/scripts/export-all-figures.R
./tools/scripts/export-all-figures.R
```

**Output**:
```
assets/figures/
├── chapter-01/
├── chapter-02/
├── chapter-03/  # BEI plots, ICF charts
│   ├── bei-by-community.png
│   ├── icf-by-category.png
│   └── taxa-distribution-by-community.png
├── chapter-04/  # QSAR plots, docking images
│   ├── qsar-actual-vs-predicted.png
│   ├── feature-importance-xgb.png
│   └── shap-summary-plot.png
├── chapter-05/  # Forest plots, funnel plots
│   ├── forest-plot-anxiety.png
│   └── funnel-plot.png
├── chapter-06/
├── chapter-07/
└── chapter-08/
```

**Requirements**:
- R packages: `here`, `fs`
- Run analysis scripts first to generate figures

---

## Installation

### 1. Install Dependencies

**For `daily-backup.sh`**:
```bash
# Install rsync (usually pre-installed on Linux)
sudo dnf install rsync  # Fedora
# or
sudo apt install rsync  # Ubuntu/Debian

# Install rclone (for cloud backup)
sudo dnf install rclone  # Fedora
# or
curl https://rclone.org/install.sh | sudo bash

# Configure rclone with Tresorit
rclone config
# Choose: n (new remote)
# Name: tresorit
# Storage: 30 (WebDAV)
# URL: https://webdav.tresorit.com
# Vendor: other
# User: your-email@example.com
# Password: your-tresorit-password
```

**For `export-all-figures.R`**:
```bash
# Install R packages
R
> install.packages(c("here", "fs"))
```

---

### 2. Set Up Cron Job for Daily Backup

```bash
# Edit crontab
crontab -e

# Add this line (runs daily at 2 AM):
0 2 * * * /home/miko/LAB/projects/KANNA/tools/scripts/daily-backup.sh >> /home/miko/LAB/logs/kanna-backup.log 2>&1

# Verify cron job
crontab -l
```

**Test cron job manually**:
```bash
# Run and check output
./tools/scripts/daily-backup.sh

# View log
tail -f ~/LAB/logs/kanna-backup.log
```

---

## Troubleshooting

### `daily-backup.sh`

**Error**: `External HDD not mounted`
- **Solution**: Mount external drive at `/media/backup/KANNA` or edit `BACKUP_DIR` variable

**Error**: `rclone not installed`
- **Solution**: Install rclone (see Installation above)

**Error**: `rclone: command not found in cron`
- **Solution**: Use full path in crontab:
  ```bash
  0 2 * * * /usr/bin/rclone sync ...
  ```

**Permission denied**:
- **Solution**: Make script executable:
  ```bash
  chmod +x tools/scripts/daily-backup.sh
  ```

---

### `export-all-figures.R`

**Error**: `cannot open file 'here'`
- **Solution**: Install R packages:
  ```R
  install.packages(c("here", "fs"))
  ```

**No figures found**:
- **Solution**: Run analysis scripts first:
  ```bash
  Rscript analysis/r-scripts/ethnobotany/calculate-bei.R
  python analysis/python/cheminformatics/qsar-modeling.py
  ```

---

## Future Scripts (To Be Added)

### `sync-zotero-obsidian.sh`
- Sync Zotero library to Obsidian notes
- Update citation database

### `figure-quality-check.py`
- Verify all figures are 300 DPI
- Check file sizes (< 10 MB for PNG)
- Validate aspect ratios

### `weekly-report.sh`
- Generate weekly progress report
- Count words written, papers read, commits made
- Update `PROJECT-STATUS.md`

### `thesis-word-count.sh`
- Count words in all LaTeX chapters
- Track progress towards 120,000-word target
- Generate progress chart

---

## Contributing

To add a new script:

1. Create script in `tools/scripts/`
2. Add shebang: `#!/usr/bin/env bash` or `#!/usr/bin/env Rscript`
3. Make executable: `chmod +x tools/scripts/your-script.sh`
4. Document in this README
5. Test thoroughly before scheduling with cron
6. Commit to Git with descriptive message

---

*Last updated: October 2025*
