---
name: debugging
description: Systematic debugging workflow for identifying, isolating, and fixing bugs. Use when troubleshooting errors, unexpected behavior, performance issues, or when code isn't working as expected. Focuses on methodical investigation over random trial-and-error.
---

# Debugging Skill

## Core Principle

**Debug systematically**: Understand → Reproduce → Isolate → Fix → Verify

## Quick Reference Workflow

1. **Gather Information**
   - Read complete error messages and stack traces
   - Check recent changes (git log, git diff)
   - Review relevant logs and console output
   - Document reproduction steps

2. **Reproduce Consistently**
   - Create minimal reproduction case
   - Document exact steps and conditions
   - Test in isolation when possible

3. **Form and Test Hypotheses**
   - Based on errors, form likely causes
   - Test most probable hypotheses first
   - Use binary search to narrow scope

4. **Isolate the Issue**
   - Add strategic logging/breakpoints
   - Check variable states and data flow
   - Verify assumptions about code behavior
   - Use git bisect for regression bugs

5. **Implement Minimal Fix**
   - Address root cause, not symptoms
   - Keep changes focused and simple
   - Follow existing patterns

6. **Verify Thoroughly**
   - Confirm original bug is fixed
   - Run full test suite
   - Test edge cases
   - Add regression test

## Investigation Techniques

### For Runtime Errors
- Parse stack trace from bottom to top (your code entry point)
- Check for null/undefined/None values
- Verify data types match expectations
- Look for off-by-one errors in loops/arrays

### For Logic Errors
- Trace execution with print/console.log at key decision points
- Verify conditional logic evaluates correctly
- Check algorithm correctness step-by-step
- Validate data transformations produce expected output

### For Performance Issues
- Profile first, optimize second
- Check for N+1 queries in database calls
- Look for unnecessary loops or computations
- Review algorithm complexity (O(n²) → O(n log n))
- Check for memory leaks or resource retention

### For Integration Issues
- Verify API request/response formats
- Check authentication tokens and headers
- Validate environment variables and configuration
- Review network tab for failed requests
- Confirm dependency versions match expectations

## Common Debugging Commands

```bash
# View recent changes
git log --oneline -10
git diff HEAD~5..HEAD

# Find when bug was introduced
git bisect start
git bisect bad HEAD
git bisect good <known-good-commit>

# Check running processes/ports
lsof -i :<port>
ps aux | grep <process>

# Monitor logs in real-time
tail -f <logfile>

# Test specific scenario
# (language-specific test commands)
```

## Strategic Logging

Add logging at:
- Function entry/exit points
- Before/after data transformations
- Error handling blocks
- Conditional branches
- External API calls

```javascript
// Good logging pattern
console.log('[functionName] Input:', JSON.stringify(input));
const result = transform(input);
console.log('[functionName] Output:', JSON.stringify(result));
```

## Anti-Patterns to Avoid

- Making multiple changes without testing each
- Skipping error message details
- Debugging by random code changes
- Fixing symptoms instead of root cause
- Not running tests after fix
- Leaving debug code in final version

## When Stuck

1. Take a break (fresh perspective)
2. Explain problem to someone (rubber duck debugging)
3. Search error message verbatim
4. Check GitHub issues for similar problems
5. Verify basic assumptions (is server running? correct environment?)
6. Start from known working state and incrementally add changes

## Verification Checklist

Before marking bug as fixed:
- [ ] Original issue no longer reproduces
- [ ] All existing tests pass
- [ ] Edge cases tested
- [ ] No new warnings or errors
- [ ] Code reviewed for similar bugs elsewhere
- [ ] Regression test added
