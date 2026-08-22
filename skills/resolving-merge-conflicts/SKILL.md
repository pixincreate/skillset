---
name: resolving-merge-conflicts
description: Work through an in-progress git merge or rebase conflict hunk by hunk, resolving each by intent traced to its source, then finish the operation — never abort. Use when a merge or rebase is mid-conflict.
triggers:
  - "resolve conflicts"
  - "merge conflict"
  - "rebase conflict"
  - "fix conflicts"
---

# Resolving Merge Conflicts

1. **See the current state.** Check git history and the conflicting files. Know which commits are in flight.

2. **Find the primary sources.** For each conflict, understand why each side changed: read the commit messages, the PRs, the original issues/tickets. Resolve by intent, never by textual proximity.

3. **Resolve each hunk.** Preserve both intents where possible. Where genuinely incompatible, pick the side matching the merge's stated goal and note the trade-off in a comment or commit message. Do **not** invent new behaviour. Always resolve; **never `--abort`**.

4. **Run the automated checks.** Discover what the project runs (typically typecheck → tests → format) and execute it. Fix anything the merge broke.

5. **Finish the operation.** Stage everything and commit. If rebasing, continue until every commit is rebased.

## Related Skills

- **safe-pr** - Pre-merge hygiene so fewer conflicts happen in the first place
- **diagnose** - If post-merge checks fail for non-obvious reasons
