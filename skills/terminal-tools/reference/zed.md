# Zed Reference

> **Docs**: https://zed.dev/docs/ — Zed updates frequently. Always verify there for the latest features and settings.

## Core Principle

Speed through keyboard-driven editing. Master the command palette, modal editing, and the built-in AI agent for efficient development.

## When to Use This Skill

This skill auto-activates when users request:
- "Open file in Zed"
- "Split pane in Zed"
- "Search in project"
- "Go to definition"
- "Format the code"
- "Toggle theme in Zed"
- "Zed AI agent"
- "Remote development in Zed"
- "Configure Zed settings"

## Quick Start

```bash
zed .                    # open current directory
zed file.py              # open file
zed file.py:42           # open at line 42
zed ~/projects/my-app    # open project
```

First launch: complete the welcome tour. Command palette (`Cmd+Shift+P`) is your gateway to every action.

## Essential Shortcuts

| Action                  | macOS            | Linux/Windows     |
| ----------------------- | ---------------- | ----------------- |
| Command palette         | `Cmd+Shift+P`    | `Ctrl+Shift+P`    |
| Go to file              | `Cmd+P`          | `Ctrl+P`          |
| Go to symbol            | `Cmd+Shift+O`    | `Ctrl+Shift+O`    |
| Find in project         | `Cmd+Shift+F`    | `Ctrl+Shift+F`    |
| Toggle terminal         | `` Ctrl+` ``     | `` Ctrl+` ``      |
| Open settings           | `Cmd+,`          | `Ctrl+,`          |
| Extensions              | `Cmd+Shift+X`    | `Ctrl+Shift+X`    |
| Theme selector          | `Cmd+K Cmd+T`    | `Ctrl+K Ctrl+T`   |
| AI agent panel          | `Cmd+Shift+A`    | `Ctrl+Shift+A`    |
| Inline AI               | `Cmd+Enter`      | `Ctrl+Enter`      |
| Git panel               | `Cmd+Shift+G`    | `Ctrl+Shift+G`    |
| Toggle sidebar          | `Cmd+B`          | `Ctrl+B`          |
| Toggle panel            | `Cmd+J`          | `Ctrl+J`          |
| Find in file            | `Cmd+F`          | `Ctrl+F`          |
| Replace in project      | `Cmd+Shift+H`    | `Ctrl+Shift+H`    |
| Toggle comment          | `Cmd+/`          | `Ctrl+/`          |
| Go to definition        | `Cmd+Click` / `F12` | `Ctrl+Click` / `F12` |
| Find all references     | `Shift+F12`      | `Shift+F12`       |
| Rename symbol           | `F2`             | `F2`              |
| Multi-cursor next match | `Cmd+D`          | `Ctrl+D`          |
| Move line up/down       | `Cmd+Shift+↑/↓`  | `Ctrl+Shift+↑/↓`  |
| Remote Projects         | `Ctrl+Cmd+Shift+O` | `Alt+Ctrl+Shift+O` |

## Settings File

`~/.config/zed/settings.json` — open with `Cmd+,`.

Common settings:

```json
{
  "theme": "One Dark",
  "buffer_font_family": "JetBrains Mono",
  "buffer_font_size": 15,
  "buffer_line_height": "comfortable",
  "format_on_save": "on",
  "vim_mode": false,
  "tab_size": 2,
  "autosave": "on_focus_change",
  "auto_signature_help": true,
  "show_signature_help_after_edits": true,
  "current_line_highlight": "all",
  "cursor_shape": "bar",
  "soft_wrap": "editor_width",
  "disable_ai": false
}
```

Notable settings:

