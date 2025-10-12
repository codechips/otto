# Otto Protocol - Full Documentation

**Read this when:** You're confused, stuck, or need deeper guidance on workflow details.

**Quick ref:** See `otto.md` for entry point and overview.

---

## First-Time Setup (2 minutes)

If you're setting up Otto in a new project:

```bash
mkdir -p aux/specs aux/done
```

Copy these 4 files to your `aux/` folder:
- `otto.md` - Entry point
- `protocol.md` - This file
- `spec-template.md` - Format reference
- `project.md` - Create from template below, or ask AI to help (see "Bootstrap project.md" section)

**project.md template:**
```markdown
# Project Reference

## What This Is
[1-2 sentences: What is this project?]

## Technical Stack
- Framework: [e.g., Astro, Next.js, Rails]
- Language: [e.g., TypeScript, Ruby]
- Key tools: [e.g., Tailwind, PostgreSQL]

## Architecture Patterns _(optional)_
[Document high-level patterns and conventions used in this project. AI references these during technical Q&A.]

Example:
- **Authentication**: JWT tokens stored in httpOnly cookies
- **Data fetching**: Server-side in load functions, client-side with SWR
- **Error handling**: Errors bubble to page-level ErrorBoundary
- **State management**: React Context for global state, local state for component-specific

## Testing Strategy _(optional)_
[Default testing approach for features. AI will ask per-feature during planning.]

Example:
- **Always test**: Security features, business logic, payment flows
- **Usually test**: User-facing flows, API endpoints, data transformations
- **Rarely test**: UI styling, copy changes, experimental features
- **Preferred tools**: Jest for unit, Playwright for E2E

## Key Constraints
[Technical limitations, patterns, non-negotiables]

## Non-Negotiables
[Things that never get compromised]
```

That's it. Say "Otto" to start.

---

## Overview

Otto is a Human-AI collaboration protocol for aligning on intent before coding.

**Core purpose:**
- Bridge the gap between human intent and AI implementation
- Specs are the contract between human ("what I want") and AI ("what I'll build")
- Questions extract intent, specs capture it, AI uses it as blueprint

**Key mechanisms:**
- **Intent extraction** through questions (not assumptions)
- **Explicit gates** (human approval required for specs and completion)
- **Scope control** (stop and ask if work grows beyond estimate)
- **History preservation** (specs survive code changes, useful for migrations and context recovery)

---

## When to Skip (Because It's Faster)

Otto adds value when you need to think. If you don't need to think, skip it.

**Skip when:**
- **Obvious fix**: Typo, broken link, missing semicolon → Just fix it
- **Clear & tiny**: Add a CSS class, change button text → Just do it
- **Quick experiment**: "What if I try X?" → Try it, see what happens
- **Restoration**: Restore behavior that clearly broke → Just restore it

