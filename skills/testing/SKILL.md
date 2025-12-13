---
name: testing
description: Writing effective tests following testing best practices. Use when writing unit tests, integration tests, E2E tests, implementing TDD, improving test coverage, or ensuring code quality. Emphasizes the testing pyramid and maintainable test code.
---

# Testing Skill

## Core Principle

**Test behavior, not implementation**: Write tests that verify what code does, not how it does it.

## Testing Pyramid

```
    /\     E2E Tests (Few)
   /  \    - Full user workflows
  /____\   - Slowest, most expensive
 /      \  Integration Tests (Some)
/        \ - Component interactions
/__________\ Unit Tests (Many)
             - Individual functions
             - Fast, isolated
```

## Unit Testing

### Arrange-Act-Assert Pattern
```javascript
test('calculateTotal returns sum of item prices', () => {
  // Arrange: Set up test data
  const items = [{ price: 10 }, { price: 20 }];

  // Act: Execute the function
  const result = calculateTotal(items);

  // Assert: Verify outcome
  expect(result).toBe(30);
});
```

### Test Naming
Be descriptive and specific:
- ✅ `test('throws error when email is invalid')`
- ✅ `test('returns empty array when no results found')`
- ❌ `test('test user function')`
- ❌ `test('it works')`

### What to Test
- **Happy path**: Normal, expected usage
- **Edge cases**: Empty inputs, boundaries, max values
- **Error cases**: Invalid inputs, error conditions
- **State changes**: Side effects and mutations

### What NOT to Test
- Framework internals
- Third-party library code
- Trivial getters/setters
- Generated code

## Test-Driven Development (TDD)

### Red-Green-Refactor Cycle
1. **Red**: Write failing test first
2. **Green**: Write minimal code to pass
3. **Refactor**: Improve while keeping tests green

```javascript
// 1. RED - Write failing test
test('formatCurrency adds dollar sign and cents', () => {
  expect(formatCurrency(100)).toBe('$100.00');
});
// Test fails: formatCurrency is not defined

// 2. GREEN - Make it pass
function formatCurrency(amount) {
  return `$${amount.toFixed(2)}`;
}
// Test passes

// 3. REFACTOR - Improve (if needed)
// Add error handling, optimize, etc.
```

**Use TDD for:**
- Complex business logic
- Bug fixes (write test that reproduces bug first)
- Clear requirements
- Designing new APIs

## Mocking

### When to Mock
- External dependencies (APIs, databases)
- Slow operations
- Non-deterministic functions (Date.now(), Math.random())
- File system operations
- Complex setup requirements

### When NOT to Mock
- Simple pure functions
- What you're actually testing
- Dependencies you control (prefer integration test)

### Mocking Examples

**JavaScript (Jest):**
```javascript
// Mock a module
jest.mock('./api');

// Mock a function
const mockFetch = jest.fn().mockResolvedValue({ data: 'test' });

// Spy on a method
const spy = jest.spyOn(obj, 'method');

// Verify mock was called
expect(mockFetch).toHaveBeenCalledWith('/api/users');
```

**Python (pytest):**
```python
from unittest.mock import Mock, patch

# Mock an object
mock_db = Mock()
mock_db.get_user.return_value = {'name': 'Test'}

# Patch a function
with patch('module.function') as mock_func:
    mock_func.return_value = 'mocked'
    # Run test
```

## Integration Testing

Test component interactions without mocking everything:

```javascript
// Test API endpoint with test database
test('POST /users creates user in database', async () => {
  const response = await request(app)
    .post('/users')
    .send({ name: 'Test', email: 'test@example.com' });

  expect(response.status).toBe(201);

  // Verify in test database
  const user = await db.users.findOne({ email: 'test@example.com' });
  expect(user.name).toBe('Test');

  // Cleanup
  await db.users.deleteOne({ _id: user._id });
});
```

### Integration Test Best Practices
- Use test databases/environments
- Clean up test data (use transactions, afterEach hooks)
- Test realistic scenarios
- Don't duplicate unit test coverage

## Testing Async Code

```javascript
// Async/await (preferred)
test('fetchUser returns user data', async () => {
  const user = await fetchUser(1);
  expect(user.name).toBe('John');
});

// Promises
test('fetchUser returns user data', () => {
  return fetchUser(1).then(user => {
    expect(user.name).toBe('John');
  });
});

// Error handling
test('fetchUser throws on invalid ID', async () => {
  await expect(fetchUser(-1)).rejects.toThrow('Invalid ID');
});
```

## Test Data Management