| Setting | Default | Options |
| ------- | ------- | ------- |
| `vim_mode` | `false` | `true/false` |
| `helix_mode` | `false` | `true/false` — enabling one disables the other |
| `autosave` | `"off"` | `"off"`, `"on_focus_change"`, `"on_window_change"`, `{ "after_delay": { "milliseconds": N } }` |
| `base_keymap` | `"VSCode"` | `VSCode`, `Atom`, `JetBrains`, `SublimeText`, `TextMate`, `None` |
| `diff_view_style` | `"split"` | `"split"`, `"unified"` |
| `minimap.show` | `"never"` | `"always"`, `"auto"`, `"never"` |
| `session.restore_unsaved_buffers` | `true` | boolean |
| `bottom_dock_layout` | `"contained"` | `"contained"`, `"full"`, `"left"`, `"right"` |
| `active_pane_modifiers.inactive_opacity` | `1.0` | 0.0–1.0 |
| `edit_predictions` | enabled | `{ "disabled_globs": ["**/.env*", ...] }` |
| `disable_ai` | `false` | boolean — turns off ALL AI features |
| `agent_font_size` | null (inherits UI) | integer 6–100 |
| `scrollbar.show` | `"auto"` | `"auto"`, `"always"`, `"never"`, `"system"` |
| `tabs.show_diagnostics` | `"off"` | `"off"`, `"errors"`, `"all"` |
| `tabs.git_status` | `false` | boolean |

Full reference: https://zed.dev/docs/reference/all-settings.html

## AI Agent Panel

Open with `Cmd+Shift+A` (macOS) or `Ctrl+Shift+A` (Linux/Windows), or search "agent: new thread" in the command palette.

### What agents can do

- Read and edit files in the project
- Run terminal commands
- Search the web
- Access LSP diagnostics
- Use MCP servers you configure

### Key behaviors

- **Checkpoints**: A "Restore Checkpoint" button appears after each edit — revert code to pre-message state
- **Reviewing changes**: After agent edits, review changed files in a multi-buffer tab; accept/reject hunks individually
- **Context**: Type `@` in the message editor to add files, directories, symbols, diagnostics, or previous threads as context
- **Images**: Attach images for vision models (drag-and-drop or `@`-mention)
- **Queuing**: Messages sent while agent is generating are queued
- **Follow agent**: Click the crosshair icon to follow the agent across files; hold `Cmd/Ctrl` while submitting to auto-follow
- **Profiles**: Built-in profiles are Write, Ask, Minimal — configurable via "Configure Profiles"

### Tool permissions

Control via `agent.tool_permissions.default` in settings:

```json
{
  "agent": {
    "tool_permissions": {
      "default": "confirm"
    }
  }
}
```

Options: `"confirm"` (prompt each time), `"allow"` (auto-approve), `"deny"` (block all)

### Configuring AI providers

Go to Agent Panel settings (click settings icon or search "agent: open settings").

Supported providers (bring your own API key):
- Anthropic, OpenAI, Google AI (Gemini), Ollama, Mistral
- DeepSeek, xAI (Grok), LM Studio, OpenRouter
- Amazon Bedrock, GitHub Copilot Chat
- Vercel AI Gateway, Vercel v0
- Any OpenAI-compatible endpoint

Keys are stored in your OS's secure credential store — not in `settings.json`.

Set via environment variables too: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, etc.

**Turn off all AI:**

```json
{ "disable_ai": true }
```

Docs: https://zed.dev/docs/ai/overview.html

## Remote Development (SSH)

Edit code on a remote server while running the Zed UI locally. The UI stays responsive on your machine; language servers, tasks, terminals, and source code run on the remote host.

**Requirements**: Zed v0.159+. Remote server must be macOS or Linux (x86_64 or arm64). Windows can be used as a local client but not yet as a remote server.

### Architecture

| Runs locally (UI machine) | Runs on remote server |
|---|---|
| Zed UI rendering | Source code |
| Tree-sitter parsing/syntax-highlight | Language servers |
| AI model interactions | Tasks & terminals |
| Unsaved changes & recent projects | Zed headless server (`~/.zed_server`) |

Communication between the two happens over SSH.

### Setup — Interactive

1. Open **Remote Projects** dialog: `Cmd+Shift+O` (macOS) / `Alt+Ctrl+Shift+O` (Linux/Windows)
2. Click **"Connect New Server"**
3. Enter the SSH command you'd normally use (e.g., `ssh user@host`)
4. On successful connection, Zed downloads the headless server binary to the remote and starts it
5. Choose a path to open on the remote server

