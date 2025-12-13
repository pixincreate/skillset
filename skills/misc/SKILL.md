---
name: misc
description: Essential development practices including code review, refactoring, documentation, version control, error handling, and general best practices. Use when reviewing code, improving code quality, writing documentation, managing dependencies, or following development standards.
---

# Miscellaneous Development Skills

## Core Principle

**Leave code better than you found it**: Small, continuous improvements compound over time.

## Code Review

### Enhanced Review Process

**5-Step Review Methodology:**
1. **Scope Identification**
   - Identify all files to review
   - Prioritize critical areas
   - Focus on change context

2. **Apply Quality Standards**
   - Check against project-specific guidelines
   - Verify security best practices
   - Ensure architectural consistency

3. **Code Analysis**
   - Static analysis with linters
   - Pattern matching for anti-patterns
   - Type and structure validation

4. **Categorize Issues**
   - **Critical** (blocker): Security, architecture breaks, data loss
   - **Warning** (needs attention): Logic errors, quality issues
   - **Suggestion** (improvement): Style, readability

5. **Generate Quality Score**
   - 100 - (Critical×20) - (Warnings×5) - (Suggestions×1)
   - ⚪ 95-100: Excellent ✨ - Auto-approve
   - ⚪ 90-94: Good ✅ - Approve
   - ⚪ 80-89: Fair ⚠️ - Request changes
   - ⚪ 60-79: Poor ❌ - Block merge
   - ⚪ 0-59: Critical 🚨 - Block immediately

### Line Number Extraction (for GitHub)

When providing feedback:
- **ALWAYS** reference the NEW file version (PR HEAD commit)
- Extract line numbers using:
```bash
# Get HEAD commit SHA
git rev-parse origin/main
# Fetch file content at HEAD
cat /path/to/file > /tmp/file.head
# Find line number in NEW file
LINE_NUM=$(grep -n "pattern" /tmp/file.head | cut -d: -f1)
```
- Never use line numbers from diff output
- Always include: `line_reference: "NEW_FILE"`
- Verify line validity against actual file length

### Example Output Structure

```yaml
review_summary:
  score: 86
  rating: "Fair ⚠️"
  decision: "REQUEST_CHANGES"

  issue_counts:
    critical: 0
    warnings: 2
    suggestions: 3

critical_issues: []

warnings:
  - severity: WARNING
    category: Code Quality
    file: src/file.rs
    line_number: 45
    line_reference: "NEW_FILE"
    issue: "Status mapping may be incorrect"
    current_code: |
      match status { "unknown" => Failure, }
    suggested_fix: |
      match status { "unknown" => Pending, }

suggestions:
  - severity: SUGGESTION
    category: Documentation
    file: src/file.rs
    line_number: 25
    line_reference: "NEW_FILE"
    issue: "Missing doc comment for struct"
    suggested_fix: |
      /// Detailed description
      pub struct MyStruct {}
```

### Integration with Other Skills

This skill works with:
- **pr-analysis**: Provides file list and scope
- **github-review-publisher**: Publishes review comments
- **connector-integration-validator**: Parallel connector validation

### Review Templates

When writing feedback:
- **Critical**: "🚨 {issue} - {impact}"
- **Warning**: "⚠️ {issue} - {reason}"
- **Suggestion**: "💡 {suggestion} - {example}"

### Error Handling

- **File Read Failure**: Verify file exists in PR HEAD
- **Invalid Line Numbers**: Double-check against NEW file
- **Clippy Failures**: Fix before final review

### Performance Tips

- For large files: Focus on changed regions
- Cache results for unchanged files
- Process independent files in parallel

### As Reviewer

**Review For:**
- Correctness and logic errors
- Security vulnerabilities
- Performance issues
- Code readability
- Test coverage
- Error handling

**Provide Feedback:**
- Be specific: Point to exact lines
- Explain why: Context matters
- Suggest alternatives when possible
- Distinguish must-fix vs nice-to-have
- Acknowledge good code

**Example Feedback:**
```
💡 Suggestion: This query could cause N+1 problem
Consider using includes() to eager load:
User.includes(:posts).where(...)

🚨 Security: SQL injection risk
Use parameterized queries instead of string interpolation
```

