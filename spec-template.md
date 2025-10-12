# Spec Template

**Purpose**: Format reference for creating specs. Copy and fill in when creating a new spec.

**File naming**: `YYYYMMDD-feature-name.md` (e.g., `20251012-add-user-auth.md`, `20251013-add-search.md`)
- `YYYYMMDD`: Date in ISO format (year-month-day)
- `feature-name`: Lowercase, kebab-case

---

## Example Spec

This shows what a well-written spec looks like. Use this as a reference when creating your own specs.

```markdown
# 20251012: Add User Authentication

> **Otto Protocol**: See `aux/protocol.md` for workflow and state machine details.

**Status**: In Progress

## Intent

Add email/password login so users can access their saved content. This enables personalized experiences and protects user data.

## Technical Approach _(optional)_

- Pattern: Follow existing authentication pattern from `UserSession.ts`
- Architecture: Client-side validation, server-side enforcement
- Integration: Extend current session management rather than replacing it

## Testing Approach _(optional)_

- Unit tests: AuthService.validateCredentials(), hashPassword()
- Integration tests: Full login flow with database
- Manual verification: Session persists across browser refresh

## Success Criteria

- [ ] Users can register with email and password
- [ ] Users can log in with existing credentials
- [ ] Users can log out
- [ ] Password is hashed before storage
- [ ] Invalid credentials show appropriate error messages
- [ ] Session persists across page navigations

## Context _(optional)_

Use JWT for session management. Need password hashing with bcrypt. Consider rate limiting on login attempts to prevent brute force attacks.

## Implementation Notes _(AI fills during implementation)_

- Decision: Used JWT tokens with 7-day expiration
- Gotcha: Remember to set httpOnly flag on cookies to prevent XSS attacks

## Revisions _(optional, added if spec changes during implementation)_

### 2025-10-12
**What changed**: Added OAuth support alongside email/password
**Why**: User feedback indicated many prefer social login for convenience

## Completion

**Completed**: 2025-10-13
```

---

## Mandatory Sections

These MUST be present in every spec:
- **Title** (in filename and heading): YYYYMMDD: Descriptive feature name
- **Status**: Current state (In Progress, Completed)
- **Intent**: Why we're building this
- **Success Criteria**: How we know it's done

## Writing Good Success Criteria

Success criteria should be concrete and testable, but not overly detailed. Focus on user-facing outcomes and key technical requirements.

**See `protocol.md` section "Success Criteria Guidelines" (lines 289-314) for detailed examples and best practices.**

**Quick guidelines:**
- Aim for 3-7 criteria per spec (Small features: 3-4, Medium: 5-7)
- Focus on what users can do, not how it's implemented
- Include key technical requirements (security, performance, data integrity)
- Each criterion should be independently verifiable
- If you have 10+ criteria, consider splitting the spec

## Optional Sections

Include when relevant:
- **Technical Approach**: High-level architectural decisions and patterns
- **Testing Approach**: What tests are needed and how to verify
- **Context**: Background info, constraints
- **Implementation Notes**: Technical details (AI adds during work)
- **Revisions**: Changes made after initial approval

---

**End of spec-template.md**
