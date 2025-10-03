#!/usr/bin/env bash
# =============================================================================
# MinerU + Kilo API Integration Configuration
# =============================================================================
# Purpose: Configure MinerU to use Kilo API for LLM-assisted formula extraction
# Kilo API: OpenRouter-compatible endpoint with GPT-4/Claude access
# =============================================================================

set -euo pipefail

CONFIG_FILE="$HOME/.config/mineru/mineru.json"
SECRETS_FILE="$HOME/.config/codex/secrets.env"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  MinerU + Kilo API Integration Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}✗ Config file not found: $CONFIG_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}Available Kilo API Models (for Title Hierarchy):${NC}"
echo "1) anthropic/claude-sonnet-4-5 (🏆 BEST: 77.2% SWE-bench, highest quality)"
echo "2) anthropic/claude-sonnet-4 (Proven: 72.7% SWE-bench, 1M context)"
echo "3) anthropic/claude-3.5-sonnet (Solid baseline)"
echo "4) google/gemini-2.0-flash-exp:free (FREE tier for testing)"
echo "5) Test API connection first"
echo "6) Disable LLM assistance"
echo

read -p "Select option [1-6]: " model_choice

case $model_choice in
    1)
        MODEL="anthropic/claude-sonnet-4-5"
        echo -e "\n${GREEN}Selected: Claude Sonnet 4.5 (BEST Quality)${NC}"
        echo -e "${YELLOW}Purpose: Title hierarchy optimization (H1→H2→H3→H4)${NC}"
        echo -e "${YELLOW}Cost: ~$5 for 500 papers | Quality: 77.2% SWE-bench${NC}"
        ;;
    2)
        MODEL="anthropic/claude-sonnet-4"
        echo -e "\n${GREEN}Selected: Claude Sonnet 4${NC}"
        echo -e "${YELLOW}Purpose: Title hierarchy (proven quality, 1M context)${NC}"
        echo -e "${YELLOW}Cost: ~$5 for 500 papers | Quality: 72.7% SWE-bench${NC}"
        ;;
    3)
        MODEL="anthropic/claude-3.5-sonnet"
        echo -e "\n${GREEN}Selected: Claude 3.5 Sonnet${NC}"
        echo -e "${YELLOW}Purpose: Title hierarchy (solid baseline)${NC}"
        echo -e "${YELLOW}Cost: ~$3-5 for 500 papers${NC}"
        ;;
    4)
        MODEL="google/gemini-2.0-flash-exp:free"
        echo -e "\n${GREEN}Selected: Gemini 2.0 Flash (Free)${NC}"
        echo -e "${YELLOW}Purpose: Testing title hierarchy (zero cost)${NC}"
        echo -e "${YELLOW}Cost: FREE | Good for simple documents${NC}"
        ;;
    5)
        echo -e "\n${BLUE}Running API connection test...${NC}"
        ~/LAB/projects/KANNA/tools/scripts/test-kilo-api.sh
        exit 0
        ;;
    6)
        echo -e "\n${YELLOW}Disabling LLM assistance...${NC}"
        jq '.["llm-aided-config"].enable = false' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
        echo -e "${GREEN}✓ LLM assistance disabled (formulas still work via UnimerNet)${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

# Get API Key
echo
echo -e "${GREEN}Kilo API Key Configuration:${NC}"
echo "1) Enter API key manually"
echo "2) Load from pass password manager (mcp/kilo-api-key)"
echo "3) Load from environment variable (\$KILO_API_KEY)"
echo

read -p "Select method [1-3]: " key_method

case $key_method in
    1)
        read -sp "Enter Kilo API key: " API_KEY
        echo
        ;;
    2)
        if ! command -v pass &> /dev/null; then
            echo -e "${RED}✗ 'pass' not installed${NC}"
            exit 1
        fi
        API_KEY=$(pass show mcp/kilo-api-key 2>/dev/null || echo "")
        if [ -z "$API_KEY" ]; then
            echo -e "${RED}✗ API key not found in pass${NC}"
            echo -e "${YELLOW}  Run: pass insert mcp/kilo-api-key${NC}"
            exit 1
        fi
        echo -e "${GREEN}✓ API key loaded from pass${NC}"
        ;;
    3)
        API_KEY="${KILO_API_KEY:-}"
        if [ -z "$API_KEY" ]; then
            echo -e "${RED}✗ \$KILO_API_KEY not set${NC}"
            echo -e "${YELLOW}  Run: export KILO_API_KEY='your-key-here'${NC}"
            exit 1
        fi
        echo -e "${GREEN}✓ API key loaded from environment${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

# Update config file with Kilo API settings
echo
echo -e "${BLUE}Updating $CONFIG_FILE...${NC}"

jq --arg model "$MODEL" --arg key "$API_KEY" \
   '.["llm-aided-config"].enable = true |
    .["llm-aided-config"].model = $model |
    .["llm-aided-config"].api_key = $key |
    .["llm-aided-config"].base_url = "https://kilocode.ai/api/openrouter"' \
   "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo -e "${GREEN}✓ Configuration updated successfully${NC}"

# Save to secrets.env for persistence
if [ -f "$SECRETS_FILE" ]; then
    if ! grep -q "KILO_API_KEY" "$SECRETS_FILE"; then
        echo "export KILO_API_KEY='$API_KEY'" >> "$SECRETS_FILE"
        echo -e "${GREEN}✓ API key saved to $SECRETS_FILE${NC}"
    fi
fi

# Test configuration
echo
echo -e "${BLUE}Testing configuration...${NC}"
if jq -e '.["llm-aided-config"].enable == true' "$CONFIG_FILE" > /dev/null; then
    CONFIGURED_MODEL=$(jq -r '.["llm-aided-config"].model' "$CONFIG_FILE")
    CONFIGURED_BASE=$(jq -r '.["llm-aided-config"].base_url' "$CONFIG_FILE")
    echo -e "${GREEN}✓ LLM assistance enabled${NC}"
    echo -e "${GREEN}  Model: $CONFIGURED_MODEL${NC}"
    echo -e "${GREEN}  Endpoint: $CONFIGURED_BASE${NC}"
else
    echo -e "${RED}✗ Configuration test failed${NC}"
    exit 1
fi

echo
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
echo -e "${YELLOW}Integration Details:${NC}"
echo "  ✓ Kilo API endpoint configured (OpenRouter-compatible)"
echo "  ✓ Model: $MODEL"
echo "  ✓ Expected accuracy: 85-90% for chemical formulas (GPT-4)"
echo "  ✓ Bilingual support: French & English"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Extract PDFs: ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh"
echo "  2. Validate quality: ~/LAB/projects/KANNA/tools/scripts/validate-extraction-quality.sh"
echo "  3. Import to Obsidian: ~/LAB/projects/KANNA/tools/scripts/mineru-to-obsidian-auto.sh"
echo
echo -e "${BLUE}Config file: $CONFIG_FILE${NC}"
echo -e "${BLUE}Secrets file: $SECRETS_FILE${NC}"
echo