### As Author

**Before Requesting Review:**
- Review your own code first
- Run tests and linters
- Write clear PR description
- Keep changes focused and reasonably sized

**PR Description Template:**
```markdown
## What
Brief summary of changes

## Why
Why this change is needed

## Testing
How was this tested

## Notes
- Areas needing special attention
- Known limitations
```

## Refactoring

### When to Refactor
- Code is hard to understand
- Duplication exists
- Functions are too long (>20-30 lines)
- Adding features is difficult

### Common Refactorings

**Extract Function:**
```javascript
// Before
function processOrder(order) {
  // validate order
  if (!order.items || order.items.length === 0) {
    throw new Error('No items');
  }
  // calculate total
  let total = 0;
  for (const item of order.items) {
    total += item.price * item.quantity;
  }
  return total;
}

// After
function processOrder(order) {
  validateOrder(order);
  return calculateTotal(order.items);
}

function validateOrder(order) {
  if (!order.items || order.items.length === 0) {
    throw new Error('No items');
  }
}

function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price * item.quantity, 0);
}
```

**Replace Magic Numbers:**
```javascript
// Before
if (user.age >= 18) { /* ... */ }

// After
const MINIMUM_AGE = 18;
if (user.age >= MINIMUM_AGE) { /* ... */ }
```

**Simplify Conditionals:**
```javascript
// Before
function canVote(user) {
  if (user.age >= 18) {
    if (user.citizenship === 'US') {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

// After
function canVote(user) {
  return user.age >= 18 && user.citizenship === 'US';
}
```

### Refactoring Rules
- Make small, incremental changes
- Run tests after each change
- Don't refactor and add features simultaneously
- Know when good enough is good enough

## Documentation

### Code Comments

**When to Comment:**
- Why, not what (code shows what)
- Complex business logic
- Non-obvious decisions
- Warnings about tricky code
- TODOs with context

```javascript
// ✅ Good
// Using exponential backoff to handle rate limiting
await retryWithBackoff(apiCall);

// Process in batches to avoid memory issues with large datasets
for (const batch of chunks(items, 1000)) { /* ... */ }

// ❌ Bad (states the obvious)
// Increment i
i++;

// Set name to userName
const name = userName;
```

### Function Documentation

```javascript
/**
 * Calculate shipping cost based on weight and destination.
 *
 * @param {number} weight - Package weight in kg
 * @param {string} destination - Two-letter country code
 * @returns {number} Shipping cost in USD
 * @throws {Error} If destination is not supported
 */
function calculateShipping(weight, destination) {
  // implementation
}
```

### README Essentials
- What the project does
- How to install and run
- Configuration options
- How to contribute
- License

## Version Control (Git)

### Commit Best Practices

**Good Commits:**
- Focused on single concern
- Have clear commit messages
- Are atomic (complete, working state)
- Are pushed regularly

**Commit Message Format:**
```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.
Explain what and why, not how.

- Can use bullet points
- For multiple changes
```

### Common Git Commands

```bash
# View changes
git status
git diff
git log --oneline -10

# Stage and commit
git add <file>
git commit -m "message"

# Branching
git checkout -b feature-name
git merge feature-name

# Syncing
git pull origin main
git push origin feature-name

# Undo changes
git checkout -- <file>  # Discard working changes
git reset HEAD <file>   # Unstage
git revert <commit>     # Create new commit that undoes
```

## Error Handling

### Error Handling Principles

**Be Specific:**
```javascript
// ❌ Bad
catch (error) {
  console.log('Error');
}

// ✅ Good
catch (error) {
  if (error instanceof ValidationError) {
    return res.status(400).json({ error: error.message });
  }
  if (error instanceof NotFoundError) {
    return res.status(404).json({ error: 'Resource not found' });
  }
  throw error; // Re-throw unexpected errors
}
```

**Provide Context:**
```javascript
throw new Error(`Failed to process order ${orderId}: ${error.message}`);
```

**Don't Swallow Errors:**
```javascript
// ❌ Bad
try {
  riskyOperation();
} catch (e) {
  // Silent failure
}

// ✅ Good
try {
  riskyOperation();
} catch (e) {
  logger.error('Risky operation failed', { error: e });
  // Handle or re-throw
}
```

