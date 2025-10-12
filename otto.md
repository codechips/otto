# Otto Framework

A collaboration protocol for humans and AI coding assistants.

## What Otto Is

Otto is a protocol that helps humans and AI align on intent before writing code.

**The problem it solves:**
- Human has vague idea: "add user authentication"
- AI implements based on assumptions
- Result doesn't match intent
- Wasted time, wrong implementation

**How Otto fixes this:**
1. **Extract**: AI asks questions to pull intent from human
2. **Capture**: Intent gets written in a spec (structured format)
3. **Implement**: AI uses spec as blueprint, not assumptions
4. **Validate**: Human checks against original intent

**The spec is the contract:**
- Human side: "Here's what I want and why"
- AI side: "Here's what I'll build and how we'll know it's done"

**Why specs are kept:**
- AI can reference past decisions ("How did we handle X before?")
- Human can remember original intent ("Why did we build this?")
- Framework migrations preserve intent when code changes

**This is NOT:**
- Project management (use your PM tool for backlogs/roadmaps)
- Team task tracking (use GitHub Issues/Linear/Jira)
- API documentation (use JSDoc/OpenAPI/README)

**This IS:**
- A protocol for one human + one AI to align on intent before coding
- A structured way to capture "what to build" so AI builds the right thing
- A record of decisions that survives code changes

## Do You Need Otto for This?

**Quick check:**
- Single file change? → Skip Otto, just do it
- Know exactly what you want? → Skip Otto, just do it
- Vague idea that needs thinking? → Use Otto
- Multi-file or unclear scope? → Use Otto

**Examples that DON'T need Otto:**
- Fix typo in button text
- Update color value in CSS
- Add console.log for debugging
- Restore intended behavior (obvious bug)

**Examples that DO need Otto:**
- "Add search" (unclear: client-side? server? static index?)
- "Make it faster" (vague: what's slow? what's the target?)
- "Improve UX" (needs definition: which flow? what's wrong?)
- "Add authentication" (multi-step: sessions? JWT? OAuth?)

**Rule of thumb:** If you spend more time deciding whether to use Otto than the task would take, just do the task.

---

## Invocation

Say **"Otto"** to activate this framework. This signals: "We're entering planning mode."

**Recognized phrases:**
- "Otto" or "otto" (case-insensitive)
- "use Otto"
- "Otto mode"
- "Otto this" (applies to current discussion)
- "Otto: [intent]" (e.g., "Otto: add user authentication")

All variations work the same way.

## What Happens When Invoked

1. **AI re-reads this file** (silent, automatic re-priming)
2. **AI enters Planning Mode** and reads `project.md` for context
3. **AI asks questions** to extract intent, constraints, scope
4. **Human explicitly requests spec creation** ("create a spec for this")
5. **AI creates spec** in `specs/YYYYMMDD-feature-name.md` with date-based ID
6. **Human approves spec**
7. **AI implements** according to spec
8. **Human validates and says "mark as done"**
9. **AI moves spec** to `done/` folder

## When to Use Otto

**Use when:**
- Planning features (you say: "let's build", "add feature", "implement")
- Unclear scope (you say: "I want to", "can we", "how about")
- Breaking changes or refactoring
- Multi-step work

**Skip when:**
- Trivial fixes (typos, formatting)
- Obvious bugs (restore intended behavior)
- Quick experiments

## File Structure

```
aux/
├── otto.md          ← You are here (entry point)
├── protocol.md         ← Full rules (read when confused/stuck)
├── project.md          ← Product reference (what we're building)
├── spec-template.md    ← Format reference (how to write specs)
├── specs/              ← Active work (YYYYMMDD-feature-name.md)
└── done/               ← Completed specs (archived for history)
```

## Reading Strategy for AI

```
"Otto" trigger → Read otto.md (always, silently)
                 ↓
         Planning mode → Read project.md
                 ↓
         Creating spec → Read spec-template.md
                 ↓
         Confused/stuck → Read protocol.md
```

## Key Principles

- **Explicit over implicit**: Human explicitly requests spec creation
- **Questions before code**: Extract intent through questions, never assume
- **Human validation gates**: AI never marks work done without explicit approval
- **Scope control**: If work is Large (8+ files, multiple features), stop and propose splitting
- **Keep history**: All specs (active and done) are preserved

## Quick Reference

- **Planning Mode**: Ask questions to extract intent, constraints, scope
- **Spec Format**: Date-based ID (YYYYMMDD), lowercase, kebab-case
- **Success Criteria**: Concrete, testable checkpoints that define "done"
- **Failure Handling**: Stop, explain blocker, propose 2-3 options, ask human to choose
- **Done Confirmation**: Explicitly ask: "Should I mark this as done and move spec to done/?"
