---
name: safe-pr
description: Prevents flow-breaking mistakes, miscommunication, and credibility hits when working on shared or critical code paths. Follow these steps for every change.
---

# Safe PR

Prevent flow-breaking mistakes, miscommunication, and credibility hits when working on shared or critical code paths.

## Overview

This skill adds invisible safety nets:

- Detect risks early through pre-PR investigation
- Loop in owners before surprises happen
- Test critical flows before merging
- Communicate ownership professionally
- Reflect and improve after each merge

## When to Use

Use this skill when:

- Working on shared code paths or critical flows
- Touching code you didn't write
- Modifying anything payment-related, auth, or integrations
- **Deprecating any flow (any code that removes functionality)**
- Any PR that could impact another team or customer-facing feature

---

## The Golden Rule: Deprecated Flows Break Consumers

**Whenever you deprecate code, you MUST:**

1. **Find all consumers** — Search for usage of the deprecated flow
2. **Migrate them FIRST** — Before the deprecation PR, migrate all consumers to new paths
3. **Test the migration** — Verify consumers work with the new approach
4. **Then deprecate** — Only after migration is complete and merged

**Never merge a deprecation without migration path.** If you do, something WILL break silently.

**The pattern:**

```
Deprecate = Find consumers → Migrate them → THEN deprecate
```

**Checklist for any deprecation:**

- [ ] Searched for all consumers (grep, grep_searchGitHub, ask team)
- [ ] Each consumer has migration path documented
- [ ] Migration tested and merged
- [ ] Migration verified working in staging/prod
- [ ] Only THEN: deprecation PR

---

## 1. Pre-PR Investigation

**Goal:** Know every flow and owner your change could impact.

**Steps:**

1. Run `git blame` on the lines you are changing. Note who last modified them and who owns the flow.
2. Map all flows touched by your change (e.g., Redsys 3DS, AuthorizeOnly, payment flows).
3. **Check for recent deprecations** — Any flow deprecated in the last 4 weeks?
4. Write down your assumptions in one line.
   - Example: "AuthorizeOnly deprecated; these fields need remapping."

**Quick checklist:**

- [ ] Blamed lines → owners identified
- [ ] Flows mapped → all dependencies noted
- [ ] Recent deprecations checked (last 4 weeks)
- [ ] Assumption written → can you defend it?

---

## 2. Early Communication

**Goal:** Avoid surprises and misperceptions.

**Steps:**

1. DM owners of affected code before making changes:
   > "I'm updating X flow for Y. This might impact Z fields - does this look safe to update?"
2. Keep messages short, neutral, and professional.
3. Tag owners in PR if relevant.

**Rule:** Every PR touching someone else's logic triggers one preemptive DM.

---

## 3. Controlled Testing

**Goal:** Catch edge-case breakages before they hit production.

**Steps:**

1. Identify critical flows impacted by your change.
2. Run manual test scenarios for these flows before merging.
3. Add automated regression tests where feasible.

**Mini-table to maintain:**

| Flow     | Test Scenario                   | Automated? |
| -------- | ------------------------------- | ---------- |
| Checkout | Guest checkout, member checkout | Yes        |
| Payment  | Card, PayPal, bank              | Manual     |
| Auth     | Login, reset, SSO               | Yes        |

---

## 4. Ownership Messaging

**Goal:** Communicate problems clearly and neutrally when they arise.

**Template:**

> Upon investigation, this traces back to my earlier work where X was set to Y. Since flow Z was deprecated, the mappings were not carried over, which caused this issue. The fix is in [PR link]. Let me know if there's a cleaner approach.

**Rules:**

- No drama
- No self-blame phrasing
- Always reference the fix and next steps
- Keep 1-2 pre-drafted neutral messages for reuse

---

## 5. Post-Merge

**Goal:** Turn incidents into process improvement.

1. Spend 5 minutes logging what assumptions failed and what you'd do differently — use **learning-log**.
2. Add a new checklist item if something slipped through (e.g., "Check field mappings in deprecated flows").
3. Share in team retro if it hit production.

**This skill is a living document. Every incident makes it stronger.**

---

## Outcome

- Minimized flow-breaking mistakes
- Improved perception as a responsible engineer
- Fewer surprises for owners and management
- Fast development with invisible safety nets

---

## Related Skills

- **learning-log** — Use to capture incidents and patterns
- **slack-voice** — Use for professional ownership messages
