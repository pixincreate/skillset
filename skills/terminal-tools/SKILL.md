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
---

# Terminal Tools

Configure and use terminal tools for an optimized development workflow.

---

> **IMPORTANT: Always check the official docs when uncertain.**
>
> These tools update frequently. If something doesn't work or you are unsure about an option, hit the official source first:
>
> - **Ghostty**: https://ghostty.org/docs
> - **tmux**: https://github.com/tmux/tmux/wiki and https://man.openbsd.org/tmux
> - **Starship**: https://starship.rs/config/ and https://starship.rs/advanced-config/
> - **Zed**: https://zed.dev/docs/
>
> Do not guess. Do not rely on memory. If uncertain — fetch the docs.

---

## Tools

| Tool     | Purpose               | Config file                      |
| -------- | --------------------- | -------------------------------- |
| tmux     | Terminal multiplexer  | `~/.tmux.conf`                   |
| starship | Shell prompt          | `~/.config/starship.toml`        |
| Ghostty  | Terminal emulator     | `~/.config/ghostty/config`       |
| Zed      | Code editor           | `~/.config/zed/settings.json`    |

---

## tmux

Terminal multiplexer. Keeps sessions alive across disconnects, organizes work into sessions/windows/panes.

**Official docs**: https://github.com/tmux/tmux/wiki/Getting-Started | https://man.openbsd.org/tmux

### Core concepts

- **Server**: single background process managing all sessions
- **Session**: group of windows (named, e.g. `mysession`)
- **Window**: group of panes, fills the whole terminal
- **Pane**: one terminal inside a window; has a running program

### Essential commands

```bash
tmux new -s <name>          # new session
tmux attach -t <name>       # attach to session
tmux ls                     # list sessions
tmux kill-session -t <name> # kill session
```

### Default key bindings (prefix: C-b)

| Key          | Action                        |
| ------------ | ----------------------------- |
| `C-b c`      | New window                    |
| `C-b n` / `p`| Next / previous window        |
| `C-b 0-9`    | Switch to window N            |
| `C-b ,`      | Rename window                 |
| `C-b %`      | Split pane horizontally       |
| `C-b "`      | Split pane vertically         |
| `C-b arrow`  | Move between panes            |
| `C-b z`      | Zoom/unzoom pane              |
| `C-b d`      | Detach from session           |
| `C-b [`      | Enter copy mode               |
| `C-b ]`      | Paste from buffer             |
| `C-b s`      | Browse sessions (tree mode)   |
| `C-b w`      | Browse windows (tree mode)    |
| `C-b :`      | Open command prompt           |
| `C-b ?`      | List all key bindings         |

### Common `.tmux.conf` settings

```bash
# Change prefix to C-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Enable mouse
set -g mouse on

# 256 colors
set -g default-terminal "tmux-256color"

# RGB color support (tmux 3.2+)
set -as terminal-features ",xterm-256color:RGB"

# Start windows at 1
set -g base-index 1
setw -g pane-base-index 1

# Reduce escape delay (good for vim)
set -sg escape-time 0

# Keep current path when splitting
bind '"' split-window -c '#{pane_current_path}'
bind '%' split-window -h -c '#{pane_current_path}'
```

### Clipboard (OSC 52 / set-clipboard)

tmux can sync copy mode to system clipboard via OSC 52:

```bash
# Check if Ms capability is set (run inside tmux)
tmux info | grep Ms

# Enable (tmux 3.2+)
set -as terminal-features ',<TERM>:clipboard'

# Or older versions
set -as terminal-overrides ',<TERM>:Ms=\E]52;%p1%s;%p2%s\007'

# tmux 3.2+ shortcut
set -s copy-command 'pbcopy'        # macOS
set -s copy-command 'xsel -i'      # Linux
```

For vi keys in copy mode:
```bash
bind -Tcopy-mode-vi Enter send -X copy-pipe-and-cancel 'pbcopy'
bind -Tcopy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel 'pbcopy'
```

### Advanced

- **Scripting**: use IDs (`%0` pane, `@0` window, `$0` session) for stable targeting
- **New session + attach**: `tmux new -As <name>` (attach if exists, create if not)
- **Named buffers**: `tmux set-buffer -b myname "text"`
- **Pipe pane to log**: `:pipe-pane 'cat >~/pane.log'`
- **Respawn pane**: `:respawn-pane -k` (restart program in pane)
- **Check config without applying**: `tmux source-file -nv ~/.tmux.conf`

**Full advanced reference**: https://github.com/tmux/tmux/wiki/Advanced-Use

---

## Starship

Fast, informative, cross-shell prompt. Works in bash, zsh, fish, and more.

**Official docs**: https://starship.rs/config/ | https://starship.rs/advanced-config/

### Setup

```bash
# Install
curl -sS https://starship.rs/install.sh | sh

# Add to shell (zsh)
eval "$(starship init zsh)"

# Config file
~/.config/starship.toml
```

### Config basics

```toml
# ~/.config/starship.toml
"$schema" = 'https://starship.rs/config-schema.json'

add_newline = true
scan_timeout = 30          # ms to scan files
command_timeout = 500      # ms timeout per command

# Custom format (overrides $all default)
format = """
$directory$git_branch$git_status
$character"""
```

### Format strings

