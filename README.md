# Skills Collection

A collection of skills for AI coding agents. Skills are packaged instructions that extend agent capabilities.

## Installation

### 1. Capsync (Recommended)

[Capsync](https://crates.io/crates/capsync) symlinks skills to all installed agentic tools automatically. Edits to skills reflect everywhere.

```bash
# 1. Clone this repo
git clone https://github.com/pixincreate/skillset.git

# 2. Install capsync
cargo install capsync

# 3. Initialize — capsync will ask for the path to the cloned repo
capsync init
```

`capsync init` detects which agentic tools you have installed (claude, opencode, codex, gemini, etc.) and symlinks the skills directory into each one.

### 2. Script-based Symlink

If capsync is not available, use the provided scripts:

```bash
# From the repo root
./scripts/symlink.sh           # Interactive - asks for installation path
./scripts/symlink-commands.sh  # Interactive - asks for commands path
```

### 3. Manual Symlink

```bash
# Skills
mkdir -p ~/.config/opencode/skill/
ln -s /path/to/skillset/skills/* ~/.config/opencode/skill/

# Commands
mkdir -p ~/.config/opencode/commands/
ln -s /path/to/skillset/commands/*.md ~/.config/opencode/commands/
```

### 4. Copy (Last Resort)

Only if symlinking is not possible:

```bash
cp -r skills/ ~/.config/opencode/skill/
cp commands/*.md ~/.config/opencode/commands/
```

## Creating a New Skill

### Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    reference/            # Optional: detailed reference material
      {topic}.md          # Reference files loaded on demand
    scripts/              # Optional: executable scripts
      {script-name}.sh    # Bash scripts
```

### Naming Conventions

- **Skill directory**: `kebab-case` (e.g., `terminal-tools`, `debugging`)
- **SKILL.md**: Always uppercase, always this exact filename
- **Scripts**: `kebab-case.sh` (e.g., `deploy.sh`, `fetch-logs.sh`)

### SKILL.md Format

````markdown
---
name: {skill-name}
description: One sentence describing when to use this skill. Include trigger phrases.
triggers:
  - "trigger phrase one"
  - "trigger phrase two"
---

# {Skill Title}

{Brief description of what the skill does.}

## {Section}

{Content}
````

### Best Practices for Context Efficiency

Skills are loaded on-demand — only the skill name and description are loaded at startup. The full `SKILL.md` loads into context only when the agent decides the skill is relevant.

- **Keep SKILL.md under 500 lines** — put detailed reference material in `reference/` files
- **Write specific descriptions** — helps the agent know exactly when to activate the skill
- **Use progressive disclosure** — reference supporting files that get read only when needed
- **Prefer scripts over inline code** — script execution doesn't consume context (only output does)

## Skills

### Terminal & Tools

| Skill | Description |
| ----- | ----------- |
| `terminal-tools/` | Terminal productivity: tmux, starship, ghostty, zed |
| `slackdump/` | Archive, dump, and query Slack workspace data |
| `web-browser/` | Web browsing and interaction |

### Development

| Skill | Description |
| ----- | ----------- |
| `architecture/` | Software architecture and system design |
| `debugging/` | Systematic debugging including root cause analysis |
| `testing/` | Testing patterns including TDD |
| `problem-solving/` | Systematic problem solving |
| `research/` | Technical research and codebase exploration |
| `spec-enforcement/` | Verify implementation matches spec |
| `behavior-validation/` | Test behavior against requirements |
| `codebase-exploration/` | Understand unfamiliar codebases |

### Code Quality & Review

| Skill | Description |
| ----- | ----------- |
| `code-quality-review/` | Code quality and security reviews |
| `code-change-review/` | Review code changes systematically |
| `github-review-publisher/` | Publishing GitHub PR reviews |
| `pr-analysis/` | Pull request analysis |
| `misc/` | General development practices |

### Planning & Collaboration

| Skill | Description |
| ----- | ----------- |
| `planning/` | Requirements and writing plans |
| `brainstorming/` | Creative exploration before implementation |
| `collaboration/` | Team collaboration practices |
| `dispatching-parallel-agents/` | Running parallel agent tasks |
| `spec-writer/` | Writing clear technical specifications |
| `refactor-path/` | Safe incremental refactoring strategies |
| `safe-pr/` | PR hygiene and safe merge practices |
| `learning-log/` | Capture and retain learnings |
| `rapidfire/` | Quick iterative decision making |

### Frontend & Design

| Skill | Description |
| ----- | ----------- |
| `frontend-design/` | UI/UX: guidelines, interfaces, creative implementation |
| `interface-design/` | High-level interface design philosophy |
| `web-design-guidelines/` | Web interface guidelines |

### Communication

| Skill | Description |
| ----- | ----------- |
| `slack-voice/` | Slack communication tone and style |

## Uninstallation

```bash
./scripts/symlink.sh
# Select option 2 to uninstall

./scripts/symlink-commands.sh
# Select option 2 to uninstall
```

## License

Creative Commons Zero v1.0 Universal
