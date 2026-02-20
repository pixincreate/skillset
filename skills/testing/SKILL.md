---
name: testing
description: Write effective tests following testing best practices. Use when writing unit tests, integration tests, E2E tests, implementing TDD, improving test coverage, or ensuring code quality.
---

# Testing

Write effective tests following testing best practices.

## Overview

This skill covers:
- Testing pyramid and strategy
- Unit testing patterns
- Integration testing
- E2E testing
- Test-driven development

## When to Use

This skill auto-activates when users request:
- "Write tests"
- "Add test coverage"
- "Write unit tests"
- "Write integration tests"
- "Write E2E tests"
- "TDD"
- "Test driven"
- Any testing-related task

## Available References

### Test-Driven Development
- **test-driven-development.md** - Rigorous TDD process following Red-Green-Refactor cycle

## Usage

For detailed TDD information:

```bash
cat testing/reference/test-driven-development.md
```

## Quick Reference

### Testing Pyramid

```
       /\
      /E2E\
     /------\
    /Integration\
   /------------\
  /    Unit      \
 /________________\
```

- **Unit tests**: Fast, isolated, test single functions/components
- **Integration tests**: Test multiple units working together
- **E2E tests**: Test complete user flows

### Key Principles

1. **Test behavior, not implementation** - Test what, not how
2. **Arrange-Act-Assert** - Clear test structure
3. **One assertion per test** - When practical
4. **Descriptive names** - `user_can_login` not `test1`
5. **Fast tests** - Units should run in milliseconds

### Common Patterns

**Given-When-Then**:
```javascript
given('user is logged out', () => { ... })
when('user clicks login', () => { ... })
then('user sees dashboard', () => { ... })
```

**Mocking**:
- Mock external dependencies (APIs, databases)
- Stub slow operations
- Use test doubles appropriately

### Anti-patterns

- Testing internal implementation details
- Brittle tests that break on refactors
- Slow tests that block CI
- No tests for edge cases
- Testing multiple things in one test
