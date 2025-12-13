# Installation Scripts

## install.sh
Creates a symlink from the current repository to `~/.claude/skills`.

### Features
- Creates backup of existing skills
- Creates symlink (not copy) for easy updates
- Verifies installation
- Lists all installed skills

### Usage
```bash
# From repository root
./scripts/install.sh
```

## uninstall.sh
Removes the Claude Skills Collection installation.

### Features
- Removes symlink safely
- Restores backup if found
- Clean removal

### Usage
```bash
# From repository root
./scripts/uninstall.sh
```

## Why Symlink?

Using symlink instead of copy means:
- Updates are trivial: `git pull` in the repo
- Single source of truth
- No duplication of files
- Easy to switch between versions if needed