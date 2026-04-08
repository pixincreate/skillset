---
name: code-quality-review
description: "Perform comprehensive code quality reviews with project-specific standards and security checks. Use when reviewing code changes, PRs, or files for quality issues. Generates issues categorized by severity with accurate line numbers for GitHub API integration."
---

# Code Quality Review Skill

## Core Principle

**Systematic quality analysis**: Apply project standards, security best practices, and extract accurate line numbers for GitHub PR reviews.

## When to Use This Skill

This skill auto-activates when users request:
- "Review this code"
- "Check code quality"
- "Find security issues"
- "Validate best practices"
- "Review PR #123"
- "Analyze file.rs for issues"

## Review Process

### 1. Scope Identification

**Input Types**:
- PR Number (reviews all changed files)
- Specific file paths (targeted review)
- Diff content (inline review)
- Current directory (all files)

### 2. Extract Line Numbers from NEW File

**CRITICAL**: Always extract line numbers from the NEW file at PR HEAD commit, not from diff positions.

```bash
# Get PR HEAD commit SHA
HEAD_SHA=$(gh pr view {pr-number} --repo {owner}/{repo} --json headRefOid -q '.headRefOid')

# Fetch file content at HEAD commit
gh api repos/{owner}/{repo}/contents/{file-path}?ref=$HEAD_SHA \
  --jq '.content' | base64 -d > /tmp/file_at_head.rs

# Find line number in NEW file
LINE_NUM=$(grep -n "{pattern}" /tmp/file_at_head.rs | head -1 | cut -d: -f1)
```

### 3. Apply Quality Standards

**Category Checks**:

#### Connector Integration Standards
- ✅ Use `RouterDataV2` instead of deprecated `RouterData`
- ✅ Use `MinorUnit` for monetary amounts
- ✅ No hardcoded IDs or test keys
- ✅ Proper error handling with existing error types
- ✅ Implement all required payment flows

#### Core Domain Standards
- ✅ Type safety with proper serialization
- ✅ No `.unwrap()` in production code
- ✅ Enum variants explicitly handled
- ✅ Optional fields properly typed

#### Security Standards
- ✅ No SQL injection vulnerabilities
- ✅ No hardcoded secrets or API keys
- ✅ Proper input validation
- ✅ Safe error handling (no sensitive data exposure)

### 4. Issue Categorization

**Severity Levels**:
- **CRITICAL** (-20 points): Security issues, breaking changes, type errors
- **WARNING** (-5 points): Code quality, potential bugs, performance issues
- **SUGGESTION** (-1 point): Style, documentation, minor improvements

### 5. Generate Quality Score

```
Score = 100 - (Critical × 20) - (Warnings × 5) - (Suggestions × 1)
```

**Rating Scale**:
- 95-100: Excellent ✨ (Auto-approve)
- 90-94: Good ✅ (Approve)
- 80-89: Needs Work ⚠️ (Request changes)
- 70-79: Significant Issues ❌ (Block merge)
- <70: Critical Issues 🚨 (Urgent fix needed)

## Output Structure

```yaml
review_summary:
  score: 92
  rating: "Good ✅"
  decision: "APPROVE"
  issue_counts:
    critical: 0
    warnings: 1
    suggestions: 3
  files_reviewed: 8
  lines_checked: 1247

critical_issues: []

warnings:
  - severity: WARNING
    category: "Code Quality"
    file: "backend/connectors/stripe/transformers.rs"
    line_number: 78          # Line in NEW file
    line_reference: "NEW_FILE"  # Explicit reference
    commit_sha: "abc123..."     # PR HEAD commit
    issue: "Status mapping may be incorrect"
    current_code: |
      status: match api_status { "unknown" => AttemptStatus::Failure }
    suggested_fix: |
      status: match api_status { "unknown" => AttemptStatus::Pending }
    rule_reference: "connector-status-mapping"

suggestions:
  - severity: SUGGESTION
    category: "Documentation"
    file: "backend/connectors/stripe/config.rs"
    line_number: 15
    line_reference: "NEW_FILE"
    commit_sha: "abc123..."
    issue: "Add documentation for configuration fields"
    current_code: |
      pub struct StripeConfig {
          api_key: String,
      }
    suggested_fix: |
      /// Configuration for Stripe connector
      ///
      /// # Fields
      /// - `api_key`: Stripe secret key (starts with sk_)
      pub struct StripeConfig {
          /// Stripe secret key
          api_key: String,
      }
```

## Quality Standards Reference

### Connector Integration Rules

1. **RouterDataV2 Usage**
```rust
// ❌ WRONG
use hyperswitch_domain_models::RouterData;

// ✅ CORRECT
use domain_types::router_data_v2::RouterDataV2;
```

2. **MinorUnit for Amounts**
```rust
// ❌ WRONG
amount: u64, // Raw amount

// ✅ CORRECT
amount: MinorUnit, // Properly structured
```

3. **Error Handling**
```rust
// ❌ WRONG
value.unwrap() // Panics on None

// ✅ CORRECT
value.ok_or_else(|| ApiError::MissingValue)?
```

