---
name: code-simplification
description: "Simplifies code for clarity. Use when refactoring code for clarity without changing behavior. Use when code works but is harder to read, maintain, or extend than it should be. Use when reviewing code that has accumulated unnecessary complexity."
triggers:
  - "simplify code"
  - "refactor"
  - "code clarity"
  - "complexity"
  - "clean up code"
  - "readability"
---

# Code Simplification

## Why This Matters

Complexity is not inevitable — it's accumulated. Every guard clause that could be a return, every ternary chain that could be a lookup table, every wrapper that just forwards to another function — each one is a small tax on the next person who reads this code. The goal is not fewer lines. It's faster comprehension. A piece of code is "simpler" when a new team member understands it in one pass instead of two.

## When to Apply

- After a feature works and tests pass, but the implementation feels heavier than it needs to
- During review when readability issues are flagged
- When you find deeply nested logic, long functions, or generic names
- When consolidating duplicated logic scattered across files

**Skip when:** the code is already clean, you don't understand what it does yet, the change would measurably degrade performance, or you're about to rewrite the module anyway.

## The Simplification Funnel

Every simplification passes through four gates before it lands:

### Gate 1: Understand First (Chesterton's Fence)

If you see a fence across a road and don't know why it's there, don't tear it down. First understand why it exists, then decide if the reason still applies.

```
BEFORE TOUCHING ANYTHING:
→ What is this code's responsibility?
→ What calls it and what does it call?
→ What are the edge cases and error paths?
→ Check git blame — why was it written this way?
→ Are there tests that define expected behavior?
```

Can't answer these? Read more context. Simplifying code you don't understand produces bugs, not clarity.

### Gate 2: Preserve Behavior Exactly

Don't change what the code does — only how it expresses it. Inputs, outputs, side effects, error behavior, and ordering must remain identical.

```
ASK: Does this produce the same output for every input?
     Does it maintain the same error behavior?
     Do all existing tests pass without modification?
```

If you're not sure a change preserves behavior, don't make it.

### Gate 3: Match Project Conventions

Simplification means making code more consistent with the codebase, not imposing external preferences. Before rewriting:

1. Read the project rules / conventions file
2. Study how neighboring code handles similar patterns
3. Match the project's import style, error handling, naming, and annotation depth

Simplification that breaks project consistency is churn, not improvement.

### Gate 4: Scope to What Changed

Default to simplifying recently modified code. Avoid drive-by refactors of unrelated code unless explicitly asked. Unscoped simplification creates noisy diffs and risks regressions.

---

## Signal Catalog

Each row is a concrete pattern to detect and a specific fix to apply.

### Structural Signals

| When you see... | The problem is... | The fix is... |
|---|---|---|
| 3+ levels of nesting | Control flow is hard to follow | Extract conditions into guard clauses or helper functions |
| 50+ line function | Multiple responsibilities | Split into focused functions with descriptive names |
| Nested ternary chain | Requires mental stack to parse | Replace with if/else, switch, or lookup object |
| Boolean parameters | `call(true, false, true)` — meaningless at call site | Options object or separate functions |
| Same condition in 5 places | Logic is duplicated, not centralized | Extract to a well-named predicate function |

### Naming and Readability Signals

| When you see... | The problem is... | The fix is... |
|---|---|---|
| `data`, `result`, `temp`, `val`, `item` | Says nothing about content | Rename to describe the content: `userProfile`, `validationErrors` |
| `usr`, `cfg`, `btn`, `evt` | Abbreviation saves 3 characters, costs 3 seconds of parsing | Use full words (except universal ones: `id`, `url`, `api`) |
| Comment says *what* | `// increment counter` above `count++` | Delete the comment — code is clear enough |
| Comment says *why* | `// Retry because the API is flaky under load` | **Keep it** — carries intent code can't express |

### Redundancy Signals

