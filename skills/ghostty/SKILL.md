---
name: ghostty
description: "Configure and use Ghostty terminal emulator effectively. Use when setting up Ghostty, customizing terminal behavior, managing themes, or optimizing terminal workflow. Auto-activates for: \"configure ghostty\", \"ghostty theme\", \"terminal font\", \"ghostty keybindings\"."
---

# Ghostty Skill

## Core Principle

**Create efficient terminal environments**: Configure Ghostty for optimal performance and workflow integration.

## When to Use This Skill

This skill auto-activates when users request:
- "Configure Ghostty terminal"
- "Change Ghostty theme"
- "Set terminal font"
- "Configure keybindings in Ghostty"
- "Create Ghostty profile"
- "Ghostty command palette"

## Getting Started

### Installation

**macOS**:
```bash
# Using Homebrew
brew install --cask ghostty

# Or download from ghostty.org
```

**Linux**:
```bash
# Ubuntu/Debian
sudo apt install ghostty

# Fedora
sudo dnf install ghostty

# Arch
paru -S ghostty-bin
```

### First Launch

1. Open Ghostty
2. Access settings: `Cmd+,` (macOS) or `Ctrl+,` (Linux)
3. Choose default profile
4. Configure shell integration

## Configuration

### Config File Location

```bash
# macOS
~/.config/ghostty/config

# Linux
~/.config/ghostty/config
```

### Basic Configuration

```conf
# Ghostty config file

# Appearance
theme = dark
font-family = JetBrains Mono
font-size = 14

# Terminal behavior
shell-integration = enabled
confirm-close-surface = false

# Key bindings
keybind = ctrl+shift+c=copy_to_clipboard
keybind = ctrl+shift+v=paste_from_clipboard
```

## Themes

### Built-in Themes

```conf
# Available themes
theme = system            # Follow system theme
theme = dark              # Dark mode
theme = light             # Light mode
theme = gruvbox           # Gruvbox theme
theme = github-dark       # GitHub Dark
theme = night-owl         # Night Owl
```

### Custom Theme

```conf
# Define custom colors
background = 282c34
foreground = abb2bf

# ANSI colors
color-0-foreground = 282c34
color-0-background = abb2bf
color-1-foreground = e06c75  # Red
color-2-foreground = 98c379  # Green
color-3-foreground = d19a66  # Yellow
color-4-foreground = 61afef  # Blue
color-5-foreground = c678dd  # Magenta
color-6-foreground = 56b6c2  # Cyan
color-7-foreground = abb2bf  # White

# Bright colors
color-8-foreground = 5c6370  # Bright black (gray)
color-9-foreground = e06c75  # Bright red
# ... continue for all bright colors
```

### Theme Switching

**Command palette**:
```
Cmd/Ctrl+Shift+P → "Theme: Dark"
Cmd/Ctrl+Shift+P → "Theme: Light"
```

## Fonts and Typography

### Font Configuration

```conf
# Font settings
font-family = JetBrains Mono Nerd Font
font-size = 14
font-weight = 400
font-style = normal

# Font features
font-feature = '+calt'  # contextual alternates
font-feature = '+liga'  # ligatures

# Line spacing
line-height = 1.2
letter-spacing = 0
```

### Font Fallbacks

```conf
# Multiple fonts with fallback
font-family = "JetBrains Mono Nerd Font, SF Mono, Monaco"
```

## Profiles

### Creating Profiles

```conf
# Development profile
profile-dev-shell = {
    shell-integration = fish
    theme = gruvbox-dark
    font-size = 16
    opacity = 0.95
}

# Server profile
profile-server = {
    theme = monokai
    font-family = Fira Code
    font-size = 12
}
```

### Profile Switching

**Switch profiles dynamically**:
```
Cmd/Ctrl+Shift+P → "Profile: dev-shell"
Cmd/Ctrl+Shift+P → "Profile: server"
```

## Keybindings

### Essential Shortcuts

```conf
# Copy/Paste
keybind = cmd+c=copy
keybind = cmd+v=paste
keybind = cmd+shift+c=copy_to_clipboard
keybind = cmd+shift+v=paste_from_clipboard

# Window management
keybind = cmd+n=new_window
keybind = cmd+w=close_window
keybind = cmd+t=new_tab
keybind = cmd+w=close_tab

# Font size
keybind = cmd+plus=increase_font_size
keybind = cmd+minus=decrease_font_size
keybind = cmd+0=reset_font_size
```

