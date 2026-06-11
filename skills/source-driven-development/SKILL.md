---
name: source-driven-development
description: "Grounds every implementation decision in official documentation. Use when you want authoritative, source-cited code free from outdated patterns. Use when building with any framework or library where correctness matters."
triggers:
  - "official docs"
  - "verify docs"
  - "check documentation"
  - "source cited"
  - "framework patterns"
  - "API docs"
  - "documentation"
---

# Source-Driven Development

## Why This Matters

Training data is a snapshot. APIs change, best practices shift, and deprecated patterns look correct until they break against a current runtime. Source-driven development means every framework-specific decision traces back to an authoritative source the user can check. The goal is not to eliminate training data — it's to verify it before acting on it.

## When to Apply

- Implementing boilerplate, starter code, or patterns that others will copy
- Using a framework or library where the recommended approach matters
- Code generation or scaffolding that sets patterns for a project
- Reviewing existing code for API correctness against current docs
- Any time you're about to write framework-specific code from memory

**Skip when:** the change is pure logic (conditionals, loops, math), mechanical (rename, move, reformat), or the user explicitly prioritizes speed over verification.

## Authority Chain

Not all sources carry equal weight. This is the hierarchy — always prefer the top:

```
TIER 1: OFFICIAL DOCS
  → framework.dev, library.dev, MDN (for web standards)
  → Official migration guides, changelogs, RFCs

TIER 2: OFFICIAL BLOG / SPEC
  → framework.dev/blog, whatwg.org, RFC specifications

TIER 3: REFERENCE MATERIAL
  → caniuse.com, node.green, bundlephobia.com

DO NOT CITE:
  → Stack Overflow, blog posts, tutorials, forum answers
  → AI-generated summaries or code
  → Your own training data (that's what we're verifying)
```

## Verification Workflow

### Step 1: Pin Versions

Read the project's dependency file first. Without exact versions, you can't know which docs apply:

```
Dependency file     What it tells you
─────────────────────────────────────────────
package.json        → Node, React, Next, Vue, etc.
pyproject.toml      → Python, Django, FastAPI
Cargo.toml          → Rust, framework versions
go.mod              → Go, module versions
Gemfile             → Ruby, Rails version
```

State what you found before fetching anything:

```
STACK:
  React 19.1.0, Next.js 15.2.0, Tailwind 4.0.3
  → Fetching docs for React 19 patterns
```

If a version is ambiguous, ask. Guessing the version means guessing the API surface.

### Step 2: Fetch the Relevant Page

Not the homepage. Not the full docs site. The exact page covering the feature you're implementing:

```
WRONG: Fetch react.dev
WRONG: Search Google for "react form handling"
RIGHT: Fetch react.dev/reference/react/useActionState
```

When fetching:

1. Extract the API signature and usage examples
2. Note any deprecation warnings or migration notes
3. Capture version-specific behavior differences
4. If official sources contradict each other (migration guide vs API reference), surface the discrepancy to the user

### Step 3: Implement Against Docs

Write code matching what the documentation shows:

- Use signatures from the docs, not from memory
- Follow the recommended (not deprecated) pattern
- If the docs don't cover your use case, flag it

**When docs conflict with existing project code:**

```
CONFLICT: Docs show useActionState() for forms, but
codebase uses manual useState + onSubmit.

Options:
A) Use the modern doc-recommended pattern
B) Match existing codebase style for consistency
→ Which way?
```

Surface the conflict. Don't silently override project conventions.

### Step 4: Cite Decisions

Every framework-specific decision needs a trail the user can follow:

```typescript
// Inline comment with source
// React 19: useActionState replaces manual form state
// Source: react.dev/reference/react/useActionState
const [state, formAction, pending] = useActionState(fn, init);
```

In conversation:

```
Using useActionState instead of manual useState +
onSubmit handler. React 19 made this the recommended
pattern for form submissions.

Source: react.dev/blog/2024/12/05/react-19
"useTransition now supports async functions,
handling pending states automatically"
```

Citation rules:

- Full URLs, not shortlinks
- Deep-link to the specific anchor when possible
- Quote relevant passages for non-obvious decisions
- If no authoritative source exists, say so explicitly:
  `"This pattern is unverified — no official documentation found."`

## Common Pitfalls

| Rationalization | Reality |
|---|---|
| "I'm sure this API is correct" | Confidence is not evidence. Training data contains outdated patterns that look correct. |
| "Fetching docs costs tokens" | An hour debugging a wrong API costs more. One fetch prevents rework. |
| "The docs won't help here" | Then you know the pattern isn't officially documented — that itself is useful information. |
| "It's a simple thing, no need to check" | Simple wrong patterns get copied across projects. |

## Red Flags

- Writing framework code without checking version-specific docs
- "I think" or "I believe" about an API instead of citing a source
- Citing blog posts or tutorials as primary sources
- Using deprecated APIs that appear in training data
- Not reading dependency files before implementing
- Delivering code without source citations for framework decisions

## Verification

- [ ] Framework/library versions identified from dependency file
- [ ] Official docs fetched for framework-specific patterns
- [ ] Sources are official docs, not blogs or training data
- [ ] Code matches the current version's documented patterns
- [ ] Non-trivial decisions include source citations
- [ ] No deprecated APIs used
- [ ] Docs-vs-codebase conflicts surfaced to user
- [ ] Unverifiable patterns flagged explicitly
