# Otto Protocol

**Version**: 2.0
**Purpose**: Human↔AI collaboration protocol for aligning on intent before coding

---

## What This Is

Otto is a **protocol** - an interface definition that governs how humans and AI assistants collaborate on software development tasks.

**Protocol = Contract**: This document defines what each party must do, what signals trigger state changes, and what artifacts get created. It does NOT prescribe how either party implements their side internally.

**Core mechanism**:
- Human provides intent through answers to questions
- AI extracts intent, captures it in a spec, implements according to spec
- Human validates implementation matches original intent
- Spec becomes permanent record of "why" that survives code changes

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

## States and Transitions

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

### State Definitions

**[Idle]**: No active Otto session
- Human can invoke protocol with "Otto" signal

**[Planning]**: AI extracts intent through questions
- AI asks questions to understand problem, scope, constraints
- Human answers questions
- Transitions to [Spec Review] when human says "create spec"

**[Spec Review]**: Human reviews proposed spec
- AI presents spec summary
- Human approves → [Implementation]
- Human rejects → [Planning] (with feedback)

**[Implementation]**: AI implements according to spec
- AI writes code, tests, documentation per spec
- If blocked → [Planning] (explain blocker, propose options)
- If complete → [Validation] (request human review)

**[Validation]**: Human validates implementation
- Human tests implementation against success criteria
- If changes needed → [Implementation]
- If satisfied, human says "mark as done" → [Done]

**[Done]**: Work complete, spec archived
- AI moves spec from `specs/` to `done/`
- Returns to [Idle]

---

## Human Signals

These are the **required human signals** that trigger state transitions:

### "Otto"
**When**: To invoke the protocol
**Variations**: "otto", "Otto mode", "use Otto", "Otto: [intent]"
**Effect**: Enters [Planning] state

### "create spec" (or equivalent)
**When**: Human is ready for AI to write a spec
**Variations**: "write the spec", "create a spec for this"
**Effect**: Transitions from [Planning] to [Spec Review]

### Approval (in Spec Review)
**When**: Human approves the spec
**Variations**: "yes", "looks good", "approved", "proceed"
**Effect**: Transitions from [Spec Review] to [Implementation]

### Rejection (in Spec Review)
**When**: Human rejects the spec or requests changes
**Variations**: "no", "change X", "what about Y?"
**Effect**: Returns to [Planning] with feedback

### "mark as done" (or equivalent)
**When**: Human validates implementation is complete
**Variations**: "mark it done", "we're done", "archive this"
**Effect**: Transitions from [Validation] to [Done]

---

## AI Deliverables

These are **required AI deliverables** at each state:

### In [Planning] State

**1. Acknowledge entry**
- Confirm Otto protocol is active
- Example: "I've entered Planning Mode. What would you like to work on?"

**2. Ask questions to extract intent**
- **Product questions** (what/why): Problem definition, user value, scope boundaries
- **Technical questions** (how): Architectural decisions, integration points, constraints
- Continue until sufficient context exists to write a clear spec

**3. Propose spec creation**
- When ready: "I have enough context to draft a spec. Should I create one?"
- Wait for human approval before transitioning

### In [Spec Review] State

**1. Present spec summary**
- Summarize: intent, success criteria, technical approach
- Ask: "Does this capture what you want? Should I write the spec file?"

**2. Create spec file** (if approved)
- Write to: `aux/specs/YYYYMMDD-feature-name.md`
- Use format from `spec-template.md`
- Confirm creation

### In [Implementation] State

**1. Implement according to spec**
- Code matches spec's technical approach
- All success criteria are addressed
- Tests are written (if specified)

**2. Handle blockers**
- If blocked: Stop immediately
- Explain blocker clearly
- Propose 2-3 options
- Wait for human decision
- Return to [Planning] if needed

**3. Request validation**
- When complete: Summarize what was implemented
- List success criteria for human to verify
- Request human review

### In [Validation] State

**1. Wait for human signal**
- If human requests changes → return to [Implementation]
- If human says "mark as done" → archive spec

**2. Archive spec**
- Move spec from `specs/` to `done/`
- Confirm: "Moved to done/YYYYMMDD-feature-name.md"

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

**Format reference**: See `spec-template.md`

### Directory Structure

```
aux/
├── protocol.md           ← This file (the contract)
├── otto.md              ← Entry point and overview
├── project.md           ← Project-specific context
├── spec-template.md     ← Spec format reference
├── guides/              ← Implementation guidance (optional)
│   └── ai-implementation.md
├── specs/               ← Active work
│   └── YYYYMMDD-feature-name.md
└── done/                ← Completed specs
    └── YYYYMMDD-feature-name.md
```

---

## Scope Control

AI must assess scope during [Planning] and flag if work is too large:

### Scope Categories

**Small**:
- Single concern, clear implementation
- Localized changes (1-3 files typically)
- Example: "Add email validation to login form"

**Medium**:
- Multiple concerns OR touches multiple systems
- Still cohesive (4-8 files typically)
- Example: "Add password reset flow"

**Large**:
- Multiple features OR unclear boundaries OR affects many files (8+ files)
- Example: "Add complete user authentication system"

### When Scope is Large

AI must:
1. Stop and say: "This looks Large (affects N files, multiple features). Should we split this?"
2. Propose 2-3 ways to split
3. Wait for human decision

### Split Strategies

