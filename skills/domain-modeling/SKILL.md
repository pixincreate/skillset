---
name: domain-modeling
description: Build and sharpen a project's domain model as you work — challenge terms against the glossary, invent edge-case scenarios to force precision, and capture resolved terms in CONTEXT.md and real trade-offs in ADRs the moment they crystallize. Use when discussing codebase terminology, writing/editing CONTEXT.md, or recording architecture decisions.
triggers:
  - "domain model"
  - "glossary"
  - "ubiquitous language"
  - "shared language"
  - "CONTEXT.md"
  - "ADR"
  - "architecture decision record"
---

# Domain Modeling

Actively build and sharpen the project's domain model while you design. This is the *active* discipline: challenging terms, stress-testing with scenarios, and writing the glossary down the moment it crystallizes. (Merely *reading* `CONTEXT.md` for vocabulary is not this skill — that's a habit any skill can have. Use this when you're changing the model, not consuming it.)

A shared language pays off session after session: consistent names, easier navigation, fewer tokens spent decoding jargon.

## File layout

Most repos have one context:

```
/
├── CONTEXT.md          # glossary ONLY — no implementation details
├── docs/adr/           # architecture decision records
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

If `CONTEXT-MAP.md` exists at the root, the repo has multiple contexts; follow the map to the right per-context `CONTEXT.md` and its own `docs/adr/`.

Create files lazily: first resolved term creates `CONTEXT.md`, first qualifying decision creates `docs/adr/`.

## During the session

### Challenge against the glossary
The user uses a term that conflicts with existing language? Call it out immediately: "The glossary defines 'cancellation' as X, but you seem to mean Y. Which is it?"

### Sharpen fuzzy language
Vague or overloaded terms get a precise canonical proposal: "You keep saying 'account' — Customer or User? Those are different things."

### Stress-test with concrete scenarios
When relationships between concepts come up, invent specific edge-case scenarios that force precision about boundaries: "Can an order be partially cancelled? Walk me through that exact case."

### Cross-reference with code
When the user states how something works, check the code agrees. Surface contradictions: "The code cancels entire Orders, but you just said partial cancellation exists. Which is right?"

### Update CONTEXT.md inline
Resolved term → update `CONTEXT.md` right then. Never batch. `CONTEXT.md` is a glossary and nothing else: no specs, no scratch notes, no implementation detail.

### Offer ADRs sparingly
Only offer an ADR when ALL three hold:

1. **Hard to reverse** — changing your mind later costs meaningfully
2. **Surprising without context** — a future reader will ask "why this way?"
3. **A real trade-off** — genuine alternatives existed and one was picked for stated reasons

Any one missing → skip the ADR. Format: numbered file (`NNNN-slug.md`), context / decision / consequences.

## Related Skills

- **zoom-out** - Consumes the glossary for orientation; this skill produces it
- **codebase-exploration** - Companion structural mapping; run both when onboarding to an unfamiliar repo
- **architecture** - For system-level design where ADR-worthy trade-offs originate
- **spec-writer** - For documents that must use the canonical terms consistently
