# Literature PDFs

**Note**: Large PDF files (>50 MB) are NOT tracked in Git to comply with GitHub's file size limits and project data management policy.

## Location of Full PDF Collection

### Primary Backups (3-2-1 Strategy)

1. **Working Copy**: `/home/miko/LAB/academic/KANNA/literature/Sceletium_Thesis_PDFs/`
   - Local SSD storage
   - Real-time access for research

2. **Local Backup**: `/run/media/miko/AYA/KANNA-backup/literature/Sceletium_Thesis_PDFs/`
   - External HDD (1.4TB)
   - Daily automated backups at 2 AM
   - Synced via rsync

3. **Cloud Backup**: `tresorit:KANNA/literature/Sceletium_Thesis_PDFs/`
   - AES-256 encrypted
   - Daily automated backups
   - Geographic redundancy

## Why Not in Git?

Following the KANNA project's **Tier 2 classification** (large files → external storage):

- ✅ Avoids GitHub's 100 MB hard limit
- ✅ Prevents copyright issues with public repositories
- ✅ Reduces repository bloat (158K+ lines of binary data)
- ✅ 3-2-1 backup strategy provides adequate protection
- ✅ Faster clone/pull operations for collaborators

## Accessing PDFs

### For Collaborators

PDFs are available in the external backups. Contact the repository owner for access to:
- External HDD backup location
- Encrypted cloud storage credentials

### Running Backups Manually

```bash
# Full backup (all 3 copies)
~/LAB/academic/KANNA/tools/scripts/daily-backup.sh

# Verify backup status
tail -20 ~/LAB/logs/kanna-backup.log
```

### Automated Backup Schedule

Backups run automatically daily at 2 AM via cron:
```cron
0 2 * * * /home/miko/LAB/academic/KANNA/tools/scripts/daily-backup.sh >> ~/LAB/logs/kanna-backup.log 2>&1
```

## PDF Inventory

**Total PDFs**: 200+ research papers
**Size**: ~15 GB uncompressed
**Topics**: *Sceletium tortuosum*, ethnobotany, pharmacology, phytochemistry

See `BIBLIOGRAPHIE/` directory for the complete curated collection.

---

**Last Updated**: October 2025
**Backup Strategy**: 3-2-1 rule (3 copies, 2 media types, 1 offsite)
