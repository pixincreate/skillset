# AGENTS.md

This file provides guidance to AI coding agents for using skills from this directory.

## Repository Overview

A collection of skills for AI coding agents. Skills are packaged instructions that extend the agent's capabilities.

## Installation

Skills can be installed in four ways, listed by preference:

### 1. Capsync (Recommended)

[Capsync](https://crates.io/crates/capsync) automatically symlinks skills and commands to all installed CLI tools. Edits to skills reflect everywhere.

```bash
cargo install capsync
capsync init  # Enter skills directory path when prompted
```

### 2. Script-based Symlink

If capsync is not available, use the provided scripts:

```bash
# From skills directory
./scripts/symlink.sh      # Interactive - asks for installation path
./scripts/symlink-commands.sh  # Interactive - asks for commands path

# Uninstall
./scripts/symlink.sh
# Select option 2 to uninstall

./scripts/symlink-commands.sh
# Select option 2 to uninstall
```

Scripts are interactive and support any CLI tool (claude, opencode, codex, gemini, etc.).

### 3. Manual Symlink

If scripts are not available, manually symlink skills and commands:

```bash
# For skills
mkdir -p ~/.claude/skills/
ln -s /path/to/skills ~/.claude/skills/skills

# For commands
mkdir -p ~/.claude/commands/
ln -s /path/to/skills/commands/*.md ~/.claude/commands/
```

### 4. Copy (Last Resort)

Only if symlinking is not possible:

```bash
cp -r skills/ ~/.claude/skills/
cp commands/*.md ~/.claude/commands/
```

## How to Use Skills

### 1. Skill Selection

When a user asks a question:

- Check if it matches any skill's description in `*/SKILL.md`
- Skills auto-activate for specific triggers in their YAML frontmatter
- Load the most relevant skill first

### 2. Skill-First Approach

Always:

1. Load the relevant skill file
2. Apply its systematic approach
3. Check if the skill provides complete guidance
4. If incomplete, escalate with research

### 3. Escalation Workflow

```
User Question → Load Skill → Check Completeness
                                    ↓
                              If incomplete
                                    ↓
                        Research with web-browser skill
                                    ↓
                              Update relevant skill
                                    ↓
                           Provide comprehensive answer
```

### 4. Response Format

Always:

1. **State the skill**: "Using the {skill-name} skill..."
2. **Apply methodology**: Follow the skill's approach
3. **Cite updates**: "I've updated {skill} with additional information from {source}"
4. **Provide complete solution**: Combine skill guidance with research when needed

### 5. Key Principles

- **Skills first**: Always check skills before general knowledge
- **Systematic approach**: Follow the skill's methodology exactly
- **Enhance continuously**: Update skills when you research new information
- **Cross-reference**: Link related skills when multiple domains intersect
- **Be explicit**: Tell users which skill guided your response

## Creating a New Skill

### Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    reference/            # Optional: detailed reference material
      {topic}.md         # Reference files loaded on demand
    scripts/              # Optional: executable scripts
      {script-name}.sh   # Bash scripts
    {skill-name}.zip    # Optional: packaged for distribution
```

### Naming Conventions

- **Skill directory**: `kebab-case` (e.g., `terminal-tools`, `debugging`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `fetch-logs.sh`)
- **Zip file**: Must match directory name exactly: `{skill-name}.zip`

### SKILL.md Format

````markdown
---
name: { skill-name }
description:
  {
    One sentence describing when to use this skill. Include trigger phrases like "Deploy my app",
    "Check logs",
    etc.,
  }
---

# {Skill Title}

{Brief description of what the skill does.}

## How It Works

{Numbered list explaining the skill's workflow}

## Usage

```bash
bash ./{skill-name}/scripts/{script}.sh [args]
```

**Arguments:**

- `arg1` - Description (defaults to X)

**Examples:**
{Show 2-3 common usage patterns}

## Output

{Show example output users will see}

## Present Results to User

{Template for how Claude should format results when presenting to users}

## Troubleshooting

{Common issues and solutions, especially network/permissions errors}
````

### Best Practices for Context Efficiency

Skills are loaded on-demand — only the skill name and description are loaded at startup. The full `SKILL.md` loads into context only when the agent decides the skill is relevant. To minimize context usage:

- **Keep SKILL.md under 500 lines** — put detailed reference material in separate files
- **Write specific descriptions** — helps the agent know exactly when to activate the skill
- **Use progressive disclosure** — reference supporting files that get read only when needed
- **Prefer scripts over inline code** — script execution doesn't consume context (only output does)
- **File references work one level deep** — link directly from SKILL.md to supporting files

### Script Requirements

- Use `#!/bin/bash` shebang
- Use `set -e` for fail-fast behavior
- Write status messages to stderr: `echo "Message" >&2`
- Write machine-readable output (JSON) to stdout
- Include a cleanup trap for temp files
- Reference the script path as `./{skill-name}/scripts/{script}.sh`

### Creating the Zip Package

After creating or updating a skill:

```bash
cd skills
zip -r {skill-name}.zip {skill-name}/
```

### End-User Installation

If the skill requires network access, instruct users to add required domains at the AI tool's capabilities settings.

```

```