## Logging

### Log Levels

- **ERROR**: Something failed, needs attention
- **WARN**: Unexpected but handled, may need attention
- **INFO**: Important business events
- **DEBUG**: Detailed diagnostic information

### What to Log

```javascript
// Good logging
logger.info('User login', { userId: user.id, ip: req.ip });
logger.error('Payment failed', {
  orderId,
  error: error.message,
  amount
});

// Don't log
logger.debug(user.password); // ❌ Sensitive data
logger.info('Starting loop iteration', { i }); // ❌ Too verbose
```

## Security Best Practices

### Input Validation
- Validate all user input
- Sanitize before use
- Use parameterized queries (prevent SQL injection)
- Whitelist, don't blacklist

### Authentication & Authorization
- Use established libraries (don't roll your own crypto)
- Hash passwords with salt (bcrypt, argon2)
- Use HTTPS for sensitive data
- Implement proper session management

### Common Vulnerabilities (OWASP Top 10)
1. **SQL Injection**: Use parameterized queries
2. **XSS**: Sanitize output, use CSP headers
3. **Broken Auth**: Use secure session management
4. **Sensitive Data Exposure**: Encrypt data, use HTTPS
5. **Missing Access Control**: Verify permissions

### Never Do
- ❌ Commit secrets to git
- ❌ Log sensitive data
- ❌ Trust user input
- ❌ Use outdated dependencies with vulnerabilities
- ❌ Disable security features

## Performance

### Quick Wins
- Add database indexes for frequent queries
- Use caching for expensive operations
- Lazy load when possible
- Minimize network requests
- Optimize images and assets

### Profile Before Optimizing
```javascript
console.time('operation');
expensiveOperation();
console.timeEnd('operation');
```

## Dependency Management

### Best Practices
- Keep dependencies updated
- Review security advisories
- Minimize dependency count
- Use lock files (package-lock.json, Cargo.lock)
- Audit regularly

```bash
# JavaScript
npm audit
npm outdated
npm update

# Python
pip list --outdated
pip-audit
```

## Code Organization

### File Structure
- Group by feature, not by type
- Keep related files together
- Use meaningful names
- Follow framework conventions

```
# ✅ Good (by feature)
users/
  UserController.js
  UserService.js
  User.model.js
  user.test.js

# ❌ Less ideal (by type)
controllers/
  UserController.js
services/
  UserService.js
models/
  User.model.js
```

## Configuration

### Configuration Best Practices
- Use environment variables for env-specific config
- Never commit secrets
- Provide defaults
- Validate config on startup
- Document all options

```javascript
// .env
DATABASE_URL=postgresql://localhost/mydb
API_KEY=secret

// config.js
const config = {
  database: process.env.DATABASE_URL,
  apiKey: process.env.API_KEY,
  port: process.env.PORT || 3000 // with default
};
```

## Development Workflow

### Before Committing
- [ ] Run tests
- [ ] Run linter
- [ ] Review your changes
- [ ] Update documentation if needed
- [ ] Remove debug code and console.logs

### Daily Practices
- Pull latest changes before starting work
- Commit frequently
- Push regularly
- Run tests locally
- Keep branches short-lived

## Quick Reference: Best Practices

**SOLID:**
- Single Responsibility
- Open/Closed
- Liskov Substitution
- Interface Segregation
- Dependency Inversion

**Other Principles:**
- DRY: Don't Repeat Yourself
- KISS: Keep It Simple, Stupid
- YAGNI: You Aren't Gonna Need It
- Separation of Concerns
- Principle of Least Surprise

## Code Quality Checklist

- [ ] Code is readable and well-organized
- [ ] Functions are small and focused
- [ ] Names are descriptive
- [ ] No duplication
- [ ] Error handling is appropriate
- [ ] Tests cover key functionality
- [ ] Security considerations addressed
- [ ] Performance is acceptable
- [ ] Documentation is adequate
- [ ] Follows project conventions

## Remember

- Code is read more than written
- Simple code > clever code
- Test your changes
- Ask for help when stuck
- Review your own code first
- Small, frequent improvements compound
- Automate repetitive tasks
- Stay curious and keep learning
