---
name: research
description: Systematic technical research and codebase exploration. Use when investigating unfamiliar codebases, evaluating technologies, researching APIs, understanding problem domains, or gathering information for technical decisions. Emphasizes thorough exploration before implementation.
---

# Research Skill

## Core Principle

**Explore systematically**: Define goal → Search strategically → Synthesize findings → Document clearly

## Research Workflow

1. **Define Objective**
   - What specific question needs answering?
   - What decision will this inform?
   - What level of detail is needed?
   - When is enough information enough?

2. **Search and Explore**
   - Use Task tool with Explore agent for comprehensive searches
   - Search strategically (breadth-first for overview, depth-first for specifics)
   - Document findings as you go

3. **Synthesize Information**
   - Connect related pieces
   - Identify patterns and contradictions
   - Separate facts from opinions
   - Note gaps requiring further investigation

4. **Present Findings**
   - Summarize key discoveries with evidence
   - Provide specific references (file:line, URLs)
   - Include recommendations
   - Note trade-offs and risks

## Codebase Research

### Initial Exploration
```bash
# Understand project structure
ls -la
tree -L 2 -I 'node_modules|dist|build'

# Review configuration and documentation
# Check: README.md, package.json, requirements.txt, Cargo.toml

# Examine entry points
# Look for: main.js, index.js, app.py, main.go
```

### Finding Functionality

**PR Analysis Approach**:

When analyzing pull requests:

1. **Parse Input**
   - Extract PR number and repository
   - Auto-detect repository from git remote
   ```bash
   git remote get-url origin
   # Parse: https://github.com/owner/repo.git → owner/repo
   ```

2. **Fetch PR Metadata**
   ```bash
   gh pr view {pr-number} --repo {owner}/{repo} \
     --json number,title,author,state,headRefName,baseRefName
   ```

3. **Identify File Changes**
   ```bash
   gh pr diff {pr-number} --repo {owner}/{repo} --name-only
   ```
   - Categorize by type:
     - Connector files: `backend/connector-integration/src/connectors/**`
     - Core domain: `backend/domain_types/**`
     - Tests: `**/*test*.rs`, `**/tests/**`

4. **Analyze Change Scope**
   - Determine primary category:
     - `connector_integration`
     - `core_domain`
     - `api_changes`
     - `infrastructure`
     - `documentation`
     - `tests`
   - Identify security-sensitive areas
   - Detect performance-critical paths

5. **Extract Diff Content**
   ```bash
   gh pr diff {pr-number} --repo {owner}/{repo}
   ```
   - Analyze hunks for added/removed lines
   - Focus on significant changes

**PR Analysis Output Structure**:
```yaml
pr_number: 238
scope:
  primary: connector_integration
  categories:
    - connector_integration
    - core_domain
    - tests
  change_characteristics:
    new_connector: true
    security_sensitive: true
    large_refactor: false

files_changed:
  connector_files:
    - backend/connector-integration/src/connectors/stripe.rs
  core_domain:
    - backend/domain_types/src/types.rs
```

**When to Use**:
- When investigating PRs for code reviews
- Before deep-diving into code changes
- To understand the scope of changes
- To identify critical areas for review

**Integration with Other Skills**:
- Works with `code-quality-review` for targeted analysis
- Provides context for `collaboration` skill's review process
- Complements codebase research for understanding change context
**Use Explore agent for:**
- Broad searches across codebase
- Understanding code patterns
- Finding similar implementations
- Multiple naming variations

**Use Grep for:**
- Specific keywords or patterns
- Known function/class names
- Error messages or strings

**Follow the Trail:**
1. Find entry point or test file
2. Follow imports/requires
3. Trace function calls
4. Read related test files for usage examples
5. Check git history for context: `git log --follow <file>`

### Understanding Code Flow
- Start from entry points (main, index, app)
- Trace key user flows through code
- Map data transformations
- Identify state management patterns
- Note error handling approaches

## Technology Research

### Quick Evaluation Checklist

| Criterion | Questions |
|-----------|-----------|
| **Functionality** | Does it solve the problem? What features? |
| **Maturity** | Production-ready? Latest version? Release frequency? |
| **Maintenance** | Active development? Recent commits? Responsive maintainers? |
| **Community** | GitHub stars? Stack Overflow questions? Tutorials? |
| **Documentation** | Complete? Up-to-date? Good examples? |
| **Performance** | Benchmarks available? Known bottlenecks? |
| **Dependencies** | How many? Security vulnerabilities? |
| **License** | Compatible with project? |
| **Team Fit** | Learning curve? Expertise required? |

