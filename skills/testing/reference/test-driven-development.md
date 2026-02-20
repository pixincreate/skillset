# Test-Driven Development Reference

Follow rigorous TDD process for robust, testable code.

## Core Principle

**Red-Green-Refactor Cycle**: Write failing tests first, then make them pass, then improve code quality.

The iron law: **NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST**

---

## The Process

### 1. Red — Write a Failing Test

Write the smallest test that expresses what you want to build. Watch it fail.

- Test describes desired behavior
- Test fails because code doesn't exist yet
- Don't skip this step

### 2. Green — Make It Pass

Write minimal code to make the test pass.

- Focus on getting to green, not perfect code
- No premature optimization
- Just enough to satisfy the test

### 3. Refactor — Improve Code

Clean up the code while keeping tests green.

- Remove duplication
- Improve names
- Extract functions
- All tests must still pass

---

## TDD Guidelines

### Test Structure

```javascript
describe('FeatureName', () => {
  describe('when condition', () => {
    it('should do thing', () => {
      // Arrange
      const input = ...
      
      // Act
      const result = functionUnderTest(input)
      
      // Assert
      expect(result).toBe(...)
    })
  })
})
```

### Naming Conventions

- Describe behavior: `userCanLogin` not `testLogin`
- Use "should": `it('should return user by id', ...)`
- Be specific: `it('should throw error when id is negative', ...)`

### Test Scope

- One behavior per test
- Test edge cases
- Test happy path
- Test error conditions

### What to Test

- Public APIs
- Boundary conditions
- Error handling
- Expected behavior

### What NOT to Test

- Implementation details
- Private methods
- Third-party code
- Trivial code (getters/setters)

---

## Rationalizations (Don't Do These)

| Instead of... | Do this |
|---------------|---------|
| "I'll write tests after" | Write tests first |
| "This is too simple to test" | Test anyway |
| "I'll remember to add tests later" | Add now |
| "The test is hard to write" | Simplify the design |
| "It's faster without tests" | Write tests - it's faster long-term |

---

## Verification Checklist

Before considering TDD complete:

- [ ] All tests pass
- [ ] Tests cover boundary conditions
- [ ] Tests are readable
- [ ] Refactoring didn't break tests
- [ ] No commented-out tests
- [ ] Test names describe behavior
- [ ] Each test has single responsibility

---

## Common Mistakes

1. **Writing code before tests** - Violates the iron law
2. **Testing implementation** - Tests become brittle
3. **Large tests** - Hard to debug, maintain
4. **Skipping refactor** - Technical debt accumulates
5. **Not running tests frequently** - Breakage accumulates

---

## Best Practices

1. **Run tests frequently** - Every few minutes
2. **Keep tests fast** - Milliseconds per test
3. **Test in isolation** - No shared state
4. **Use descriptive names** - Self-documenting
5. **Follow naming conventions** - Consistency matters
6. **One assertion per test** - When practical
7. **Mock external dependencies** - Test units in isolation

---

## When TDD Is Difficult

TDD may not work well for:
- Exploratory work
- UI layouts (hard to specify behavior upfront)
- Performance optimization
- Legacy code (add tests after)

In these cases, write tests after implementation but before moving on.
