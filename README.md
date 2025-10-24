# Otto

*A lightweight collaboration protocol for humans and AI coding assistants*

## TL;DR

**What is it?** A markdown-based protocol that helps you and your AI align on *what* to build before writing code, so you don't waste time on wrong implementations.

**Quick start:**
```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/codechips/otto/main/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh && ./bootstrap.sh
```

**Then:** Say "Otto, help me set up project.md" and your AI will guide you through it.

**When to use:** Vague requests ("add auth"), multi-step features (4+ files), breaking changes.

**When to skip:** Obvious fixes, trivial changes, you already know exactly what you want

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

## What Otto IS

- A protocol for one human + one AI to align on intent before coding
- A structured way to capture "what to build" so AI builds the right thing
- A record of decisions that survives code changes

## What Otto Is NOT

- **Project management**: Use your PM tool for backlogs/roadmaps
- **Team task tracking**: Use GitHub Issues/Linear/Jira
- **API documentation**: Use JSDoc/OpenAPI/README

## Why Otto is Different

No lock-in, maximum flexibility:

- **No complex setup**: Just markdown files in an `aux/` folder - no databases, no servers, no accounts
- **No CLI tools required**: Works with any AI assistant that can read files (Claude Code, Cursor, GitHub Copilot, etc.)
- **No lock-in**: Plain markdown means you can read/edit specs with any text editor, migrate to any system
- **Easy upgrades**: New version? Just download the updated files - no package managers, no breaking changes
- **Extensible**: Integrate with your tools (add `gh cli` commands, custom scripts, project-specific workflows)
- **Adaptable**: Modify the protocol to fit your team - add sections, change formats, adjust the workflow

**Your project, your rules.** Otto is a starting point, not a straitjacket.

## Why the name Otto?

It's fun and easy to type. It's also German and Germans a famous for their efficiency and order.

## Philosophy

**Otto is a collaboration protocol, not a project management system.**

The core insight: AI coding assistants need structured intent to build the right thing. Specs are the interface document between human intent and AI implementation.

**Design principles:**
- **Lightweight**: Minimal files, no complex tooling
- **Explicit**: Human approval required at key gates
- **Intent-focused**: Capture why and what, not just how
- **Portable**: Specs survive code rewrites, framework migrations, language changes

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

Run these commands in your project root:

```bash
curl -sSL https://raw.githubusercontent.com/codechips/otto/main/bootstrap.sh -o bootstrap.sh
chmod +x bootstrap.sh
./bootstrap.sh
```

This will:
- Create `aux/` directory structure
- Download core files (otto.md, protocol.md, spec-template.md) to `aux/`
- Create `project.md` template
- Detect CLAUDE.md or AGENTS.md and offer to append Otto section automatically
- For Claude Code users: offers to install `/otto` slash command

**Then:** Say "Otto, help me set up project.md" - your AI will ask questions to fill in your project details.

---

### Manual Setup

If you prefer to set up manually:

```bash
# 1. Create directory structure
mkdir -p aux/specs aux/done aux/guides aux/protocol

# 2. Download modular protocol files
curl -o aux/protocol/core.md https://raw.githubusercontent.com/codechips/otto/main/aux/protocol/core.md
curl -o aux/protocol/specs.md https://raw.githubusercontent.com/codechips/otto/main/aux/protocol/specs.md
curl -o aux/protocol/blockers.md https://raw.githubusercontent.com/codechips/otto/main/aux/protocol/blockers.md
curl -o aux/protocol/index.md https://raw.githubusercontent.com/codechips/otto/main/aux/protocol/index.md

# 3. Download reference files
curl -o aux/otto.md https://raw.githubusercontent.com/codechips/otto/main/aux/otto.md
curl -o aux/spec-template.md https://raw.githubusercontent.com/codechips/otto/main/aux/spec-template.md
curl -o aux/guides/ai-implementation.md https://raw.githubusercontent.com/codechips/otto/main/aux/guides/ai-implementation.md
curl -o aux/protocol.md https://raw.githubusercontent.com/codechips/otto/main/aux/protocol.md

# 4. Create project.md from template below
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

---

## Claude Code Integration

If you use Claude Code, bootstrap offers to install the `/otto` slash command:

```bash
/otto add user authentication
```

This provides:
- **Faster invocation**: Type `/otto` instead of saying "Otto"
- **Argument passing**: Feature description as command argument
- **Same workflow**: Identical behavior to text invocation

**Both methods work identically** - use whichever you prefer.

---

**Add to CLAUDE.md** (if using Claude Code):

> **Note**: The automated bootstrap script will offer to add this automatically if it detects CLAUDE.md or AGENTS.md.

```markdown
<!-- SPEC-PROTOCOL:START -->
# Otto Protocol

