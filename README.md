# Skills Collection

A collection of skills for AI coding agents. Skills are packaged instructions that extend agent capabilities.

## Installation

### 1. Capsync (Recommended)

[Capsync](https://crates.io/crates/capsync) automatically symlinks skills and commands to all installed CLI tools.

```bash
cargo install capsync
capsync init  # Enter skills directory path when prompted
```

### 2. Script-based Symlink

```bash
./scripts/symlink.sh      # Interactive - asks for installation path
./scripts/symlink-commands.sh  # Interactive - asks for commands path
```

### 3. Manual Symlink

```bash
# For skills
mkdir -p ~/.claude/skills/
ln -s /path/to/skills ~/.claude/skills/skills

# For commands
mkdir -p ~/.claude/commands/
ln -s /path/to/skills/commands/*.md ~/.claude/commands/
```

### 4. Copy (Last Resort)

```bash
cp -r skills/ ~/.claude/skills/
cp commands/*.md ~/.claude/commands/
```

## Skills

### Merged Skills (with references)

| Skill                    | Description                                            |
| ------------------------ | ------------------------------------------------------ |
| `terminal-tools/`        | Terminal productivity: tmux, starship, ghostty, zed    |
| `frontend-design/`       | UI/UX: guidelines, interfaces, creative implementation |
| `testing/`               | Testing patterns including TDD                         |
| `debugging/`             | Systematic debugging including root cause analysis     |
| `web-design-guidelines/` | Web interface guidelines fetched from web              |

### Individual Skills

| Skill                          | Description                                |
| ------------------------------ | ------------------------------------------ |
| `architecture/`                | Software architecture and system design    |
| `behavior-validation/`         | Test behavior against requirements         |
| `brainstorming/`               | Creative exploration before implementation |
| `code-change-review/`          | Review code changes systematically         |
| `code-quality-review/`         | Code quality and security reviews          |
| `codebase-exploration/`        | Understand unfamiliar codebases            |
| `collaboration/`               | Team collaboration practices               |
| `dispatching-parallel-agents/` | Running parallel agent tasks               |
| `github-review-publisher/`     | Publishing GitHub PR reviews               |
| `interface-design/`            | High-level interface design philosophy     |
| `misc/`                        | General development practices              |
| `planning/`                    | Requirements and writing plans             |
| `pr-analysis/`                 | Pull request analysis                      |
| `problem-solving/`             | Systematic problem solving                 |
| `research/`                    | Technical research and exploration         |
| `spec-enforcement/`            | Verify implementation matches spec         |
| `web-browser/`                 | Web browsing and interaction               |

## Usage

Skills auto-activate based on triggers in their YAML frontmatter. The skill description tells you when to use each skill.

## Uninstallation

```bash
./scripts/symlink.sh
# Select option 2 to uninstall

./scripts/symlink-commands.sh
# Select option 2 to uninstall
```

## License

Creative Commons Zero v1.0 Universal