| When you see... | The problem is... | The fix is... |
|---|---|---|
| Same 5 lines in 3 places | Logic is duplicated | Extract to a shared function |
| Unreachable branches, unused variables, commented-out blocks | Dead code | Remove (after confirming it's truly dead) |
| Factory-for-a-factory, strategy-with-one-strategy | Over-engineering | Replace with the simple direct approach |
| Casting to a type that's already inferred | Noise | Remove the assertion |

---

## Language-Specific Examples

### TypeScript / JavaScript

```typescript
// Remove unnecessary async wrapper
// Before
async function getUser(id: string): Promise<User> {
  return await userService.findById(id);
}
// After
function getUser(id: string): Promise<User> {
  return userService.findById(id);
}

// Condense verbose assignment
// Before
let displayName: string;
if (user.nickname) {
  displayName = user.nickname;
} else {
  displayName = user.fullName;
}
// After
const displayName = user.nickname || user.fullName;

// Replace manual iteration with array method
// Before
const activeUsers: User[] = [];
for (const user of users) {
  if (user.isActive) {
    activeUsers.push(user);
  }
}
// After
const activeUsers = users.filter((u) => u.isActive);

// Flatten boolean return
// Before
function isValid(input: string): boolean {
  if (input.length > 0 && input.length < 100) return true;
  return false;
}
// After
function isValid(input: string): boolean {
  return input.length > 0 && input.length < 100;
}
```

### Python

```python
# List comprehension replaces manual building
# Before
result = {}
for item in items:
    result[item.id] = item.name
# After
result = {item.id: item.name for item in items}

# Guard clauses replace nested ifs
# Before
def process(data):
    if data is not None:
        if data.is_valid():
            if data.has_permission():
                return do_work(data)
            else:
                raise PermissionError("No permission")
        else:
            raise ValueError("Invalid data")
    else:
        raise TypeError("Data is None")
# After
def process(data):
    if data is None:
        raise TypeError("Data is None")
    if not data.is_valid():
        raise ValueError("Invalid data")
    if not data.has_permission():
        raise PermissionError("No permission")
    return do_work(data)
```

### React / JSX

```tsx
// Extract variant selection from conditional rendering
// Before
function UserBadge({ user }: Props) {
  if (user.isAdmin) return <Badge variant="admin">Admin</Badge>;
  return <Badge variant="default">User</Badge>;
}
// After
function UserBadge({ user }: Props) {
  const variant = user.isAdmin ? 'admin' : 'default';
  const label = user.isAdmin ? 'Admin' : 'User';
  return <Badge variant={variant}>{label}</Badge>;
}
```

---

## The Rule of 500

If a refactoring touches more than 500 lines, stop. Invest in automation — codemods, AST transforms, or scripts — rather than manual edits. At that scale, manual changes are error-prone and exhausting to review.

---

## Common Traps

| "It's working, no need to touch it" | Working code that's hard to read will be hard to fix when it breaks. |
|---|---|
| "Fewer lines is always simpler" | A one-line nested ternary is not simpler than a five-line if/else. Comprehension speed, not line count. |
| "I'll clean up unrelated code too" | Unscoped changes create noisy diffs and risk regressions. Stay focused. |
| "The types make it self-documenting" | Types document structure, not intent. A well-named function explains *why*. |
| "This abstraction might be useful later" | Code that doesn't exist has no bugs. Remove it, re-add when needed. |
| "The original author had a reason" | Maybe — check git blame. But complexity is often just residue from iteration under pressure. |

## Red Flags

- Simplification that requires modifying tests (you changed behavior)
- "Simplified" code that's longer or harder to follow than the original
- Renaming to personal preference rather than project conventions
- Removing error handling because "it makes the code cleaner"
- Simplifying code you don't fully understand
- Batching many changes into one un-reviewable diff

## Verification

- [ ] All existing tests pass without modification
- [ ] Build succeeds with no new warnings
- [ ] Linter clean — no style regressions
- [ ] Each change is reviewable and incremental
- [ ] Diff is clean — no unrelated changes mixed in
- [ ] Simplified code follows project conventions
- [ ] No error handling was removed or weakened
- [ ] No dead code left behind
