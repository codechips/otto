# Otto Protocol - Specs

**Version**: 2.0
**Module**: Spec format and success criteria guidelines

---

## Spec Files

### Location
- **Active**: `aux/specs/`
- **Completed**: `aux/done/`

### Naming Convention
`YYYYMMDD-feature-name.md`

- `YYYYMMDD`: Date in ISO format (e.g., 20251012)
- `feature-name`: Lowercase, kebab-case, descriptive

**Examples**:
- `20251012-add-user-auth.md`
- `20251013-optimize-search.md`

---

## Mandatory Sections

Every spec MUST include:

### Title
`# YYYYMMDD: Feature Name`

### Status
"In Progress" or "Completed"

### Intent
Why we're building this, what problem it solves

### Success Criteria
Concrete, testable checkpoints (3-7 items)

---

## Optional Sections

Include when relevant:

- **Technical Approach**: High-level architectural decisions
- **Testing Approach**: What tests are needed
- **Context**: Background information, constraints
- **Implementation Notes**: Details added during work
- **Revisions**: Changes made after initial approval

**Format reference**: See `spec-template.md` for full examples

---

## Success Criteria Guidelines

Success criteria define "done" and must be:
- **Concrete**: Specific enough to verify
- **Testable**: Can be checked objectively
- **User-focused**: Emphasize outcomes, not implementation details
- **Scoped**: 3-7 criteria per spec (if 10+, consider splitting)

### Examples

**Too vague:**
- [ ] Users can authenticate
- [ ] System is faster

**Too detailed:**
- [ ] Login form has email field with type="email"
- [ ] Login form has password field with type="password"
- [ ] Submit button is disabled when fields empty

**Just right:**
- [ ] Users can log in with email/password
- [ ] Invalid credentials show error message
- [ ] Session persists across page navigations

---

## Guidelines by Feature Size

### Small features (3-4 criteria)
Focus on core functionality only
```
- [ ] Core feature works
- [ ] Error states handled
- [ ] Tests pass
```

### Medium features (5-7 criteria)
Add integration and edge cases
```
- [ ] Core functionality works
- [ ] Integrates with existing system X
- [ ] Error states handled appropriately
- [ ] Edge case Y handled
- [ ] Performance meets requirements
- [ ] Tests cover main flows
```

### Large features (8+ criteria)
**Stop and split into multiple specs**

If you find yourself writing 10+ success criteria, the feature is too large. Split it into smaller, focused specs.

---

**See also**:
- `aux/protocol/core.md` - State machine and workflow
- `aux/spec-template.md` - Complete example spec

**End of specs.md**
