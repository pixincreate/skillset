---
name: misc
description: Essential development practices including code review, refactoring, documentation, version control, error handling, and general best practices. Use when reviewing code, improving code quality, writing documentation, managing dependencies, or following development standards.
---

# Miscellaneous Development Skills

## Core Principle

**Leave code better than you found it**: Small, continuous improvements compound over time.

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
