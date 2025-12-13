---
name: pr-analysis
description: Fetch and analyze pull request data from GitHub repositories. Use when you need to understand PR changes, review code modifications, or analyze scope of pull requests. Auto-activates for: "analyze PR", "fetch pull request", "get PR details", "what changed in PR", "review PR #123".
---

# PR Analysis Skill

## Core Principle

**Extract comprehensive PR context**: Parse pull request metadata, file changes, and diff content to understand scope and impact.

## When to Use This Skill

This skill auto-activates when users request:
- "Analyze PR #123"
- "What changed in pull request 456?"
- "Get details for PR from owner/repo"
- "Review the changes in this PR"
- "What files were modified in PR #789?"
- "Show me the diff for PR #123"

## PR Analysis Workflow

### 1. Parse Input

**Accepts multiple formats**:
- PR number only (auto-detects repo from current directory)
- Full PR URL (https://github.com/owner/repo/pull/123)
- PR number + explicit repository
- Repository name + PR number

**Auto-detection**:
```bash
# From git remote
git remote get-url origin
# Parse: git@github.com:owner/repo.git → owner/repo
# Parse: https://github.com/owner/repo.git → owner/repo
```

### 2. Fetch PR Metadata

```bash
# Get comprehensive PR information
gh pr view {pr-number} --repo {owner}/{repo} \
  --json number,title,author,state,headRefName,baseRefName,headRefOid,baseRefOid,createdAt,updatedAt,mergeable,additions,deletions,changedFiles,url,reviewDecision
```

**Returns**:
- PR number and title
- Author and state (OPEN/CLOSED/MERGED)
- Branch information (head/base)
- File statistics
- Merge status
- Review decisions

### 3. Identify File Changes

```bash
# Get list of modified files
gh pr diff {pr-number} --repo {owner}/{repo} --name-only
```

**Categorize files by type**:
- Connector files: `backend/connector-integration/src/connectors/**`
- Core domain: `backend/domain_types/**`
- Tests: `**/*test*.rs`, `**/tests/**`
- Configuration: `**/*.toml`, `**/*.yaml`
- Documentation: `**/*.md`

### 4. Extract Diff Content

```bash
# Get complete diff
gh pr diff {pr-number} --repo {owner}/{repo}
```

**Analyze diff for**:
- Added/removed lines
- Function signature changes
- Import modifications
- Configuration updates

### 5. Analyze Change Scope

**Primary categories**:
- `connector_integration` - New connectors or integration changes
- `core_domain` - Domain model modifications
- `api_changes` - Request/response structure changes
- `infrastructure` - Build, CI/CD, deployment changes
- `documentation` - Documentation updates
- `tests` - Test additions/modifications

**Connector-specific analysis**:
```yaml
if connector_files:
  connector_name: # Extract from file path
  flows_implemented: # Identify payment flows
  configuration_changes: # Config file modifications
```

## Output Structure

```yaml
pr_metadata:
  pr_number: 238
  title: "feat(connector): Add Stripe integration"
  author: "username"
  state: "OPEN"
  head_branch: "feature/stripe-connector"
  base_branch: "main"
  head_sha: "abc123..."
  base_sha: "def456..."
  created_at: "2024-01-15T10:30:00Z"
  updated_at: "2024-01-15T14:45:00Z"
  mergeable: true
  additions: 1247
  deletions: 23
  changed_files: 8
  url: "https://github.com/owner/repo/pull/238"
  review_decision: "APPROVED"

files_changed:
  connector_files:
    - path: "backend/connector-integration/src/connectors/stripe.rs"
      additions: 850
      deletions: 0
  core_domain:
    - path: "backend/domain_types/src/types.rs"
      additions: 50
      deletions: 10
  tests:
    - path: "tests/connector_tests/stripe_tests.rs"
      additions: 300
      deletions: 0
  configuration:
    - path: "config/connectors/stripe.toml"
      additions: 47
      deletions: 0

scope:
  primary: "connector_integration"
  categories:
    - "connector_integration"
    - "core_domain"
    - "tests"
  change_characteristics:
    new_connector: true
    security_sensitive: true
    large_refactor: false
    breaking_change: false

connector_details:
  connector_name: "stripe"
  flows_implemented:
    - "Authorize"
    - "Capture"
    - "Void"
    - "Refund"
  configuration_additions:
    - "API key configuration"
    - "Webhook endpoints"
```

## Common Analysis Patterns

### New Connector Detection

**Indicators**:
- New file in `backend/connector-integration/src/connectors/`
- Configuration file added
- Tests created for new connector
- Domain types additions

### Security-Sensitive Changes

**Look for**:
- API key handling
- Authentication flows
- Secret management
- Input validation changes

### Breaking Changes Detection

**Check for**:
- Domain type modifications
- API response structure changes
- Required field additions
- Interface modifications

## Error Handling

### Common Issues

1. **PR not found**: Verify repository and PR number
2. **Authentication required**: Check `gh auth status`
3. **No internet**: Ensure GitHub access
4. **Rate limit**: Wait for rate limit reset

### Error Messages

```bash
# Check GitHub CLI authentication
gh auth status

# Test repository access
gh repo view {owner}/{repo}

# Validate PR exists
gh pr view {pr-number} --repo {owner}/{repo} --json title
```

## Integration Notes

### Works With

- **code-quality-review**: Provides file paths and diff for analysis
- **github-review-publisher**: Supplies PR metadata for review creation
- **collaboration**: Enhancement for code review process

### Data Flow

```
pr-analysis → file_paths + diff + metadata → code-quality-review
                                          ↓
                                    issues + line_numbers → github-review-publisher
```

### Output Formats

- **YAML**: Structured data for skill integration
- **JSON**: API-compatible format
- **Markdown**: Human-readable summary

## Quick Reference Commands

```bash
# Quick PR summary
gh pr view {pr} --repo {owner}/{repo}

# Get file changes only
gh pr diff {pr} --name-only

# Get commit messages
gh pr view {pr} --repo {owner}/{repo} --json commits

# Check merge status
gh pr view {pr} --repo {owner}/{repo} --json mergeable

# Get reviewer decisions
gh pr view {pr} --repo {owner}/{repo} --json reviewDecision

# Extract head SHA (critical for line number extraction)
gh pr view {pr} --repo {owner}/{repo} --json headRefOid -q '.headRefOid'
```

## Verification Checklist

Before completing PR analysis:
- [ ] PR exists and is accessible
- [ ] Repository authenticated with GitHub CLI
- [ ] All relevant files identified
- [ ] Diff content extracted
- [ ] Scope properly categorized
- [ ] Metadata formatted correctly
- [ ] Security-sensitive areas flagged
- [ ] Breaking changes identified

## Remember

- Always use PR HEAD SHA for accurate file content
- Categorize changes by impact and scope
- Note security-sensitive modifications
- Identify potential breaking changes
- Provide structured output for downstream skills
- Include all metadata needed for review workflow
- Flag new connectors as security-sensitive by default