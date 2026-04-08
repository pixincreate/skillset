---
name: refactor-path
description: Plan and execute refactors safely by creating a step-by-step path from current state to target state. Use when user wants to refactor code, plan a rewrite, or needs help with refactoring strategy.
---

# Refactor Path

Plan and execute refactors safely with a step-by-step path from current to target state.

## Overview

This skill helps plan:
- Incremental refactors
- Large-scale rewrites
- Pattern migrations
- Code organization improvements
- Technical debt reduction

## Refactor Strategy

### Phase 1: Assess

1. **Understand current state**
   - What does the code do?
   - How is it used?
   - What's broken/risky?

2. **Define target state**
   - What should it look like?
   - What problems does it solve?
   - What's the win?

3. **Map the gap**
   - What's different?
   - What's the risk per change?
   - What's the easiest first step?

### Phase 2: Plan

Create a step-by-step path:

```
Step 1: [Safe, measurable]
Step 2: [Builds on step 1]
Step 3: [ ... ]
...
Target: [Final state]
```

**Rules:**
- Each step should be independently testable
- Each step should leave system working
- Each step should reduce risk for next step
- Never do more than 1 "hard" step at a time

### Phase 3: Execute

1. **Run tests first** — establish baseline
2. **Make smallest step first** — prove approach
3. **Test after each step** — verify nothing broke
4. **Commit after each step** — checkpoint progress
5. **Measure impact** — did it help?

## Common Refactor Patterns

### 1. Extract and Delegate

```
Before: Big function does everything
After:  Big function delegates to smaller functions
```

Steps:
1. Identify logical chunks
2. Create extracted functions (callers unchanged)
3. Redirect calls to new functions
4. Remove original implementation

### 2. Rename and Dealias

```
Before: Confusing names, scattered usage
After:  Clear names, centralized usage
```

Steps:
1. Add new names alongside old
2. Update all references to new names
3. Remove old names
4. Verify no dead code

### 3. Parallel Implementation

```
Before: Old system
After:  New system side-by-side, traffic migrated
```

Steps:
1. Build new system alongside old
2. Instrument both for comparison
3. Route small percentage to new
4. Increase traffic gradually
5. Remove old when stable

### 4. Strangler Fig

```
Before: Monolithic code
After:  Modular with clear boundaries
```

Steps:
1. Identify module boundary
2. Create new module
3. Route new functionality to new module
4. Migrate existing functionality one piece at a time
5. Remove old implementation when empty

### 5. Feature Flag Rollout

```
Before: All-or-nothing deployment
After:  Gradual rollout with kill switch
```

Steps:
1. Implement new behavior with flag
2. Default flag to old behavior
3. Enable for small percentage
4. Monitor for issues
5. Increase percentage
6. Remove flag when stable

## Decision Framework

When planning, answer:

| Question | Why It Matters |
|----------|----------------|
| What's the risk of NOT doing this? | Justifies effort |
| What's the simplest first step? | Gets momentum |
| How do we verify it works? | Confidence |
| How do we rollback? | Safety |
| What's the test coverage? | Risk |
| Who's affected? | Communication |

## Warning Signs

Stop and reassess if:
- More than 10 steps planned
- Any step takes more than 4 hours
- Breaking changes cluster together
- No test coverage for affected code
- You can't explain the target state simply

## Rollback Protocol

Always know:
- What commit to revert to?
- How to verify rollback worked?
- What data might need cleanup?
- Who to notify?

## Output Format

For each refactor:

```
## Current State
[Description + file locations]

## Target State
[Description + what improves]

## Path
| Step | Description | Files | Risk | Test |
|------|-------------|-------|------|------|
| 1 | ... | ... | Low | ... |
| 2 | ... | ... | Medium | ... |

## Rollback
[How to undo]

## Success Criteria
[How to know done]
```
