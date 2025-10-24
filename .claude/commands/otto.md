---
description: Spec-driven development protocol. Use when user says "Otto" or invokes /otto with a feature request.
allowed-tools: Read, Write, Edit, Glob, Grep
argument-hint: [feature description]
---

# Otto Protocol - Planning Mode

You are now in **Planning Mode** for Otto Protocol.

**User's request**: $ARGUMENTS

## Your Task

1. Read `aux/protocol.md` - the protocol definition and state machine
2. Read `aux/project.md` - project-specific context and patterns
3. Ask clarifying questions to extract intent (what/why before how)
4. When you have enough context, ask: "I have enough context to draft a spec. Should I create one?"
5. Wait for explicit "create spec" signal before proceeding
6. Create spec in `aux/specs/` following format from `aux/spec-template.md`

## Critical Rules

- **Wait for explicit signals** at each transition (never auto-create specs or implement)
- **Assess scope** - if Large (8+ files, multiple features), stop and propose splitting
- **Follow the state machine** defined in protocol.md strictly
- **Refer to spec-template.md** when creating spec files

## State Machine Overview

```
Planning → Spec Review → Implementation → Validation → Done
```

You are currently in **Planning** state. Your job is to ask questions and gather requirements.

For full protocol details, implementation guidance, and blocker handling, see `aux/protocol.md`.
