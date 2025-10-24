# Otto Protocol - Index

**Version**: 2.0
**Purpose**: Human↔AI collaboration protocol for aligning on intent before coding

---

## Protocol Modules

Otto protocol is split into focused modules for efficient context loading:

### Core (required)
**`aux/protocol/core.md`** - State machine and workflow
Load this first. Contains the state transitions and basic rules.

### Specs (load when creating specs)
**`aux/protocol/specs.md`** - Spec format and success criteria guidelines
Load when entering Spec Review state or creating spec files.

### Blockers (load when blocked)
**`aux/protocol/blockers.md`** - Blocker handling procedures
Load when you encounter blockers during implementation.

---

## Quick Start

**For AI assistants entering Otto for first time:**

1. Read `aux/protocol/core.md` - understand the state machine
2. Read `aux/project.md` - get project context
3. Enter [Planning] state and begin

**Load other modules on-demand** as you progress through states.

---

## For Backward Compatibility

If you prefer a single file, `aux/protocol.md` contains all modules combined.

Use modular files for optimal context efficiency (~1K tokens initial load vs ~4K for full protocol).

---

**See also**:
- `aux/otto.md` - Human-facing quick reference
- `aux/spec-template.md` - Example spec format
- `aux/guides/ai-implementation.md` - AI-specific implementation guidance

**End of index.md**