### Comparative Analysis Template

| Feature | Library A | Library B | Library C |
|---------|-----------|-----------|-----------|
| Size | | | |
| Performance | | | |
| API simplicity | | | |
| Documentation | | | |
| Community | | | |
| Last updated | | | |
| License | | | |
| **Recommendation** | | | |

### Information Sources
1. **Official docs** (start here)
2. **GitHub repository** (README, issues, discussions)
3. **npm/PyPI/crates.io** (package metadata, downloads)
4. **Stack Overflow** (common problems)
5. **Dev.to/Medium** (tutorials, comparisons)
6. **GitHub search** (code examples, real usage)

## API Research

### Understanding an API
1. **Read documentation/OpenAPI spec**
2. **Check authentication** (API key, OAuth, JWT?)
3. **Review endpoints** (REST, GraphQL, RPC?)
4. **Understand rate limits** and quotas
5. **Test key endpoints** (Postman, curl, httpie)
6. **Check error responses** and status codes
7. **Review SDKs** if available
8. **Note versioning** and deprecation policy

### API Testing Pattern
```bash
# Test with curl
curl -X GET "https://api.example.com/v1/resource" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json"

# Or with httpie (more readable)
http GET api.example.com/v1/resource \
  Authorization:"Bearer $TOKEN"
```

## Search Strategies

### Effective Code Search
**Try multiple variations:**
- `getUser`, `fetchUser`, `retrieveUser`, `loadUser`
- `UserService`, `UserRepository`, `UserModel`
- `user_controller`, `users_controller`

**Search locations:**
- Source code
- Test files (often show usage)
- Configuration files
- Documentation
- Commit messages: `git log --grep="keyword"`

**Use glob patterns:**
- `**/*.service.ts` - All service files
- `**/test/**/*.js` - All test files
- `**/*config*` - All config files

### Breadth-First Approach
1. Get high-level overview
2. Identify main components
3. Map system boundaries
4. Then dive deep into specifics

**Good for:** Unfamiliar codebases, large systems

### Depth-First Approach
1. Start with specific question
2. Follow trail deeply
3. Branch out as needed

**Good for:** Focused investigations, specific bugs

## Taking Notes

### Research Log Template
```markdown
## Research: [Topic/Question]
**Goal:** What I'm trying to find out
**Date:** YYYY-MM-DD

### Findings
- [Source] Key finding with link/reference
- [Source] Another finding

### Questions Raised
- Follow-up question 1
- Follow-up question 2

### Recommendations
- What to do based on findings
- Trade-offs to consider

### References
- file.ts:123 - Relevant code location
- https://... - Documentation link
- Commit abc123 - Related change
```

## Verification

Before concluding research:
- [ ] Cross-referenced multiple sources
- [ ] Checked information is current (dates, versions)
- [ ] Verified against official sources
- [ ] Tested code examples if applicable
- [ ] Identified any gaps in understanding
- [ ] Noted confidence level in findings

## Common Research Pitfalls

- **Analysis paralysis**: Researching endlessly
- **Outdated information**: Not checking dates
- **Confirmation bias**: Only seeking confirming info
- **Single source**: Not cross-referencing
- **Surface level**: Not going deep enough
- **Scope creep**: Researching tangential topics
- **Missing context**: Not understanding "why"

## When to Stop

You have enough when you can:
- Answer the original question
- Make an informed decision
- Understand key trade-offs
- Identify main risks
- Proceed with implementation

**Remember:** Perfect information is impossible. Aim for sufficient confidence.

## Quick Commands

```bash
# Find files by pattern
find . -name "*Service.ts"

# Search code content
grep -r "functionName" src/

# View file tree
tree -L 3 -I 'node_modules|dist'

# Check git history
git log --oneline --grep="keyword"
git log --follow -- path/to/file

# Find recent changes
git log --since="2 weeks ago" --oneline

# Search commit content
git log -S "searchString" --source --all
```

## Research Deliverable Template

```markdown
# Research Findings: [Topic]

## Summary
Brief 2-3 sentence summary of key findings.

## Recommendation
What to do based on research.

## Findings
### [Area 1]
- Finding with evidence (file:line or URL)
- Another finding

### [Area 2]
- More findings

## Trade-offs
- Pro: Benefit with rationale
- Con: Drawback with rationale

## Risks
- Risk 1 and mitigation
- Risk 2 and mitigation

## Next Steps
1. Immediate action items
2. Follow-up research needed

## References
- [Source 1](URL) - What it covers
- src/file.ts:123 - Code reference
```
