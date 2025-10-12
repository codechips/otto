# Otto Protocol

*Align on intent before coding*

---

## What This Is

Otto prevents AI from implementing based on assumptions.

**Without Otto:**
- You: "add user authentication"
- AI: implements based on guesses
- Result: doesn't match your intent

**With Otto:**
- You: "Otto: add user authentication"
- AI: asks questions to extract your intent
- AI: writes spec capturing what you want
- You: approve spec
- AI: implements from spec, not assumptions

**The spec is your contract.** Intent captured in writing, survives code changes.

---

## When to Use

**Use Otto when:**
- Scope unclear: "add search" (client? server? static?)
- Request vague: "make it faster" (what's slow? target?)
- Multi-step work: 4+ files or breaking changes

**Skip Otto when:**
- Single file, obvious fix
- You know exactly what you want
- Task is trivial (typo, console.log)

**Rule:** If deciding takes longer than doing, just do it.

---

## Setup

### Install

```bash
cd your-project
curl -sSL https://raw.githubusercontent.com/codechips/otto/main/bootstrap.sh | bash
```

This creates `aux/` with Otto files and offers to configure your CLAUDE.md or AGENTS.md.

### Configure

Say: **"Otto, help me set up project.md"** (or "Otto help me setup project")

Your AI will ask questions to fill in:
- What your project is
- Technical stack and patterns
- Architectural constraints

This gives AI context for better questions during planning.

---

## Maintenance

**Update project.md when:**
- Architecture patterns change (REST → GraphQL)
- New constraints added ("must support offline")
- AI repeatedly makes wrong assumptions

**How:** Say **"Otto, help me update project.md"** (or "Otto update project")

Stale patterns are worse than no patterns. Keep current or remove.

---

## How It Works

1. Say **"Otto"** to enter Planning Mode
2. AI asks questions, you answer
3. Say **"create spec"** when ready
4. AI writes spec to `aux/specs/YYYYMMDD-feature-name.md`
5. You approve → AI implements
6. You validate → say **"mark as done"**
7. Spec moves to `aux/done/` for history

---

## File Structure

```
aux/
├── otto.md              ← You are here (human reference)
├── protocol.md          ← The contract (AI reads this)
├── project.md           ← Your project context
├── spec-template.md     ← Spec format reference
├── guides/
│   └── ai-implementation.md
├── specs/               ← Active work
└── done/                ← Completed specs
```

---

## For AI Assistants

When human says "Otto":
1. Read `aux/protocol.md` (the contract)
2. Read `aux/project.md` (project context)
3. Follow the state machine

**This file is for humans.** Go to protocol.md for your instructions.

---

## What Otto Is

- Protocol for human + AI to align on intent before coding
- Structured way to capture "what to build"
- Record of decisions that survives code changes

## What Otto Is NOT

- Project management (use your PM tool)
- Team task tracking (use Issues/Jira)
- API documentation (use JSDoc/OpenAPI)

---

## Why Keep Completed Specs

Specs in `done/` preserve intent:
- Framework migrations: code changes, intent doesn't
- Context recovery: remember why features exist
- Onboarding: understand decisions without reading code
- Pattern reference: how did we approach X?

Specs capture planning intent, not final implementation. Implementation reveals edge cases. This is expected.

---

**See protocol.md for complete state machine and workflow details.**
