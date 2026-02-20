---
name: debugging
description: Systematic debugging workflow for identifying, isolating, and fixing bugs. Use when troubleshooting errors, unexpected behavior, performance issues, or when code isn't working as expected.
---

# Debugging

Systematic debugging workflow for identifying, isolating, and fixing bugs.

## Overview

This skill covers:
- Systematic debugging methodology
- Root cause analysis
- Performance debugging

## When to Use

This skill auto-activates when users request:
- "Debug this"
- "Fix this bug"
- "Why is this slow"
- "This isn't working"
- "There's an error"
- Any debugging-related task

## Available References

### Systemic Debugging
- **systemic-debugging.md** - Rigorous root cause analysis methodology

## Usage

For detailed debugging methodology:

```bash
cat debugging/reference/systemic-debugging.md
```

## Quick Reference

### Debugging Workflow

```
Gather → Reproduce → Form Hypotheses → Isolate → Fix → Verify
```

### Essential Steps

1. **Gather** - Collect error messages, logs, context
2. **Reproduce** - Make the bug happen consistently
3. **Form Hypotheses** - What could cause this?
4. **Isolate** - Narrow down the root cause
5. **Fix** - Implement the solution
6. **Verify** - Confirm the fix works

### Common Techniques

- **Binary search** - Remove half the code to isolate
- **Logging** - Add debug output
- **Bisecting** - Use git bisect for regressions
- **Rubber ducking** - Explain the problem aloud

### Tools

- Debugger (breakpoints, step-through)
- Console/logs
- Error messages
- Network inspector
- Profiler