**This project uses Otto** - a spec-driven development protocol that aligns human intent with AI implementation before coding.

**When user says "Otto":**
1. Read `aux/protocol/core.md` (state machine and workflow)
2. Read `aux/project.md` (project context)
3. Follow the state machine defined in core.md
4. Load additional modules on-demand:
   - Creating specs? Read `aux/protocol/specs.md`
   - Hit blocker? Read `aux/protocol/blockers.md`
5. For AI-specific guidance, see `aux/guides/ai-implementation.md`

**Most tasks don't need Otto** - only use for unclear scope, breaking changes, or multi-step features.

<!-- SPEC-PROTOCOL:END -->
```

## How to Use

Once set up:

1. **Say "Otto"** (or use `/otto` in Claude Code) when you want to plan a feature
2. **AI asks questions** to extract your intent
3. **You say "create a spec"** when ready
4. **AI writes a spec** and waits for your approval
5. **You approve** and AI implements
6. **You validate** and say "mark as done"
7. **Spec moves to `done/`** for historical reference

## Uninstalling Otto

To completely remove Otto from your project:

```bash
./bootstrap.sh --remove
```

This will:
- Delete `aux/` directory (all specs and protocol files)
- Remove `/otto` slash command if installed
- Remove Otto sections from CLAUDE.md and AGENTS.md

**⚠️ Warning**: This permanently deletes all specs including completed ones in `aux/done/`. Back up any specs you want to keep before running this command.

For help: `./bootstrap.sh --help`

## Git Integration

**Branching strategy is a team convention, not a protocol requirement.** Otto doesn't prescribe how you organize branches, commits, or merges.

That said, most teams implement each spec in its own feature branch. This allows you to:
- Work on multiple specs in parallel
- Review and merge work independently
- Keep spec lifecycle aligned with branch lifecycle

Follow your team's existing branching strategy (trunk-based, gitflow, etc.). Otto works with any approach.

## File Structure

```
your-project/
├── aux/
│   ├── protocol/            # Modular protocol (v2.0)
│   │   ├── core.md          # State machine (~680 tokens)
│   │   ├── specs.md         # Spec format (~364 tokens)
│   │   ├── blockers.md      # Blocker handling (~399 tokens)
│   │   └── index.md         # Module overview
│   ├── otto.md              # Entry point (what is Otto)
│   ├── protocol.md          # Single file version
│   ├── project.md           # Your project context
│   ├── spec-template.md     # Spec format reference
│   ├── guides/              # Implementation guidance (optional)
│   │   └── ai-implementation.md
│   ├── specs/               # Active work
│   │   └── 20251012-add-user-auth.md
│   └── done/                # Completed specs
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

**Setting up initially:** Say "Otto, help me set up project.md" - AI will guide you through the template with questions.

**Updating later:** Say "Otto, help me update project.md" when patterns change - AI will ask about what's changed.

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
- When you make architectural changes, update project.md immediately (or tell your AI assistant to update it)
- During monthly reviews, scan Architecture Patterns and remove/update obsolete entries
- Keep it current or remove it - stale patterns are worse than no patterns

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
