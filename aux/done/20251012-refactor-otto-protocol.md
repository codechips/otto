# 20251012: Refactor Otto as Clean Human↔AI Protocol

**Status**: Completed

## Intent

Refactor Otto documentation to be a clean Human↔AI interaction protocol by separating protocol definition (the interface contract between human and AI) from AI implementation details (guidance for how one party implements its side).

**The problem**: Current Otto mixes protocol rules (what states exist, what gates require approval, what artifacts are created) with AI-specific implementation details (memory management strategies, tool usage, agent-specific workarounds). This makes it unclear what is the "contract" versus what is guidance for one party.

**The goal**: Make Otto AI-agnostic so any AI that can read/write files can implement the protocol, regardless of its internal architecture or memory management approach.

## Technical Approach

### Protocol Definition (New `protocol.md`)
- Define Otto as a state machine with explicit states and transitions
- Specify required human signals ("Otto", "create spec", "mark as done")
- Specify required AI deliverables at each state (questions, spec, implementation, validation request)
- Define artifact format (spec structure, file naming)
- Define file structure (aux/, specs/, done/)
- **Length target**: ~300-400 lines
- **Audience**: Both humans and AIs - this is the contract

### Implementation Guidance (New `guides/` directory)
- Move AI memory management strategies here
- Move tool usage patterns (Read, Write, TodoWrite, etc.)
- Move agent-specific notes (Claude Code, Cursor, etc.)
- Keep troubleshooting and common pitfalls
- **Audience**: AI implementers

### State Machine Model
```
[Idle] --("Otto")--> [Planning]
[Planning] --("create spec")--> [Spec Review]
[Spec Review] --(human approves)--> [Implementation]
[Spec Review] --(human rejects)--> [Planning]
[Implementation] --(blocked)--> [Planning]
[Implementation] --(complete)--> [Validation]
[Validation] --("mark as done")--> [Done]
[Validation] --(changes needed)--> [Implementation]
```

### What Gets Removed from Protocol
- "Re-read otto.md to re-prime yourself"
- "If you cannot recall project details, re-read project.md"
- "Claude Code has limited working memory"
- Tool mappings (Read, Write, TodoWrite, Bash)
- Agent-specific memory management checkpoints

### What Stays in Protocol
- States and transitions
- Human signals and when to use them
- Required AI deliverables
- Spec format requirements
- Success criteria guidelines
- Scope control rules (Small/Medium/Large)
- Failure handling (stop, explain, propose options)

## Success Criteria

- [ ] New `protocol.md` exists and defines the Human↔AI contract (~300-400 lines)
- [ ] Protocol is defined as a state machine with explicit states and transitions
- [ ] Protocol contains no AI-internal implementation details (memory management, tool usage)
- [ ] New `guides/` directory exists with AI implementation guidance
- [ ] Old `protocol.md` is deleted
- [ ] `otto.md` is updated to reference new structure (if needed)
- [ ] `spec-template.md` references protocol correctly
- [ ] `README.md` is updated to reflect new documentation structure
- [ ] `bootstrap.sh` downloads/creates correct files

## Context

This is a documentation refactoring only. The workflow phases (Planning → Spec → Implementation → Validation), file naming conventions (YYYYMMDD-feature-name.md), and spec format all remain unchanged.

The distinction:
- **Protocol** = Interface definition (what both parties must do)
- **Implementation** = How one party does its part (internal details)

Current Otto conflates these. This refactoring separates them.

## Files Modified

1. ✓ Created new `aux/protocol.md` (protocol definition only, ~420 lines)
2. ✓ Created `aux/guides/ai-implementation.md` (AI-specific guidance)
3. ✓ Replaced old `protocol.md` with new version and moved to aux/
4. ✓ Updated `otto.md` (references to new structure)
5. ✓ Updated `README.md` (documentation structure section)
6. ✓ Updated `bootstrap.sh` (downloads guides/ai-implementation.md, creates guides/ directory)
7. ✓ Updated `spec-template.md` (references protocol.md correctly)

## Implementation Notes

**Key changes:**
- New protocol.md defines Otto as state machine with explicit states/transitions
- All AI memory management, tool usage, and agent-specific notes moved to guides/ai-implementation.md
- Protocol is now AI-agnostic (any AI that can read/write files can implement it)
- Clear separation: protocol = interface contract, implementation = one party's internal strategies

**File sizes:**
- protocol.md: 420 lines (down from ~494)
- ai-implementation.md: ~530 lines (AI-specific content extracted)
- Total: ~950 lines (vs original 1,200+ mixed content)

## Completion

**Completed**: 2025-10-12