### Security Patterns

1. **No Hardcoded Secrets**
```rust
// ❌ WRONG
api_key: "sk_test_123456789"

// ✅ CORRECT
api_key: config.get("STRIPE_API_KEY")?
```

2. **Input Validation**
```rust
// ❌ WRONG
fn process_amount(amount: String) -> u64 {
    amount.parse().unwrap()
}

// ✅ CORRECT
fn process_amount(amount: &str) -> Result<MinorUnit, ApiError> {
    amount.parse::<u64>()
        .map(MinorUnit::from)
        .map_err(|_| ApiError::InvalidAmount)
}
```

## Line Number Extraction Methods

### Method 1: GitHub API (Most Reliable)

```bash
# Get file at specific commit
HEAD_SHA=$(gh pr view {pr} --repo {owner}/{repo} --json headRefOid -q '.headRefOid')
gh api repos/{owner}/{repo}/contents/{file}?ref=$HEAD_SHA | jq -r '.content' | base64 -d > /tmp/file

# Find line for pattern
grep -n "pattern" /tmp/file | cut -d: -f1
```

### Method 2: Git Checkout

```bash
# Checkout PR HEAD
gh pr checkout {pr} --repo {owner}/{repo}

# Find line number
grep -n "pattern" path/to/file.rs
```

### Method 3: Direct Parsing

```rust
// When analyzing code directly
let content = std::fs::read_to_string(file_path)?;
let lines: Vec<&str> = content.lines().collect();
for (i, line) in lines.iter().enumerate() {
    if line.contains(target_pattern) {
        return Some(i + 1); // Line number (1-based)
    }
}
```

## Common Issue Patterns

### Type Safety Issues
```yaml
- Using RouterData instead of RouterDataV2
- Missing error handling with .unwrap()
- Unhandled enum variants
- Incorrect Option/Result handling
```

### Security Issues
```yaml
- Hardcoded API keys or secrets
- SQL injection vulnerabilities
- Sensitive data in logs/errors
- Missing input validation
```

### Code Quality Issues
```yaml
- Inconsistent error types
- Missing documentation
- Magic numbers without constants
- Dead or unused code
```

## Validation Checklist

Before publishing review:
- [ ] Line numbers extracted from NEW file
- [ ] `line_reference` set to "NEW_FILE"
- [ ] Commit SHA included for validation
- [ ] All issues categorized by severity
- [ ] Suggested fixes provided
- [ ] Rule references included
- [ ] No hardcoded secrets in suggestions
- [ ] Quality score calculated correctly

## Integration with Other Skills

### Works With

- **pr-analysis**: Provides file paths and commit SHA
- **github-review-publisher**: Consumes structured issues
- **collaboration**: Enhanced review process

### Required Fields for Integration

```yaml
# Required by github-review-publisher
file: "path/to/file.rs"
line_number: 123
line_reference: "NEW_FILE"
commit_sha: "abc123..."
severity: "CRITICAL|WARNING|SUGGESTION"
issue: "Description of problem"
current_code: "Line(s) with issue"
suggested_fix: "Corrected code"
```

## Best Practices

### During Review

1. **Be consistent**: Apply same standards across all files
2. **Be constructive**: Provide clear, actionable feedback
3. **Be specific**: Show exact code with line numbers
4. **Be helpful**: Include suggested fixes with examples
5. **Be accurate**: Double-check line numbers

### Issue Formatting

1. **Category matters**: Group issues by type
2. **Severity consistency**: Apply same criteria
3. **Code context**: Include enough surrounding code
4. **Fix explanation**: Explain why fix is needed

## Quick Reference

### Severity Quick Guide

| Issue Type | Severity | Points | Example |
|------------|----------|--------|---------|
| Security vulnerability | CRITICAL | -20 | Hardcoded API key |
| Breaking change | CRITICAL | -20 | Removed field from struct |
| Type error | CRITICAL | -20 | Wrong type in signature |
| Performance issue | WARNING | -5 | N+1 query pattern |
| Code quality | WARNING | -5 | Inconsistent error type |
| Missing documentation | SUGGESTION | -1 | Undocumented public function |
| Style issue | SUGGESTION | -1 | Inconsistent naming |

### Common Commands

```bash
# Find RouterData usage
grep -r "use.*RouterData" --include="*.rs" backend/

# Check for unwraps
grep -r "\.unwrap()" --include="*.rs" backend/

# Look for hardcoded keys
grep -r "sk_test\|rk_test" --include="*.rs" backend/

# Check API responses
grep -r "serde::Serialize\|serde::Deserialize" --include="*.rs" backend/
```

## Remember

- Always extract line numbers from NEW file at PR HEAD
- Include `line_reference: "NEW_FILE"` for GitHub API
- Provide suggested fixes with code examples
- Categorize issues consistently
- Calculate quality score based on severity
- Focus on security and breaking changes first
- Be constructive and specific in feedback

---

## Related Skills

- **pr-analysis** — Provides file paths and commit SHA for integration
- **github-review-publisher** — Consumes structured issues for GitHub
- **collaboration** — Enhanced review process