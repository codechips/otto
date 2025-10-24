# Otto Protocol - Blockers

**Version**: 2.0
**Module**: Blocker handling procedures

---

## What Qualifies as a Blocker

**AI must stop and ask when encountering:**
- Technical impossibility with specified approach
- Missing dependency or prerequisite that doesn't exist
- Security vulnerability in proposed approach
- Scope explosion (estimated 4 files, now requires 12+)
- Breaking change that affects existing features

---

## What AI Should Decide Autonomously

**Do NOT stop for these (use good judgment):**
- Specific error handling patterns (if project.md doesn't specify)
- Variable or function names
- Implementation details not in spec (map vs forEach, file organization)
- HTTP status codes (follow conventions)
- Minor refactoring to maintain consistency

---

## Blocker Handling Procedure

**When blocked:**

1. **Stop immediately** - do not continue with uncertain approach
2. **Explain blocker clearly** - what is the issue and why can't you proceed?
3. **Propose 2-3 options** with pros/cons for each
4. **Ask for decision**: "Which approach should I take?"
5. **Document decision** in spec under "Revisions" section

---

## Example Blocker Scenarios

### Scenario: Technical Impossibility

```
Blocker: The spec requires server-side session storage, but this is
a static site with no backend.

Options:
1. Use client-side localStorage (Pro: works immediately, Con: less secure)
2. Add a minimal backend API (Pro: secure, Con: infrastructure overhead)
3. Revise spec to use token-based auth (Pro: stateless, Con: changes scope)

Which approach should I take?
```

### Scenario: Scope Explosion

```
Blocker: The spec estimated 4 files, but implementing proper error
handling requires changes to 15+ files across 3 modules.

Options:
1. Implement minimal error handling in 4 files only
2. Expand scope to cover all 15 files properly
3. Split into two specs: core feature + comprehensive error handling

Which approach should I take?
```

### Scenario: Missing Prerequisite

```
Blocker: Spec requires integration with payment API, but no API
credentials exist in the project.

Options:
1. Use sandbox/test credentials for development
2. Wait for production credentials before implementing
3. Mock the payment API for now

Which approach should I take?
```

---

## After Decision

Once human provides direction:

1. **Update the spec** - add to "Revisions" section
2. **Document what changed** and why
3. **Proceed with implementation** using chosen approach

**Revision format**:
```markdown
## Revisions

### 2025-10-24
**Blocker**: [Brief description]
**Decision**: [Chosen approach]
**Rationale**: [Why this approach]
```

---

**See also**:
- `protocol/core.md` - State machine and workflow
- `protocol/specs.md` - How to document revisions in specs

**End of blockers.md**
