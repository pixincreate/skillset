---
name: zed
description: "Use Zed editor effectively with workflows for navigation, editing, and project management. Use when working with Zed, managing projects, using keybindings, or configuring themes. Auto-activates for: \"open in zed\", \"split pane\", \"search in project\", \"format code\"."
---

# Zed Skill

## Core Principle

**Speed through keyboard-driven editing**: Master Zed's modal editing and command palette for efficient development.

## When to Use This Skill

This skill auto-activates when users request:
- "Open file in Zed"
- "Split pane horizontally"
- "Search in project"
- "Go to definition"
- "Format the code"
- "Toggle theme"
- "Zen mode"

## Essential Zed Basics

### Quick Start

**Opening Zed**:
```bash
# Open Zed
zed

# Open file
zed file.py

# Open directory
zed project-folder/

# Open with line number
zed file.py:42
```

**First-time setup**:
1. Open Zed
2. Complete welcome tour
3. Open Command Palette: `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Linux)
4. Configure theme and settings

## Core Navigation

### File Navigation

**Command Palette**:
```
Cmd/Ctrl+Shift+P - Access all commands
```

**Basic movement**:
```
h, j, k, l        - Move cursor (vi mode)
w, b              - Word forward/backward
0, $              - Line start/end
gg, G             - File start/end
```

**Quick navigation**:
```
Cmd/Ctrl+P        - Open file
Cmd/Ctrl+T        - File tree
Cmd/Ctrl+B        - Toggle side bar
```

### Search and Replace

**Project search**:
```
Cmd/Ctrl+Shift+F  - Find in project
Cmd/Ctrl+F        - Find in file
Cmd/Ctrl+Shift+H - Replace in project
```

**Search patterns**:
- `filename:*test*` - Find test files
- `path:src/` - Search in directory
- `content:"TODO"` - Find text content

## Editing Workflows

### Multi-Cursor Editing

**Multiple cursors**:
```
Cmd/Ctrl+D        - Add selection to next match
Cmd/Ctrl+Option+Click - Add cursor at position
Alt/Option+Up/Down - Add cursor above/below
```

**Column selection**:
```
Option+Drag       - Column select (macOS)
Ctrl+Alt+Drag     - Column select (Linux)
```

### Code Manipulation

**Essential edits**:
```
Cmd/Ctrl+/        - Toggle comment
Cmd/Ctrl+Shift+K - Delete line
Cmd/Ctrl+Shift+↑/↓ - Move line up/down
Cmd/Ctrl+[ or ]   - Navigate in/out of pairs
Cmd/Ctrl+Enter    - Insert line below
Cmd/Ctrl+Shift+Enter - Insert line above
```

**Language specific**:
```
Cmd/Ctrl+Shift+F  - Format file
Cmd/Ctrl+.        - Quick fix suggestions
Cmd/Ctrl+Space    - Autocomplete
```

## Pane Management

### Splitting and Layouts

**Window splits**:
```
Cmd/Ctrl+Shift+P → "split:horizontal"
Cmd/Ctrl+Shift+P → "split:vertical"
Cmd/Ctrl+Shift+P → "close-pane"
```

**Pane navigation**:
```
Cmd/Ctrl+K Cmd/Ctrl+Up/Down/Left/Right - Move between panes
Cmd/Ctrl+W        - Close current pane
```

**Layout presets**:
```
Cmd/Ctrl+Shift+P → "layout:two-columns"
Cmd/Ctrl+Shift+P → "layout:three-columns"
Cmd/Ctrl+Shift+P → "layout:toggle-vertical"
```

## Project Management

### Project Workspaces

**Project panel**:
```
Cmd/Ctrl+Shift+P → "project-panel:toggle"
Right-click       - File operations
a                 - New file
```

**Project-wide operations**:
```
Cmd/Ctrl+Shift+P → "search:in-project"
Cmd/Ctrl+Shift+P → "terminal:new"
Cmd/Ctrl+Shift+P → "task:new"
```

### Version Control

**Git integration**:
```
Cmd/Ctrl+Shift+G - Git panel
Cmd/Ctrl+Shift+P → "git:stage"
Cmd/Ctrl+Shift+P → "git:unstage"
Cmd/Ctrl+Shift+P → "git:commit"
```

## Language Features

### Go to Definition

**Code navigation**:
```
Cmd/Ctrl+Click    - Go to definition
Cmd/Ctrl+Shift+Click - Peek definition
F12               - Go to definition
Alt+F12           - Peek definition
```

**Find references**:
```
Shift+F12         - Find all references
Cmd/Ctrl+F12      - Find implementations
```

### Intellisense

**Autocomplete**:
```
Tab or Enter      - Accept suggestion
Cmd/Ctrl+.        - Show all fixes
Cmd/Ctrl+,        - Parameter hints
```

## Quick Configuration

### Settings

**Open settings**:
```
Cmd/Ctrl+,        - Settings
Cmd/Ctrl+Shift+, - Toggle keybindings
```

**Common settings**:
```json
{
  "theme": "Zed Dark",
  "font_size": 14,
  "tab_size": 4,
  "show_line_numbers": true,
  "soft_wrap": "editor_width",
  "auto_save": "on_focus_change"
}
```

### Keybindings

**Custom keybindings**:
```json
[
  {
    "context": "Editor",
    "bindings": {
      "cmd-j": "editor:JoinLines"
    }
  }
]
```

## Common Workflows

### Debugging Workflow

1. **Open file**: `Cmd/Ctrl+P` → search
2. **Set breakpoint**: `F9` on line
3. **Debug panel**: `Cmd/Ctrl+Shift+D`
4. **Start debugging**: `F5`
5. **Step through**: `F10` (step over), `F11` (step into)

### Refactoring Workflow

1. **Find symbol**: `Cmd/Ctrl+Shift+O`
2. **Rename symbol**: `F2` or right-click → rename
3. **Extract method**: Select → `Cmd/Ctrl+.` → extract
4. **Format file**: `Cmd/Ctrl+Shift+F`

### Theme Customization

```json
// In theme file
{
  "name": "Custom Theme",
  "extends": "dark",
  "properties": {
    "editor.background": "#1e1e1e",
    "editor.foreground": "#d4d4d4",
    "editor.line_number": "#858585"
  }
}
```

## Advanced Features

### Terminal Integration

**Terminal in Zed**:
```
Cmd/Ctrl+J        - Toggle terminal panel
Cmd/Ctrl+`        - New terminal
Cmd/Ctrl+Shift+`  - Focus terminal
```

**Multi-repo**:
```
Cmd/Ctrl+Shift+P → "project:add-directory"
```

### Tasks and Build

**Run commands**:
```
Cmd/Ctrl+Shift+P → "task:new"
Cmd/Ctrl+Shift+T - Run task
```

**Task configuration**:
```json
{
  "tasks": [
    {
      "label": "Build",
      "command": "npm",
      "args": ["run", "build"]
    }
  ]
}
```

## Performance Tips

### Keep Zed Fast

1. **Minimize large files**: Avoid opening >10MB files
2. **Use search filters**: Be specific with search terms
3. **Close unused panes**: Keep window clean
4. **Disable extensions**: Remove unused language servers

## Quick Reference

### Essential Shortcuts
```
Cmd/Ctrl+P        - Open file
Cmd/Ctrl+Shift+P - Command palette
Cmd/Ctrl+/        - Toggle comment
Cmd/Ctrl+S        - Save
Cmd/Ctrl+Z        - Undo
Cmd/Ctrl+Y        - Redo
```

### View Commands
```
Cmd/Ctrl+`        - Toggle terminal
Cmd/Ctrl+B        - Toggle sidebar
Cmd/Ctrl+J        - Toggle panel
Cmd/Ctrl+0        - Focus active editor
```

### Search Commands
```
Cmd/Ctrl+F        - Find
Cmd/Ctrl+Shift+F - Find in directory
Cmd/Ctrl+R        - Replace
Cmd/Ctrl+Shift+R - Replace in directory
```

## Language Support

**Built-in languages**:
- JavaScript, TypeScript
- Python, Rust, Go
- HTML, CSS, JSON
- Markdown, YAML

**LSP configuration**:
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

## Integration Notes

Works seamlessly with:
- Git workflows
- Language servers
- Build tools
- Testing frameworks
- Multiple repositories