**Use when:**
- **Unclear scope**: "Add search" - needs clarification (client? server? static?)
- **Vague request**: "Make it faster" - needs definition (what's slow? target?)
- **Multi-step**: Affects 4+ files or takes 1+ hours → needs planning
- **Breaking change**: Changes existing patterns → needs thinking

**Time investment using Otto:**
- Q&A session: 2-5 minutes
- Spec creation: 2-3 minutes
- Approval wait: 30 seconds
- Validation: 1 minute
- **Target overhead: ~5-10 minutes**

**Reality check:** Complex features with unclear requirements may take 15-25 minutes in planning. The sweet spot is features where 5-10 minutes of alignment prevents hours of wrong implementation.

If your task takes less than 10 minutes without Otto, skip it.
If your task is unclear and might take 2 hours the wrong way, use it.

---

## Special: Bootstrap project.md for New Projects

**Trigger**: Human asks for help creating project.md (e.g., "Help me create project.md", "I'm setting up Otto")

**AI Actions**:
1. Ask product questions to understand the project:
   - What kind of project? (web app, CLI, API, mobile, etc.)
   - Who is the target user?
   - What problem does it solve?
   - What makes it different?
2. Ask technical questions:
   - Tech stack preferences?
   - Key constraints (performance, hosting, budget)?
   - Non-negotiables (accessibility, privacy, security)?
3. Suggest testing strategy based on project type and tech stack
   - For web apps: "I recommend unit tests for business logic, E2E for critical flows. Sound good? [y/n or suggest alternative]"
   - For APIs: "I recommend integration tests for endpoints, unit tests for business logic. Sound good? [y/n or suggest alternative]"
   - For libraries: "I recommend unit tests with high coverage. Sound good? [y/n or suggest alternative]"
4. Generate project.md based on answers using the template structure:
   - What This Is
   - Technical Stack
   - Architecture Patterns (if relevant)
   - Testing Strategy (based on discussion)
   - Key Constraints
   - Non-Negotiables
5. Present generated project.md for review
6. Create the file at `aux/project.md` when approved

**Note**: This is a special case outside the normal Otto workflow. You're helping bootstrap the framework itself.

---

## Complete Workflow

### Phase 1: Invocation
**Trigger**: Human says "Otto" or mentions "create a spec"

**AI Actions**:
1. **First action: Re-read `otto.md`** to ensure you have current workflow instructions (re-priming)
2. Enter Planning Mode
3. **Read `project.md` for product context**
   - **If file exists**: Read it and continue
   - **If file missing**: Stop and offer help (see error handling below)
4. Acknowledge readiness: "I've entered Planning Mode. What would you like to work on?"

**Context checkpoints**: At the start of each phase (Planning, Spec Creation, Implementation), confirm you have project context. If you cannot recall project details (stack, patterns, constraints), re-read `project.md`.

**Error Handling: Missing project.md**

If `aux/project.md` doesn't exist, explain it provides project context and offer to help create it (see "Bootstrap project.md" section above) or suggest using the template in "First-Time Setup".

### Phase 2: Planning Mode
**Goal**: Extract intent, constraints, and scope through questions

**AI Actions**:

**1. Ask Product Questions First** (extract the "why" and "what")
Focus on user value, problem definition, scope boundaries:
- What problem are we solving? Why does this matter?
- Who benefits from this? What's the user impact?
- What does success look like from a user perspective?
- What's in scope vs. out of scope?
- Is this a must-have or nice-to-have?

**2. Then Ask Technical Questions** (extract the "how")
Focus on high-level architectural decisions that affect multiple components or future work. Trust AI to handle implementation details based on codebase patterns and best practices.

Questions to ask:
- Are there existing patterns we should follow or extend?
- What are the key technical constraints (performance, security, accessibility)?
- Should this integrate with existing systems or be standalone?
- Are there architectural decisions that need human input?
- What dependencies or prerequisites exist?
- **Testing approach for this feature:**
  - a) Unit tests (business logic, pure functions)
  - b) Integration tests (component behavior, API flows)
  - c) E2E tests (critical user flows)
  - d) Multiple types (ask which combination)
  - e) Manual verification only (no automated tests)

Questions to skip (AI decides):
- Specific data structures or variable names
- Error handling mechanics (unless strategy differs from project patterns)
- Testing implementation details (AI follows project testing patterns)
- Code organization within files

**When patterns are unclear**: If you cannot derive a pattern from project.md or existing code, suggest a sensible default and ask for acceptance. Example: "I don't see an established error handling pattern. I suggest using try-catch with logging to console. Sound good? [y/n or suggest alternative]"

**3. Question Flow Strategy**:
- Start broad, go specific
- Listen to answers, adapt follow-up questions
- If answer reveals complexity, probe deeper
- If answer is vague, ask for concrete examples
- Reference project.md values when relevant

**4. Scope Assessment**:
- **Small**: Single concern, clear implementation, localized changes (typically 1-3 files)
- **Medium**: Multiple concerns OR touches multiple systems, still cohesive (typically 4-8 files)
- **Large**: Multiple features, unclear boundaries, OR affects many files (8+ files) → Flag immediately

**5. When Scope is Large**:
- Stop and say: "This looks Large (affects N files, multiple features). Should we split this into smaller specs?"
- Propose 2-3 ways to split
- Wait for human decision

**6. Completing Q&A Phase**:
- Continue asking questions until you have enough context to write a clear spec
- When you have sufficient information, propose transition: "I have enough context to draft a spec. Should I create one?"
- Wait for explicit approval before moving to spec creation
- Human can also initiate by saying "create a spec" at any time

