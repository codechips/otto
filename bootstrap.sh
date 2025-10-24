#!/bin/bash

# Otto Bootstrap Script
# Downloads Otto files and sets up the directory structure
# Works on macOS and Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check for required commands
for cmd in curl mkdir cat; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${RED}❌ Error: Required command '$cmd' not found${NC}"
        exit 1
    fi
done

OTTO_VERSION="main"
BASE_URL="https://raw.githubusercontent.com/codechips/otto/${OTTO_VERSION}"

echo "🔍 Otto Bootstrap"
echo "===================="
echo ""

# Check if aux/ already exists
if [ -d "aux" ] && [ -f "aux/protocol.md" ]; then
    echo -e "${YELLOW}⚠️  Warning: aux/ directory with Otto files already exists${NC}"
    read -p "Do you want to re-download and overwrite? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted. No changes made."
        exit 0
    fi
fi

# Create directory structure
echo "📁 Creating aux/ directory structure..."
mkdir -p aux/specs aux/done aux/guides

# Download core protocol files to aux/
echo "⬇️  Downloading Otto protocol files..."

if curl -sSL "${BASE_URL}/otto.md" -o aux/otto.md; then
    echo "   ✓ otto.md"
else
    echo -e "${RED}   ✗ Failed to download otto.md${NC}"
    exit 1
fi

if curl -sSL "${BASE_URL}/protocol.md" -o aux/protocol.md; then
    echo "   ✓ protocol.md"
else
    echo -e "${RED}   ✗ Failed to download protocol.md${NC}"
    exit 1
fi

if curl -sSL "${BASE_URL}/spec-template.md" -o aux/spec-template.md; then
    echo "   ✓ spec-template.md"
else
    echo -e "${RED}   ✗ Failed to download spec-template.md${NC}"
    exit 1
fi

if curl -sSL "${BASE_URL}/guides/ai-implementation.md" -o aux/guides/ai-implementation.md; then
    echo "   ✓ guides/ai-implementation.md"
else
    echo -e "${RED}   ✗ Failed to download guides/ai-implementation.md${NC}"
    exit 1
fi

# Check if project.md exists
if [ -f "aux/project.md" ]; then
    echo "   ⚠️  aux/project.md already exists, skipping"
else
    echo ""
    echo "📝 Creating project.md template..."
    cat > aux/project.md << 'EOF'
# Project Reference

## What This Is
[1-2 sentences: What is this project?]

## Technical Stack
- Framework: [e.g., SvelteKit, Next.js, Rails]
- Language: [e.g., TypeScript, Ruby, Go]
- Key tools: [e.g., Tailwind, PostgreSQL]

## Architecture Patterns _(optional)_
[Document high-level patterns and conventions used in this project. AI references these during technical Q&A.]

Example:
- **Authentication**: JWT tokens stored in httpOnly cookies
- **Data fetching**: Server-side in load functions, client-side with SWR
- **Error handling**: Errors bubble to page-level ErrorBoundary
- **State management**: React Context for global state, local state for component-specific
- **Testing**: Unit tests for business logic, Playwright for user flows

## Key Constraints
[Technical limitations, patterns, non-negotiables]

## Non-Negotiables
[Things that never get compromised]
EOF
    echo "   ✓ project.md (template created - please customize)"
    echo ""
    echo -e "${YELLOW}   ⚠️  IMPORTANT: The placeholder template won't provide useful context.${NC}"
    echo -e "${YELLOW}      Say 'Otto, help me set up project.md' to fill it in properly.${NC}"
fi

# Function to append Otto section to AI config file
append_otto_section() {
    local config_file="$1"
    local config_name="$2"

    # Check if Otto section already exists
    if grep -q "SPEC-PROTOCOL:START" "$config_file" 2>/dev/null; then
        echo -e "${YELLOW}   ⚠️  Otto section already exists in $config_name, skipping${NC}"
        return 0
    fi

    echo ""
    echo -e "${GREEN}📌 $config_name detected!${NC}"
    echo ""
    read -p "Would you like to append the Otto Protocol section to $config_name? (Y/n): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "   Skipped. You can manually add the Otto section later."
        return 0
    fi

    # Append Otto section
    cat >> "$config_file" << 'EOF'

<!-- SPEC-PROTOCOL:START -->
# Otto Protocol

**This project uses Otto** - a spec-driven development protocol that aligns human intent with AI implementation before coding.

**When user says "Otto":**
1. Read `aux/protocol.md` (protocol definition - the contract)
2. Read `aux/project.md` (project context)
3. Follow the state machine and workflow defined in protocol.md
4. For implementation guidance, see `aux/guides/ai-implementation.md`

**Most tasks don't need Otto** - only use for unclear scope, breaking changes, or multi-step features.

<!-- SPEC-PROTOCOL:END -->
EOF

    echo -e "${GREEN}   ✓ Otto section added to $config_name${NC}"
}

