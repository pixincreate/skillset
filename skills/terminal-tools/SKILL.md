---
name: terminal-tools
description: Configure and use terminal tools effectively for an optimized terminal workflow. Use when working with terminal multiplexers, shell prompts, terminal emulators, or code editors. Auto-activates for: "tmux", "starship", "ghostty", "zed", "terminal multiplexer", "shell prompt", "configure terminal".
triggers:
  - "tmux"
  - "starship"
  - "ghostty"
  - "zed"
  - "terminal multiplexer"
  - "shell prompt"
  - "configure terminal"
cli:
  command: term
  subcommands: [tmux, starship, ghostty, zed, docs, describe]
  output_schema: schema/term-output.json
---

# Terminal Tools

Configure and use terminal tools effectively for an optimized development workflow.

## Machine Contract

This skill provides a CLI interface for programmatic access:

```bash
# Level 0: List available subcommands
term
# Output: [exit:0 | 12ms]

# Level 1: Get usage for specific tool
term tmux
# Output: Usage, actions: config, commands, tips [exit:0 | 10ms]

# Get documentation excerpt
term docs tmux

# JSON output for machine consumption
term tmux config --json
```

### Error Navigation

```
[error] term: unknown subcommand 'foo'. Available: tmux, starship, ghostty, zed, docs, describe
[error] docs: usage: term docs <tool-name>. Available: tmux, starship, ghostty, zed
```

## Overview

This skill covers terminal productivity tools:

- Terminal multiplexers for session management
- Shell prompts for informative command lines
- Terminal emulators for the best terminal experience
- Code editors for terminal-based editing

## When to Use

This skill auto-activates when users request:

- "Configure tmux"
- "Set up starship prompt"
- "Configure Ghostty terminal"
- "Use Zed editor"
- Any terminal multiplexer, shell prompt, or terminal editor configuration

## Available References

### Terminal Multiplexers

- **tmux** - Session, window, and pane management for persistent workflows

### Shell Prompts

- **starship** - Fast, informative shell prompt

### Terminal Emulators

- **Ghostty** - Modern terminal emulator
- **Zed** - High-performance code editor

## Usage

For detailed information on each tool, see the reference files in this directory:

```bash
# Read specific tool reference
cat terminal-tools/reference/tmux.md
cat terminal-tools/reference/starship.md
cat terminal-tools/reference/ghostty.md
cat terminal-tools/reference/zed.md
```

## Quick Reference

| Tool     | Purpose               | Key Command                       |
| -------- | --------------------- | --------------------------------- |
| tmux     | Terminal multiplexing | `tmux new -s <name>`              |
| starship | Shell prompt          | `eval "$(starship init <shell>)"` |
| Ghostty  | Terminal emulator     | `ghostty` or `Cmd+,`              |
| Zed      | Code editor           | `zed <file>`                      |

## Integration

These tools work well together:

- Use tmux with any terminal emulator for persistent sessions
- Starship works in tmux, SSH, and all shells
- Zed can be launched from tmux or terminal
