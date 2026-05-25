---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up and continue work. Use when user wants to save context, hand off to another session, or create a continuation document.
argument-hint: "What will the next session be used for?"
---

# Handoff: Conversation Continuation

Write a handoff document summarising the current conversation so a fresh agent can continue the work. Save to the temporary directory of the user's OS - not the current workspace.

## What To Include

### Required Sections

1. **Summary** — 2-3 sentences on what this conversation was about
2. **Goal** — What we were trying to achieve
3. **Current State** — Where we are now (what's done, what's pending)
4. **Next Steps** — What the next agent should do
5. **Open Questions** — Unresolved decisions or ambiguities
6. **Key Artifacts** — Files modified, plans created, issues referenced
7. **Suggested Skills** — Which skills the next agent should invoke

### Rules

- **Do NOT duplicate content** already captured in other artifacts (PRDs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.
- **Redact sensitive information**: API keys, passwords, personally identifiable information.
- **Tailor to the next session's focus**: If user passed arguments about what the next session is for, optimize for that.

## Template

```markdown
# Handoff: <Brief Title>

**Created:** <timestamp>
**Next Session Focus:** <what the next session will do>

## Goal

<What we were trying to achieve>

## Current State

- **Done**:

  - <item 1>
  - <item 2>

- **In Progress**:

  - <item>

- **Not Started**:
  - <item>

## Key Decisions Made

1. <Decision> — <Reason>
2. <Decision> — <Reason>

## Open Questions / Blockers

- [ ] <Question> — needs resolution
- [ ] <Blocker> — waiting on user/external

## Next Steps

1. <First thing next agent should do>
2. <Second thing>
3. <Third thing>

## Key Artifacts

- Modified files:

  - `src/file1.ts`
  - `src/file2.ts`

- Plans/Docs:
  - `docs/plans/2026-05-25-feature.md`
  - PR #123
  - Issue #456

## Suggested Skills for Next Session

- **skill-1**: because <reason>
- **skill-2**: because <reason>

## Context Snapshot

<Anything else the next agent needs to know that isn't captured elsewhere>
```

## Where To Save

Save to OS temp directory:

- macOS/Linux: `$TMPDIR` or `/tmp`
- Windows: `%TEMP%`

Filename: `handoff-<YYYYMMDD>-<HHMMSS>-<slug>.md`

Example:

- `/tmp/handoff-20260525-143022-auth-implementation.md`

## After Saving

Tell the user:

1. Where the handoff file was saved (absolute path)
2. What the key next steps are
3. How to use it: "In your next session, say 'continue from this handoff' and provide the file path"