# Function to install Claude Code slash command
install_claude_slash_command() {
    local project_commands_dir=".claude/commands"
    local otto_command_file="$project_commands_dir/otto.md"

    # Check if .claude/commands already has otto.md
    if [ -f "$otto_command_file" ]; then
        echo -e "${YELLOW}   ⚠️  /otto command already exists in $project_commands_dir, skipping${NC}"
        return 0
    fi

    echo ""
    echo -e "${GREEN}🎯 Claude Code detected!${NC}"
    echo ""
    echo "Would you like to install the /otto slash command for Claude Code?"
    echo "This allows you to use '/otto [feature]' instead of saying 'Otto' in chat."
    echo ""
    read -p "Install /otto slash command? (Y/n): " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Nn]$ ]]; then
        echo "   Skipped. You can say 'Otto' in chat instead."
        return 0
    fi

    # Create .claude/commands directory
    mkdir -p "$project_commands_dir"

    # Download otto.md slash command
    if curl -sSL "${BASE_URL}/.claude/commands/otto.md" -o "$otto_command_file"; then
        echo -e "${GREEN}   ✓ /otto slash command installed${NC}"
        echo "   You can now use: /otto [feature description]"
        return 0
    else
        echo -e "${RED}   ✗ Failed to download slash command${NC}"
        return 1
    fi
}

# Check for AI assistant config files
AI_CONFIG_DETECTED=false
CLAUDE_CODE_DETECTED=false
SLASH_COMMAND_INSTALLED=false

# Check if we're in a Claude Code environment
if command -v claude &> /dev/null || [ -n "$CLAUDE_CODE" ]; then
    CLAUDE_CODE_DETECTED=true
fi

# Offer Claude Code slash command installation first if detected
if [ "$CLAUDE_CODE_DETECTED" = true ]; then
    if install_claude_slash_command; then
        SLASH_COMMAND_INSTALLED=true
    fi
fi

# Only append to CLAUDE.md if slash command was NOT installed
if [ -f "CLAUDE.md" ]; then
    AI_CONFIG_DETECTED=true
    if [ "$SLASH_COMMAND_INSTALLED" = false ]; then
        append_otto_section "CLAUDE.md" "CLAUDE.md"
    else
        echo ""
        echo -e "${GREEN}✓ Slash command installed - skipping CLAUDE.md section (not needed)${NC}"
    fi
fi

if [ -f "AGENTS.md" ]; then
    AI_CONFIG_DETECTED=true
    append_otto_section "AGENTS.md" "AGENTS.md"
fi

echo ""
echo -e "${GREEN}✅ Otto bootstrap complete!${NC}"
echo ""
echo "Next steps:"
if [ "$AI_CONFIG_DETECTED" = true ]; then
    echo -e "${YELLOW}⚠️  IMPORTANT: Set up project.md before using Otto!${NC}"
    echo "   Say: 'Otto, help me set up project.md' - your AI will guide you"
    echo ""
    if [ "$SLASH_COMMAND_INSTALLED" = true ]; then
        echo "Then start using Otto by typing: /otto [feature description]"
        echo "(Or say 'Otto' in chat if you prefer)"
    else
        echo "Then start using Otto for your features by saying 'Otto'"
    fi
else
    echo -e "${YELLOW}⚠️  Manual step required:${NC} Add Otto Protocol section to your AI config file"
    echo "   (CLAUDE.md, AGENTS.md, .cursorrules, etc.)"
    echo "   See README.md for the section to add."
    echo ""
    echo -e "${YELLOW}⚠️  IMPORTANT: Set up project.md before using Otto!${NC}"
    echo "   Say: 'Otto, help me set up project.md' - your AI will guide you"
    echo ""
    if [ "$SLASH_COMMAND_INSTALLED" = true ]; then
        echo "Then start using Otto by typing: /otto [feature description]"
        echo "(Or say 'Otto' in chat if you prefer)"
    else
        echo "Then start using Otto for your features by saying 'Otto'"
    fi
fi
echo ""
echo "Documentation: https://github.com/codechips/otto"
echo ""
