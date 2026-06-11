---
name: doubt-driven-development
description: "Subjects every non-trivial decision to a fresh-context adversarial review before it stands. Use when correctness matters more than speed, when working in unfamiliar code, when stakes are high (production, security-sensitive logic, irreversible operations), or any time a confident output would be cheaper to verify now than to debug later."
triggers:
  - "doubt"
  - "adversarial review"
  - "verify reasoning"
  - "check assumptions"
  - "hallucinating"
  - "review decision"
  - "cross-check"
---

# Doubt-Driven Development

## Why This Matters

Long sessions turn assumptions into facts without anyone noticing. A pattern that looked right in isolation quietly becomes the foundation for five more decisions, and nobody stops to ask "is the first one actually correct?" Doubt-driven development means materializing a reviewer biased to **disprove** — not approve — before a non-trivial decision hardens into committed code. It's not `/review` (a verdict on a finished artifact). It's an in-flight posture: catch wrong turns while course correction is still cheap.

## When to Apply

A decision is **non-trivial** if any of these hold:

- Introduces or modifies branching logic
- Crosses a module or service boundary
- Asserts a property the type system can't verify (thread safety, idempotence, ordering)
- Correctness depends on context a future reader can't see
- Blast radius is irreversible (production deploy, data migration, public API change)

Apply when:
- About to make an architectural decision under uncertainty
- About to commit non-trivial code
- About to claim something non-obvious ("this is safe", "this scales")
- Working in code you don't fully understand

**Skip when:** mechanical operations (rename, format, file moves), following a clear user instruction, one-line changes, pure tooling.

If you doubt every keystroke, you ship nothing. This applies only to the definition above.

---

## The Doubt Cycle

### Step 1: Name the Claim

Write the decision in two or three lines:

```
CLAIM: "The caching layer is thread-safe under the
        read-heavy workload in the spec."
WHY: A race here corrupts user data and is
     hard to detect in QA.
```

If you can't write the claim that compactly, you have a vibe, not a decision. Surface it before scrutinizing it.

### Step 2: Extract the Reviewable Unit

A reviewer needs two things and nothing else:

- **ARTIFACT** — the diff, the function, the decision in 3–5 sentences
- **CONTRACT** — what it must satisfy (constraints, invariants)

Strip your reasoning. If you hand over conclusions, you get back validation of those conclusions. The unit must fit in one mental pass — if it's a 500-line PR, decompose first.

### Step 3: Doubt — Adversarial Review

**Do NOT pass the CLAIM.** The reviewer must independently determine whether the artifact satisfies the contract.

```
Adversarial review. Find what is wrong with this artifact.
Assume the author is overconfident. Look for:
- Unstated assumptions
- Edge cases not handled
- Hidden coupling or shared state
- Ways the contract could be violated
- Existing conventions this might break
- Failure modes under unexpected input

Do NOT validate. Do NOT summarize. Find issues, or state
explicitly that you cannot find any after thorough examination.

ARTIFACT: <paste artifact>
CONTRACT: <paste contract>
```

#### Cross-model escalation

A single-model reviewer shares blind spots with the original author. A cold, different-architecture model catches them.

**Interactive:** After single-model review, offer alternatives:

> *"Single-model review done. Want a second opinion? Options: Gemini CLI, Codex CLI, manual paste elsewhere, or skip."*

If user picks a CLI:
1. Verify it's in PATH and works
2. Confirm exact invocation with user
3. Pass ARTIFACT + CONTRACT + adversarial prompt **only** — no session context, no CLAIM
4. Pipe through stdin — never shell-quote the artifact

**Non-interactive:** Skip cross-model. Announce the skip.

### Step 4: Reconcile Findings

The reviewer's output is data, not verdict. You are still the orchestrator. Classify each finding in this order:

1. **Contract misread** — reviewer flagged something because CONTRACT was unclear. Fix the contract, re-classify.
2. **Valid + actionable** — real issue requiring a change. Change it, re-loop.
3. **Valid trade-off** — issue is real but cost of fixing exceeds cost of accepting. Document it.
4. **Noise** — correct under context the reviewer didn't have. Note it, move on.

### Step 5: Stop

Stop when:
- Next iteration returns only trivial or already-considered findings, **or**
- 3 cycles completed (escalate to user, don't grind a fourth alone), **or**
- User says "ship it"

If 3 cycles is "obviously insufficient" because the artifact is too large: decompose and re-loop. Do not lift the bound.

---

## Common Traps

| "I'm confident, skip the doubt step" | Confidence and correctness are uncorrelated on novel problems. Blind spots hide at exactly the moment of certainty. |
|---|---|
| "Spawning a reviewer costs tokens" | Debugging a wrong commit in production costs more. The check is bounded; the bug isn't. |
| "The reviewer will just nitpick" | Only if unscoped. Constrain to "issues that make this fail under the contract." |
| "I'll doubt at the end with /review" | /review is too late. Doubt-driven catches wrong directions early when correction is cheap. |
| "If I doubt every step I'll never ship" | Re-read "When to Apply." This is for non-trivial decisions only. |
| "The reviewer disagreed so I was wrong" | The reviewer lacks your context. Disagreement is information, not verdict. Classify, then decide. |

## Red Flags

- Spawning a reviewer for a one-line rename
- Treating reviewer output as authoritative without re-reading the artifact
- Looping >3 cycles without escalating
- Prompting "is this good?" instead of "find issues"
- **Doubt theater**: substantive findings across 2+ cycles, zero classified as actionable
- **Silently skipping cross-model in interactive mode**
- Passing the CLAIM to the reviewer (biases agreement)
- Doubting only after committing — that's /review, not doubt-driven

## Related Skills

- **source-driven-development**: verifies facts about frameworks against official docs. Doubt-driven verifies *your reasoning about the artifact*.
- **testing**: TDD's RED step is doubt made concrete — a failing test is a disproof attempt.
- **diagnose**: when the reviewer surfaces a real failure mode, drop into diagnose to localize and fix.

## Verification

- [ ] Every non-trivial decision was named as a CLAIM before standing
- [ ] At least one fresh-context review per non-trivial artifact
- [ ] Reviewer received ARTIFACT + CONTRACT — NOT the CLAIM or your reasoning
- [ ] Reviewer's prompt was adversarial ("find issues"), not validating ("is it good")
- [ ] Findings were classified against the artifact text (not rubber-stamped)
- [ ] Stop condition met (trivial findings, 3 cycles, or user override)
- [ ] Interactive: cross-model explicitly offered
- [ ] Non-interactive: cross-model skip announced