> **Avoid opening very large directories** (e.g., `/` or `~` with >100k files) — Zed creates file indexes for the project tree. Open specific project subdirectories instead.

### Setup — CLI Shortcut

```bash
zed ssh://[<user>@]<host>[:<port>]/<path>
zed ssh://[<user>@]<host>:~/project       # relative path
zed ssh://[<user>@]<host>:/absolute/path  # absolute path
```

You can also hotlink into an SSH project via: `zed://ssh/[<user>@]<host>[:<port>]/<path>`

### SSH Connection Config

The list of remote servers is stored in your **local** `settings.json` (`~/.config/zed/settings.json` on macOS/Linux). Use the Remote Projects dialog to add them (it validates the connection before saving), or edit manually:

```json
{
  "ssh_connections": [
    {
      "host": "192.168.1.10",
      "username": "me",
      "port": 22,
      "projects": [{ "paths": ["~/code/myapp"] }],
      "nickname": "dev-server",
      "args": ["-i", "~/.ssh/work_id_file"],
      "upload_binary_over_ssh": false
    }
  ]
}
```

| Field | Type | Description |
|---|---|---|
| `host` | string | **Required.** Hostname or IP |
| `username` | string | SSH user (defaults to local username) |
| `port` | number | SSH port (default: 22) |
| `projects` | array | Paths to open on the remote `[{ "paths": ["~/project"] }]` |
| `nickname` | string | Display label in Zed UI |
| `args` | string[] | Extra SSH args, e.g. `["-i", "~/.ssh/key"]` |
| `upload_binary_over_ssh` | bool | Download server binary locally, then upload over SSH (useful when remote has restricted internet) |

Zed shells out to the `ssh` binary on your `PATH` and inherits `~/.ssh/config` settings automatically — so host aliases, identity files, and jump hosts configured there just work.

### Port Forwarding

Forward remote ports to your local machine (useful for web dev — load the site in your browser):

```json
{
  "ssh_connections": [
    {
      "host": "192.168.1.10",
      "port_forwards": [
        { "local_port": 8080, "remote_port": 80 }
      ]
    }
  ]
}
```

By default, ports bind to `localhost`. Override with `local_host`:

```json
{
  "port_forwards": [
    {
      "local_port": 8080,
      "remote_port": 80,
      "local_host": "0.0.0.0",
      "remote_host": "docker-host"
    }
  ]
}
```

Under the hood this uses `ssh -L`.

### Supported SSH Options

When typing in the "Connect New Server" dialog, you can use bash-style quoting. These options are supported:

- `-p` / `-l` — port and username (equivalent to host string syntax)
- `-L` / `-R` — port forwarding
- `-i` — specific identity file
- `-o` — custom SSH options
- `-J` / `-w` — jump host / tunnel
- `-F` — custom SSH config file
- `-4`, `-6`, `-A`, `-B`, `-C`, `-D`, `-I`, `-K`, `-P`, `-X`, `-Y`, `-a`, `-b`, `-c`, `-k`, `-m`, `-o`, `-p`, `-w`, `-x`, `-y`

Options that Zed sets for you (e.g., `-t`, `-T`) are deliberately blocked.

### Settings Locations for Remote Projects

| Settings file | Scope | Use for |
|---|---|---|
| `~/.config/zed/settings.json` (local) | Local machine | UI tweaks: font size, theme, etc. |
| `~/.config/zed/settings.json` (remote server) | Remote machine | Server-side config: language server paths, proxy |
| `.zed/settings.json` (in project) | Per-project | Shared team config: indent, formatter, LSP settings |

The local and server settings are NOT synced — each is read independently. Project settings are read by both.

Extensions installed locally are propagated to the remote server automatically.

### Proxy Configuration

The remote server does NOT use your local proxy. Configure proxy on the remote server itself:

```bash
# In ~/.bashrc on the remote
export http_proxy="http://proxy.example.com:8080"
export https_proxy="http://proxy.example.com:8080"
export no_proxy="localhost,127.0.0.1"
```

Or in the remote machine's Zed settings:

```json
{
  "proxy": "http://proxy.example.com:8080"
}
```

