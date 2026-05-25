---
name: planning
description: MANDATORY Plan-First Workflow. ALWAYS activate before ANY implementation. Read plans twice, validate clarity, break into pieces, generate human-readable test cases, get approval. Only THEN write code. Planning phase matters more than anything after.
triggers:
  - "create plan"
  - "write plan"
  - "implementation plan"
  - "create prd"
  - "draft spec"
  - "architect solution"
  - "break down project"
  - "requirements"
  - "implement"
  - "add feature"
  - "build"
  - "create"
  - "code"
  - "fix bug"
  - "change code"
  - "develop"
  - "ship"
  - "deploy"
  - "start"
  - "begin"
  - "let's go"
  - "do it"
---

# Plan-First Mandatory Workflow

> **PLANNING PHASE MATTERS MORE THAN ANYTHING THAT COMES AFTER IT.**

This is your mandatory gatekeeper before ANY code gets written. No exceptions.

## THE IRON RULES - DO NOT SKIP

### Rule 1: Always Start in Plan Mode

When ANY implementation-related request comes in:

- **STOP. Do NOT write code.**
- If a plan/PRD exists: **Read it. Then read it again.**
- If no plan exists: **Create one first.**

### Rule 2: Clarity Check Before Code

If ANY part of the plan is unclear:

> **STOP. Ask questions. Do NOT write a single line.**

What counts as "unclear":

- You can't explain the goal back in your own words
- Edge cases aren't covered
- Success criteria are vague or missing
- You're making assumptions that aren't written down
- "I think they want..." → STOP. Ask.

**Ask until there's ZERO ambiguity.**

### Rule 3: If It's Too Big, Break It

> If the plan is too big to fit in your head, it's too big.

How to check:

- Can you summarize the entire plan without scrolling?
- Can you explain all the tasks from memory?
- Would a single PR be reviewable in under 30 minutes?

If **NO** to any: Break into smaller pieces.

**Good chunk size:**

- Each piece = 1 focused goal
- Each piece = reviewable in one sitting
- Each piece = can be tested independently

### Rule 4: Collaborate During Planning

Go back and forth with the user during this phase:

1. Present your understanding
2. Ask clarifying questions
3. Propose approach(es)
4. Get feedback
5. Iterate

**This back-and-forth is not "slow". It prevents rework.**

### Rule 5: Safety Nets First

Before ANY implementation:

1. **Version control check:**

   - What branch are you on?
   - Should you create a feature branch?
   - Is the working tree clean?
   - Can you roll back if something breaks?

2. **Know your undo:**
   - `git stash`
   - `git checkout -- <file>`
   - `git reset HEAD~1` (soft undo last commit)

### Rule 6: Human-Readable Test Cases

Generate test cases the user can read and approve BEFORE writing code:

```
**Test Cases - Please Validate:**

1. **Happy Path:** User submits valid form → success message, data saved
2. **Invalid Email:** User enters "not-an-email" → validation error shown
3. **Duplicate Username:** Username already exists → friendly error
4. **Empty Form:** All fields blank → all required field errors shown
```

Format:

- **Plain English**, not technical jargon
- **Input → Expected Output** pairs
- **Covers**: happy path, edge cases, error conditions
- **User must approve** these before code starts

### Rule 7: Only THEN - Auto Mode

All of these must be true before writing code:

- [ ] Plan/PRD exists and has been read TWICE
- [ ] No ambiguity - all questions answered
- [ ] Plan is broken into reviewable chunks
- [ ] User has collaborated and agrees to approach
- [ ] Version control safety net is ready
- [ ] Human-readable test cases generated AND APPROVED by user

**IF ALL YES → Now you may write code.**

---

## THE WORKFLOW - Step by Step

### Phase 1: Assessment

```
User: "Build me a login form with JWT"

You (IMMEDIATELY - no code):
1. Check for existing plans/PRDs in docs/, docs/plans/, PRD/
2. If found: Read once, read again
3. If not found: Announce you're entering planning phase
```

### Phase 2: Clarification

Ask questions until clear. ONE question per message:

> "Before I design or code anything, I want to make sure I understand correctly.
>
> Should this login form also support 'forgot password' flow, or is that out of scope for now?"

Wait for answer. Then next question.

### Phase 3: Present Approach

Propose 2-3 approaches when applicable:

> "Here's how I'm thinking about this:
>
> **Option A (Recommended):** JWT in httpOnly cookie + refresh token rotation. Most secure.
>
> **Option B:** JWT in localStorage. Simpler but vulnerable to XSS.
>
> My recommendation is Option A. Does that work for you, or would you prefer to discuss?"

