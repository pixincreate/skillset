# Zed Reference

> **IMPORTANT**: Zed updates frequently. Always verify at https://zed.dev/docs/ when uncertain.

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

Edit code on a remote server while running the Zed UI locally. Language servers, tasks, and terminals run on the remote host.

**Requirements**: Zed v0.159+. Remote server must be macOS or Linux (x86_64 or aarch64). Windows remote server not yet supported.

### Setup

1. Open Remote Projects dialog: `Ctrl+Cmd+Shift+O` (macOS) / `Alt+Ctrl+Shift+O` (Linux/Windows)
2. Click "Connect New Server"
3. Enter the SSH command for the remote server
4. Zed downloads and starts the headless server on the remote host
5. Choose a path to open on the remote server

Zed's headless server is installed to `~/.zed_server` on the remote.

### SSH config (settings.json)

```json
{
  "ssh_connections": [
    {
      "host": "myserver.example.com",
      "username": "me",
      "port": 22,
      "nickname": "prod",
      "projects": ["/home/me/projects/myapp"]
    }
  ]
}
```

### Known limitations

- Cannot open remote files from the local terminal via `zed` command
- Windows cannot act as remote server (only client)

Docs: https://zed.dev/docs/remote-development.html

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
