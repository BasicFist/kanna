#!/bin/bash
#
# Backup Script for Sceletium Thesis PDF Collection
# Creates a timestamped backup using rsync
#

set -e  # Exit on error

# Configuration
SOURCE_DIR="/home/miko/Documents/Sceletium_Thesis_PDFs"
BACKUP_BASE_DIR="/home/miko/Documents/Backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="${BACKUP_BASE_DIR}/Sceletium_Thesis_PDFs_backup_${TIMESTAMP}"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "================================================================================================"
echo "  PDF COLLECTION BACKUP SCRIPT"
echo "================================================================================================"
echo ""
echo "Source:      ${SOURCE_DIR}"
echo "Destination: ${BACKUP_DIR}"
echo ""

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}ERROR: Source directory does not exist!${NC}"
    exit 1
fi

# Create backup base directory if it doesn't exist
if [ ! -d "$BACKUP_BASE_DIR" ]; then
    echo -e "${YELLOW}Creating backup base directory: ${BACKUP_BASE_DIR}${NC}"
    mkdir -p "$BACKUP_BASE_DIR"
fi

# Calculate source size
echo -e "${YELLOW}Calculating source size...${NC}"
SOURCE_SIZE=$(du -sh "$SOURCE_DIR" | cut -f1)
echo "Source size: ${SOURCE_SIZE}"
echo ""

# Auto-confirm if NON_INTERACTIVE=1 is set
if [ "${NON_INTERACTIVE}" != "1" ]; then
    echo -e "${YELLOW}Ready to create backup. Press Enter to continue, or Ctrl+C to cancel...${NC}"
    read -r
else
    echo -e "${GREEN}Running in non-interactive mode...${NC}"
fi

# Create backup using rsync
echo -e "${GREEN}Creating backup...${NC}"
echo ""

rsync -av --progress \
    --exclude='analysis_results' \
    --exclude='*.pyc' \
    --exclude='__pycache__' \
    --exclude='.git' \
    "$SOURCE_DIR/" "$BACKUP_DIR/"

# Verify backup
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Backup completed successfully!${NC}"
    echo ""

    # Calculate backup size
    BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
    echo "Backup location: ${BACKUP_DIR}"
    echo "Backup size:     ${BACKUP_SIZE}"
    echo ""

    # Create a backup info file
    cat > "${BACKUP_DIR}/BACKUP_INFO.txt" << EOF
BACKUP INFORMATION
==================
Source Directory: ${SOURCE_DIR}
Backup Directory: ${BACKUP_DIR}
Backup Date: $(date)
Source Size: ${SOURCE_SIZE}
Backup Size: ${BACKUP_SIZE}

This is a complete backup of the Sceletium Thesis PDF collection.
Created before running deduplication and organization scripts.

To restore this backup:
  rsync -av "${BACKUP_DIR}/" "${SOURCE_DIR}/"

EOF

    echo -e "${GREEN}✓ Backup info saved to: ${BACKUP_DIR}/BACKUP_INFO.txt${NC}"
    echo ""
    echo "================================================================================================"
    echo "  BACKUP COMPLETE"
    echo "================================================================================================"
    echo ""
    echo "You can now safely run analysis and deduplication scripts."
    echo "To restore this backup later, run:"
    echo "  rsync -av \"${BACKUP_DIR}/\" \"${SOURCE_DIR}/\""
    echo ""
else
    echo ""
    echo -e "${RED}✗ Backup failed!${NC}"
    exit 1
fi