### Phase 4: Human-Readable Tests

Generate test cases for approval:

> "Before writing any code, let me confirm the expected behavior with test cases:
>
> **Test Cases:**
>
> 1. Valid credentials → User gets "Welcome back!" and redirected to dashboard
> 2. Wrong password → "Invalid email or password" (no distinction for security)
> 3. Empty fields → "Email is required" / "Password is required"
> 4. Locked account (5 failed attempts) → "Account temporarily locked. Try again in 15 minutes."
>
> Please approve these test cases, or let me know what to change."

### Phase 5: Write the Plan

Save to `docs/plans/YYYY-MM-DD-<feature-name>.md`:

```markdown
# Login with JWT Implementation Plan

**Goal:** Add email/password authentication with JWT tokens

**Approach:**

- JWT stored in httpOnly, secure cookie
- Refresh token stored in DB with rotation
- bcrypt for password hashing

**Files to touch:**

- Create: `src/routes/auth/login.ts`
- Modify: `src/middleware/auth.ts`
- Create: `tests/auth/login.test.ts`

**Test Cases (Approved):**

1. [as above]
2. [as above]
```

### Phase 6: User Approval

> "Plan saved to `docs/plans/2026-05-25-login-jwt.md`. I'm ready to proceed when you confirm:
>
> 1. The approach looks right
> 2. The test cases cover what you need
> 3. You want me to start implementation
>
> Shall I begin?"

### Phase 7: NOW - Implementation

**ONLY AFTER USER EXPLICITLY SAYS YES:**

- Create feature branch (if appropriate)
- Follow the plan
- Run tests
- Keep commits atomic
- Reference the plan in commit messages if helpful

---

## HARD-GATE: No Implementation Without This

```
┌─────────────────────────────────────────────────────────────────┐
│                    BEFORE YOU WRITE ANY CODE                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. Is there a plan? → Read it. Read it AGAIN.                  │
│                                                                 │
│  2. Are you 100% clear on requirements?                         │
│     → If NO: STOP. ASK QUESTIONS.                              │
│                                                                 │
│  3. Is the plan broken into reviewable chunks?                 │
│     → If NO: Break it down FIRST.                               │
│                                                                 │
│  4. Have you proposed the approach to the user?                 │
│     → If NO: Do that. Get feedback.                             │
│                                                                 │
│  5. Are human-readable test cases generated AND APPROVED?       │
│     → If NO: Generate. Get approval.                            │
│                                                                 │
│  6. Is your version control safety net ready?                   │
│     → Branch created? Working tree clean?                       │
│                                                                 │
│  7. Did the user explicitly say "proceed" or equivalent?        │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                    ALL YES? → NOW you may code.                 │
└─────────────────────────────────────────────────────────────────┘
```

**IF YOU SKIP THIS GATE, YOU ARE DOING IT WRONG.**

---

## When Does This NOT Apply?

Almost never. But for truly trivial tasks:

**Trivial =** Single line change, typo fix, obvious config tweak, already-discussed-and-agreed minuscule change.

**Even then:**

