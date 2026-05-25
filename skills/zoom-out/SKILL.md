---
name: zoom-out
description: Tell the agent to zoom out and give broader context or a higher-level perspective on an unfamiliar section of code. Use when you're unfamiliar with a section of code, need to understand how it fits into the bigger picture, or want a system-level view.
triggers:
  - "zoom out"
  - "broader context"
  - "bigger picture"
  - "how does this fit"
  - "system overview"
  - "explain this module"
  - "what calls this"
  - "what does this call"
---

# Zoom-Out: Broader Context

I don't know this area of code well. Go up a layer of abstraction. Give me a map of all the relevant modules and callers.

## What To Provide

### 1. Module Map

List:

- **This module**: What it does (1 sentence)
- **Callers**: What calls this module (incoming)
- **Dependencies**: What this module calls (outgoing)
- **Siblings**: Related modules at the same level

### 2. Data Flow

Show how data moves:

- What goes in
- What transformations happen
- What comes out
- Where it goes next

### 3. Domain Vocabulary

Use the project's domain glossary from `CONTEXT.md` if it exists. If terms are unclear, note that.

### 4. Key Files

List the key files/directories with 1-line descriptions.

## Example Output

```
## Zoom-Out: auth middleware

**What this module does**: Authenticates incoming HTTP requests via JWT tokens.

**Callers (incoming)**:
- `src/server.ts` - mounts this middleware on `/api/*` routes
- `src/routes/admin.ts` - uses a stricter variant for admin endpoints

**Dependencies (outgoing)**:
- `src/lib/jwt.ts` - token verification
- `src/db/users.ts` - fetching user by ID from token payload
- `src/lib/logger.ts` - auth failures

**Data Flow**:
1. Request arrives with `Authorization: Bearer <token>` header
2. Middleware extracts and verifies JWT
3. If valid: fetches user, attaches to `req.user`, calls `next()`
4. If invalid: returns 401, logs the failure

**Key Files**:
- `src/middleware/auth.ts` - MAIN: this is the file
- `src/lib/jwt.ts` - token handling
- `src/server.ts` - where middleware is mounted
```

## If CONTEXT.md Exists

Check for `CONTEXT.md` at the repo root (or mapped contexts). Use the domain vocabulary from it. If terms conflict, surface the conflict.

## If Unclear

If you genuinely can't figure out the broader structure:

1. Say what you DO understand
2. List what's unclear
3. Suggest files the user might want to point you to

---

## Related Skills

- **codebase-exploration** - For full structural documentation (creates CLAUDE.md files)
- **research** - For broader research including tech evaluation, APIs, external docs
- **architecture** - For system-level design decisions
