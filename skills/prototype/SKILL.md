---
name: prototype
description: Build throwaway code that answers one design question — a single shareable HTML demo for state/logic questions, or several radically different UI variants switchable on one route. Use when sanity-checking whether a state model feels right, or exploring what a UI should look like before committing.
triggers:
  - "prototype"
  - "try out an idea"
  - "what would this look like"
  - "play with this state machine"
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

- **"Does this logic / state model feel right?"** → [reference/logic.md](reference/logic.md). One self-contained HTML file anyone can drive by clicking buttons.
- **"What should this look like?"** → [reference/ui.md](reference/ui.md). Several radically different UI variants on one route, switchable via `?variant=`.

Getting this wrong wastes the whole prototype. Genuinely ambiguous and user unreachable? Default to whichever matches the surrounding code (backend module → logic; page/component → UI) and state the assumption at the top of the prototype.

## Rules both branches obey

1. **Throwaway from day one, visibly.** Locate near the code it prototypes for, but named so a casual reader sees it's a prototype.
2. **Trivial to run.** One command, or double-click. No thinking to start.
3. **No persistence by default.** In-memory state; persistence is only allowed when it's the thing being checked (scratch DB / clearly-named local file).
4. **Skip polish.** No tests, no error handling beyond runnable, no abstractions. Learn fast.
5. **Surface the state.** After every action / variant switch, show full relevant state so changes are visible.
6. **Capture it when done.** Fold validated decisions into real code; commit the prototype itself to a **throwaway branch** (never main) as a primary source, with a pointer from the issue/commit. Capture the verdict too.

## Related Skills

- **rapidfire** - If the design question itself needs resolving first
- **brainstorming** - For exploring intent before deciding a demo is worth building
- **frontend-design** / **interface-design** - For building the production version once the question is answered
- **architecture** - For recording what the prototype taught as a lasting decision
