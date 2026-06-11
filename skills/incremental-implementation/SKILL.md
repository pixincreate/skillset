---
name: incremental-implementation
description: "Delivers changes incrementally. Use when implementing any feature or change that touches more than one file. Use when you're about to write a large amount of code at once, or when a task feels too big to land in one step."
triggers:
  - "incremental"
  - "vertical slice"
  - "multi-file change"
  - "large feature"
  - "step by step"
  - "increment"
---

# Incremental Implementation

## Why This Matters

A feature that touches ten files should not be written in one pass and tested at the end. When you implement everything at once and something breaks, you don't know which of the ten changes caused it. Incremental implementation means building in thin vertical slices — each one leaves the system in a working, testable state. Bugs surface at the slice that introduced them, not in a tangled 500-line diff.

## When to Apply

- Any multi-file change
- Building a new feature from a task breakdown
- Refactoring existing code
- Any time you're tempted to write 100+ lines before running tests

**Skip when:** single-file, single-function changes where scope is already minimal.

---

## Slicing Strategies

### Vertical Slices (Preferred)

Build one complete user-visible path through the stack per slice:

```
Slice 1: Create a task (DB → API → UI)
  → User can create a task via the UI. Tests pass.

Slice 2: List tasks (query → API → UI)
  → User can see their tasks. Tests pass.

Slice 3: Edit a task (update → API → UI)
  → User can modify tasks. Tests pass.

Slice 4: Delete (with confirmation)
  → Full CRUD complete. Tests pass.
```

Each slice delivers end-to-end functionality. No slice leaves the system broken.

### Contract-First Slicing

When backend and frontend develop in parallel:

```
Slice 0: Define API contract (types, interfaces, schema)
Slice 1a: Backend against contract + API tests
Slice 1b: Frontend against mock data matching contract
Slice 2: Integrate and test end-to-end
```

### Risk-First Slicing

Tackle the most uncertain piece first:

```
Slice 1: Prove WebSocket connects (highest risk)
Slice 2: Real-time updates on proven connection
Slice 3: Offline support and reconnection
```

If Slice 1 fails, you discover it before investing in Slices 2 and 3.

---

## Implementation Rules

### Rule 1: One Thing Per Increment

Each increment changes one logical thing. Don't mix:

**Bad:** One commit that adds a component, refactors an existing one, and updates build config.

**Good:** Three commits — one per change.

### Rule 2: Keep It Working

After each slice, the project must build and existing tests must pass. Never leave the codebase in a broken state between slices.

### Rule 3: Feature Flags for Incomplete Work

If a feature isn't ready for users but you need to merge:

```typescript
const ENABLE_TASK_SHARING = process.env.FEATURE_TASK_SHARING === 'true';

if (ENABLE_TASK_SHARING) {
  // New sharing UI — hidden behind flag
}
```

This lets you merge small increments without exposing incomplete work.

### Rule 4: Safe Defaults

New code defaults to conservative behavior:

```typescript
// Notify disabled by default — opt-in
export function createTask(data: TaskInput, options?: { notify?: boolean }) {
  const shouldNotify = options?.notify ?? false;
  // ...
}
```

### Rule 5: Rollback-Friendly

Each increment should be independently revertable:

- Additive changes (new files, new functions) are easiest to revert
- Modifications to existing code should be minimal and focused
- Each DB migration must have a corresponding rollback migration
- Don't delete and replace in the same commit — separate them

### Rule 6: Scope Discipline

Touch only what the task requires. Do NOT:
- "Clean up" adjacent code
- Refactor imports in files you're not modifying
- Remove comments you don't understand
- Add features not in scope

When you notice something outside scope, note it but don't fix it:

```
NOTICED BUT NOT TOUCHING:
- src/utils/format.ts: unused import (unrelated)
- Auth middleware: weak error messages (separate task)
→ Want these as separate tasks?
```

---

## The Increment Loop

```
For each slice:

1. Implement — smallest complete piece
2. Test — run test suite (write test if none exists)
3. Verify — tests pass, build succeeds
4. Commit — descriptive message
5. Next slice
```

### Working with Agents

When directing an agent to implement incrementally:

```
"Let's implement Task 3 from the plan. Start with just the
database schema change and the API endpoint. Don't touch UI yet.
After implementing, run `npm test` and `npm run build`."
```

Be explicit about scope boundaries for each increment.

---

## Common Traps

| "I'll test it all at the end" | Bugs compound. A bug in Slice 1 makes Slices 2-5 wrong. Test each slice. |
|---|---|
| "It's faster to do it all at once" | Feels faster until something breaks and you can't find which of 500 changed lines caused it. |
| "Small commits aren't worth it" | Small commits are free. Large commits hide bugs and make rollbacks painful. |
| "I'll add the feature flag later" | If it's not complete, it shouldn't be user-visible. Add the flag now. |
| "This refactor is small enough to include" | Refactors mixed with features make both harder to review and debug. Separate them. |

## Red Flags

- 100+ lines written without running tests
- Multiple unrelated changes in a single increment
- "Let me just quickly add this too" — scope creep
- Skipping the verify step to "move faster"
- Build broken between increments
- Large uncommitted changes accumulating
- Building abstractions before the third use case demands it
- Creating new utility files for one-time operations

## Verification

After completing all increments:

- [ ] Each increment was individually tested and committed
- [ ] Full test suite passes
- [ ] Build is clean
- [ ] Feature works end-to-end as specified
- [ ] No uncommitted changes remain
