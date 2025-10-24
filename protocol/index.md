# Otto Protocol - Index

**Version**: 2.0
**Purpose**: Human↔AI collaboration protocol for aligning on intent before coding

---

## Protocol Modules

Otto protocol is split into focused modules for efficient context loading:

### Core (required)
**`protocol/core.md`** - State machine and workflow
Load this first. Contains the state transitions and basic rules.

### Specs (load when creating specs)
**`protocol/specs.md`** - Spec format and success criteria guidelines
Load when entering Spec Review state or creating spec files.

### Blockers (load when blocked)
**`protocol/blockers.md`** - Blocker handling procedures
Load when you encounter blockers during implementation.

---

## Quick Start

**For AI assistants entering Otto for first time:**

1. Read `protocol/core.md` - understand the state machine
2. Read `aux/project.md` - get project context
3. Enter [Planning] state and begin

**Load other modules on-demand** as you progress through states.

---

## For Backward Compatibility

If you prefer a single file, `protocol.md` contains all modules combined.

Use modular files for optimal context efficiency (~1K tokens initial load vs ~4K for full protocol).

---

**See also**:
- `otto.md` - Human-facing quick reference
- `spec-template.md` - Example spec format
- `guides/ai-implementation.md` - AI-specific implementation guidance

**End of index.md**
