# tmux Reference

## Core Principle

Terminal multiplexing for persistent, organized workflows: Use tmux to maintain long-running sessions, organize work into windows and panes, and seamlessly switch between contexts without losing state.

## When to Use This Skill

This skill auto-activates when users request:
- "Create a tmux session"
- "Split window/pane in tmux"
- "Configure tmux"
- "Change tmux prefix"
- "Detach/attach tmux"
- "Copy/paste in tmux"
- "Tmux status bar"
- "Remote tmux workflow"

## Essential Concepts

### Architecture Hierarchy

```
Server (single process)
  └── Session (named, groups windows)
        └── Window (groups panes, has index)
              └── Pane (contains terminal/program)
```

**Key Terms**:
- **Server**: Background process managing all state (`/tmp/tmux-<uid>/default`)
- **Session**: Collection of windows with a name (e.g., `mysession`)
- **Window**: Full-screen container for panes (indexed: 0, 1, 2...)
- **Pane**: Rectangular terminal area showing a program
- **Client**: Terminal connection to a session
- **Prefix**: Special key to trigger tmux commands (default: `C-b`)

## Quick Start

### Creating Sessions

```bash
# Create and attach new session
tmux new
tmux new-session
tmux new -s mysession           # Named session
tmux new -n mywindow top        # Named window running top
tmux new -s dev -d              # Create detached

# Attach to existing session
tmux attach
tmux attach -t mysession
tmux attach -d -t mysession     # Detach others

# Create or attach (if exists)
tmux new -As mysession

# List sessions
tmux ls
tmux list-sessions
```

### Basic Window Management

```
Prefix + c          Create new window
Prefix + n          Next window
Prefix + p          Previous window
Prefix + 0-9        Jump to window 0-9
Prefix + '          Prompt for window index
Prefix + ,          Rename current window
Prefix + .          Move window to index
Prefix + &          Kill current window (prompt)
Prefix + l          Jump to last window
```

### Pane Management

```
Prefix + "          Split vertically (top/bottom)
Prefix + %          Split horizontally (left/right)
Prefix + Arrow      Move to pane in direction
Prefix + o          Move to next pane
Prefix + ;          Move to last pane
Prefix + x          Kill current pane (prompt)
Prefix + z          Zoom/unzoom pane
Prefix + Space      Cycle through layouts
Prefix + q          Show pane numbers (press number to select)
Prefix + {          Swap with previous pane
Prefix + }          Swap with next pane
Prefix + C-o        Rotate panes
```

### Session Management

```
Prefix + d          Detach from session
Prefix + $          Rename session
Prefix + s          Choose session (tree mode)
Prefix + D          Choose client to detach
Prefix + (          Switch to previous session
Prefix + )          Switch to next session
Prefix + L          Switch to last session
```

### Copy Mode

```
Prefix + [          Enter copy mode
Prefix + ]          Paste from buffer
Prefix + =          Choose paste buffer

# In copy mode (emacs keys by default):
Ctrl + Space        Start selection
Ctrl + w            Copy and exit
q                   Exit copy mode
Arrow keys          Move cursor
PageUp/PageDown     Scroll
Ctrl + r            Search backward
Ctrl + s            Search forward
```

### Command Prompt

```
Prefix + :          Open command prompt
Prefix + ?          Show all key bindings
Prefix + /          Describe key
```

## Configuration

### Config File Location

```bash
~/.tmux.conf           # Main config file
~/.config/tmux/tmux.conf  # Alternative location (tmux 3.1+)
```

### Essential Configuration

```bash
# Change prefix from C-b to C-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Set default terminal
set -g default-terminal "tmux-256color"

# Use vi keys in copy mode and status line
set -g mode-keys vi
set -g status-keys vi

# Start window/pane numbering at 1
set -g base-index 1
setw -g pane-base-index 1

# Renumber windows when one is closed
set -g renumber-windows on

# Increase scrollback history
set -g history-limit 10000

# Reduce escape-time for faster key response
set -sg escape-time 10

# Enable focus events
set -g focus-events on

# Set terminal title
set -g set-titles on
set -g set-titles-string "#S:#W - #T"
```

### Status Bar Customization

