---
name: diagnose
description: Debugging discipline for all bugs. Two paths: (1) Quick Path for obvious bugs (typo, syntax, clear stack trace); (2) Full 6-Phase Discipline for hard bugs (performance, non-deterministic, multiple hypotheses). Start with Quick Path if confident; switch to Full Discipline at the first sign of uncertainty.
triggers:
  - "diagnose"
  - "debug this"
  - "fix this bug"
  - "this is broken"
  - "error"
  - "failing"
  - "crashing"
  - "regression"
  - "performance issue"
  - "why is this slow"
---

# Diagnose: Debugging Discipline

**Two paths. Choose based on confidence. Switch paths if needed.**

---

## Quick Path: For Obvious Bugs Only

Use this ONLY if:

- The bug has an obvious error message pointing directly to the problem
- You already know the root cause from the stack trace
- It's a typo, syntax error, or obvious configuration issue
- Fix is straightforward and low-risk

**If ANY doubt → skip to Full Discipline below.**

### Quick Path Workflow

1. **Gather** - Read the error message, stack trace, relevant code
2. **Reproduce** - Make sure you can make it happen
3. **Identify** - The obvious root cause (e.g., "undefined access because X is null")
4. **Fix** - Implement the minimal fix
5. **Verify** - Confirm the bug is fixed

### If At Any Point...

If you:

- Catch yourself guessing
- Make a fix that doesn't work
- Realize there are multiple possible causes
- Need to add logging or instrumentation

**STOP. Switch to Full Discipline. Start at Phase 1.**

### Common Simple Bug Patterns

These are candidates for Quick Path:

- **Syntax/Type errors** - Error message points directly to file:line
- **Missing import** - "Cannot find module X"
- **Null/undefined access** - Stack trace shows exactly where
- **Off-by-one errors** - Obvious from boundary condition
- **Configuration mismatch** - Wrong URL, wrong port, missing env var

---

## Full Discipline: 6-Phase Loop

For when you're not 100% certain. For hard bugs, performance regressions, non-deterministic issues.

**PHASE 1 IS THE SKILL.** Everything else is mechanical.

### Phase 1 — Build a Feedback Loop

**This is 90% of debugging.** If you have a fast, deterministic, agent-runnable pass/fail signal for the bug, you WILL find the cause. If you don't have one, no amount of staring at code will save you.

**Spend disproportionate effort here. Be aggressive. Be creative. Refuse to give up.**

#### Ways to construct a feedback loop — try in roughly this order:

1. **Failing test** at whatever seam reaches the bug — unit, integration, e2e.
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright / Puppeteer) — drives the UI, asserts on DOM/console/network.
5. **Replay a captured trace.** Save a real network request / payload / event log to disk; replay it through the code path in isolation.
6. **Throwaway harness.** Spin up a minimal subset of the system (one service, mocked deps) that exercises the bug code path with a single function call.
7. **Property / fuzz loop.** If the bug is "sometimes wrong output", run 1000 random inputs and look for the failure mode.
8. **Bisection harness.** If the bug appeared between two known states (commit, dataset, version), automate "boot at state X, check, repeat" so you can `git bisect run` it.
9. **Differential loop.** Run the same input through old-version vs new-version (or two configs) and diff outputs.
10. **HITL bash script.** Last resort. If a human must click, drive them with a script so the loop is still structured.

#### Iterate on the loop itself

Once you have a loop, ask:

- Can I make it **faster**? (Cache setup, skip unrelated init, narrow test scope)
- Can I make the signal **sharper**? (Assert on the specific symptom, not "didn't crash")
- Can I make it **more deterministic**? (Pin time, seed RNG, isolate filesystem, freeze network)

A 30-second flaky loop is barely better than no loop. A 2-second deterministic loop is a debugging superpower.

#### Non-deterministic bugs

The goal is not a clean repro but a **higher reproduction rate**. Loop the trigger 100×, parallelize, add stress, narrow timing windows, inject sleeps. A 50%-flake bug is debuggable; 1% is not — keep raising the rate until it's debuggable.

#### When you genuinely cannot build a loop

STOP and say so explicitly. List what you tried. Ask the user for:

- (a) access to whatever environment reproduces it
- (b) a captured artifact (HAR file, log dump, core dump, screen recording with timestamps)
- (c) permission to add temporary production instrumentation

Do **not** proceed to Phase 2 until you have a loop you believe in.

### Phase 2 — Reproduce

Run the loop. Watch the bug appear.

Confirm:

- [ ] The loop produces the **user's described failure mode** — not a different failure that happens to be nearby. Wrong bug = wrong fix.
- [ ] The failure is reproducible across multiple runs (or, for non-deterministic bugs, reproducible at a high enough rate to debug against).
- [ ] You have captured the **exact symptom** (error message, wrong output, slow timing) so later phases can verify the fix actually addresses it.

Do not proceed until you reproduce the bug.

### Phase 3 — Hypothesise

Generate **3–5 ranked hypotheses** before testing any of them. Single-hypothesis generation anchors on the first plausible idea.

Each hypothesis must be **falsifiable**: state the prediction it makes.

