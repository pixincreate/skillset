---
name: github-review-publisher
description: "Create and publish GitHub PR review comments from code quality issues. Validates line numbers and creates pending reviews for manual approval. Use when you have code issues to publish as GitHub review comments."
---

# GitHub Review Publisher Skill

## Core Principle

**Create validated pending reviews**: Format issues as GitHub comments, validate line numbers against PR diff, create pending reviews for manual approval.

## When to Use This Skill

This skill auto-activates when users request:
- "Create review comments"
- "Publish review to GitHub"
- "Post these issues as review"
- "Create GitHub review from findings"
- "Publish code quality issues"

## Review Publishing Process

### 1. Collect Review Data

**Input Sources**:
- Issues from code-quality-review skill
- Issues from pr-analysis (context)
- Custom issue list (direct input)

**Issue Structure Required**:
```yaml
file: "path/to/file.rs"
line_number: 123           # Line in NEW file
line_reference: "NEW_FILE" # Must be "NEW_FILE"
commit_sha: "abc123..."    # PR HEAD commit
severity: "CRITICAL|WARNING|SUGGESTION"
issue: "Description"
current_code: "Problematic code"
suggested_fix: "Corrected code"
```

### 2. Normalize Input (Backward Compatibility)

**Handle old formats**:
```yaml
# Convert old format to new
if "line" exists and not "line_number":
  line_number = line
  line_reference = "NEW_FILE"

# Default missing fields
if not "line_reference":
  line_reference = "NEW_FILE"
```

### 3. Fetch PR Diff and Extract Valid Ranges

**Get PR diff**:
```bash
gh pr diff {pr-number} --repo {owner}/{repo} > /tmp/pr_diff.txt
```

**Parse diff hunks**:
```bash
# Extract hunk headers: @@ -start,count +start,count @@
grep -E '^@@ -[0-9]+(,[0-9]+)? \+[0-9]+(,[0-9]+)? @@' /tmp/pr_diff.txt
# Example: @@ -10,5 +10,7 @@
```

**Build valid line map**:
```python
valid_ranges = {}  # file -> set of valid lines

for hunk in hunks:
    file = extract_file_from_hunk(hunk)
    new_start = hunk.new_start
    new_count = hunk.new_count

    # Add valid line range
    for line in range(new_start, new_start + new_count):
        valid_ranges[file].add(line)
```

### 4. Validate Each Issue

**Validation Steps**:
```bash
is_line_valid() {
    local file="$1"
    local line="$2"

    # Check file exists in PR
    if ! grep -q "^+++ b/$file" /tmp/pr_diff.txt; then
        return 1  # File not in PR
    fi

    # Check line exists in file
    local file_lines=$(cat "/tmp/file_$file" | wc -l)
    if [ "$line" -gt "$file_lines" ]; then
        return 1  # Line doesn't exist
    fi

    # Check line is in changed hunks
    if ! echo "$valid_ranges" | grep -q "$file:$line"; then
        echo "⚠️ Line $line not in changed lines for $file"
        return 1
    fi

    return 0
}
```

**Classify Issues**:
- **VALID**: Line exists and is in changed hunks
- **SKIPPED**: Invalid line number (detailed reason)

### 5. Create Pending Review via gh CLI

**Get PR HEAD commit**:
```bash
HEAD_SHA=$(gh pr view {pr} --repo {owner}/{repo} --json headRefOid -q '.headRefOid')
```

**Create review with comments**:
```bash
# Base review call
gh api repos/{owner}/{repo}/pulls/{pr}/reviews \
  -X POST \
  -F commit_id="$HEAD_SHA" \
  -F body="" \
  -F event="COMMENT" | jq -r '.id' > /tmp/review_id

# Add each comment
for issue in valid_issues; do
    gh api repos/{owner}/{repo}/pulls/{pr}/reviews/$(cat /tmp/review_id)/comments \
      -X POST \
      -F "path=$issue_file" \
      -F "line=$issue_line" \
      -F "side=RIGHT" \
      -F "body=$issue_comment_body"
done
```

## Comment Formatting

### Severity Emojis and Priority

| Severity | Emoji | Priority | Color |
|----------|-------|----------|-------|
| CRITICAL | 🔴 | P0 | Red |
| WARNING   | 🟡 | P1 | Yellow |
| SUGGESTION | 🟢 | P2 | Green |

### Comment Structure

**Critical Issue Template**:
```markdown
🔴 **Critical** - {Category}

{Detailed explanation of issue and impact}

**Current**:
```rust
{problematic_code}
```

**Suggested Fix**:
```rust
{fixed_code}
```

**Impact**: {Why this must be fixed}
```

**Warning Template**:
```markdown
🟡 **Warning** - {Category}

{Issue description and potential problems}

**Line**: {file}:{line}
**Fix**: {quick_fix_description}
```

**Suggestion Template**:
```markdown
🟢 **Suggestion** - {Improvement type}

{Suggested improvement}

**Example**:
```diff
- {current}
+ {improved}
```
```

