#!/usr/bin/env bash
# =============================================================================
# MinerU LLM Configuration Helper
# =============================================================================
# Purpose: Securely configure LLM-assisted formula recognition
# Supports: Qwen2.5-32B, OpenAI GPT-4, Anthropic Claude
# Security: Uses pass password manager or environment variables
# =============================================================================

set -euo pipefail

CONFIG_FILE="$HOME/.config/mineru/mineru.json"
SECRETS_FILE="$HOME/.config/codex/secrets.env"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  MinerU LLM-Assisted Formula Recognition Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}✗ Config file not found: $CONFIG_FILE${NC}"
    echo -e "${YELLOW}  Run: mkdir -p ~/.config/mineru && cp ~/LAB/projects/KANNA/tools/templates/mineru.json $CONFIG_FILE${NC}"
    exit 1
fi

# Model selection
echo -e "${GREEN}Available LLM Models:${NC}"
echo "1) Qwen2.5-32B Instruct (Recommended for chemistry/math)"
echo "2) OpenAI GPT-4 (Requires API key)"
echo "3) Anthropic Claude 3.5 Sonnet (Requires API key)"
echo "4) Disable LLM assistance (use base models only)"
echo

read -p "Select model [1-4]: " model_choice

case $model_choice in
    1)
        MODEL="qwen2.5-32b-instruct"
        echo -e "\n${GREEN}Selected: Qwen2.5-32B Instruct${NC}"
        echo -e "${YELLOW}⚠️  Requires: Qwen API key (https://dashscope.aliyun.com)${NC}"
        ;;
    2)
        MODEL="gpt-4"
        echo -e "\n${GREEN}Selected: OpenAI GPT-4${NC}"
        echo -e "${YELLOW}⚠️  Requires: OpenAI API key (https://platform.openai.com)${NC}"
        ;;
    3)
        MODEL="claude-3-5-sonnet-20241022"
        echo -e "\n${GREEN}Selected: Claude 3.5 Sonnet${NC}"
        echo -e "${YELLOW}⚠️  Requires: Anthropic API key (https://console.anthropic.com)${NC}"
        ;;
    4)
        echo -e "\n${YELLOW}Disabling LLM assistance...${NC}"
        jq '.["llm-aided-config"].enable = false' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
        echo -e "${GREEN}✓ LLM assistance disabled${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

# API Key management
echo
echo -e "${GREEN}API Key Configuration:${NC}"
echo "1) Enter API key manually (one-time)"
echo "2) Load from pass password manager (mcp/mineru-api-key)"
echo "3) Load from environment variable (\$MINERU_API_KEY)"
echo

read -p "Select method [1-3]: " key_method

case $key_method in
    1)
        read -sp "Enter API key: " API_KEY
        echo
        ;;
    2)
        if ! command -v pass &> /dev/null; then
            echo -e "${RED}✗ 'pass' not installed${NC}"
            exit 1
        fi
        API_KEY=$(pass show mcp/mineru-api-key 2>/dev/null || echo "")
        if [ -z "$API_KEY" ]; then
            echo -e "${RED}✗ API key not found in pass${NC}"
            echo -e "${YELLOW}  Run: pass insert mcp/mineru-api-key${NC}"
            exit 1
        fi
        echo -e "${GREEN}✓ API key loaded from pass${NC}"
        ;;
    3)
        API_KEY="${MINERU_API_KEY:-}"
        if [ -z "$API_KEY" ]; then
            echo -e "${RED}✗ \$MINERU_API_KEY not set${NC}"
            echo -e "${YELLOW}  Run: export MINERU_API_KEY='your-key-here'${NC}"
            exit 1
        fi
        echo -e "${GREEN}✓ API key loaded from environment${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

# Update config file
echo
echo -e "${BLUE}Updating $CONFIG_FILE...${NC}"

jq --arg model "$MODEL" --arg key "$API_KEY" \
   '.["llm-aided-config"].enable = true |
    .["llm-aided-config"].model = $model |
    .["llm-aided-config"].api_key = $key' \
   "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo -e "${GREEN}✓ Configuration updated successfully${NC}"

# Also add to secrets.env for persistence
if [ -f "$SECRETS_FILE" ]; then
    if ! grep -q "MINERU_API_KEY" "$SECRETS_FILE"; then
        echo "export MINERU_API_KEY='$API_KEY'" >> "$SECRETS_FILE"
        echo -e "${GREEN}✓ API key saved to $SECRETS_FILE${NC}"
    fi
fi

# Test configuration
echo
echo -e "${BLUE}Testing configuration...${NC}"
if jq -e '.["llm-aided-config"].enable == true' "$CONFIG_FILE" > /dev/null; then
    CONFIGURED_MODEL=$(jq -r '.["llm-aided-config"].model' "$CONFIG_FILE")
    echo -e "${GREEN}✓ LLM assistance enabled with model: $CONFIGURED_MODEL${NC}"
else
    echo -e "${RED}✗ Configuration test failed${NC}"
    exit 1
fi

echo
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Setup Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Test extraction: mineru -p sample.pdf -o output/"
echo "  2. Check formula quality in output markdown"
echo "  3. Run batch extraction: ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh"
echo
echo -e "${BLUE}Config file: $CONFIG_FILE${NC}"
echo -e "${BLUE}Secrets file: $SECRETS_FILE${NC}"
echo
