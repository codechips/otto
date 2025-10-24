# Otto Protocol

**Version**: 2.0
**Purpose**: Human↔AI collaboration protocol for aligning on intent before coding

> **Note**: This is the legacy single-file protocol for backward compatibility.
>
> **For better context efficiency**, use modular files in `protocol/`:
> - `protocol/core.md` - State machine (~1K tokens)
> - `protocol/specs.md` - Spec format (load when creating specs)
> - `protocol/blockers.md` - Blocker handling (load when blocked)
>
> See `protocol/index.md` for module overview.

---

## What This Is

Otto is a **protocol** - a contract that defines how humans and AI assistants collaborate on software development.

**Core mechanism**: Human provides intent → AI captures in spec → AI implements from spec → Human validates

This document defines states, signals, and artifacts. It does NOT prescribe implementation details.

---

## Quick Start for AI Assistants

**When human says "Otto":**

1. Read `aux/protocol.md` (this file) - understand the contract
2. Read `aux/project.md` - get project context
3. Enter [Planning] state and ask questions
4. Wait for "create spec" signal → create spec in `aux/specs/`
5. Wait for approval → implement according to spec
6. Wait for "mark as done" signal → move spec to `aux/done/`

**Key rule:** Wait for explicit human signals at each transition. Never auto-create specs, never implement before approval, never mark as done without signal.

---

## States

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

### [Idle]
**Human**: Can invoke with "Otto" or "otto" or "use Otto"
**AI**: Wait for invocation

### [Planning]
**Human**:
- Says "Otto" to enter this state
- Answers AI's questions
- Says "create spec" (or "write the spec") when ready

**AI must**:
1. Acknowledge entry: "I've entered Planning Mode. What would you like to work on?"
2. Ask questions to extract intent (what/why before how)
3. Assess scope - if Large (8+ files, multiple features): stop and propose splitting
4. When sufficient context: "I have enough context to draft a spec. Should I create one?"
5. Wait for explicit "create spec" signal

### [Spec Review]
**Human**:
- Reviews spec summary
- Says "yes" / "looks good" / "approved" → go to Implementation
- Says "no" / "change X" → return to Planning with feedback

**AI must**:
1. Present spec summary (intent, success criteria, approach)
2. Ask: "Does this capture what you want? Should I write the spec file?"
3. If approved: Write spec to `aux/specs/YYYYMMDD-feature-name.md` using format from `spec-template.md`
4. Confirm creation

### [Implementation]
**Human**:
- Monitors progress
- Answers questions about blockers

**AI must**:
1. Re-read the spec before starting
2. Implement according to spec (address all success criteria, write tests if specified)
3. If blocked (technical impossibility, missing prerequisite, security concern, scope explosion):
   - Stop immediately
   - Explain blocker clearly
   - Propose 2-3 options with pros/cons
   - Wait for decision
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

## Artifacts

### Spec Files

**Location**: `aux/specs/` (active) or `aux/done/` (completed)

**Naming**: `YYYYMMDD-feature-name.md`
- `YYYYMMDD`: Date in ISO format (e.g., 20251012)
- `feature-name`: Lowercase, kebab-case, descriptive

**Mandatory sections**:
- **Title**: `# YYYYMMDD: Feature Name`
- **Status**: "In Progress" or "Completed"
- **Intent**: Why we're building this, what problem it solves
- **Success Criteria**: Concrete, testable checkpoints (3-7 items)

**Optional sections**:
- **Technical Approach**: High-level architectural decisions
- **Testing Approach**: What tests are needed
- **Context**: Background information, constraints
- **Implementation Notes**: Details added during work
- **Revisions**: Changes made after initial approval

**Format reference**: See `spec-template.md` for examples

---

## Success Criteria

Success criteria define "done" and must be:
- **Concrete**: Specific enough to verify
- **Testable**: Can be checked objectively
- **User-focused**: Emphasize outcomes, not implementation details
- **Scoped**: 3-7 criteria per spec (if 10+, consider splitting)

**Examples:**

Too vague:
- [ ] Users can authenticate
- [ ] System is faster

Too detailed:
- [ ] Login form has email field with type="email"
- [ ] Login form has password field with type="password"
- [ ] Submit button is disabled when fields empty

Just right:
- [ ] Users can log in with email/password
- [ ] Invalid credentials show error message
- [ ] Session persists across page navigations

---

## Blockers

**What qualifies as a blocker (must stop and ask):**
- Technical impossibility with specified approach
- Missing dependency or prerequisite that doesn't exist
- Security vulnerability in proposed approach
- Scope explosion (estimated 4 files, now requires 12+)
- Breaking change that affects existing features

**What AI should decide autonomously:**
- Specific error handling patterns (if project.md doesn't specify)
- Variable or function names
- Implementation details not in spec (map vs forEach, file organization)
- HTTP status codes (follow conventions)

**When blocked:**
1. Stop immediately
2. Explain blocker clearly
3. Propose 2-3 options with pros/cons
4. Ask: "Which approach should I take?"
5. Document decision in spec under "Revisions"

---

## Implementation Guidance

For AI-specific guidance (memory management, tool usage, agent-specific patterns), see `guides/ai-implementation.md`.

Otto is tool-agnostic. Any AI that can read/write files can implement this protocol.

---

**End of protocol.md**
