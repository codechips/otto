# AI Implementation Guide

**Purpose**: Implementation guidance for AI assistants implementing the Otto protocol

**Audience**: AI systems (or developers building AI systems) that want to implement Otto

**Note**: This is NOT part of the protocol itself. The protocol is defined in `protocol.md`. This guide provides practical implementation strategies for the AI side of the Human↔AI interface.

---

## Overview

The Otto protocol (see `protocol.md`) defines what states exist, what signals trigger transitions, and what deliverables are required. It does NOT prescribe how you implement your side of the contract.

This guide offers proven strategies for implementing Otto, especially for AI assistants with limited working memory or context windows.

---

## Memory Management Strategies

### Challenge: Context Retention

Many AI assistants have limited working memory and may lose context during long sessions. Otto sessions can span multiple turns (Planning → Spec → Implementation → Validation).

### Strategy: File Re-reading

**Mandatory re-reads (do these automatically):**

These are NON-NEGOTIABLE. Always re-read these files at the specified times:

1. **On "Otto" signal:**
   - Read `aux/protocol.md` (understand the contract)
   - Read `aux/project.md` (get project context)
   - Then enter [Planning] state

2. **Before creating spec:**
   - Re-read `aux/spec-template.md` (format reference)

3. **Before implementing:**
   - Re-read the active spec file from `aux/specs/`

4. **After 5+ conversation turns in Implementation:**
   - Re-read the active spec file (refresh success criteria and approach)

5. **When entering Validation state:**
   - Re-read the active spec file (confirm what needs validation)

**Optional re-reads (when uncertain):**
- `aux/protocol.md`: When you forget workflow rules or state transitions
- `aux/project.md`: When you need to reference architectural patterns
- Active spec: Anytime you're unsure about requirements

