---
name: list-skills
description: Lists all available skills in the skillset with their descriptions and categories
---

# /list-skills - List All Available Skills

## Description

Lists all available skills in the Claude Skills Collection with their descriptions and auto-activation triggers.

## Usage

```bash
/list-skills
/list-skills --category [CATEGORY]
```

## Categories

- `core` - Core development skills (debugging, architecture, testing)
- `tools` - Tool-specific skills (starship, zed, ghostty)
- `workflow` - Process-oriented skills (research, problem-solving)
- `github` - GitHub-focused skills (pr-analysis, code-quality-review, github-review-publisher)

## Examples

```bash
# List all skills
/list-skills

# List core development skills only
/list-skills --category core

# List tool-specific skills
/list-skills --category tools
```

## Output Format

```
# Available Skills (15 total)

## Core Development Skills
- **debugging** - Systematic bug fixing workflow
  Activates: "debug this", "error occurs", "help troubleshoot"

- **architecture** - System design and architecture patterns
  Activates: "design system", "architecture advice", "structure this"

- **testing** - Test strategies and best practices
  Activates: "write tests", "test this", "TDD help"

- **problem-solving** - Algorithmic and technical problem approach
  Activates: "solve this", "algorithm help", "optimize this"

- **research** - Investigation and codebase exploration
  Activates: "investigate", "understand codebase", "research this"

## Tool-Specific Skills
- **starship** - Shell prompt configuration
  Activates: "configure starship", "shell prompt", "starship config"

- **zed** - Code editor workflows
  Activates: "zed editor", "open in zed", "zed shortcuts"

- **ghostty** - Terminal emulator setup
  Activates: "ghostty config", "terminal setup", "ghostty theme"

## GitHub Workflow Skills
- **pr-analysis** - Pull request metadata and changes
  Activates: "analyze PR", "PR #123", "what changed in PR"

- **code-quality-review** - Code quality with security checks
  Activates: "review code", "quality check", "security review"

- **github-review-publisher** - Create GitHub review comments
  Activates: "publish review", "create review comments"

## Utility Skills
- **web-browser** - Web research and content access
  Activates: "search web", "check website", "analyze page"

- **tmux** - Terminal multiplexing
  Activates: "split terminal", "tmux session", "terminal windows"

- **collaboration** - Team workflows and communication
  Activates: "code review", "team workflow", "collaboration tips"

- **misc** - General development practices
  Activates: "best practices", "code standards", "development tips"
```

## Skill Status

Each skill includes:
- ✅ **Valid YAML frontmatter**
- ✅ **Auto-activation triggers**
- ✅ **Structured workflow**
- ✅ **Practical examples**
- ✅ **Verification checklists**

## Integration Info

Skills work together in workflows:
- `/pr-review` - Combines 3 GitHub skills
- "tool setup" - Combines web-browser + tool skill
- "code implementation" - Combines architecture + testing + collaboration

## Related Commands

- `/pr-review` - Execute complete PR review workflow
- `/skill-info [SKILL_NAME]` - Get detailed info about a skill