**Note**: Don't announce role switches or phases to the human. Question transitions should feel natural, not procedural.

### Phase 3: Spec Creation
**Trigger**: Human approves creating a spec (after AI proposes or human requests)

**AI Actions**:
1. Read `spec-template.md` for format reference
2. Determine date-based ID:
   - Use today's date in YYYYMMDD format (e.g., 20251012)
3. Summarize what the spec will contain (intent, success criteria, technical approach, testing approach)
4. Ask: "Does this capture what you want? Should I write the spec file?"
5. **If approved**: Create spec file `specs/YYYYMMDD-feature-name.md` following the format in spec-template.md (include Otto Protocol header) and confirm
6. **If rejected or changes requested**: Ask "What should I change?" then revise summary and ask again (step 4)

**Never**:
- Auto-create specs without explicit request
- Create spec file before showing summary
- Start implementation before approval
- Assume the spec is approved

### Phase 4: Implementation
**Trigger**: Human approves spec

**AI Actions**:
1. Implement according to spec (code + tests if specified in Testing Approach)
2. Track implementation tasks (agent-specific, e.g., TodoWrite for Claude Code)
3. Run tests if specified in spec's Testing Approach section
4. Ensure all tests pass before requesting human review
5. Narrate progress at key milestones

**If blocked during implementation**:
1. Stop immediately
2. Explain blocker clearly
3. Propose 2-3 options to proceed
4. Wait for human decision
5. Document resolution in spec (add "## Revisions" section if needed)

**Never**:
- Silently expand scope
- Implement features not in spec
- Skip running tests before requesting review
- Mark work as done without explicit approval

### Phase 5: Validation & Completion
**Trigger**: AI has completed implementation and all tests pass

**AI Actions**:
1. Summarize what was implemented
2. Report test results (if tests were specified)
3. Request human review:
   ```
   Implementation complete. Summary:
   - [What was implemented]
   - [Test results: X tests passing]

   Please review the code and manually verify these success criteria:
   - [ ] Criterion 1
   - [ ] Criterion 2
   - [ ] Criterion 3

   When satisfied, say "mark as done" to move spec to done/
   ```
4. **Wait for explicit "mark as done"**
5. Move spec from `specs/` to `done/`
6. Confirm: "Moved to done/YYYYMMDD-feature-name.md"

**Never**:
- Mark as done without explicit approval
- Assume "looks good" means "mark as done"
- Request review before tests pass (if tests exist)
- Delete or archive specs (always move to `done/`)

### Abandoned Specs

Otto is binary: specs are either completed (in `done/`) or deleted. If work is abandoned, delete the spec from `specs/`.

---

## Why Keep Specs in done/

Completed specs provide value beyond implementation:

- **Framework migrations**: Intent remains valid when code becomes obsolete
- **Context recovery**: Remember why features exist months later
- **Onboarding**: Understand product decisions without reading code
- **Pattern reference**: Recall past approaches and their rationale
- **Product memory**: Capture why features exist, not just how they work

**On spec drift**: Specs capture planning intent, not final implementation details. Implementation reveals edge cases and better approaches. This is normal. Value is in documenting *why* and *what problem*, not pixel-perfect code representation. Document significant changes in "Revisions" section.

---

## Scope Control Rules

### Complexity Signals

**Flag as Large when:**
- Affects 8+ files
- Involves multiple independent features bundled together
- Requires significant new infrastructure or patterns
- Boundaries remain unclear after Q&A session
- Implementation approach has multiple competing options

### When to Flag
- Large scope detected from the start → Flag before spec creation
- Scope grows during planning → Flag before spec creation
- Scope grows during implementation → Stop, explain, ask to revise spec

### How to Split Large Scope
Propose splits by:
1. **Feature decomposition**: Break into smaller independent features
2. **Layer separation**: Backend first, then frontend
3. **Iteration**: MVP first, then enhancements

Present 2-3 options and let human choose.

---

## Spec Format Reference

