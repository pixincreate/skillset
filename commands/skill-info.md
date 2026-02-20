---
name: skill-info
description: Shows detailed information about a specific skill including purpose, triggers, and features
---

# /skill-info - Get Information About a Skill

## Description

Shows detailed information about a specific skill, including its purpose, auto-activation triggers, and key features.

## Usage

```bash
/skill-info [SKILL_NAME]
```

## Examples

```bash
/skill-info debugging
/skill-info starship
/skill-info pr-analysis
/skill-info code-quality-review
```

## Output Format

```
# Debugging Skill

## Purpose
Systematic workflow for identifying, isolating, and fixing bugs.

## When It Activates
The debugging skill automatically activates when you request:
- "debug this code"
- "help troubleshoot"
- "error investigation"
- "fix this issue"
- "why is this failing"

## Key Features
- 6-step debugging workflow
- Investigation techniques for different error types
- Strategic logging patterns
- Tool-specific debugging commands
- Verification checklist

## Workflow Steps
1. Isolate the problem
2. Form hypotheses
3. Test hypotheses
4. Identify root cause
5. Implement fix
6. Validate solution

## Quick Commands
- `strace -f -p <pid>` - Trace system calls
- `lsof -p <pid>` - Check open files
- `ps aux | grep <process>` - Find process info
- `journalctl -u <service>` - Check service logs

## Related Skills
- problem-solving - For algorithmic issues
- research - To investigate unknown code
- testing - To verify fixes
```

## Available Skills

All skill names are lowercase:
- debugging
- architecture
- testing
- problem-solving
- research
- misc
- collaboration
- web-browser
- tmux
- starship
- zed
- ghostty
- pr-analysis
- code-quality-review
- github-review-publisher

## Integration Examples

The skill-info command shows how skills integrate:
```
/skill-info pr-analysis
→ Shows integration with code-quality-review
→ Shows data provided to github-review-publisher
```

## Error Cases

```
/skill-info invalid-skill
❌ Error: 'invalid-skill' is not a valid skill

Valid skills:
[List of all 15 skills]
```

## Related Commands

- `/list-skills` - See all available skills
- `/pr-review` - See workflow integration example