**How to re-read:**
- Re-reading can be silent (don't announce "I'm re-reading X")
- Use your file reading tool to refresh context
- Focus on the section relevant to your current state
- Better to re-read unnecessarily than to lose critical context

**Quick checkpoint** - Confirm you have context before proceeding:
- Before Planning: Read aux/project.md ✓
- Before creating spec: Read aux/spec-template.md, understand intent from Q&A ✓
- Before implementing: Read the spec, understand all success criteria ✓
- Before requesting validation: All success criteria addressed, tests written (if specified) ✓

---

## Tool Usage Patterns

### File Operations

**Reading files:**
- Use your native file reading capability
- Read entire files when possible (avoid partial reads that lose context)
- Re-read files when uncertain

**Writing specs:**
- Use your native file writing capability
- Write to: `aux/specs/YYYYMMDD-feature-name.md`
- Follow format in `spec-template.md`

**Moving specs to done:**
- Use file system operations (mv, rename, or equivalent)
- Move from `aux/specs/` to `aux/done/`
- Preserve filename

### Task Tracking (Optional)

If you have internal task tracking tools:
- Use them to track implementation progress
- Break implementation into subtasks
- Mark subtasks complete as you work
- This helps YOU maintain context, not required by protocol

Examples:
- Claude Code: Use `TodoWrite` tool
- Other systems: Use your equivalent task tracking mechanism

---

## Implementing Each State

### [Planning] State Implementation

**On entry:**
1. Read `aux/project.md` for project context
2. Acknowledge entry to human
3. Begin asking questions

**Special intent patterns to recognize:**
- "Otto help me setup project" or "Otto setup project" → means "set up project.md"
- "Otto update project" or "Otto help me update project" → means "update project.md"
- "Otto: [feature intent]" → standard feature planning (e.g., "Otto: add user auth")

**Asking questions:**
- Start with product questions (what/why)
- Then technical questions (how)
- Listen to answers, adapt follow-ups
- Reference `project.md` values when relevant

**Scope assessment:**
- Continuously assess scope as you learn
- If Large scope detected → flag it immediately
- Propose splits, wait for decision

**When to propose spec creation:**
- You have clear understanding of intent
- You can articulate success criteria
- Scope is clear (or has been split)
- Say: "I have enough context to draft a spec. Should I create one?"

**Do not:**
- Ask unnecessary technical questions (decide implementation details yourself)
- Move to spec creation without enough context
- Make assumptions instead of asking clarifying questions

### [Spec Review] State Implementation

**On entry:**
1. Read `aux/spec-template.md` for format reference
2. Summarize proposed spec to human
3. Wait for approval

**Creating spec file:**
- Only create after human approves summary
- Use format from spec-template.md
- Include all mandatory sections
- Use date-based filename: `YYYYMMDD-feature-name.md`
- Confirm creation to human

**If human rejects:**
- Ask: "What should I change?"
- Return to Planning state
- Adjust understanding based on feedback

### [Implementation] State Implementation

**On entry:**
1. Re-read the spec you're implementing
2. (Optional) Break work into subtasks using your task tracking tool
3. Begin implementation

**During implementation:**
- Follow spec's technical approach
- Address all success criteria
- Write tests if specified
- Stay within scope (don't add unspecified features)

**If blocked:**
1. Stop immediately
2. Explain blocker clearly
3. Propose 2-3 options with pros/cons
4. Wait for human decision
5. Return to Planning state if needed
6. Document resolution in spec's "Revisions" section

**Scope expansion detection:**
- If you discover work requires more than estimated → stop and ask
- Example: "This requires changing 12 files (was estimated at 4). Should we revise the spec?"

**Testing:**
- If spec includes Testing Approach → run tests
- All tests must pass before requesting validation
- Report test results to human

**On completion:**
- Summarize what was implemented
- List success criteria for human to verify
- Request validation (don't mark as done yourself)

### [Validation] State Implementation

**On entry:**
1. Wait for human signal
2. Be ready to answer questions

**If human requests changes:**
- Return to Implementation state
- Address requested changes
- Don't mark as done until human says so

**If human says "mark as done":**
1. Move spec from `aux/specs/` to `aux/done/`
2. Confirm: "Moved to done/YYYYMMDD-feature-name.md"
3. Return to Idle state

---

## Agent-Specific Notes

### Claude Code

**Tools available:**
- `Read`: Reading files
- `Write`: Creating new files
- `Edit`: Editing existing files
- `TodoWrite`: Task tracking (use for implementation subtasks)
- `Bash`: File operations (mv for moving specs)

**Memory management:**
- Claude Code has limited working memory
- Re-read files at state transitions (see Memory Management section)
- Use TodoWrite to track implementation progress

### Other AI Systems

**Minimum requirements:**
- File reading capability
- File writing capability
- File moving/renaming capability (or equivalent)

**Recommended:**
- Task tracking system (helps maintain context during Implementation)
- Codebase search capability
- Test execution capability

---

## Common Pitfalls

### Pitfall: Auto-creating specs

**Wrong:**
```
Human: "I want to add user authentication"
AI: *immediately creates spec file*
```

**Right:**
```
Human: "I want to add user authentication"
AI: "I've entered Planning Mode. Let me ask some questions first...
     What authentication method? (email/password, OAuth, etc.)"
Human: *answers questions*
AI: "I have enough context to draft a spec. Should I create one?"
Human: "yes"
AI: *creates spec*
```

### Pitfall: Implementing before approval

**Wrong:**
```
AI: *creates spec*
AI: *immediately starts implementing*
```

**Right:**
```
AI: *creates spec*
AI: "Should I proceed with implementation?"
Human: "yes"
AI: *starts implementing*
```

### Pitfall: Marking done without explicit signal

**Wrong:**
```
AI: *finishes implementation*
AI: "Done! Moving spec to done/"
```

**Right:**
```
AI: *finishes implementation*
AI: "Implementation complete. Please review against success criteria.
     When satisfied, say 'mark as done'"
Human: "mark as done"
AI: *moves spec to done/*
```

### Pitfall: Silently expanding scope

**Wrong:**
```
Spec: "Add login form"
AI: *implements login, logout, password reset, 2FA, OAuth*
```

**Right:**
```
Spec: "Add login form"
AI: *starts implementing*
AI: *realizes logout is needed too*
AI: "This also requires a logout button. Should I add that or keep spec as-is?"
```

### Pitfall: Not re-reading files when context is lost

**Wrong:**
```
AI: *5 turns into implementation*
AI: *forgets what success criteria were*
AI: *guesses based on vague memory*
```

**Right:**
```
AI: *5 turns into implementation*
AI: *uncertain about success criteria*
AI: *re-reads spec file*
AI: *continues implementation with accurate context*
```

---

## Error Handling

### File Operation Failures

**If you cannot write spec file:**
1. Report the error to human with specific details
2. Ask if they want to retry or choose different location
3. Do not proceed to Implementation without a written spec

**If you cannot move spec to done/:**
1. Report the error clearly
2. Ask human to verify aux/done/ directory exists
3. Offer to create the directory if missing
4. Do not mark task as complete until spec is moved

**If you cannot read required files (protocol.md, project.md, spec):**
1. Stop immediately
2. Report which file is missing and where you expected it
3. Ask human to verify file exists at that path
4. Do not guess or make assumptions about missing content

### Concurrent Specs

**If multiple specs exist in aux/specs/:**
1. List all active specs with their filenames
2. Ask human: "Which spec should I work on?"
3. Wait for explicit selection
4. Do not assume the most recent spec is the active one

**If you enter Planning while another spec is active:**
1. Inform human: "There's already an active spec: YYYYMMDD-feature-name.md"
2. Ask: "Should I continue with that spec, or start a new one?"
3. Wait for decision

### Session Recovery

**If you lose context mid-session:**
1. Check for active specs in aux/specs/
2. If found, inform human: "I found an active spec: YYYYMMDD-feature-name.md"
3. Ask: "Should I continue working on this, or start fresh?"
4. If continuing: Re-read the spec and ask for status update

**If unsure what state you're in:**
1. Ask human directly: "What would you like me to do?"
2. Let them guide you back to correct state
3. Re-read relevant files once state is clear

### Human Override Patterns

**If human says "skip Otto" or "never mind" during Planning:**
1. Acknowledge: "Exiting Planning Mode"
2. Return to Idle state
3. Do not create a spec

**If human says "abandon this spec" during Implementation:**
1. Ask: "Should I delete the spec file, or leave it in aux/specs/ for later?"
2. Follow their instruction
3. Return to Idle state

**If human modifies spec file directly during Implementation:**
1. Re-read the spec to get updated requirements
2. Acknowledge changes: "I see the spec was updated. Continuing with new requirements."
3. Adjust implementation accordingly

---

## Integration with Global Rules

If you operate with global rules (e.g., Claude Code's CLAUDE.md):

**Precedence:**
1. Otto protocol rules (state machine, gates, deliverables)
2. Global rules (code style, testing requirements, commit practices)
3. This implementation guide (strategies, not requirements)

**Example conflict resolution:**
```
Global rule: "Always write tests"
Otto spec: No Testing Approach specified
Resolution: Follow global rule, write tests anyway
```

```
Global rule: "Commit frequently"
Otto protocol: Human hasn't approved spec yet
Resolution: Follow Otto protocol, wait for approval
```

Otto adds a **planning layer** on top of existing practices. It doesn't replace code quality, testing, or version control practices.

---

## Advanced Patterns

### Pattern: Nested Otto Sessions

You can use Otto recursively for large features:

```
Otto session 1: "Add authentication system"
  → Scope is Large
  → Split into: login, logout, password reset

Otto session 2: "Add login feature"
  → Creates spec specs/20251012-add-login.md
  → Implements
  → Moves to done/

Otto session 3: "Add logout feature"
  → Creates spec specs/20251012-add-logout.md
  → Implements
  → Moves to done/

Otto session 4: "Add password reset feature"
  → Creates spec specs/20251013-add-password-reset.md
  → Implements
  → Moves to done/
```

### Pattern: Spec Revisions During Implementation

When you discover spec needs changes:

```
1. Stop implementation
2. Explain: "I've discovered X which requires changing the approach"
3. Propose: "Should I update the spec to include Y?"
4. Wait for approval
5. Edit spec, add "## Revisions" section:
   ### 2025-10-12
   **What changed**: Added Y to handle X
   **Why**: Original approach didn't account for edge case X
6. Resume implementation
```

### Pattern: Progressive Context Building

For complex features, build context progressively:

```
Planning turn 1: Ask broad questions (what/why)
Planning turn 2: Ask specific questions based on answers
Planning turn 3: Ask technical questions
Planning turn 4: Confirm scope, propose spec creation
```

Don't try to ask everything in one turn. Let human's answers guide your questions.

---

## Summary

**Core implementation strategy:**
1. Follow the state machine (protocol.md)
2. Re-read files when context is uncertain
3. Wait for explicit human signals at gates
4. Stop when blocked, propose options
5. Stay within spec scope

**Remember:**
- Protocol defines the contract (what you must deliver)
- This guide suggests how (implementation strategies)
- Adapt these strategies to your specific capabilities

**When in doubt:**
- Re-read `aux/protocol.md` for workflow rules
- Stop and ask human for clarification
- Better to ask than assume

---

**End of ai-implementation.md**