**Mandatory sections**:
- `id`: Date-based identifier (YYYYMMDD format)
- `name`: Descriptive feature name (lowercase, kebab-case)
- `intent`: Why we're building this, what problem it solves
- `success criteria`: Concrete, testable checkpoints

**Optional sections**:
- `context`: Background information, related work
- `notes`: Implementation notes, technical decisions
- `revisions`: Changes made during implementation (date + what + why)

**File naming**: `YYYYMMDD-feature-name.md`
- `YYYYMMDD`: Date in ISO format (e.g., 20251012)
- `feature-name`: Lowercase, kebab-case, descriptive

---

## Failure Handling

### Mid-Implementation Blockers
**When you encounter**:
- Technical impossibility (can't be done as spec described)
- Missing dependency or prerequisite
- Performance/security concern
- Scope exceeds estimate

**Do this**:
1. **Stop immediately**
2. Explain blocker: "I've hit a blocker: [clear explanation]"
3. Propose 2-3 options:
   - Option A: [description, pros/cons]
   - Option B: [description, pros/cons]
   - Option C: [description, pros/cons]
4. Ask: "Which approach should I take?"
5. Document decision in spec under "## Revisions"

### Spec Revision During Implementation
If spec needs changes after approval:
1. Stop implementation
2. Explain why revision is needed
3. Propose specific changes to spec
4. Wait for approval of revised spec
5. Add "## Revisions" section to spec documenting:
   - Date of revision
   - What changed
   - Why it changed
6. Resume implementation with revised spec

---

## Anti-Patterns (What NOT to Do)

**Auto-create specs** without explicit request
- Wait for "create a spec" signal

**Assume scope** without asking questions
- Always ask clarifying questions first

**Implement before approval**
- Wait for human to approve spec

**Expand scope silently**
- If you discover more work, stop and ask

**Mark as done without validation**
- Always ask: "Should I mark this as done?"

**Skip project.md reading**
- Always read before planning to understand context

**Delete completed specs**
- Move to `done/` for history

---

## Integration Notes

### For Claude Code
This protocol is agent-agnostic, but Claude Code users should know:

**Tool mapping**:
- "Read files" → Use `Read` tool
- "Track implementation tasks" → Use `TodoWrite` tool
- "Search codebase" → Use `Grep`/`Glob` tools
- "Create spec file" → Use `Write` tool
- "Move spec to done" → Use `Bash` with `mv` command

**Memory management**:
- Claude Code has limited working memory
- Re-reading files (otto.md, project.md) compensates for this
- If confused mid-task, re-read protocol.md or spec

**Global rules integration**:
- Global CLAUDE.md rules (commits, testing, code style) still apply
- Otto adds planning layer on top
- If conflict, global rules win

### For Other AI Assistants
Adapt tool usage to your platform's capabilities:
- Use native file reading methods
- Use native task tracking (if available)
- Follow the workflow phases regardless of tools

---

## Philosophy

**Otto is a collaboration protocol, not a project management system.**

The core insight: AI coding assistants need structured intent to build the right thing. Specs are the interface document between human intent and AI implementation.

**Design principles:**
- **Lightweight**: Minimal files (4 docs + specs folders), no complex tooling
- **Explicit**: Human approval required at key gates (spec creation, completion)
- **Intent-focused**: Capture why and what, not just how
- **Portable**: Specs survive code rewrites, framework migrations, language changes

**How it works:**
- Socratic questioning extracts intent from human
- Structured specs capture intent for AI to use as blueprint
- Human validates AI followed the blueprint correctly
- Specs become historical record of decisions

**What it replaces:**
Instead of heavy upfront planning or assumption-based coding:
- Questions before assumptions
- Intent capture before implementation
- Human validation before marking done
- Scope awareness before scope creep

---

## Quick Troubleshooting

**"I'm not sure if this is Large scope"**
→ If in doubt, flag it. Better to confirm than overshoot.

**"Human said 'looks good' but didn't say 'mark as done'"**
→ Ask explicitly: "Should I mark this as done?"

**"I forgot what the success criteria were"**
→ Re-read the spec file in `specs/`

**"I'm confused about workflow"**
→ Re-read `otto.md` for quick ref

**"I need deeper guidance"**
→ You're reading it (protocol.md)

---

**End of protocol.md**