## Output Structure

### Successful Creation

```markdown
# 📋 PR Review Complete: PR #{pr-number}

## Review Statistics
- Total Pending Comments: {total}
  - 🔴 Critical: {critical_count}
  - 🟡 Important: {warning_count}
  - 🟢 Suggestions: {suggestion_count}

## Line-Level Comments Created (Pending Approval)

### 📄 backend/connector-integration/src/connectors/stripe.rs

**Line 25** • 🔴 Critical - Type Safety
> Using RouterData instead of RouterDataV2

**Current**:
```rust
use hyperswitch_domain_models::RouterData;
```

**Suggested Fix**:
```rust
use domain_types::router_data_v2::RouterDataV2;
```

**Impact**: This prevents the connector from working with the UCS architecture.

---

### 📄 tests/connector_tests/stripe.rs

**Line 78** • 🟡 Important - Test Coverage
> Missing test for error scenarios

**Fix**: Add test case for API error responses

---

[All remaining comments...]

---

✅ **{total} Pending Review Comments Created**

**Next Steps:**
1. Go to GitHub PR: {pr_url}/files
2. Review pending comments on specific lines
3. Manually approve/edit/delete each comment
4. Submit your review when ready

⚠️ **Comments are NOT posted publicly yet** - pending your approval in GitHub UI.
```

### Skipped Comments Report

```markdown
⚠️ **{skipped_count} Comment(s) Skipped Due to Invalid Line Numbers**

### 1. **File**: `backend/connectors/revolut.rs`
   **Line**: 999
   **Reason**: Line 999 does not exist in NEW file (file has 738 lines)
   **Valid Lines in PR**: 1-738
   **Action**: Verify line number in GitHub UI

### 2. **File**: `config/connectors/stripe.toml`
   **Line**: 5
   **Reason**: Line 5 not in changed lines (only lines 10-25 were modified)
   **Changed Lines**: 10-25
   **Action**: Check if comment should be on line 10-25
```

## Error Handling

### Common GitHub API Errors

| Error | Cause | Solution |
|-------|-------|----------|
| 422 Unprocessable Entity | Invalid line number | Use line validation before API call |
| 403 Forbidden | No write permission | Check repository permissions |
| 404 Not Found | PR/commit not found | Verify PR exists and is not merged |
| 422 Review already exists | Duplicate review | Use existing review or delete first |

### Recovery Strategies

1. **Batch Comments**: Group comments by file to reduce API calls
2. **Retry Logic**: Retry failed comments (once)
3. **Partial Success**: Report successful ones, retry others
4. **Manual Links**: Provide direct GitHub links for manual posting

## Validation Checklist

Before creating review:
- [ ] All issues normalized with required fields
- [ ] PR diff fetched and parsed
- [ ] Line numbers validated against changed hunks
- [ ] File paths verified in PR
- [ ] Comments formatted with severity emojis
- [ ] Suggested fixes provided for critical issues
- [ ] Review created as PENDING (not published)
- [ ] Skipped comments documented with reasons

## Integration Patterns

### Input from pr-analysis
```yaml
pr_info:
  pr_number: 238
  owner: "company"
  repo: "monorepo"
  head_sha: "abc123..."
  files: ["file1.rs", "file2.rs"]
```

### Input from code-quality-review
```yaml
issues:
  - file: "backend/file.rs"
    line_number: 123
    severity: "CRITICAL"
    line_reference: "NEW_FILE"
    commit_sha: "abc123..."
    # ... other fields
```

### Workflow Integration
```
pr-analysis → (metadata, files, sha)
    ↓
code-quality-review → (issues with line numbers)
    ↓
github-review-publisher → (pending review)
```

## Quick Commands

```bash
# Check PR review permissions
gh pr view {pr} --repo {owner}/{repo} --json viewerCanReview

# Get existing reviews
gh pr view {pr} --repo {owner}/{repo} --json reviews

# Delete review (if needed)
REVIEW_ID=$(gh pr view {pr} --repo {owner}/{repo} --json reviews | jq '.reviews[-1].id')
gh api repos/{owner}/{repo}/pulls/{pr}/reviews/{REVIEW_ID} -X DELETE

# Get review comments
gh pr view {pr} --repo {owner}/{repo} --json reviewComments
```

## Best Practices

### Before Publishing
1. Verify all line numbers
2. Check file existence
3. Validate permissions
4. Format comments consistently
5. Include helpful suggested fixes

### Comment Quality
1. Be specific about issues
2. Explain impact clearly
3. Provide working code examples
4. Use appropriate severity
5. Group related issues

## Remember

- Always validate line numbers before GitHub API calls
- Create PENDING reviews (manually approve before posting)
- Include detailed skipped comments report
- Provide direct PR links for manual approval
- Backward compatible with old issue formats
- Format with severity emojis for quick scanning
- Always explain the impact of critical issues