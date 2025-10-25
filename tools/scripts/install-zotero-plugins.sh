#!/usr/bin/env bash
# Install Zotero plugins: ZotFile and Zutilo
# - Downloads latest .xpi releases
# - Copies to Zotero profile extensions directory using correct IDs
# - Prints optimal configuration guidance

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
PLUGINS_DIR="$REPO_ROOT/tools/plugins"
ZOTERO_PROFILES_DIR="$HOME/.zotero/zotero"

mkdir -p "$PLUGINS_DIR"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }

download_latest_xpi() {
  local repo="$1" name="$2" out_var="$3"
  local api="https://api.github.com/repos/${repo}/releases/latest"
  log "Fetching latest release for $name ($repo)"
  local url
  url=$(curl -fsSL "$api" | jq -r '.assets[] | select(.name | test("\\.xpi$")) | .browser_download_url' | head -n1)
  if [ -z "$url" ]; then
    warn "Could not find .xpi asset for $repo"
    return 1
  fi
  local fname="$PLUGINS_DIR/${name}.xpi"
  log "Downloading → $fname"
  curl -fsSL "$url" -o "$fname"
  eval "$out_var='$fname'"
}

# 1) Download latest XPI files

need_jq=false
if ! command -v jq >/dev/null 2>&1; then
  warn "jq not found; attempting to parse without jq will fail"
  need_jq=true
fi

ZUTILO_XPI=""; ZOTFILE_XPI=""

if ! $need_jq; then
  download_latest_xpi "wshanks/Zutilo" "zutilo" ZUTILO_XPI || true
  download_latest_xpi "jlegewie/zotfile" "zotfile" ZOTFILE_XPI || true
else
  warn "Install jq to auto-download releases or download .xpi manually:\n  - https://github.com/wshanks/Zutilo/releases\n  - https://github.com/jlegewie/zotfile/releases"
fi

# 2) Locate Zotero profile

if [ ! -d "$ZOTERO_PROFILES_DIR" ]; then
  warn "Zotero profiles directory not found: $ZOTERO_PROFILES_DIR"
  warn "Launch Zotero at least once, then rerun this script."
  exit 0
fi

PROFILE_INI="$ZOTERO_PROFILES_DIR/profiles.ini"
if [ ! -f "$PROFILE_INI" ]; then
  warn "profiles.ini not found at $PROFILE_INI"
  exit 0
fi

# Pick first profile Path= line
PROFILE_PATH=$(grep -E '^Path=' "$PROFILE_INI" | head -n1 | cut -d'=' -f2)
if [ -z "$PROFILE_PATH" ]; then
  warn "No profile path found in $PROFILE_INI"
  exit 0
fi

PROFILE_DIR="$ZOTERO_PROFILES_DIR/$PROFILE_PATH"
EXT_DIR="$PROFILE_DIR/extensions"
mkdir -p "$EXT_DIR"

log "Using Zotero profile: $PROFILE_DIR"
log "Extensions dir: $EXT_DIR"

# 3) Install by copying XPI to extensions/<id>.xpi
#    Known IDs:
#      - Zutilo: zutilo@www.wesailatdawn.com
#      - ZotFile: zotfile@columbia.edu

if [ -f "$ZUTILO_XPI" ]; then
  cp -f "$ZUTILO_XPI" "$EXT_DIR/zutilo@www.wesailatdawn.com.xpi"
  log "Installed Zutilo XPI"
fi

if [ -f "$ZOTFILE_XPI" ]; then
  cp -f "$ZOTFILE_XPI" "$EXT_DIR/zotfile@columbia.edu.xpi"
  log "Installed ZotFile XPI"
fi

log "Done. Restart Zotero to load add-ons."

cat <<EOF

Next steps (optimal settings):

1) Zotero → Preferences → Advanced → Files and Folders
   - Linked Attachment Base Directory: $REPO_ROOT

2) ZotFile Preferences (Tools → Add-ons → ZotFile → Preferences):
   - Location of Files: Custom Location → $REPO_ROOT/literature/pdfs/BIBLIOGRAPHIE
   - Check: "Use Zotero Linked Attachment Base Directory"
   - Renaming Format (suggested): {%y} - {title}

3) Use case:
   - Select legacy stored attachments → right-click → Manage Attachments → Rename Attachments (ZotFile)
   - This converts to linked files under the repo and applies renaming rules

4) Verify with our audit scripts:
   - conda run -n kanna python analysis/python/audit_zotero_metadata.py \\
       --output tools/reports/zotero-metadata-audit.json \\
       --csv tools/reports/zotero-metadata-audit.csv

EOF

