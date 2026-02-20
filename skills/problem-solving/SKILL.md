---
name: problem-solving
description: Systematic problem-solving for complex technical challenges. Use when faced with algorithmic problems, performance optimization, complex bugs, design decisions, or when multiple approaches exist. Emphasizes understanding before solving and evaluating trade-offs.
---

# Problem Solving Skill

## Core Principle

**Understand first, solve second**: Clearly define the problem before jumping to solutions.

## Problem-Solving Process

1. **Understand the Problem**
   - What exactly is the problem?
   - What is expected vs actual behavior?
   - What are the constraints?
   - What are success criteria?

2. **Break Down the Problem**
   - Decompose into smaller sub-problems
   - Identify dependencies
   - Determine what's critical vs nice-to-have

3. **Generate Solutions**
   - Brainstorm at least 3 approaches
   - Consider both simple and complex solutions
   - Look for similar solved problems

4. **Evaluate Trade-offs**
   - Time complexity (Big O)
   - Space complexity
   - Maintainability
   - Implementation time
   - Risk level

5. **Implement and Verify**
   - Start with simplest approach that works
   - Test thoroughly
   - Refine if needed

## Common Problem-Solving Strategies

### Divide and Conquer
Break into independent sub-problems, solve each, combine results.

**Good for:** Sorting, searching, tree problems

### Work Backwards
Start from desired outcome, work backwards to current state.

**Good for:** Planning, pathfinding, puzzle solving

### Simplify First
Solve simpler version, then add complexity incrementally.

**Good for:** Complex algorithms, unclear requirements

### Pattern Recognition
Match problem to known patterns/algorithms.

**Good for:** Common CS problems, established solutions exist

### Binary Search on Answer
When answer is in a range, binary search the solution space.

**Good for:** Optimization problems, "find minimum/maximum X"

## Algorithm Selection

### Searching
- **Linear search**: O(n) - unsorted data
- **Binary search**: O(log n) - sorted data
- **Hash table**: O(1) average - key-value lookup

### Sorting
- **Built-in sort**: O(n log n) - use when possible
- **Counting sort**: O(n + k) - limited range integers
- **Quick select**: O(n) average - find kth element

### Data Structures
- **Array/List**: Sequential access, O(1) index lookup
- **Hash Map/Dict**: O(1) average key lookup
- **Set**: O(1) membership, uniqueness
- **Stack**: LIFO, O(1) push/pop
- **Queue**: FIFO, O(1) enqueue/dequeue
- **Heap/Priority Queue**: O(log n) insert, O(1) min/max
- **Tree**: O(log n) operations for balanced trees

### Graph Algorithms
- **BFS**: Shortest path, level-order traversal
- **DFS**: Explore all paths, cycle detection
- **Dijkstra**: Shortest path with weights
- **Topological sort**: Dependency ordering

### Dynamic Programming
Identify:
1. Overlapping sub-problems
2. Optimal substructure
3. Recurrence relation

**Approaches:**
- **Memoization** (top-down): Cache recursive results
- **Tabulation** (bottom-up): Build table iteratively

```javascript
// Memoization example
const memo = {};
function fib(n) {
  if (n <= 1) return n;
  if (memo[n]) return memo[n];
  memo[n] = fib(n - 1) + fib(n - 2);
  return memo[n];
}
```

## Performance Optimization

### Identify Bottlenecks
1. **Profile first** - don't guess
2. Focus on biggest impact
3. Measure before and after

### Optimization Strategies
- **Algorithmic**: Better algorithm (O(n²) → O(n log n))
- **Caching**: Store computed results
- **Lazy evaluation**: Compute only when needed
- **Batch processing**: Group operations
- **Indexing**: Database query optimization
- **Parallelization**: Use multiple cores/threads

### Common Bottlenecks
- **N+1 queries**: Load related data in single query
- **Nested loops**: Often can be optimized
- **Unnecessary work**: Cache or skip redundant operations
- **Poor data structures**: Wrong tool for the job
- **No indexes**: Database scans entire table

## Decision-Making Framework

| Criterion | Option A | Option B | Option C |
|-----------|----------|----------|----------|
| **Time Complexity** | | | |
| **Space Complexity** | | | |
| **Code Complexity** | | | |
| **Maintainability** | | | |
| **Time to Implement** | | | |
| **Risk** | | | |

Choose based on:
- Requirements and constraints
- Long-term vs short-term needs
- Team expertise
- Reversibility of decision

## Problem-Solving Heuristics

### Occam's Razor
Simplest solution is usually best.

### Pareto Principle (80/20)
80% of effects from 20% of causes. Focus on high-impact areas.

### YAGNI
You Aren't Gonna Need It. Don't over-engineer for hypothetical futures.

### Rubber Duck Debugging
Explain problem out loud. Often reveals solution.

### Five Whys
Ask "why" repeatedly to find root cause.

### Take Breaks
Fresh perspective often leads to breakthroughs.

## Common Patterns

### Two Pointers
```javascript
// Example: Find pair with target sum in sorted array
function findPair(arr, target) {
  let left = 0, right = arr.length - 1;
  while (left < right) {
    const sum = arr[left] + arr[right];
    if (sum === target) return [left, right];
    if (sum < target) left++;
    else right--;
  }
  return null;
}
```

### Sliding Window
```javascript
// Example: Max sum of k consecutive elements
function maxSum(arr, k) {
  let maxSum = 0, windowSum = 0;
  for (let i = 0; i < k; i++) windowSum += arr[i];
  maxSum = windowSum;

  for (let i = k; i < arr.length; i++) {
    windowSum = windowSum - arr[i - k] + arr[i];
    maxSum = Math.max(maxSum, windowSum);
  }
  return maxSum;
}
```

