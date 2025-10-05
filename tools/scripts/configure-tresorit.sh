#!/usr/bin/env bash
# =============================================================================
# Configure Tresorit Cloud Backup
# =============================================================================
# Purpose: Interactive Tresorit rclone configuration
# Usage: ./configure-tresorit.sh
# =============================================================================

set -euo pipefail

echo "========================================="
echo "Tresorit Cloud Backup Configuration"
echo "========================================="
echo ""

echo "This script will configure Tresorit as your encrypted cloud backup."
echo ""
echo "Prerequisites:"
echo "  1. Tresorit account (https://tresorit.com)"
echo "  2. WebDAV access enabled in your Tresorit settings"
echo ""

read -p "Do you have a Tresorit account? (y/n): " HAS_ACCOUNT

if [ "$HAS_ACCOUNT" != "y" ]; then
    echo ""
    echo "Please create a Tresorit account first:"
    echo "  https://tresorit.com/signup"
    echo ""
    echo "Then enable WebDAV access:"
    echo "  1. Log in to Tresorit web"
    echo "  2. Settings → Security → Enable WebDAV"
    echo "  3. Note your WebDAV username and password"
    echo ""
    exit 0
fi

echo ""
echo "Configuring rclone for Tresorit..."
echo ""

# Remove existing config if present
rclone config delete tresorit 2>/dev/null || true

# Interactive configuration
rclone config create tresorit webdav \
    url "https://tresoritapp.com/webdav" \
    vendor "other" \
    user "$(read -p 'Tresorit email: ' email && echo $email)" \
    pass "$(read -sp 'Tresorit WebDAV password: ' pass && echo && echo $pass)" \
    --obscure

echo ""
echo "Testing connection..."
if rclone lsd tresorit: >/dev/null 2>&1; then
    echo "✓ Tresorit connection successful!"

    # Create KANNA folder in Tresorit
    echo ""
    echo "Creating KANNA backup folder..."
    rclone mkdir tresorit:KANNA 2>/dev/null || true

    echo ""
    echo "========================================="
    echo "✓ Tresorit configuration complete!"
    echo "========================================="
    echo ""
    echo "Your backup script will now sync to:"
    echo "  tresorit:KANNA"
    echo ""
    echo "Next backup: Tonight at 2 AM (automatic)"
    echo "Manual backup: ~/LAB/projects/KANNA/tools/scripts/daily-backup.sh"
else
    echo "✗ Connection failed. Please check your credentials."
    echo ""
    echo "Troubleshooting:"
    echo "  1. Verify WebDAV is enabled in Tresorit settings"
    echo "  2. Check your email and password"
    echo "  3. Try https://tresoritapp.com/webdav in a browser"
    exit 1
fi