```bash
# Status bar position and style
set -g status-position bottom
set -g status-style 'bg=black fg=white'
set -g status-left-length 40
set -g status-right-length 100

# Status bar content
set -g status-left '#[fg=green]#S#[default] | '
set -g status-right '#[fg=yellow]%H:%M#[default] | #[fg=cyan]%d-%b-%y#[default]'

# Window status format
setw -g window-status-format ' #I:#W '
setw -g window-status-current-format '#[bg=blue,fg=white,bold] #I:#W* #[default]'
setw -g window-status-separator ''

# Enable activity monitoring
setw -g monitor-activity on
set -g visual-activity on
```

### Pane Borders

```bash
# Pane border styles
set -g pane-border-style 'fg=colour240'
set -g pane-active-border-style 'fg=colour39'

# Pane border status line
set -g pane-border-status top
set -g pane-border-format '#[bold]#{pane_title}#[default]'
```

## Key Bindings

### Custom Key Bindings

```bash
# Reload config file
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Better split keys (remember: v=vertical split visually, h=horizontal)
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# Vim-style pane navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Vim-style pane resizing
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Create new window with current directory
bind c new-window -c "#{pane_current_path}"

# Quick session switching
bind S choose-session

# Kill session quickly
bind X confirm-before -p "Kill session #S? (y/n)" kill-session

# Sync panes toggle
bind y setw synchronize-panes

# Enter copy mode with Escape
bind Escape copy-mode

# Paste with p
bind p paste-buffer

# Choose buffer with b
bind b choose-buffer
```

### Copy Mode Key Bindings (Vi Style)

```bash
# Vi copy mode bindings
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi C-v send -X rectangle-toggle
bind -T copy-mode-vi y send -X copy-selection-and-cancel
bind -T copy-mode-vi Escape send -X cancel
bind -T copy-mode-vi H send -X start-of-line
bind -T copy-mode-vi L send -X end-of-line
```

### Mouse Bindings

```bash
# Enable mouse
set -g mouse on

# Mouse drag to copy (vi mode)
bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
```

## Window and Pane Layouts

### Predefined Layouts

```
Prefix + M-1       Even horizontal
Prefix + M-2       Even vertical
Prefix + M-3       Main horizontal (large pane at top)
Prefix + M-4       Main vertical (large pane on left)
Prefix + M-5       Tiled
```

### Pane Sizing and Zoom

```bash
# Resize panes
Prefix + C-Arrow      Resize by 1 cell
Prefix + M-Arrow      Resize by 5 cells

# Zoom pane (fullscreen toggle)
Prefix + z

# Set specific window size
tmux resize-window -x 160 -y 48

# Auto-size from attached clients
tmux resize-window -A
```

### Working Directory Preservation

```bash
# New panes/windows open in current directory
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
```

## Remote Workflow

### SSH + tmux Best Practices

```bash
# On local machine, connect to remote and attach/create session
ssh user@server -t "tmux new -As main"

# Or for existing session
ssh user@server -t "tmux attach -t main"

# Keep connection alive in ~/.ssh/config
Host myserver
    HostName server.example.com
    User username
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

### Session Persistence

```bash
# Always use named sessions for important work
tmux new -s production
tmux new -s development
tmux new -s monitoring

# Detach and reattach from different locations
tmux detach          # or Prefix + d
tmux attach -t production

# List and switch between sessions
tmux ls
tmux switch -t development
```

### Multiple Clients

```bash
# View same session from multiple terminals (read-only)
tmux attach -t mysession

# View with different current window
tmux new-session -t mysession -s mysession2
```

## Advanced Features

### Tree Mode (Choose Mode)

```
Prefix + s          Choose session (tree view)
Prefix + w          Choose window (tree view)
Prefix + f          Find window by text

# In tree mode:
Enter               Select item
t                   Tag/untag item
T                   Untag all
X                   Kill tagged items
:                   Run command on tagged items
q                   Exit
Arrow keys          Navigate
Right/Left          Expand/collapse
```

### Pane Title and Terminal Title

```bash
# Set pane title
:select-pane -T "My Pane Title"

# Automatic rename
setw -g automatic-rename on
setw -g automatic-rename-format '#{b:pane_current_path}'

# Set terminal window title
set -g set-titles on
set -g set-titles-string '#S:#W - #T'
```

### Alerts and Monitoring

```bash
# Monitor activity in a window
setw -g monitor-activity on

# Monitor silence (no output for N seconds)
setw -g monitor-silence 30

# Visual alerts
set -g visual-activity on
set -g visual-bell on
set -g visual-silence on

# Activity action (any, none, current, other)
set -g activity-action other

