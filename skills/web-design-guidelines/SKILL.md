---
name: web-design-guidelines
description: Review UI code for Web Interface Guidelines compliance. Use when asked to "review my UI", "check accessibility", "audit design", "review UX", or "check my site against best practices".
---

# Web Interface Guidelines

Review files for compliance with Web Interface Guidelines.

## Overview

This skill covers:
- Web accessibility guidelines
- Form design best practices
- Animation guidelines
- Typography standards
- Performance optimization

## When to Use

This skill auto-activates when users request:
- "Review my UI"
- "Check accessibility"
- "Audit design"
- "Review UX"
- "Check my site against best practices"

## Available References

### Detailed Guidelines
- **web-interface.md** - Comprehensive web interface guidelines

## How It Works

### Primary Method (Fetches Fresh)

1. Fetch the latest guidelines from the source URL
2. Read the specified files (or prompt user for files/pattern)
3. Check against all rules in the fetched guidelines
4. Output findings in the terse `file:line` format

### Reference Method

For offline access or detailed study:

```bash
cat web-design-guidelines/reference/web-interface.md
```

## Guidelines Source

Fetch fresh guidelines before each review:

```
https://raw.githubusercontent.com/vercel-labs/web-interface-guidelines/main/command.md
```

Use WebFetch to retrieve the latest rules. The fetched content contains all the rules and output format instructions.

## Usage

When a user provides a file or pattern argument:

1. Fetch guidelines from the source URL above
2. Read the specified files
3. Apply all rules from the fetched guidelines
4. Output findings using the format specified in the guidelines

If no files specified, ask the user which files to review.