- `$variable` — insert variable from a module
- `[text]($style)` — styled text group, e.g. `[on](red bold)`
- `($combined)` — conditional: renders nothing if all variables inside are empty

Style values: `bold`, `italic`, `underline`, `fg:red`, `bg:blue`, `#ff0000`, `bright-green`

### Key modules

```toml
# Prompt character
[character]
success_symbol = '[➜](bold green)'
error_symbol = '[✗](bold red)'

# Directory
[directory]
truncation_length = 3
truncate_to_repo = true

# Git
[git_branch]
symbol = ' '

[git_status]
conflicted = '='
ahead = '⇡${count}'
behind = '⇣${count}'
diverged = '⇕⇡${ahead_count}⇣${behind_count}'
modified = '!'
staged = '+'
untracked = '?'

# Node
[nodejs]
symbol = ' '

# Python
[python]
symbol = ' '
```

### Right prompt

```toml
# Move modules to right side
right_format = """$cmd_duration$time"""
```

Supported in: fish, zsh, elvish, nushell, cmd, bash (with Ble.sh).

### Debugging

```bash
starship explain          # show active modules and their output
STARSHIP_LOG=trace starship module rust  # trace a specific module
starship timings          # show which modules are slow
starship bug-report       # create GitHub issue
```

**FAQ**: https://starship.rs/faq/

---

## Ghostty

Fast, GPU-accelerated terminal emulator. Native UI on macOS and Linux. Zero config required to get started.

**Official docs**: https://ghostty.org/docs

### Key features

- GPU-accelerated rendering
- Platform-native UI (macOS: AppKit; Linux: GTK4)
- Hundreds of built-in themes
- Supports light/dark mode theming separately
- Flexible keybinding configuration

### Config file

Location: `~/.config/ghostty/config`

Zero-configuration philosophy: works well out of the box, config is optional.

### Common config options

```
# Font
font-family = "JetBrains Mono"
font-size = 14

# Theme
theme = "Catppuccin Mocha"

# Theme per mode
theme = light:GitHub Light,dark:Catppuccin Mocha

# Window
window-padding-x = 10
window-padding-y = 10

# Shell integration
shell-integration = zsh

# Keybind (format: keybind = trigger=action)
keybind = cmd+shift+t=new_tab
```

### Keybindings

Format: `keybind = <modifiers>+<key>=<action>`

Common modifiers: `cmd`, `ctrl`, `alt`, `shift`

Open keybind reference: `Cmd+,` opens config; see https://ghostty.org/docs/config/keybind for full action list.

### Themes

Ghostty ships hundreds of built-in themes. Browse them:
- In app: command palette or config `theme = <name>`
- Full list: https://ghostty.org/docs/features/theme

---

## Zed

High-performance code editor. Built in Rust. Collaborative by default. Has built-in AI (agent panel + inline assistant).

**Official docs**: https://zed.dev/docs/

### Open from command line

```bash
zed .                    # open current directory
zed <file>               # open file
zed ~/projects/my-app    # open project
```

### Essential shortcuts (macOS)

| Action              | macOS           | Linux/Windows    |
| ------------------- | --------------- | ---------------- |
| Command palette     | `Cmd+Shift+P`   | `Ctrl+Shift+P`   |
| Go to file          | `Cmd+P`         | `Ctrl+P`         |
| Go to symbol        | `Cmd+Shift+O`   | `Ctrl+Shift+O`   |
| Find in project     | `Cmd+Shift+F`   | `Ctrl+Shift+F`   |
| Toggle terminal     | `` Ctrl+` ``    | `` Ctrl+` ``     |
| Open settings       | `Cmd+,`         | `Ctrl+,`         |
| Extensions          | `Cmd+Shift+X`   | `Ctrl+Shift+X`   |
| Theme selector      | `Cmd+K Cmd+T`   | `Ctrl+K Ctrl+T`  |
| AI agent panel      | `Cmd+Shift+A`   | `Ctrl+Shift+A`   |
| Inline AI           | `Cmd+Enter`     | `Ctrl+Enter`     |

### Settings file

`~/.config/zed/settings.json`

```json
{
  "theme": "One Dark",
  "buffer_font_family": "JetBrains Mono",
  "buffer_font_size": 14,
  "format_on_save": "on",
  "vim_mode": false,
  "tab_size": 2
}
```

### Key features

- **Vim mode**: `"vim_mode": true` in settings
- **Helix mode**: `"helix_mode": true`
- **Collaboration**: real-time shared editing via channels
- **Remote dev**: SSH-based remote development
- **Extensions**: language support, themes, debuggers, MCP servers
- **AI**: built-in agent panel (Cmd+Shift+A) and inline assistant — configure provider in settings

### Language setup

Zed includes built-in support for most languages. For others:
1. `Cmd+Shift+X` to open Extensions
2. Search your language
3. Install

See: https://zed.dev/docs/languages

### Terminal inside Zed

Toggle with `` Ctrl+` ``. Full terminal pane — works with tmux inside it.

---

## Integration Tips

- **tmux + Ghostty**: use `tmux new -As dev` in Ghostty's startup command for persistent sessions
- **Starship in tmux**: works natively; set `add_newline = false` in starship config to reduce noise in narrow panes
- **Zed terminal + tmux**: open Zed's built-in terminal, attach to existing tmux session
- **256 colors**: set `TERM=xterm-256color` outside tmux, `default-terminal "tmux-256color"` inside