### Custom Actions

```conf
# Custom keybinds
keybind = cmd+1=profile:dev-shell
keybind = cmd+2=profile:server
keybind = cmd+d=theme:dark
keybind = cmd+l=theme:light

# Shell integration
keybind = cmd+enter=send_command_enter
keybind = cmd+k=clear_screen
```

## Shell Integration

### Fish Integration

```conf
# Fish-specific settings
shell-integration = fish
cwd-tracking = true
prompt-marking = true
```

### Bash Integration

```conf
# Bash-specific settings
shell-integration = bash
title-update = true
```

## Window Management

### Split Panes

**Split commands**:
```
Cmd/Ctrl+Shift+P → "Split Pane Below"
Cmd/Ctrl+Shift+P → "Split Pane Right"
```

**Navigation**:
```
Cmd/Ctrl+Opt/Alt+Arrow keys - Navigate panes
Cmd/Ctrl+W - Close pane
```

### Tabs Management

```conf
# Tab behavior
show-tab-bar = always
tab-bar-position = bottom
tab-width = 200
tab-close-buttons = true
```

## Performance Optimization

### Fast Terminal

```conf
# Performance settings
gpu-acceleration = on
fps = 60
buffer-lines = 10000
scrollback-limit = 10000

# Reduce repaints
opacity = 1.0
blur = false
```

### Memory Usage

```conf
# Memory optimization
buffer-lines = 5000
max-bell-ring-duration = 1000
```

## Advanced Features

### Shell Integration Features

**Command features**:
```conf
# Enable all shell integration
shell-integration-full = true

# Features
command-notifications = true
directory-change-notifications = true
fi-command = "\u001b]1337;File=inline=1;:" $FILE "\u0007"
```

### Custom Commands

```conf
# Define custom commands
custom-command-1 = {
    name = "Open Editor"
    command = "nvim ."
    keybind = cmd+e
}

custom-command-2 = {
    name = "Git Status"
    command = "git status"
    keybind = cmd+g
}
```

## Command Palette

### Accessing Commands

```
Cmd/Ctrl+Shift+P  # Open command palette
```

**Common commands**:
- "New Window"
- "Split Pane"
- "Change Theme"
- "Switch Profile"
- "Clear Screen"
- "Copy URL"
- "Open Config"

## Quick Reference

### Configuration Commands
```conf
# Appearance
theme = darkOpacity = 0.9blur = falsebackground = #1e1e1eforeground = #d4d4d4

# Font
font-family = Code Profont-size = 14font-weight = 500line-height = 1.4

# Behavior
shell-integration = enabledconfirm-close-surface = truemouse-hide-while-typing = true
```

### Keybind Patterns
```conf
# Copy/Paste
cmd+c=copycmd+v=pasteshift+cmd+c=copy_to_clipboard shift+cmd+v=paste_from_clipboard

# Navigation
cmd+t=new_tabcmd+w=close_tabcmd+shift+T=reopen_tabcmd+n=new_windowcmd+w=close_window

# Font
cmd+plus=increase_font_size cmd+minus=decrease_font_size cmd+0=reset_font_size
```

## Troubleshooting

### Common Issues

**Font not loading**:
1. Check font installation with `fc-list | grep -i jetbrains`
2. Use full font name with spaces quoted
3. Restart Ghostty after font changes

**Shell integration not working**:
1. Verify shell is supported (fish, bash, zsh)
2. Check shell initialization scripts
3. Enable with `shell-integration-full`

**Performance issues**:
1. Disable blur and transparency
2. Reduce font features
3. Limit buffer size

### Debug Mode

```bash
# Run with debug output
ghostty --debug

# Check configuration
ghostty --config-check

# Show version and features
ghostty --version
```

## Workflows

### Development Workflow

1. **Profile setup**: Create dev profile with larger font
2. **Multiple tabs**: Use tabs for different contexts
3. **Split panes**: Editor and terminal side-by-side
4. **Quick actions**: Custom commands for common tasks

### System Administration

1. **Server profiles**: Multiple profiles for different servers
2. **SSH integration**: Configure for remote work
3. **Logging**: Enable command notifications

## Integration Notes

Works with:
- All modern shells
- Tmux integration
- Multiplexer compatibility
- VS Code integrated terminal
- SSH connections