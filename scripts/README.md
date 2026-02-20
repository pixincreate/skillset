# Scripts

## symlink.sh

Creates or removes a symlink from this repository to `~/.claude/skills`.

### Usage

```bash
# Install (create symlink)
./scripts/symlink.sh

# Uninstall (remove symlink)
./scripts/symlink.sh --uninstall
```

### Features

- Creates symlink (not copy) for easy updates
- Creates backup if existing skills directory is found
- Verifies installation

### Why Symlink?

Using symlink instead of copy means:
- Updates are trivial: `git pull` in the repo
- Single source of truth
- No duplication of files

---

## symlink-commands.sh

Symlinks commands to tool-specific directories (Claude Code, OpenCode, etc.).

### Usage

```bash
./scripts/symlink-commands.sh
```

### What it does

Creates symlinks from `commands/` to:
- `~/.claude/commands/` (Claude Code)
- `~/.opencode/commands/` (OpenCode)

### Features

- Tool-specific directories are created if they exist
- Skips directories that don't exist
- Symlinks (not copies) - updates reflect immediately

### Prerequisites

For a tool's commands to work, its config directory must exist:
- Claude Code: `~/.claude/`
- OpenCode: `~/.opencode/`
