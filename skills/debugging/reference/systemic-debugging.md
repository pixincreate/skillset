# Systemic Debugging Reference

Rigorous root cause analysis methodology.

## Core Principle

**The Iron Law: NO FIXES WITHOUT ROOT CAUSE**

Don't treat symptoms. Find and fix the underlying problem.

---

## The Four Phases

### 1. Root Cause Discovery

Understand WHY the bug exists before thinking about fixes.

Questions to ask:
- What changed?
- When did it start?
- What's the actual vs expected behavior?
- Can I reproduce it consistently?

### 2. Pattern Analysis

Look for patterns in the bug behavior:
- Does it happen in specific conditions?
- Is it consistent or intermittent?
- Are there related failures?
- What's common across failures?

### 3. Hypothesis Formation

Form specific, testable hypotheses:
- "The bug happens because X"
- "Changing Y should fix it"
- Test one hypothesis at a time

### 4. Implementation

Only implement after root cause is confirmed:
- Fix the root cause, not symptoms
- Add tests to prevent regression
- Verify fix works

---

## The 3+ Failed Fixes Rule

If you've attempted 3+ fixes without success:
**STOP. This is likely an architectural problem.**

Re-evaluate:
- Are you treating symptoms?
- Is there a design issue?
- Do you understand the root cause?

---

## Rationalizations (Don't Do These)

| Instead of... | Do this |
|---------------|---------|
| "I'll try this fix" | Find root cause first |
| "It seems to work now" | Verify properly |
| "It's probably a race condition" | Prove it |
| "I'll add a workaround" | Find the real fix |
| "It works in dev" | Understand why it differs |

---

## Verification Checklist

Before declaring bug fixed:

- [ ] Root cause identified and understood
- [ ] Fix addresses root cause
- [ ] Bug cannot be reproduced
- [ ] Related scenarios work
- [ ] No regressions introduced
- [ ] Test added to prevent recurrence

---

## Anti-patterns

- Fixing symptoms not causes
- Not reproducing before fixing
- Making changes without understanding
- Skipping verification
- Not adding regression tests

---

## Best Practices

1. **Reproduce first** - If you can't reproduce, you can't verify
2. **One change at a time** - Test each change individually
3. **Document findings** - Write down what you learned
4. **Verify thoroughly** - Test related functionality
5. **Add tests** - Prevent future regressions
