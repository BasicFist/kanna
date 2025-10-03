#!/usr/bin/env bash
# =============================================================================
# Kilo API Test Script - Verify Capabilities for MinerU Integration
# =============================================================================
# Purpose: Test Kilo API key and discover available models
# Usage: ./test-kilo-api.sh
# =============================================================================

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Kilo API Test - Model Discovery & Capabilities${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo

# Check for API key
if [ -z "${KILO_API_KEY:-}" ]; then
    echo -e "${YELLOW}Enter your Kilo API key:${NC}"
    read -sp "API Key: " KILO_API_KEY
    echo
    export KILO_API_KEY
fi

echo -e "${GREEN}✓ API key loaded (${#KILO_API_KEY} characters)${NC}"
echo

# Test 1: Simple completion request
echo -e "${BLUE}[Test 1] Testing basic API connectivity...${NC}"

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
    https://kilocode.ai/api/openrouter/chat/completions \
    -H "Authorization: Bearer $KILO_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
        "model": "google/gemini-2.0-flash-exp:free",
        "messages": [
            {
                "role": "user",
                "content": "Reply with just: API_TEST_SUCCESS"
            }
        ],
        "max_tokens": 20
    }' 2>&1)

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -n -1)

if [ "$HTTP_CODE" = "200" ]; then
    echo -e "${GREEN}✓ API connection successful (HTTP $HTTP_CODE)${NC}"
    echo -e "${GREEN}Response:${NC}"
    echo "$BODY" | jq -r '.choices[0].message.content // .error // .' 2>/dev/null || echo "$BODY"
else
    echo -e "${RED}✗ API connection failed (HTTP $HTTP_CODE)${NC}"
    echo "$BODY" | jq . 2>/dev/null || echo "$BODY"
    exit 1
fi

echo

# Test 2: Test with GPT-4 (if available)
echo -e "${BLUE}[Test 2] Testing GPT-4 access (important for MinerU formulas)...${NC}"

GPT4_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
    https://kilocode.ai/api/openrouter/chat/completions \
    -H "Authorization: Bearer $KILO_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
        "model": "openai/gpt-4",
        "messages": [
            {
                "role": "user",
                "content": "Extract the chemical formula from this text: The alkaloid mesembrine (C17H23NO3) has a molecular weight of 289.37 g/mol. Return ONLY the formula."
            }
        ],
        "max_tokens": 50
    }' 2>&1)

GPT4_HTTP=$(echo "$GPT4_RESPONSE" | tail -1)
GPT4_BODY=$(echo "$GPT4_RESPONSE" | head -n -1)

if [ "$GPT4_HTTP" = "200" ]; then
    echo -e "${GREEN}✓ GPT-4 available! This is perfect for MinerU formula extraction.${NC}"
    echo -e "${GREEN}Test extraction:${NC}"
    echo "$GPT4_BODY" | jq -r '.choices[0].message.content // .' 2>/dev/null || echo "$GPT4_BODY"
else
    echo -e "${YELLOW}⚠ GPT-4 not available (HTTP $GPT4_HTTP). Trying Claude 3.5...${NC}"
    echo "$GPT4_BODY" | jq -r '.error.message // .' 2>/dev/null || echo "$GPT4_BODY"
fi

echo

# Test 3: Test with Claude 3.5 Sonnet (alternative)
echo -e "${BLUE}[Test 3] Testing Claude 3.5 Sonnet access...${NC}"

CLAUDE_RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
    https://kilocode.ai/api/openrouter/chat/completions \
    -H "Authorization: Bearer $KILO_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
        "model": "anthropic/claude-3.5-sonnet",
        "messages": [
            {
                "role": "user",
                "content": "Extract the chemical formula: Mesembrenone (C17H23NO2). Return ONLY the formula."
            }
        ],
        "max_tokens": 30
    }' 2>&1)

CLAUDE_HTTP=$(echo "$CLAUDE_RESPONSE" | tail -1)
CLAUDE_BODY=$(echo "$CLAUDE_RESPONSE" | head -n -1)

if [ "$CLAUDE_HTTP" = "200" ]; then
    echo -e "${GREEN}✓ Claude 3.5 Sonnet available!${NC}"
    echo "$CLAUDE_BODY" | jq -r '.choices[0].message.content // .' 2>/dev/null || echo "$CLAUDE_BODY"
else
    echo -e "${YELLOW}⚠ Claude 3.5 not available (HTTP $CLAUDE_HTTP)${NC}"
    echo "$CLAUDE_BODY" | jq -r '.error.message // .' 2>/dev/null || echo "$CLAUDE_BODY"
fi

echo
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Test Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
echo -e "${YELLOW}Models Available for MinerU Integration:${NC}"
if [ "$GPT4_HTTP" = "200" ]; then
    echo -e "  ${GREEN}✓ GPT-4 (RECOMMENDED for chemistry formulas)${NC}"
fi
if [ "$CLAUDE_HTTP" = "200" ]; then
    echo -e "  ${GREEN}✓ Claude 3.5 Sonnet (excellent alternative)${NC}"
fi
echo -e "  ${GREEN}✓ Gemini 2.0 Flash (free, good for general text)${NC}"
echo
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Save API key: pass insert mcp/kilo-api-key"
echo "  2. Configure MinerU: ~/LAB/projects/KANNA/tools/scripts/configure-mineru-kilo.sh"
echo "  3. Extract PDFs: ~/LAB/projects/KANNA/tools/scripts/extract-pdfs-mineru.sh"
echo
