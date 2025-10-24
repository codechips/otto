# Otto Protocol - Core

**Version**: 2.0
**Module**: Core state machine and workflow

---

## What This Is

Otto is a **protocol** - a contract that defines how humans and AI assistants collaborate on software development.

**Core mechanism**: Human provides intent → AI captures in spec → AI implements from spec → Human validates

This document defines states, signals, and artifacts. It does NOT prescribe implementation details.

---

## Quick Start for AI Assistants

**When human says "Otto":**

1. Read `aux/protocol/core.md` (this file) - understand the state machine
2. Read `aux/project.md` - get project context
3. Enter [Planning] state and ask questions
4. When creating specs, read `aux/protocol/specs.md` for format
5. If blocked during implementation, read `aux/protocol/blockers.md` for guidance

**Key rule:** Wait for explicit human signals at each transition. Never auto-create specs, never implement before approval, never mark as done without signal.

---

## State Machine

Otto is a state machine with explicit transitions:

```
[Idle]
  │
  ├─ "Otto" ──────────────────────────────────────────────┐
  │                                                        ▼
  │                                                   [Planning]
  │                                                        │
  │  ┌─────────────────────── "create spec" ──────────────┤
  │  ▼                                                     │
  │  [Spec Review]                                         │
  │  │         │                                           │
  │  │ approve │ reject ────────────────────────────────────┘
  │  ▼         │
  │  [Implementation]
  │  │         │
  │  │ blocked ─┘
  │  │ complete
  │  ▼
  │  [Validation]
  │  │         │
  │  │ changes ─┘
  │  │ "mark as done"
  │  ▼
  └─ [Done] ────────────────────────────────────────────> [Idle]
```

---

## States

### [Idle]
**Human**: Can invoke with "Otto" or "otto" or "use Otto"
**AI**: Wait for invocation

### [Planning]
**Human**:
- Says "Otto" to enter this state
- Answers AI's questions
- Says "create spec" (or "write the spec") when ready

**AI must**:
1. Read `aux/project.md` - if it's unfilled template (contains placeholder text), stop and guide human to fill it out before continuing
2. Acknowledge entry: "I've entered Planning Mode. What would you like to work on?"
3. Ask questions to extract intent (what/why before how)
4. Assess scope - if Large (8+ files, multiple features): stop and propose splitting
5. When sufficient context: "I have enough context to draft a spec. Should I create one?"
6. Wait for explicit "create spec" signal

### [Spec Review]
**Human**:
- Reviews spec summary
- Says "yes" / "looks good" / "approved" → go to Implementation
- Says "no" / "change X" → return to Planning with feedback

**AI must**:
1. Present spec summary (intent, success criteria, approach)
2. Ask: "Does this capture what you want? Should I write the spec file?"
3. If approved: Write spec to `aux/specs/YYYYMMDD-feature-name.md` using format from `aux/protocol/specs.md`
4. Confirm creation

### [Implementation]
**Human**:
- Monitors progress
- Answers questions about blockers

**AI must**:
1. Re-read the spec before starting
2. Implement according to spec (address all success criteria, write tests if specified)
3. If blocked (technical impossibility, missing prerequisite, security concern, scope explosion):
   - See `aux/protocol/blockers.md` for detailed handling
   - Stop immediately, explain blocker, propose options
   - Document resolution in spec's "Revisions" section
4. When complete: Summarize implementation and list success criteria for human to verify
5. Request validation (don't mark as done yourself)

### [Validation]
**Human**:
- Tests implementation against success criteria
- Requests changes → return to Implementation
- Says "mark as done" / "we're done" / "archive this" when satisfied

**AI must**:
1. Wait for human signal
2. If "mark as done": Move spec from `specs/` to `done/`, confirm move, return to Idle

---

## Implementation Guidance

For AI-specific guidance (memory management, tool usage, agent-specific patterns), see `guides/ai-implementation.md`.

Otto is tool-agnostic. Any AI that can read/write files can implement this protocol.

---

**See also**:
- `aux/protocol/specs.md` - Spec format and success criteria guidelines
- `aux/protocol/blockers.md` - Blocker handling procedures
- `aux/spec-template.md` - Example spec format

**End of core.md**