- **Feature decomposition**: Break into smaller independent features
- **Layer separation**: Backend first, then frontend
- **Iteration**: MVP first, then enhancements

---

## Question Guidelines

### Product Questions (Ask First)

Focus on understanding **what** and **why**:
- What problem are we solving?
- Who benefits? What's the user impact?
- What does success look like?
- What's in scope vs. out of scope?
- Is this must-have or nice-to-have?

### Technical Questions (Ask Second)

Focus on **architectural decisions** that affect multiple components:
- Are there existing patterns to follow?
- What are key constraints (performance, security, accessibility)?
- Should this integrate with existing systems or be standalone?
- What dependencies or prerequisites exist?
- What testing approach? (unit, integration, E2E, manual only)

### Questions to Skip

AI decides implementation details:
- Specific data structures or variable names
- Error handling mechanics (unless strategy differs from patterns)
- Code organization within files
- Testing implementation details

### When Patterns are Unclear

If you cannot derive a pattern from project.md or existing code:
- Suggest a sensible default
- Ask for acceptance
- Example: "I don't see an established error handling pattern. I suggest try-catch with logging. Sound good? [y/n or suggest alternative]"

---

## Success Criteria Guidelines

Success criteria define "done" and must be:
- **Concrete**: Specific enough to verify
- **Testable**: Can be checked objectively
- **User-focused**: Emphasize outcomes, not implementation
- **Scoped**: 3-7 criteria per spec (if 10+, consider splitting)

### Examples

**Too vague:**
- [ ] Users can authenticate
- [ ] System is faster

**Too detailed:**
- [ ] Login form has email field with type="email"
- [ ] Login form has password field with type="password"
- [ ] Submit button is disabled when fields empty
- [ ] ... (15 more micro-criteria)

**Just right:**
- [ ] Users can log in with email/password
- [ ] Invalid credentials show error message
- [ ] Session persists across page navigations

---

## Failure Handling

### Mid-Implementation Blockers

When AI encounters:
- Technical impossibility (can't be done as spec described)
- Missing dependency or prerequisite
- Performance/security concern
- Scope exceeds estimate

**Examples of blockers (must stop and ask):**
- Spec says "use library X" but X doesn't support required feature Y
- Performance requirement cannot be met with specified architecture
- Security vulnerability discovered in proposed approach
- Missing prerequisite: feature requires authentication system that doesn't exist
- Scope exploded: estimated 4 files, now requires 12+ files
- Breaking change: implementation would break existing features

**Examples of NOT blockers (AI decides):**
- Which specific error handling pattern to use (if project.md doesn't specify)
- How to name internal variables or functions
- Whether to use map() vs. forEach() for iteration
- Which HTTP status code to return (follow standard conventions)
- File organization within a module
- Minor implementation details not specified in spec

AI must:
1. **Stop immediately**
2. Explain blocker clearly
3. Propose 2-3 options with pros/cons
4. Ask: "Which approach should I take?"
5. Document decision in spec under "## Revisions"

### Spec Revision During Implementation

If spec needs changes after approval:
1. Stop implementation
2. Explain why revision is needed
3. Propose specific changes to spec
4. Wait for approval of revised spec
5. Add "## Revisions" section documenting:
   - Date of revision
   - What changed
   - Why it changed
6. Resume implementation with revised spec

---

## When to Use Otto

**Use when:**
- Unclear scope: "Add search" (client-side? server? static index?)
- Vague request: "Make it faster" (what's slow? target metrics?)
- Multi-step work: Affects 4+ files or takes 1+ hours
- Breaking changes: Modifies existing patterns

**Skip when:**
- Single file, obvious fix
- You know exactly what you want
- Trivial change (typo, color value, console.log)

**Rule of thumb**: If deciding whether to use Otto takes longer than the task itself, just do the task.

---

## Why Keep Completed Specs

Specs in `done/` provide value beyond implementation:

- **Framework migrations**: Intent remains valid when code becomes obsolete
- **Context recovery**: Remember why features exist months later
- **Onboarding**: Understand decisions without reading code
- **Pattern reference**: Recall past approaches
- **Product memory**: Capture why features exist, not just how they work

**Note on spec drift**: Specs capture planning intent, not final implementation details. Implementation often reveals edge cases and better approaches. This is expected. The value is in documenting the original problem and intent.

---

## Anti-Patterns

**Never:**
- Auto-create specs without explicit "create spec" signal
- Assume scope without asking questions
- Implement before spec is approved
- Expand scope silently (if scope grows, stop and ask)
- Mark as done without explicit "mark as done" signal
- Delete completed specs (always move to `done/`)

---

## Integration with Existing Tools

Otto is **tool-agnostic**. Any AI that can:
- Read files
- Write files
- Track its own implementation tasks (optional)

...can implement this protocol.

For AI-specific implementation guidance (memory management, tool usage patterns, agent-specific notes), see `guides/ai-implementation.md`.

---

## What Otto Is NOT

- **Project management**: Use your PM tool for backlogs/roadmaps
- **Team task tracking**: Use GitHub Issues/Linear/Jira
- **API documentation**: Use JSDoc/OpenAPI/README

## What Otto IS

- A protocol for one human + one AI to align on intent before coding
- A structured way to capture "what to build" so AI builds the right thing
- A record of decisions that survives code changes

---

**End of protocol.md**