### Use Factories/Builders
```javascript
// Factory function
function createUser(overrides = {}) {
  return {
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
    role: 'user',
    ...overrides
  };
}

// Use in tests
test('admin can delete users', () => {
  const admin = createUser({ role: 'admin' });
  expect(canDelete(admin)).toBe(true);
});
```

### Test Data Principles
- Make data obvious and meaningful
- Use minimal data for test
- Each test has independent data
- Clean up after tests

## Common Testing Patterns

### Testing Errors
```javascript
test('throws error for invalid input', () => {
  expect(() => divide(10, 0)).toThrow('Division by zero');
});

test('returns error status for bad request', async () => {
  const response = await api.post('/users', { invalidData });
  expect(response.status).toBe(400);
  expect(response.body.error).toBeDefined();
});
```

### Testing State Changes
```javascript
test('adds item to cart', () => {
  const cart = new ShoppingCart();
  cart.addItem({ id: 1, price: 10 });

  expect(cart.items).toHaveLength(1);
  expect(cart.total()).toBe(10);
});
```

### Parameterized Tests
```javascript
test.each([
  [2, 3, 5],
  [0, 5, 5],
  [-1, 1, 0],
])('add(%i, %i) returns %i', (a, b, expected) => {
  expect(add(a, b)).toBe(expected);
});
```

## Test Organization

### Structure
```
src/
  components/
    Button.js
    Button.test.js      # Co-located
  utils/
    format.js
    format.test.js

# OR

src/
  components/
    Button.js
tests/
  components/
    Button.test.js      # Mirrored structure
```

### Test Suites
```javascript
describe('UserService', () => {
  describe('createUser', () => {
    test('creates user with valid data', () => {});
    test('throws error for duplicate email', () => {});
  });

  describe('deleteUser', () => {
    test('deletes existing user', () => {});
    test('throws error for non-existent user', () => {});
  });
});
```

## Test Coverage

### Understanding Coverage
- **Line**: Which lines executed
- **Branch**: Which if/else branches taken
- **Function**: Which functions called
- **Statement**: Which statements executed

### Coverage Best Practices
- Aim for 70-90% coverage (100% often not worth it)
- Focus on critical paths and complex logic
- Coverage doesn't guarantee quality
- Missing coverage reveals untested code
- Don't test just for coverage

### Check Coverage
```bash
# JavaScript
npm test -- --coverage

# Python
pytest --cov=src --cov-report=html
```

## Test Maintenance

### Keep Tests Clean
- Refactor tests like production code
- Remove duplication (use helpers, fixtures)
- Update tests when requirements change
- Delete obsolete tests

### Test Smells
- ❌ Tests depend on execution order
- ❌ Tests share mutable state
- ❌ Tests test multiple things
- ❌ Flaky tests (pass/fail randomly)
- ❌ Slow tests that could be fast
- ❌ Overly complex test setup
- ❌ Testing implementation details

## Framework-Specific Quick Reference

### JavaScript/TypeScript
```bash
# Jest
npm test
npm test -- --watch
npm test -- Button.test.js

# Vitest
npm run test
npm run test -- --ui
```

### Python
```bash
# pytest
pytest
pytest -v                    # Verbose
pytest tests/test_user.py   # Specific file
pytest -k "test_create"     # Match pattern
pytest --pdb                # Debug on failure
```

## Testing Checklist

Before committing tests:
- [ ] Tests have descriptive names
- [ ] Tests are independent (can run in any order)
- [ ] Happy path tested
- [ ] Edge cases covered
- [ ] Error conditions tested
- [ ] Async code properly awaited
- [ ] Mocks used appropriately
- [ ] Test data is clear
- [ ] Tests are fast
- [ ] All tests pass

## Quick Debugging Tests

```bash
# Run single test
npm test -- -t "test name pattern"

# Run in watch mode
npm test -- --watch

# Run with verbose output
npm test -- --verbose

# Debug test (Node)
node --inspect-brk node_modules/.bin/jest --runInBand

# See console.log output
npm test -- --silent=false
```

## Anti-Patterns

- **Ice Cream Cone**: More E2E than unit tests
- **Testing Implementation**: Tests break on refactor
- **Fragile Tests**: Break from minor changes
- **Mystery Guest**: Unclear test setup
- **Assertion Roulette**: Too many assertions per test
- **Slow Tests**: Suite takes too long to run
- **Ignoring Failures**: Skipped or commented tests

## Remember

- Tests are documentation - they show how code should be used
- Good tests enable confident refactoring
- Write tests that would have caught past bugs
- Fast tests = more frequent testing = better quality
- Test the contract, not the implementation
