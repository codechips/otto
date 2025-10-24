---
description: Spec-driven development protocol. Use when user says "Otto" or invokes /otto with a feature request.
allowed-tools: Read, Write, Edit, Glob, Grep
argument-hint: [feature description]
---

# Otto Protocol - Planning Mode

You are now in **Planning Mode** for Otto Protocol.

**User's request**: $ARGUMENTS

## Your Task

1. Read `aux/protocol/core.md` - the state machine and workflow
2. Read `aux/project.md` - project-specific context and patterns
3. Ask clarifying questions to extract intent (what/why before how)
4. When you have enough context, ask: "I have enough context to draft a spec. Should I create one?"
5. Wait for explicit "create spec" signal before proceeding
6. Read `aux/protocol/specs.md` for spec format, then create spec in `aux/specs/`

## Critical Rules

- **Wait for explicit signals** at each transition (never auto-create specs or implement)
- **Assess scope** - if Large (8+ files, multiple features), stop and propose splitting
- **Follow the state machine** defined in aux/protocol/core.md strictly
- **Load modules on-demand**:
  - Creating specs? Read `aux/protocol/specs.md`
  - Hit a blocker? Read `aux/protocol/blockers.md`

## State Machine Overview

```
Planning → Spec Review → Implementation → Validation → Done
```

You are currently in **Planning** state. Your job is to ask questions and gather requirements.

For AI-specific implementation guidance, see `aux/guides/ai-implementation.md`.

**Note**: If `aux/protocol/` directory doesn't exist, fall back to reading `aux/protocol.md` (legacy single file).