# Navigate to windows with alerts
Prefix + M-n        Next window with alert
Prefix + M-p        Previous window with alert
```

### Synchronize Panes

```bash
# Send input to all panes in window (use with caution!)
Prefix + :set synchronize-panes on

# Or bind to a key
bind y setw synchronize-panes
```

### Buffer Management

```bash
# List buffers
Prefix + =
tmux list-buffers
tmux lsb

# Save buffer to file
:save-buffer ~/output.txt

# Load buffer from file
:load-buffer ~/input.txt

# Set buffer content
:set-buffer "text to paste"

# Delete buffer
:delete-buffer -b buffer0
```

### Piping and Logging

```bash
# Pipe pane output to file
:pipe-pane 'cat >> ~/log.txt'
:pipe-pane          # Stop piping

# Toggle piping with a key
bind P pipe-pane -o 'cat >> ~/tmux-#S-#W-#P.log' \; display "Toggled logging"

# Capture pane content
: capture-pane -pS - -E -     # Capture all including history to stdout
```

## Clipboard Integration

### Using OSC 52 (Terminal Integration)

```bash
# Enable set-clipboard (default: external)
set -s set-clipboard external

# For tmux inside tmux, use 'on'
set -s set-clipboard on

# Check if Ms capability is available
tmux info | grep Ms

# If missing, add for your terminal (tmux 3.2+)
set -as terminal-features ',xterm-256color:clipboard'

# For older tmux
set -as terminal-overrides ',xterm-256color:Ms=\\E]52;%p1%s;%p2%s\\007'
```

### Using External Tools

```bash
# tmux 3.2+ - set copy command
set -s copy-command 'xclip -selection clipboard'

# tmux 2.4+ - copy-pipe bindings (vi mode)
bind -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -selection clipboard'
bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel 'xclip -selection clipboard'

# macOS
bind -T copy-mode-vi y send -X copy-pipe-and-cancel 'pbcopy'

# WSL
bind -T copy-mode-vi y send -X copy-pipe-and-cancel 'clip.exe'
```

## Scripting tmux

### Command Targeting

```bash
# Target syntax: session:window.pane
tmux send-keys -t mysession:1.0 'ls' Enter
tmux send-keys -t %0 'exit' Enter     # Target by pane ID

# Use IDs for reliability in scripts
SESSION=$(tmux new -dPF '#{session_id}' -s mysession)
WINDOW=$(tmux neww -dPF '#{window_id}' -t $SESSION)
PANE=$(tmux splitw -dPF '#{pane_id}' -t $WINDOW)
tmux send-keys -t $PANE 'echo "Hello"' Enter
```

### Session Templates

```bash
# Create development environment
tmux new-session -d -s dev
tmux rename-window -t dev:1 'editor'
tmux send-keys -t dev:1 'vim' Enter
tmux new-window -t dev -n 'server'
tmux send-keys -t dev:2 'npm start' Enter
tmux new-window -t dev -n 'logs'
tmux send-keys -t dev:3 'tail -f log.txt' Enter
tmux select-window -t dev:1
tmux attach -t dev
```

### Hooks

```bash
# Run command when pane/window/session changes
set-hook -g after-new-window 'display "New window created"'
set-hook -g pane-exited 'display "Pane closed"'

# Pane-specific hooks
set-hook -t %0 pane-focus-in 'display "Pane 0 focused"'
```

### Conditional Configuration

```bash
# Version-specific config (%if since tmux 2.4)
%if #{>=:#{version},3.0}
    set -g status-style bg=blue
%else
    set -g status-bg blue
%endif

# Host-specific config
%if #{==:#{host_short},myhost}
    source ~/.tmux.conf.work
%endif
```

## Recipes and Workflows

### Development Workflow

```bash
# Create dev session
tmux new -s dev -d

# Window 1: Editor
tmux rename-window -t dev:1 code
tmux send-keys -t dev:1 'vim' Enter

# Window 2: Terminal
tmux new-window -t dev -n term
tmux splitw -h -t dev:2
tmux splitw -v -t dev:2.2

# Window 3: Build/Tests
tmux new-window -t dev -n build
tmux send-keys -t dev:3 'npm run watch' Enter

tmux attach -t dev
```

### Server Monitoring

```bash
# Create monitoring session
tmux new -s monitoring -d

# htop
tmux send-keys -t monitoring:1 'htop' Enter

# logs
tmux new-window -t monitoring -n logs
tmux send-keys -t monitoring:2 'tail -f /var/log/syslog' Enter

