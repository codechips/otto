#!/bin/bash

# Otto Bootstrap Script
# Downloads Otto files and sets up the directory structure
# Works on macOS and Linux

set -e

# Check for required commands
for cmd in curl mkdir cat; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "❌ Error: Required command '$cmd' not found"
        exit 1
    fi
done

OTTO_VERSION="main"
BASE_URL="https://raw.githubusercontent.com/codechips/otto/${OTTO_VERSION}"

echo "🔍 Otto Bootstrap"
echo "===================="
echo ""

# Create directory structure
echo "📁 Creating aux/ directory structure..."
mkdir -p aux/specs aux/done

# Download core files
echo "⬇️  Downloading Otto files..."

curl -sSL "${BASE_URL}/otto.md" -o aux/otto.md
echo "   ✓ otto.md"

curl -sSL "${BASE_URL}/protocol.md" -o aux/protocol.md
echo "   ✓ protocol.md"

curl -sSL "${BASE_URL}/spec-template.md" -o aux/spec-template.md
echo "   ✓ spec-template.md"

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
fi

# Check for AI assistant config files
AI_CONFIG_DETECTED=false

if [ -f "CLAUDE.md" ]; then
    AI_CONFIG_DETECTED=true
    echo ""
    echo "📌 CLAUDE.md detected!"
    echo ""
    echo "Add this to your CLAUDE.md to enable Otto:"
    echo ""
    echo "<!-- SPEC-PROTOCOL:START -->"
    echo "# Otto Protocol"
    echo ""
    echo "**This project uses Otto** - a spec-driven development protocol that aligns human intent with AI implementation before coding."
    echo ""
    echo "**When user says \"Otto\":**"
    echo "1. Read \`aux/otto.md\` (entry point with full instructions)"
    echo "2. Read \`aux/project.md\` (project context)"
    echo "3. Follow the workflow defined in those files"
    echo ""
    echo "**Most tasks don't need Otto** - only use for unclear scope, breaking changes, or multi-step features."
    echo ""
    echo "<!-- SPEC-PROTOCOL:END -->"
    echo ""
fi

if [ -f "AGENTS.md" ]; then
    AI_CONFIG_DETECTED=true
    echo ""
    echo "📌 AGENTS.md detected!"
    echo ""
    echo "Add this to your AGENTS.md to enable Otto:"
    echo ""
    echo "<!-- SPEC-PROTOCOL:START -->"
    echo "# Otto Protocol"
    echo ""
    echo "**This project uses Otto** - a spec-driven development protocol that aligns human intent with AI implementation before coding."
    echo ""
    echo "**When user says \"Otto\":**"
    echo "1. Read \`aux/otto.md\` (entry point with full instructions)"
    echo "2. Read \`aux/project.md\` (project context)"
    echo "3. Follow the workflow defined in those files"
    echo ""
    echo "**Most tasks don't need Otto** - only use for unclear scope, breaking changes, or multi-step features."
    echo ""
    echo "<!-- SPEC-PROTOCOL:END -->"
    echo ""
fi

echo ""
echo "✅ Otto bootstrap complete!"
echo ""
echo "Next steps:"
echo "1. Customize aux/project.md with your project details"
if [ "$AI_CONFIG_DETECTED" = true ]; then
    echo "2. Add the Otto Protocol section to your AI config file (see above)"
    echo "3. Say 'Otto' to your AI assistant to start using the protocol"
else
    echo "2. Say 'Otto' to your AI assistant to start using the protocol"
fi
echo ""
echo "Documentation: https://github.com/codechips/otto"
