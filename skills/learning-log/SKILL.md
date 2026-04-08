---
name: learning-log
description: Capture and organize learned patterns, anti-patterns, and insights from project work. Use when user wants to log lessons learned, document patterns, or build a personal knowledge base.
---

# Learning Log

Capture and organize patterns, anti-patterns, and insights from your work.

## Overview

This skill helps:

- Log lessons learned from debugging
- Document discovered patterns
- Capture anti-patterns to avoid
- Build a personal knowledge base
- Track project-specific insights

## When to Use

Use this skill when:

- Debugging reveals a pattern worth remembering
- Implementing something with tricky parts
- Discovering how code actually works
- Making mistakes that could be avoided
- Learning something new about the codebase

## Log Categories

### 1. Patterns (Do This)

```
## Pattern: [Name]

Context: [When this applies]
Solution: [What to do]
Example: [Code or file reference]
```

### 2. Anti-Patterns (Avoid This)

```
## Anti-Pattern: [Name]

Problem: [Why it's bad]
Signs: [How to recognize]
Better: [Alternative approach]
```

### 3. Gotchas (Watch Out)

```
## Gotcha: [Name]

What happens: [Unexpected behavior]
Why: [Root cause]
Workaround: [How to handle]
```

### 4. Discovery (Now I Know)

```
## Discovery: [Topic]

Previously: [What you thought]
Actually: [What reality is]
Implication: [How this affects work]
```

## Workflow

### 1. Capture Immediately

When you learn something significant:

- Write it down right away
- Include context (file, situation)
- Note why it matters

### 2. Review Weekly

At end of week:

- Review captures
- Merge duplicates
- Identify themes
- Add to index

### 3. Cross-Reference

Link related entries:

- Pattern relates to anti-pattern?
- Gotcha ties to discovery?
- Cross-link for navigation

## Storage

Suggested location: `.learning/` in project root

```
.learning/
├── index.md
├── patterns/
├── anti-patterns/
├── gotchas/
└── discoveries/
```

### Index Format

```markdown
# Learning Log

## Patterns
- [auth-flow](patterns/auth-flow.md)
- [error-handling](patterns/error-handling.md)

## Anti-Patterns
- [n+1-queries](anti-patterns/n+1-queries.md)

## Gotchas
- [dates-timezone](gotchas/dates-timezone.md)

## Discoveries
- [api-rate-limits](discoveries/api-rate-limits.md)
```

## Example Entries

### Pattern

```
## Pattern: Abort Controller for Cleanup

Context: Long-running async operations that need cancellation
Solution: Pass AbortSignal to all async functions
Example:
  async function fetchWithTimeout(url, signal) {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 5000);
    try {
      return await fetch(url, { signal: signal || controller.signal });
    } finally {
      clearTimeout(timeout);
    }
  }
```

### Anti-Pattern

```
## Anti-Pattern: Catching Without Logging

Problem: Silent failures hide bugs
Signs:
  - try { ... } catch (e) {}
  - catch (err) { return; }
Better:
  - Always log at minimum
  - Consider re-throwing for unexpected errors
```

### Gotcha

```
## Gotcha: Array Mutation in map()

What happens: map() doesn't mutate original but...
Why: If you mutate elements inside map(), original array is affected
Workaround: Always use map(() => ({...item})) to copy first
```

## Quality Guidelines

- Write for future you — will you understand in 6 months?
- Include concrete examples, not just theory
- Note the source (personal discovery, documentation, colleague)
- Date entries for relevance tracking

## Maintenance

- Monthly: Review and prune stale entries
- Quarterly: Identify patterns across entries
- Onboarding: Share relevant entries with new team members
