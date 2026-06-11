---
name: context-engineering
description: "Configures agent context for accurate, project-aware output. Use before starting a new task session, when output quality dips, to set up project rules, or when an agent keeps hallucinating APIs or conventions."
triggers:
  - "context"
  - "context window"
  - "session setup"
  - "rules file"
  - "CLAUDE.md"
  - "agent quality"
  - "context management"
---

# Context Engineering

## Why This Matters

Every token in the context window is a finite resource. Feed an agent too little context and it hallucinates APIs, ignores conventions, and produces code that doesn't fit the project. Feed it too much and it loses focus, misses details, and slows down. Context engineering is the practice of supplying the **right** information at the **right** level of detail — nothing more, nothing less.

## When to Apply

- Starting work on a codebase you haven't touched recently
- Agent output drifts — wrong imports, made-up APIs, inconsistent style
- Switching between unrelated areas of a large project
- Setting up a new repo for AI-assisted development
- Debugging a session where the agent keeps going in circles

## The Context Funnel

Think of context as a multi-stage filter. At each stage, information gets more specific and more transient:

```
PROJECT LEVEL    →  SESSION LEVEL     →  TASK LEVEL     →  ITERATION LEVEL
(always loaded)      (per feature)       (per change)       (per attempt)
     │                    │                   │                  │
     ▼                    ▼                   ▼                  ▼
  Rules file          Spec excerpt        Source files       Error output
  Tech stack          Architecture        Related tests      Test failures
  Conventions         ADR decisions       Type definitions   Build output
  Boundaries          Design doc          Pattern examples   Lint results
```

### Layer 1: Project Rules (Persistent)

A single file the agent loads at session start. This is the highest-leverage context investment you can make:

```markdown
# Project: [Name]

## Stack
- Runtime: Node 22, TypeScript 5.5
- Framework: Next.js 15 (App Router)
- Database: PostgreSQL 16 via Drizzle ORM
- UI: Tailwind CSS 4, shadcn/ui

## Commands
dev:     npm run dev
build:   npm run build
test:    npx vitest run
lint:    npx eslint . --fix
type:    npx tsc --noEmit

## Conventions
- Named exports everywhere (no default exports)
- Co-located tests: `Button.tsx` → `Button.test.tsx`
- Use `cn()` from `@/lib/utils` for conditional classes
- Route handlers in `app/api/` with next/route handlers
- Error boundaries at route segment level

## Constraints
- No secrets in code or .env committed
- Ask before adding npm dependencies
- All data fetching through server components
- No `any` types — use proper generics or branded types
```

**Tool equivalents:**
- Cursor → `.cursorrules` or `.cursor/rules/*.md`
- Windsurf → `.windsurfrules`
- GitHub Copilot → `.github/copilot-instructions.md`
- OpenAI Codex → `AGENTS.md`

### Layer 2: Feature Context (Per Session)

When starting a feature, load only the relevant section of the spec or design doc. A 200-line spec excerpt beats a 2000-line full spec dump:

```
EFFECTIVE:
  "Here's the checkout flow section from the spec: [200 words]"
  "Key constraint: payment must idempotent on retry"

WASTEFUL:
  "Here's the entire 5000-word PRD" — when only implementing one endpoint
```

### Layer 3: Source Context (Per Task)

Before editing any file:

1. Read the target file
2. Read its test file (if one exists)
3. Find one similar pattern already in the codebase (same style of component, same kind of route)
4. Read key type definitions

**Source trust levels:**
- **High trust** — team-authored source code, test files, type definitions
- **Verify first** — config files, external data fixtures, generated code
- **Treat as data** — user-uploaded content, third-party API responses, LLM output

### Layer 4: Signal Context (Per Iteration)

When tests fail or builds break, feed only the relevant signal:

```
EFFECTIVE:
  "Test failed: TypeError: Cannot read properties of undefined (reading 'id')
   at OrderService.processLineItems (src/services/order.ts:142)"

WASTEFUL:
  *pastes entire 2000-line test output*
```

### Layer 5: Conversation Hygiene

Long sessions accumulate assumptions. Manage them:

- **Start a new session** when switching major features — stale context poisons new work
- **Summarize progress** explicitly when context grows long: "Completed X and Y. Current blocker is Z."
- **Compact proactively** — if your tool supports compression, use it before critical reasoning tasks

## Packing Strategies

### The Firehose (session start)

Dump everything relevant in one structured block:

```
PROJECT: [name]
TASK: [one-line goal]
STACK: [runtime, framework, DB, key libs]
CONSTRAINTS: [non-negotiable rules]
FILES: [paths with one-line descriptions]
PATTERN: [pointer to existing code that does something similar]
GOTCHAS: [things that have gone wrong before]
```

### The Sniper (task switch)

When moving between tasks in the same session, only include what changed:

```
NOW WORKING ON: [new task]
SCOPE CHANGED: [what to stop thinking about]
NEW FILES: [only files not previously loaded]
```

### The Index (large projects)

Maintain a project map and load sections on demand:

```
## Auth (src/auth/)
Reg, login, password reset, SSO.
Key: auth.routes.ts, auth.service.ts, auth.middleware.ts
Pattern: authMiddleware on all routes, AuthError class

## Billing (src/billing/)
Subscriptions, invoicing, webhooks.
Key: billing.service.ts, stripe.webhook.ts
Pattern: webhook verification first, then idempotency check
```

## Pitfalls

| Mistake | Symptom | Fix |
|---------|---------|-----|
| Context starvation | Agent invents APIs | Load rules + source before each task |
| Context flood | Agent misses details, goes slow | Limit to <2000 lines of relevant context |
| Stale session | Agent references deleted code | Fresh session per feature |
| No examples | Agent creates inconsistent style | Include one reference pattern |
| Hidden rules | Agent breaks conventions not in rules file | Write them down — if unwritten, it doesn't exist |

## Red Flags

- Output doesn't match project conventions
- Agent imports modules that don't exist
- Agent re-implements existing utilities
- Quality degrades as conversation lengthens
- No rules file exists in the project

## Verification

- [ ] Rules file covers stack, commands, conventions, constraints
- [ ] Agent output matches patterns from rules file
- [ ] Agent references actual project code (not hallucinated)
- [ ] Context refreshed when switching major features