> Format: "If `<X>` is the cause, then `<changing Y>` will make the bug disappear / `<changing Z>` will make it worse."

If you cannot state the prediction, the hypothesis is a vibe — discard or sharpen it.

**Show the ranked list to the user before testing.** They often have domain knowledge that re-ranks instantly ("we just deployed a change to #3"), or know hypotheses they've already ruled out. Cheap checkpoint, big time saver. Don't block on it — proceed with your ranking if the user is AFK.

### Phase 4 — Instrument

Each probe must map to a specific prediction from Phase 3. **Change one variable at a time.**

Tool preference:

1. **Debugger / REPL inspection** if the env supports it. One breakpoint beats ten logs.
2. **Targeted logs** at the boundaries that distinguish hypotheses.
3. Never "log everything and grep".

**Tag every debug log** with a unique prefix, e.g. `[DEBUG-a4f2]`. Cleanup at the end becomes a single grep. Untagged logs survive; tagged logs die.

**Performance branch.** For performance regressions, logs are usually wrong. Instead: establish a baseline measurement (timing harness, `performance.now()`, profiler, query plan), then bisect. Measure first, fix second.

### Phase 5 — Fix + Regression Test

Write the regression test **before the fix** — but only if there is a **correct seam** for it.

A correct seam is one where the test exercises the **real bug pattern** as it occurs at the call site. If the only available seam is too shallow (single-caller test when the bug needs multiple callers, unit test that can't replicate the chain that triggered the bug), a regression test there gives false confidence.

**If no correct seam exists, that itself is the finding.** Note it. The codebase architecture is preventing the bug from being locked down. Flag this for the next phase.

If a correct seam exists:

1. Turn the minimised repro into a failing test at that seam.
2. Watch it fail.
3. Apply the fix.
4. Watch it pass.
5. Re-run the Phase 1 feedback loop against the original (un-minimised) scenario.

### Phase 6 — Cleanup + Post-Mortem

**REQUIRED** before declaring done:

- [ ] Original repro no longer reproduces (re-run the Phase 1 loop)
- [ ] Regression test passes (or absence of seam is documented)
- [ ] All `[DEBUG-...]` instrumentation removed (`grep` the prefix)
- [ ] Throwaway prototypes deleted (or moved to a clearly-marked debug location)
- [ ] The hypothesis that turned out correct is stated clearly in the commit / PR message — so the next debugger learns

**Then ask: what would have prevented this bug?**

If the answer involves architectural change (no good test seam, tangled callers, hidden coupling):

- Note it.
- Make the recommendation **after** the fix is in, not before.
- You have more information now than when you started.

---

## The Checklist — Copy/Paste This

**Quick Path Check (simple bugs only):**

- [ ] Gathered error/stack
- [ ] Reproduced
- [ ] Identified OBVIOUS root cause
- [ ] Fixed minimally
- [ ] Verified
- [ ] Never had to guess

**Full Discipline Check:**

```
□ Phase 1: Built feedback loop I trust
  □ Fast (< 10s ideal, < 30s acceptable)
  □ Deterministic (or high repro rate for flakes)
  □ Reproduces the EXACT symptom user described
  □ Not a different nearby bug

□ Phase 2: Reproduced it
  □ Can make it happen on demand
  □ Captured exact error/output/timing

□ Phase 3: 3-5 ranked, falsifiable hypotheses
  □ Each says: "If X is cause, then Y will happen"
  □ Shown to user (cheap re-rank opportunity)

□ Phase 4: Instrumented & tested hypotheses
  □ One variable changed at a time
  □ Debug logs tagged for cleanup
  □ Root cause identified

□ Phase 5: Fixed with regression test (where possible)
  □ Regression test written BEFORE fix
  □ Test fails without fix, passes with fix
  □ Correct seam exists (or absence documented)
  □ Original scenario also passes

□ Phase 6: Cleaned up + post-mortem
  □ All [DEBUG-...] logs removed
  □ Temporary files deleted
  □ Root cause explained in commit/PR
  □ Architecture gaps noted (if any)
```

---

## Key Principles

**Don't shotgun debug.** Random changes hoping something works = wasted time + broken code.

**Don't refactor while debugging.** Get to GREEN first. Then refactor.

**Don't ignore contradictions.** If the code says X but your observation says Y, your understanding is wrong. Find the contradiction.

**The bug is always in the last place you look.** So look systematically: build the loop → bisect → hypothesize → verify.

## When In Doubt

Default to **Full Discipline**. Shotgun debugging (random changes hoping something works) wastes far more time than the disciplined approach.

If you started Quick Path and hit uncertainty, **STOP. Go back to Phase 1 of Full Discipline.**

---

## Related Skills

- **planning** - For bugs that are really "this needs to be rearchitected"
- **behavior-validation** - For verifying fixes against live systems
- **doubt-driven-development** - Systematic CLAIM→DOUBT→RECONCILE cycle for when debugging reveals uncertainty about assumptions or correctness
- **incremental-implementation** - Vertical-slice approach that prevents bugs by keeping changes small and verifiable