### Server Initialization

1. Zed shells out to `ssh` to create a ControlMaster connection
2. SSH prompts (host key verification, key passwords) are shown in the UI
3. Zed checks for the server binary at `~/.zed_server` on the remote
4. If missing or version mismatch: downloads from `https://zed.dev` (or uploads locally if `upload_binary_over_ssh: true`)
5. Server binary naming: `zed-remote-server-{CHANNEL}-{VERSION}` — must exactly match local Zed version

To maintain the server binary yourself: download from [GitHub releases](https://github.com/zed-industries/zed/releases) or `cargo build -p remote_server --release`, then upload to `~/.zed_server/` with the exact version string.

### Connection Maintenance

Zed creates new SSH connections reusing an existing ControlMaster. Each connection starts the server daemon in proxy mode:
- Starts the daemon if not running
- Reconnects to it if already running
- Unsaved changes persist locally — reconnect to the project later to restore them

For connection issues: `Cmd+Shift+P` → "Open Log" to inspect the Zed log. File issues on [GitHub](https://github.com/zed-industries/zed/issues/new).

### WSL Support (Windows)

- **Open local folder in WSL**: action `projects: open in wsl` → pick folder → pick WSL distro
- **Open folder inside WSL**: action `projects: open wsl` → pick distro → appears in Remote Projects window

### Known Limitations

- Cannot open files from the remote Terminal via the `zed` CLI command
- Windows cannot act as remote server (only client)
- Large directories (>100k files) cause slow indexing — open subfolders instead

### Supported Remote Platforms

- macOS Catalina or later (Intel or Apple Silicon)
- Linux x86_64 or arm64 (not exhaustively tested on all distros)
- Windows not yet supported as remote server

Docs: https://zed.dev/docs/remote-development.html

---

## Environment Variables

**Applies to Zed 0.152.0+.** Environment variables affect tasks, the built-in terminal, and language server look-up.

### How Zed Gets Environment Variables

#### Launched from the CLI

```bash
export MY_VAR=hello
zed .
```

Zed inherits the surrounding shell's environment. Starting with 0.152.0, the CLI always passes env vars to Zed even if a previous instance is running.

#### Launched from Dock / Launcher (macOS/Linux)

When launched from the Dock, GNOME/KDE icon, Alfred, Raycast, etc., there's no shell to inherit from. Zed spawns a **login shell in your home directory** and reads its environment for the **process-level** variables.

Then, when opening a project, Zed spawns **another login shell in the project directory** to capture **project-specific** variables (useful for `direnv`, `asdf`, `mise`). This second set is NOT applied to the process — it's stored per-project.

### Two Sets of Environment Variables

| Set | When populated | Scope |
|---|---|---|
| Process env | At startup (or from login shell) | All Zed windows, inherited by every spawned process |
| Project env | When opening a project (from login shell in project dir) | Only tasks, terminals, and language servers in that project |

### How Features Use Them

**Tasks & Built-in Terminal** — combined env, precedence (low → high):
1. Zed process environment
2. CLI environment (if project opened from CLI)
3. Project environment (if not from CLI)
4. Explicitly configured env in settings

**Language Server Look-up** (for `$PATH`-based binary discovery):
- From CLI: uses CLI environment
- From Dock: uses project environment (login shell in project dir)

**Language Server Process** — inherits Zed process env, plus:
- If found in project env's `$PATH`: project env is passed along
- If found globally: inherits process env + CLI env

Docs: https://zed.dev/docs/environment.html

---

## Dev Containers

Dev Containers let you define your project's dependencies, tools, and settings in a Docker/Podman container. Zed can open a project **inside** the container — the files are volume-mounted from your workspace, but tasks, terminals, and language servers run inside the container environment.

This is useful when:
- Onboarding: every dev gets the same tools/versions automatically
- Avoiding "works on my machine" — the dev environment is codified
- Isolating dependencies (e.g., different projects need different Node/Python versions)

### Requirements

- **Docker** or **Podman** installed and on `PATH`
- Podman users must set `"use_podman": true` in Zed settings
- Your project must have a `.devcontainer/devcontainer.json` file

### How to Use

#### Automatic Prompt

Open a project with `.devcontainer/devcontainer.json` → Zed asks: **"Open in Container?"**

Choose "Open in Container" and Zed:
1. Builds the container image (if needed)
2. Launches the container
3. Reopens the project connected to the container environment

#### Manual Open

- **Command palette**: `"Project: Open Remote"` → select dev container option
- **Remote Projects modal** (`Ctrl+Cmd+Shift+O` / `Alt+Ctrl+Shift+O`): choose "Connect Dev Container"

### Dev Container Configuration

Standard dev container spec is used. Zed reads `.devcontainer/devcontainer.json` — it supports specifying Zed extensions via the `customizations` field:

```json
{
  "name": "My Dev Environment",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:18",
  "customizations": {
    "zed": {
      "extensions": ["vue", "ruby"]
    },
    "vscode": {
      "extensions": [...]
    }
  },
  "postCreateCommand": "npm install"
}
```

> Zed extensions loaded via dev containers also install locally on your machine.

### Editing Config

If you change `.devcontainer/devcontainer.json` after connecting, Zed does NOT rebuild or reload automatically. You must:
1. Stop/kill the container manually (e.g., `docker kill <container>`)
2. Reopen the project in the container

### Known Limitations

- No automatic rebuild on config changes — manual container restart required
- Feature is still in active development

Docs: https://zed.dev/docs/dev-containers.html

---

## Language Setup

Zed has built-in support for most languages. For others:

1. `Cmd+Shift+X` → search your language → Install
2. LSP configuration in settings:

```json
{
  "lsp": {
    "rust-analyzer": {
      "binary": {
        "path": "/path/to/rust-analyzer"
      }
    }
  }
}
```

Docs: https://zed.dev/docs/languages

## Vim / Helix Mode

```json
{ "vim_mode": true }
```

or

```json
{ "helix_mode": true }
```

Enabling one automatically disables the other. Full docs: https://zed.dev/docs/vim

## Custom Keybindings

`~/.config/zed/keymap.json`

```json
[
  {
    "context": "Editor",
    "bindings": {
      "cmd-j": "editor::JoinLines"
    }
  }
]
```

Open with `Cmd+K Cmd+S` or search "zed: open keymap" in the command palette.

Docs: https://zed.dev/docs/key-bindings

## Multi-Cursor

| Action | macOS | Linux/Windows |
| ------ | ----- | ------------- |
| Add cursor to next match | `Cmd+D` | `Ctrl+D` |
| Add cursor above/below | `Alt+↑/↓` | `Alt+↑/↓` |
| Add cursor at click | `Cmd+Option+Click` | `Ctrl+Alt+Click` |
| Column select | `Option+Drag` | `Ctrl+Alt+Drag` |

## Tasks

```json
// .zed/tasks.json in project root
[
  {
    "label": "Build",
    "command": "npm run build"
  },
  {
    "label": "Test",
    "command": "npm test"
  }
]
```

Run with `Cmd+Shift+P` → "task: spawn" or `Cmd+Shift+T`.

## Recent Features (2025–2026)

- **Multi-line search and replace** in Buffer Search and Project Search (v0.230.0)
- **Git status indicators** in the project panel (v0.230.0)
- **Paste files/folders into Agent Panel** as context (v0.230.0)
- **Vim/Emacs modeline support** for per-file language detection and editor settings (v0.230.0)
- **Screen sharing on Wayland/Linux** (v0.230.0)
- **Settings Editor UI** — fully rebuilt with strong-typed settings, per-project/per-server/user levels (Dec 2025)
- **Zeta2 edit prediction model** — 30% better acceptance rate, open-weight, default for all users (Mar 2026)
- **Multiple Project Search Tabs** — open searches in parallel tabs
- **External agents**: Claude Agent, Gemini CLI, Codex run directly in Zed via Agent Client Protocol
- **Helix mode** added alongside Vim mode (enabling one disables the other)
- **Minimap** (opt-in): `{ "minimap": { "show": "auto" } }`

Release notes: https://zed.dev/releases
Blog: https://zed.dev/blog
