# Otto

*A lightweight collaboration protocol for humans and AI coding assistants*

## The Problem

You have a vague idea: "add user authentication"

Your AI assistant implements based on assumptions.

The result doesn't match your intent.

Time wasted. Wrong implementation.

## The Solution

Otto aligns human intent with AI implementation BEFORE coding begins:

1. **Extract**: AI asks questions to understand what you actually want
2. **Capture**: Intent gets written into a structured spec
3. **Implement**: AI uses the spec as a blueprint, not assumptions
4. **Validate**: You verify against your original intent

**The spec is the contract** between "what I want" and "what I'll build."

## When to Use Otto

**Use it when:**
- Unclear scope: "Add authentication" (sessions? JWT? OAuth? email only?)
- Vague request: "Make it faster" (what's slow? target metrics?)
- Multi-step work: Affects 4+ files or takes 1+ hours
- Breaking changes: Modifies existing patterns

**Skip it when:**
- Single file, obvious fix
- You know exactly what you want
- Trivial change (typo, color value, console.log)

**Rule of thumb:** If deciding whether to use Otto takes longer than the task itself, just do the task.

## Quick Start

### Automated Setup (Recommended)

Run this one-liner in your project root:

```bash
curl -sSL https://raw.githubusercontent.com/codechips/otto/main/bootstrap.sh | bash
```

This will:
- Create `aux/` directory structure
- Download core files (otto.md, protocol.md, spec-template.md)
- Create `project.md` template for you to customize
- Show you how to integrate with CLAUDE.md (if detected)

**Then:**
1. Customize `aux/project.md` with your project details
2. (Optional) Add Otto section to CLAUDE.md if using Claude Code
3. Say "Otto" to your AI assistant to start

---

### Manual Setup

If you prefer to set up manually:

```bash
# 1. Create directory structure
mkdir -p aux/specs aux/done

# 2. Download core files
cd aux/
curl -O https://raw.githubusercontent.com/codechips/otto/main/otto.md
curl -O https://raw.githubusercontent.com/codechips/otto/main/protocol.md
curl -O https://raw.githubusercontent.com/codechips/otto/main/spec-template.md
cd ..

# 3. Create project.md from template below
```

**project.md template:**

```markdown
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

## Testing Strategy _(optional)_
[Default testing approach for features. AI will ask per-feature during planning.]

Example:
- **Always test**: Security features, business logic, payment flows
- **Usually test**: User-facing flows, API endpoints, data transformations
- **Rarely test**: UI styling, copy changes, experimental features
- **Preferred tools**: Jest for unit, Playwright for E2E

## Key Constraints
[Technical limitations, patterns, non-negotiables]

## Non-Negotiables
[Things that never get compromised]
```

**Add to CLAUDE.md** (if using Claude Code):

```markdown
<!-- SPEC-PROTOCOL:START -->
# Otto Protocol

**This project uses Otto** - a spec-driven development protocol that aligns human intent with AI implementation before coding.

**When user says "Otto":**
1. Read `aux/otto.md` (entry point with full instructions)
2. Read `aux/project.md` (project context)
3. Follow the workflow defined in those files

**Most tasks don't need Otto** - only use for unclear scope, breaking changes, or multi-step features.

<!-- SPEC-PROTOCOL:END -->
```

## How to Use

Once set up:

1. **Say "Otto"** when you want to plan a feature
2. **AI asks questions** to extract your intent
3. **You say "create a spec"** when ready
4. **AI writes a spec** and waits for your approval
5. **You approve** and AI implements
6. **You validate** and say "mark as done"
7. **Spec moves to `done/`** for historical reference

## File Structure

```
your-project/
├── aux/
│   ├── otto.md          # Entry point (what is Otto)
│   ├── protocol.md         # Full workflow docs
│   ├── spec-template.md    # Format reference
│   ├── project.md          # Your project context
│   ├── specs/              # Active work
│   │   └── 20251012-add-user-auth.md
│   └── done/               # Completed specs
│       └── 20251011-add-search.md
└── [your code files]
```

## Why Keep Completed Specs?

Specs in `done/` are valuable beyond their implementation:

- **Framework migrations**: Code becomes obsolete, but intent remains valid
- **Context recovery**: Remember why features exist months later
- **Onboarding**: New team members understand product decisions without reading code
- **Pattern reference**: "How did we approach X last time?"
- **Product memory**: Specs capture *why*, code captures *how*

**Note on spec drift**: Specs capture intent at planning time, not necessarily final implementation details. Implementation often reveals edge cases or better approaches. This is expected. The value is in documenting the original problem and intent, not in pixel-perfect accuracy.

## Maintaining project.md

The `project.md` file provides context that helps AI ask better questions and make better decisions. Keep it current.

**When to update:**
- Introducing a new architectural pattern (e.g., switching from REST to GraphQL)
- Changing existing patterns (e.g., moving from Context to Zustand for state)
- Adding new technical constraints (e.g., "must support offline mode")
- Discovering a pattern was documented incorrectly

**How often:**
- Review monthly, or when you notice AI asking questions that project.md should answer
- If AI repeatedly makes assumptions that contradict your patterns, project.md is probably stale

**What happens if it's outdated:**
- AI gets bad context and follows old patterns
- Specs reference deprecated approaches
- More time spent correcting AI during implementation

**Practical approach:**
- When you make architectural changes, update project.md immediately
- During monthly reviews, scan Architecture Patterns and remove/update obsolete entries
- Keep it current or remove it - stale patterns are worse than no patterns

## What Otto Is NOT

- **Project management**: Use your PM tool for backlogs/roadmaps
- **Team task tracking**: Use GitHub Issues/Linear/Jira
- **API documentation**: Use JSDoc/OpenAPI/README

## What Otto IS

- A protocol for one human + one AI to align on intent before coding
- A structured way to capture "what to build" so AI builds the right thing
- A record of decisions that survives code changes

## Why Otto is Different

**No lock-in, maximum flexibility:**

- **No complex setup**: Just markdown files in an `aux/` folder - no databases, no servers, no accounts
- **No CLI tools required**: Works with any AI assistant that can read files (Claude Code, Cursor, GitHub Copilot, etc.)
- **No lock-in**: Plain markdown means you can read/edit specs with any text editor, migrate to any system
- **Easy upgrades**: New version? Just download the updated files - no package managers, no breaking changes
- **Extensible**: Integrate with your tools (add `gh cli` commands, custom scripts, project-specific workflows)
- **Adaptable**: Modify the protocol to fit your team - add sections, change formats, adjust the workflow

**Your project, your rules.** Otto is a starting point, not a straitjacket.

## Philosophy

**Otto is a collaboration protocol, not a project management system.**

The core insight: AI coding assistants need structured intent to build the right thing. Specs are the interface document between human intent and AI implementation.

**Design principles:**
- **Lightweight**: Minimal files, no complex tooling
- **Explicit**: Human approval required at key gates
- **Intent-focused**: Capture why and what, not just how
- **Portable**: Specs survive code rewrites, framework migrations, language changes

## Example Spec

```markdown
# 20251012: Add User Authentication

**Status**: In Progress

## Intent

Add email/password login so users can access their saved content. This enables personalized experiences and protects user data.

## Success Criteria

- [ ] Users can register with email and password
- [ ] Users can log in with existing credentials
- [ ] Users can log out
- [ ] Password is hashed before storage
- [ ] Invalid credentials show appropriate error messages
- [ ] Session persists across page navigations

## Context

Use JWT for session management. Need password hashing with bcrypt. Consider rate limiting on login attempts to prevent brute force attacks.
```

## License

MIT

## Contributing

Issues are welcome. This is a living protocol and an experiment - feedback helps it evolve.

## Credits

Created by [@codechips](https://github.com/codechips)
