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

## House Style

How skills here are written — and how this differs from other skill collections:

| | This repo | e.g. mattpocock/skills |
| ----- | ----------- | ----------- |
| Activation | Frontmatter `triggers` list; each skill stands alone | Narrative prompts, often activated by other skills |
| Coupling | Self-contained; no required companion setup | Ecosystem-coupled (triage → to-spec → to-tickets → implement chain) |
| Structure | One SKILL.md, flat sections | Progressive disclosure with bundled reference files |
| Families | Similar skills clubbed via `## Related Skills` cross-links | Skills reference a shared personal workflow |
| Scope | Broad: dev, review, comms, tooling, agent-meta | Dev-workflow centric |

Every skill follows the same shape: YAML frontmatter (`name`, `description`, `triggers`), body sections, and a **Related Skills** footer that clubs it into its family (planning/process, architecture/domain, verification, review pipeline, design, communication, tooling) so adjacent skills point at each other instead of duplicating content.

## Skills

### Planning & Process

| Skill | Description |
| ----- | ----------- |
| `planning/` | Mandatory plan-first workflow before any implementation |
| `brainstorming/` | Explore intent, requirements, and design before creative work |
| `rapidfire/` | Blunt feedback mode + one-question-at-a-time alignment interview |
| `spec-writer/` | Templates and checklists for specs, PRDs, RFCs |
| `spec-enforcement/` | Documentation, linting, formatting after code changes |
| `incremental-implementation/` | Deliver multi-file changes in vertical slices |
| `refactor-path/` | Step-by-step path from current state to target state |
| `safe-pr/` | Prevent flow-breaking mistakes on shared/critical paths |
| `doubt-driven-development/` | Fresh-context adversarial review of key decisions |
| `problem-solving/` | Systematic approach to complex technical challenges |
| `simplicity-first/` | Minimum code, surgical edits, explicit assumptions |
| `source-driven-development/` | Ground decisions in official documentation |
| `learning-log/` | Capture learned patterns, anti-patterns, insights |

### Architecture & Domain

| Skill | Description |
| ----- | ----------- |
| `architecture/` | System design, SOLID patterns, trade-off analysis |
| `api-and-interface-design/` | Stable API and module boundary contracts |
| `domain-modeling/` | Shared-language glossary (CONTEXT.md) + ADR discipline |
| `zoom-out/` | Higher-level map of an unfamiliar module's callers/context |

### Development

| Skill | Description |
| ----- | ----------- |
| `codebase-exploration/` | Map structure, dependencies; creates CLAUDE.md |
| `research/` | Tech evaluation, APIs, external docs investigation |
| `testing/` | Behavior-focused tests and TDD red-green-refactor |
| `behavior-validation/` | Verify against running systems: services, HTTP, E2E |
| `diagnose/` | Debugging discipline: quick path + full 6-phase loop |
| `resolving-merge-conflicts/` | Resolve merge/rebase conflicts by traced intent |
| `security-and-hardening/` | Harden input handling, auth, storage, integrations |
| `observability-and-instrumentation/` | Logging, metrics, tracing for production visibility |
| `context-engineering/` | Configure project-aware agent context |
| `code-simplification/` | Refactor for clarity without changing behavior |

### Code Review & PRs

| Skill | Description |
| ----- | ----------- |
| `code-quality-review/` | Heavyweight review: scoring, severity, line numbers |
| `code-change-review/` | Lightweight surgical change review |
| `github-review-publisher/` | Publish structured GitHub PR review comments |
| `pr-analysis/` | Fetch and analyze pull request data |

### Design & Frontend

| Skill | Description |
| ----- | ----------- |
| `frontend-design/` | Distinctive, production-grade frontend interfaces |
| `interface-design/` | Product interfaces: dashboards, apps, tools |
| `web-design-guidelines/` | Audit UI against web interface guidelines |
| `remotion-best-practices/` | Video creation in React with Remotion |

### Communication

| Skill | Description |
| ----- | ----------- |
| `caveman/` | Ultra-compressed communication mode |
| `slack-voice/` | Translate casual messages into polished Slack tone |
| `collaboration/` | Team collaboration and feedback practices |
| `handoff/` | Compact a conversation into a continuation document |
| `wait-what/` | Re-pitch a message that didn't land, in plain language |

### Tools & Utilities

| Skill | Description |
| ----- | ----------- |
| `terminal-tools/` | tmux, starship, ghostty, zed, wezterm configuration |
| `slackdump/` | Archive and query Slack workspace data via SQLite |
| `web-browser/` | Web search, navigation, content interaction |
| `prototype/` | Throwaway demos that answer one design question |
| `dispatching-parallel-agents/` | Orchestrate parallel background agents |
| `write-a-skill/` | Create new skills with proper structure |

## Uninstallation

```bash
./scripts/symlink.sh
# Select option 2 to uninstall

./scripts/symlink-commands.sh
# Select option 2 to uninstall
```

## License

Creative Commons Zero v1.0 Universal