### Hash Map for O(1) Lookup
```javascript
// Example: Two sum problem
function twoSum(nums, target) {
  const map = new Map();
  for (let i = 0; i < nums.length; i++) {
    const complement = target - nums[i];
    if (map.has(complement)) {
      return [map.get(complement), i];
    }
    map.set(nums[i], i);
  }
  return null;
}
```

## When Stuck

1. **Re-read the problem** - may have missed something
2. **Try examples** - work through manually
3. **Look for patterns** - similar to known problems?
4. **Simplify** - solve easier version first
5. **Take a break** - let subconscious work
6. **Ask questions** - clarify requirements
7. **Search for hints** - not full solutions
8. **Change approach** - try different strategy

## Validation Checklist

Before finalizing solution:
- [ ] Solves the original problem
- [ ] Handles edge cases (empty, single element, large input)
- [ ] Correct time complexity
- [ ] Acceptable space complexity
- [ ] Code is readable and maintainable
- [ ] No obvious bugs or off-by-one errors
- [ ] Tested with multiple examples
- [ ] Errors handled appropriately

## Time Complexity Quick Reference

| Complexity | Name | Example |
|------------|------|---------|
| O(1) | Constant | Hash lookup, array access |
| O(log n) | Logarithmic | Binary search |
| O(n) | Linear | Single loop, linear search |
| O(n log n) | Linearithmic | Efficient sorting |
| O(n²) | Quadratic | Nested loops |
| O(2ⁿ) | Exponential | Recursive fibonacci (naive) |
| O(n!) | Factorial | Generate all permutations |

## Anti-Patterns

- **Jumping to code** without understanding
- **Over-engineering** simple problems
- **Premature optimization** before profiling
- **Analysis paralysis** - thinking too long
- **Ignoring edge cases**
- **Not testing solution**
- **Reinventing the wheel** - use built-ins/libraries

## Quick Problem Types

### String Manipulation
- Use built-in methods when possible
- Consider character array for mutations
- Hash map for character counting
- Two pointers for palindromes

### Array Problems
- Two pointers for sorted arrays
- Hash map for O(1) lookup
- Sliding window for subarrays
- Binary search if sorted

### Tree Problems
- Recursion is natural fit
- Consider BFS vs DFS
- Use helper functions

### Graph Problems
- Choose BFS or DFS appropriately
- Track visited nodes
- Consider using queue (BFS) or stack (DFS)

## References and Further Reading

### Essential Problem-Solving Resources
- [LeetCode](https://leetcode.com) - Algorithmic practice with curated problems
- [HackerRank](https://hackerrank.com) - Data structures and algorithm challenges
- [Codeforces](https://codeforces.com) - Competitive programming contests
- [Project Euler](https://projecteuler.net) - Mathematical/computational problems
- [Advent of Code](https://adventofcode.com) - Daily coding challenges (December)

### Algorithm Design References
- [Introduction to Algorithms (CLRS)](https://mitpress.mit.edu/9780262033848/) - The comprehensive algorithm textbook
- [Algorithm Design Manual](https://www.algorist.com) - Practical problem-solving approach
- [GeeksforGeeks](https://geeksforgeeks.org) - Extensive algorithm explanations
- [Competitive Programmer's Handbook](https://cses.fi/book.pdf) - Free comprehensive guide

### Problem-Solving Methodologies
- [How to Solve It by George Pólya](https://press.princeton.edu/books/paperback/9780691164076/how-to-solve-it) - Classic problem-solving framework
- [Think Like a Programmer](https://nostarch.com/thinklikeaprogrammer) - Problem-solving mindset
- [The Pragmatic Programmer](https://pragprog.com/titles/tpp20) - Practical problem approaches
- [Clean Code](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship) - Writing maintainable solutions

### Complexity Analysis References
- [Big O Cheat Sheet](https://www.bigocheatsheet.com) - Quick complexity reference
- [VisuAlgo](https://visualgo.net) - Visual algorithm animations
- [Algorithm Visualizer](https://algorithm-visualizer.org) - Interactive algorithm exploration

### Specific Technique References
- Dynamic Programming: [MIT 6.006](https://ocw.mit.edu/courses/6-006-introduction-to-algorithms-spring-2020/) lectures
- Graph Algorithms: [Algorithms Specialization](https://www.coursera.org/specializations/algorithms)
- System Design: [System Design Primer](https://github.com/donnemartin/system-design-primer)

## Task Breakdown

Break down complex problems into manageable tasks:

1. **Identify Components**: What are the main parts?
2. **Identify Dependencies**: What must be done first?
3. **Estimate Effort**: How long each task takes
4. **Order Tasks**: Dependency-first ordering
5. **Create Checkpoints**: Milestones for validation

### Task Granularity

**Each task should be 2-5 minutes:**

- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make test pass" - step
- "Run tests and verify they pass" - step
- "Commit" - step

## Systematic Engineering

Plan and execute complex code changes systematically:

1. **Analyze**: Map affected files and dependencies
2. **Plan**: Determine optimal order (Dependencies First)
3. **Execute**: Implement changes atomically and incrementally
4. **Rescue**: If errors occur, trace back to root cause

### Principles

- **Atomic Changes**: Testable, independent steps
- **Dependency First**: Resolve dependencies before dependents
- **Test Early**: Validate at each step
- **Rollback Strategy**: Know how to revert if needed

## Remember

- Understand the problem thoroughly first
- Consider multiple approaches before coding
- Start simple, optimize if needed
- Test edge cases
- Measure, don't guess for optimization
- Clear code > clever code
- Perfect is the enemy of good
- Practice regularly to improve pattern recognition
