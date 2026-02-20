---
name: pr-review
description: Complete pull request review workflow - analyzes PR, reviews code quality, and creates pending review
---

# /pr-review - Complete Pull Request Review Workflow

## Description

Executes a comprehensive PR review workflow by orchestrating three specialized skills:
1. **pr-analysis** - Extract PR metadata and changes
2. **code-quality-review** - Analyze code quality with accurate line numbers
3. **github-review-publisher** - Create validated pending reviews

## Usage

```bash
/pr-review [PR_NUMBER]
/pr-review [PR_NUMBER] [OWNER/REPO]
/pr-review [FULL_PR_URL]
```

## Examples

```bash
# Review PR in current repo
/pr-review 238

# Review PR in specific repo
/pr-review 238 company/monorepo

# Review PR using full URL
/pr-review https://github.com/owner/repo/pull/238
```

## Workflow Process

### Step 1: PR Analysis
- Fetches PR metadata (title, author, state, branches)
- Identifies all changed files
- Extracts diff content
- Categorizes changes by scope (connector, core domain, tests, etc.)
- Provides structured output for downstream analysis

### Step 2: Code Quality Review
- Analyzes each changed file for:
  - Security vulnerabilities
  - Type safety issues
  - Code quality violations
  - Best practice violations
- Extracts accurate line numbers from NEW file (not diff)
- Categorizes issues: Critical (-20), Warning (-5), Suggestion (-1)
- Calculates overall quality score (0-100)

### Step 3: GitHub Review Publisher
- Validates all line numbers against actual PR diff
- Creates pending review comments (not posted publicly)
- Formats comments with severity emojis (🔴🟡🟢)
- Provides detailed report of created and skipped comments
- Generates direct links to GitHub for manual approval

## Output Structure

```
# 📋 PR Review Complete: PR #238

## PR Analysis Summary
- Title: feat(connector): Add Stripe integration
- Author: username
- Changed Files: 8
- Primary Category: connector_integration

## Quality Review Summary
- Score: 92/100 (Good ✅)
- Critical Issues: 0
- Warnings: 2
- Suggestions: 5

## Review Comments Created
- Total Pending Comments: 7
  - 🔴 Critical: 0
  - 🟡 Important: 2
  - 🟢 Suggestions: 5

### Comments by File:
- backend/connectors/stripe.rs (3 comments)
- tests/stripe_integration.rs (2 comments)
- config/stripe.toml (2 comments)

## Next Steps
1. Go to PR: https://github.com/owner/repo/pull/238/files
2. Review pending comments on each line
3. Approve/edit/delete comments in GitHub UI
4. Submit review when ready

⚠️ Comments are NOT posted publicly yet
```

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Write access to the repository
- PR must not be merged

## Integration with Skills

This command orchestrates:
- `/skills/pr-analysis/SKILL.md`
- `/skills/code-quality-review/SKILL.md`
- `/skills/github-review-publisher/SKILL.md`

Data flows:
```
pr-analysis → metadata + files + diff
    ↓
code-quality-review → issues + line numbers
    ↓
github-review-publisher → pending review
```

## Error Handling

- PR not found: Verifies repository and PR number
- No permissions: Checks GitHub CLI authentication
- Large PR: May timeout on PRs with >100 files
- Line validation: Skips invalid lines with detailed report

## Related Commands

- `/list-skills` - See all available skills
- `/skill-info pr-analysis` - Learn about PR analysis skill
- `/skill-info code-quality-review` - Learn about quality review