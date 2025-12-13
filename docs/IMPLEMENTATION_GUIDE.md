# Implementation Guide for AI Agents Using Claude Skills Collection

## Overview

This guide provides comprehensive documentation for implementing and maintaining the skills collection system. It enables any AI agent (Claude Code, OpenAI's tools, GitHub Copilot, or other AI assistants) to effectively utilize the skills collection for enhanced software development capabilities.

For the actual system prompt to use with AI agents, see `/SYSTEM_PROMPT.md`.

## Core Instructions

### 1. Skill Activation Protocol

When a user request is received:

1. **Identify Relevant Skill**: Check if the request matches any skill's description or auto-activation triggers
2. **Load Primary Skill**: Read the relevant `/skills/{skill-name}/SKILL.md` file
3. **Apply Skill Guidance**: Use the skill's systematic approach to address the request
4. **Check Completeness**: Determine if the skill provides sufficient information
5. **Escalate if Needed**: If insufficient, follow the escalation workflow

### 2. Skill Escalation Workflow

When a skill doesn't provide complete information:

```
1. Identify Gap → 2. Web Research → 3. Update Skill → 4. Address User Request
```

**Example Workflows:**

**Starship Configuration Question:**
```
User: "How do I configure starship to show AWS profile?"
→ Load starship skill
→ Skill covers basic config but not AWS specifics
→ Use web-browser skill to fetch starship.rs/aws docs
→ Update starship skill with AWS configuration example
→ Provide complete answer with updated skill info
```

**Ghostty Theme Issue:**
```
User: "My ghostty transparency isn't working on macOS"
→ Load ghostty skill
→ Skill has troubleshooting section but lacks specific macOS transparency issues
→ Use web-browser skill to search ghostty.org + GitHub issues
→ Add macOS-specific transparency solutions to ghostty skill
→ Provide comprehensive fix
```

**Zed Language Server Setup:**
```
User: "How to setup LSP for Python in Zed?"
→ Load zed skill
→ Skill mentions LSP but lacks Python-specific setup
→ Research zed.dev/docs/lsp/python
→ Update zed skill with Python LSP configuration
→ Provide step-by-step guide
```

### 3. Skill Update Protocol

When updating skills during escalation:

1. **Preserve Structure**: Maintain existing YAML frontmatter and sections
2. **Add New Section**: If updating, add under appropriate heading (e.g., "Advanced Configuration")
3. **Include Examples**: Add code examples with clear explanations
4. **Update Date**: Add last updated date to section if needed
5. **Cross-Reference**: Link to related skills if relevant

**Update Template:**
```markdown
### {Topic} Configuration (Added: {Date})

{Comprehensive explanation with code examples}

**Related:**
- {linked-skill} for {related-topic}
```

## Skill Mapping Guide

### Primary Skills by Domain

| Domain | Primary Skill | Secondary Skills | Escalation Sources |
|--------|---------------|------------------|-------------------|
| Terminal | ghostty, starship, tmux | web-browser | ghostty.org, starship.rs |
| Code Editing | zed | misc, debugging | zed.dev |
| Architecture | architecture | problem-solving | Official docs of tech stack |
| Testing | testing | misc, collaboration | Framework documentation |
| Shell/CLI | tmux, starship, ghostty | web-browser | Tool-specific docs |
| Code Review | misc, collaboration | research | Style guides, lint docs |
| Error Resolution | debugging | problem-solving, web-browser | Stack Overflow, docs |
| Research | research, web-browser | - | Official documentation |

### Skill Interaction Patterns

**Common Workflows:**

1. **Tool Setup**
   ```
   Tool (starship/zed/ghostty) → web-browser → update tool skill
   ```

2. **Problem Solving**
   ```
   debugging → problem-solving → web-browser → update relevant skill
   ```

3. **Code Implementation**
   ```
   architecture → testing → misc (review) → collaboration
   ```

4. **Research**
   ```
   research → web-browser → update research or domain skill
   ```

5. **GitHub PR Review (Complete Workflow)**
   ```
   pr-analysis → code-quality-review → github-review-publisher
   ```
   - pr-analysis: Extract PR metadata, file changes, and diff content
   - code-quality-review: Analyze code issues with accurate line number extraction from NEW file
   - github-review-publisher: Create validated pending reviews for manual approval

## Implementation for Different AI Tools

### Claude Code
- Native skill loading through file system
- Automatic activation via YAML description matching
- Use `Read` tool to access skill files

### OpenAI Tools
- Access skills via repository content
- Identify skills through file path patterns
- Use vector search for skill matching

### GitHub Copilot Chat
- Reference skills in workspace context
- Include recommended skills in responses
- Link to skill files for guidance

### Other AI Assistants
- Load skills from cloned repository
- Use skill descriptions for context switching
- Follow escalation workflow

## Activation Triggers

### Auto-Activation Keywords

Each skill defines auto-activation triggers in its YAML frontmatter. Common patterns:

```
- "configure [tool-name]"
- "[tool-name] [action]"
- "how to [action] with [tool-name]"
- "my [tool-name] is [problem]"
- "setup [tool-name]"
```

### Manual Activation

If no auto-activation matches:
1. Analyze user intent
2. Check skill directory for relevant domain
3. Load most appropriate skill
4. Inform user which skill is being used

## Best Practices

### For AI Agents

1. **Always cite skills**: Reference which skill provided guidance
2. **Explain reasoning**: Tell user why a skill was selected
3. **Flag updates**: When skills are updated, mention it
4. **Verify sources**: Cross-check information before updating skills
5. **Maintain quality**: Ensure updates follow skill structure

### Response Template

```
Using {skill-name} skill for your request.

{Apply skill guidance to address request}

{If research was performed:}
I've updated the {skill-name} skill with additional information from {source} to better handle this case.

{Final answer incorporating skill + research}
```

## Continuous Improvement

### Feedback Loop

1. Track which skills are frequently escalated
2. Identify gaps in skill coverage
3. Prioritize skill updates based on usage
4. Create new skills for emerging patterns

### Skill Health Metrics

- **Escalation Rate**: How often skills need web research
- **Update Frequency**: How often skills are enhanced
- **User Satisfaction**: Outcomes after skill-guided solutions
- **Cross-Reference Usage**: How skills work together

## Emergency Procedures

### If Skill Loading Fails

1. Use general knowledge for basic guidance
2. Attempt to repair/load skill from backup
3. Inform user about skill unavailability
4. Log the failure for later investigation

### If Skills Are Conflicting

1. Check which skill is more specific to the request
2. Combine insights from both skills if compatible
3. Prefer the skill with more recent activity/updates
4. Ask user for clarification if truly ambiguous

## Memory and Context Management

### Skill Caching

- Cache recently used skills for faster access
- Keep skill metadata in working memory
- Refresh cache when skills are updated

### Context Preservation

- Maintain skill usage history in session
- Note which approaches worked previously
- Track user preferences for skill recommendations

## Example Conversations

### Example 1: Terminal Setup
```
User: "I want my terminal to show git branch and node version"

AI: Using the starship skill to configure your prompt.

[Load starship skill]

The starship skill shows how to add git and Node.js modules to your prompt.
Here's the configuration:

[Provide config from skill]

The skill mentions advanced profiling which we could also set up if needed.
Would you like me to add performance monitoring to your prompt?
```

### Example 2: Complex Debugging
```
User: "My API is returning 500 errors in production"

AI: Using the debugging skill to systematically identify the issue.

[Load debugging skill]

Following the debugging workflow:
1. Reproduction: Can you share the request that's failing?
2. Isolation: Is this happening for all endpoints or specific ones?
3. Analysis: Changes in last deploy?

[If logs or traces are insufficient]
I'll use the web-browser skill to research common causes for 500 errors
with your stack.

[Research and update debugging skill with findings]
```

### Example 3: New Feature Implementation
```
User: "How should I structure a new microservice for user authentication?"

AI: Using the architecture skill to design your microservice.

[Load architecture skill]

The architecture skill provides patterns for service design.
For authentication, the recommended approach is:

[Provide architecture guidance]

I'll also check the testing skill for authentication testing patterns,
and the collaboration skill for security review checkpoints.

[Synthesize multiple skills]
```

## Repository Structure

```
/
├── README.md                    # Overview and installation
├── SYSTEM_PROMPT.md             # Detailed system prompt (this file)
├── SYSTEM_PROMPT_CONCISE.md     # Concise system prompt
└── skills/                      # Individual skill directories
    ├── architecture/            # Software architecture and design
    ├── collaboration/           # Team communication and code reviews
    ├── code-quality-review/     # Code quality analysis with security checks
    ├── debugging/               # Systematic bug fixing
    ├── ghostty/                 # Terminal emulator configuration
    ├── github-review-publisher/ # Create validated GitHub PR reviews
    ├── misc/                    # Code quality and general practices
    ├── pr-analysis/             # Pull request metadata and analysis
    ├── problem-solving/         # Algorithmic approaches
    ├── research/                # Investigation methods
    ├── starship/                # Shell prompt configuration
    ├── testing/                 # Test strategies
    ├── web-browser/             # Web research and content access
    └── zed/                     # Code editor workflows

Each skill directory contains a single SKILL.md file with:
- YAML frontmatter (name, description)
- Core Principle
- When to Use section
- Systematic workflows
- Practical examples
- Checklists and references
```

Remember: The skills collection is a living document. Each user interaction is an opportunity to enhance the skills for future users.