# network
tmux new-window -t monitoring -n network
tmux splitw -h -t monitoring:3
tmux send-keys -t monitoring:3.1 'iftop' Enter
tmux send-keys -t monitoring:3.2 'nload' Enter
```

### Pair Programming

```bash
# Create shared session
tmux new -s pair -d

# Allow multiple clients to see same session
tmux attach -t pair       # User 1
tmux attach -t pair       # User 2 (same view)

# Or create grouped session for different views
tmux new -t pair -s pair2  # User 2 can have different current window
```

### Project-Specific Sessions

```bash
# In project directory, create session
cd ~/projects/myproject
tmux new -s myproject -c "$(pwd)"

# Create helper script ~/bin/tmux-project
#!/bin/bash
PROJECT=$(basename "$PWD")
tmux new -s "$PROJECT" -c "$PWD" || tmux attach -t "$PROJECT"
```

## Troubleshooting

### Common Issues

**Prefix key not working**:
```bash
# Check current prefix
tmux show -g prefix

# Ensure prefix is set correctly
set -g prefix C-b
bind C-b send-prefix
```

**Colors not working**:
```bash
# Set correct TERM inside tmux
set -g default-terminal "tmux-256color"

# Enable RGB color if terminal supports it
set -as terminal-features ",xterm-256color:RGB"
# Or for older tmux
set -as terminal-overrides ",xterm-256color:Tc"
```

**Escape delay in vim**:
```bash
# Reduce escape-time
set -sg escape-time 10
# Or in vim
set ttimeoutlen=10
```

**UTF-8 characters not displaying**:
```bash
# Force UTF-8
tmux -u new
# Or in config
setw -q utf8 on  # tmux < 2.2
```

**Server exited unexpectedly**:
```bash
# Check if server is running
pgrep tmux

# Check socket
ls -la /tmp/tmux-$(id - u)/

# Recreate socket if deleted
pkill -USR1 tmux
```

### Diagnostics

```bash
# Show tmux information
tmux info

# Show current options
tmux show -g
tmux show -g status-left
tmux show -wg mode-keys

# List all key bindings
tmux lsk
tmux lsk -N          # With descriptions

# List commands
tmux lscm

# Verbose output (run in terminal)
tmux -vv new
# Check tmux-client-*.log, tmux-server-*.log
```

### Debugging Config

```bash
# Validate config without running
tmux source-file -n ~/.tmux.conf

# Source with verbose output
tmux source-file -v ~/.tmux.conf

# Start without config
tmux -f /dev/null new
```

## Quick Reference

### Essential Commands

```bash
# Session control
tmux new -s <name>           Create named session
tmux attach -t <name>        Attach to session
tmux detach                  Detach from session
tmux ls                      List sessions
tmux kill-session -t <name>  Kill session
tmux switch -t <name>        Switch to session

# Window control
tmux neww                     Create window
tmux selectw -t <index>       Select window
tmux renamew <name>           Rename window
tmux killw                    Kill window

# Pane control
tmux splitw -v                Split vertical
tmux splitw -h                Split horizontal
tmux selectp -t <index>       Select pane
tmux killp                    Kill pane
tmux resizep -D 10            Resize pane down 10
```

### Key Binding Reference

```
Sessions:
  d        Detach
  $        Rename session
  s        Choose session
  ( )      Previous/next session
  L        Last session

Windows:
  c        Create
  n        Next
  p        Previous
  0-9      Select by index
  '        Prompt for index
  ,        Rename
  .        Move
  &        Kill
  l        Last window
  f        Find window

Panes:
  "        Split vertical
  %        Split horizontal
  Arrows   Navigate
  o        Next pane
  ;        Last pane
  x        Kill pane
  z        Zoom
  { }      Swap
  Space    Cycle layouts
  q        Show numbers
  !        Break to window

Copy Mode:
  [        Enter copy mode
  ]        Paste
  =        Choose buffer
```

## Best Practices

1. **Always use named sessions** for important work
2. **Split vertically** for logs/output, **horizontally** for side-by-side editing
3. **Use window names** that describe their purpose
4. **Enable mouse support** for easier navigation
5. **Customize prefix** if C-b conflicts with your workflow
6. **Save pane contents** with `capture-pane` before closing
7. **Use synchronize-panes sparingly** - it affects all panes in window
8. **Test config changes** in a new session before reloading main config
9. **Use IDs in scripts** rather than names for reliability
10. **Group related work** into single session, use windows for contexts