- Quick mental check: "Am I making any assumptions?"
- If yes → Still follow the workflow
- If truly zero assumptions → Proceed (but consider mentioning what you're doing)

**Good heuristic:** If you would be surprised if the user says "wait that's not what I wanted" → you should have planned first.

---

## References

- [requirements-architect](reference/requirements-architect.md) - High-level requirements and PRD creation
- [writing-plans](reference/writing-plans.md) - Detailed implementation planning with task breakdown

## Related Skills

- **rapidfire** - Use for deep alignment when you need to walk the ENTIRE decision tree (Interview Mode). Also provides blunt feedback on ideas (Feedback Mode). Invoke if planning reveals major ambiguities.
- **brainstorming** - For creative/design work before planning
- **testing** - For actual test implementation after test cases are approved
- **safe-pr** - For PR safety when working with shared code

---

## Domain Awareness: Check These First

**Before asking the user ANY question, explore the codebase for:**

### 1. Domain Glossary (CONTEXT.md)

Look for `CONTEXT.md` at the repo root. If it exists:

- Read it to understand the project's **ubiquitous language**
- Use the project's terms, not your own
- If user uses a term conflicting with `CONTEXT.md`, call it out immediately:
  > "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

If `CONTEXT-MAP.md` exists, the repo has multiple bounded contexts. Read it to understand which context applies.

### 2. Architecture Decision Records (docs/adr/)

Look for `docs/adr/` directory. If it exists:

- Read any ADRs relevant to the area you're touching
- **Do not re-litigate decisions that are already recorded**
- If a proposed approach contradicts an ADR, only surface it if the friction is real enough to warrant reopening:
  > "This contradicts ADR-0007 — but worth reopening because..."

### 3. Existing Patterns in Code

Before asking "what should we use for X?", check:

- `package.json` / `Cargo.toml` / etc. for dependencies already in use
- Similar modules to see how similar problems were solved
- Middleware, utilities, helpers that already exist

**If a question can be answered by exploring the codebase, EXPLORE FIRST. Don't ask the user.**

---

## Question Asking: The Grill-Me Pattern

When you DO need to ask a question:

### 1. ONE Question Per Message

**EXACTLY ONE. Not two. Not three.**

Wait for the answer. Then ask the next question based on what was learned.

Why? Each answer changes the decision tree. You can't know the right second question until you hear the first answer.

### 2. Provide Your Recommended Answer

For every question, provide what you think the answer is (based on context, patterns, and best practices). This accelerates alignment.

**BAD (just a question):**

> "Should we use JWT or sessions?"

**GOOD (question + recommendation):**

> "For auth, should we use JWT in httpOnly cookies, or server-side sessions?
>
> **My recommendation**: JWT in httpOnly cookies. They're stateless, work well with APIs, and httpOnly mitigates XSS risk.
>
> Sessions are simpler if you have a single server and don't need horizontal scaling.
>
> Which fits your use case better?"

### 3. Walk The Entire Decision Tree

Stop only when:

- Every branch has been explored
- No unstated assumptions remain
- You could explain the entire plan back without confusion
- Edge cases and error conditions are covered
- Success criteria are concrete and measurable

---

## PRD Template: Full Structure

When synthesizing into a formal plan/PRD, use this structure:

```markdown
# {Feature Name}

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## User Stories

A LONG, numbered list of user stories. Each in this format:

1. As an <actor>, I want a <feature>, so that <benefit>

**Example:**

1. As a mobile bank customer, I want to see balance on my accounts, so that I can make better informed decisions about my spending

This list should be **extensive** and cover ALL aspects of the feature.

## Implementation Decisions

What was decided. Include:

- The modules that will be built/modified
- The interfaces of those modules
- Technical clarifications
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

**Do NOT include specific file paths or code snippets.** They become stale quickly.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it and note it came from a prototype.

## Testing Decisions

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (similar types of tests in the codebase)

## Out of Scope

What is DEFINITELY OUT of scope for this PRD. This is as important as what's IN scope.

## Further Notes

Any other relevant context.
```

---

## Breaking Into Issues: Vertical Slices

Once the PRD is approved and you're ready to break into implementation tasks, use **vertical slices** (tracer bullets), NOT horizontal slices.

### ❌ WRONG: Horizontal Slices

```
Task 1: Build all database schemas
Task 2: Build all API endpoints
Task 3: Build all UI components
Task 4: Write all tests
```

### ✅ CORRECT: Vertical Slices

Each slice is a **thin but COMPLETE path through every layer** (schema, API, UI, tests). A completed slice is demoable or verifiable on its own.

```
Slice 1 (HITL): User can see login form
  - Schema: user table (minimal)
  - API: GET /login (serve form)
  - UI: email + password fields, submit button
  - Test: form renders

Slice 2 (AFK): User can submit valid credentials
  - API: POST /login handler
  - Logic: credential verification
  - Test: valid credentials -> success

Slice 3 (AFK): Error cases
  - Invalid credentials error
  - Empty fields validation
  - Test: all error paths
```

**Slices may be 'HITL' or 'AFK':**

- **HITL** = Human-In-The-Loop: requires human interaction (architectural decision, design review)
- **AFK** = Away-From-Keyboard: can be implemented without human interaction

**Prefer AFK over HITL where possible.**

For each slice, show:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which stories this addresses

Then ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?
- Are the correct slices marked as HITL and AFK?

Iterate until approved.

---

## The Grill-Me Flow For Deep Ambiguity

If during planning you discover that requirements are fundamentally unclear or the decision tree is large:

**STOP. Invoke the `rapidfire` skill explicitly.**

Say:

> "This is more complex than I initially thought. Let me switch into rapidfire interview mode to make sure we cover every branch of the decision tree."

Then follow rapidfire's Interview Mode: relentless, one-question-at-a-time interview until full alignment.

Only return to planning when every decision branch is resolved.
