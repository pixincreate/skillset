# WezTerm Reference

WezTerm is a GPU-accelerated cross-platform terminal emulator and multiplexer written in Rust. Config lives in `~/.config/wezterm/wezterm.lua` (Lua).

> **Docs**: [wezfurlong.org/wezterm](https://wezfurlong.org/wezterm/) — always check there for the latest config options and changelog.

## Config Entry Point

```lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- apply settings...
return config
```

## Key Config Options

| Option | Type | Notes |
|--------|------|-------|
| `font` | `wezterm.font_with_fallback{}` | Font stack with fallback |
| `font_size` | number | e.g. `13` |
| `window_background_opacity` | float 0-1 | e.g. `0.88` |
| `window_decorations` | string | `"RESIZE"`, `"TITLE"`, `"NONE"`, `"TITLE\|RESIZE"` |
| `default_cursor_style` | string | `"SteadyBar"`, `"BlinkingBar"`, `"SteadyBlock"` etc. |
| `hide_mouse_cursor_when_typing` | bool | |
| `scrollback_lines` | int | Default 3500, recommend 350000 |
| `max_fps` | int | e.g. `75` |
| `enable_tab_bar` | bool | |
| `use_fancy_tab_bar` | bool | Set `false` for retro style |
| `audible_bell` | string | `"Disabled"` |
| `copy_on_select` | bool | Primary selection copy |
| `enable_wayland` | bool | Linux only |
| `front_end` | string | `"WebGpu"`, `"Software"`, `"OpenGL"` |
| `use_ime` | bool | Input method |
| `native_macos_fullscreen_mode` | bool | macOS only |

## Colors

```lua
config.colors = {
    foreground = "#c5c9c5",
    background = "#181616",
    cursor_bg  = "#c5c9c5",
    cursor_fg  = "#181616",
    selection_bg = "#2d4f67",
    selection_fg = "#dcd7ba",
    ansi    = { "#0d0c0c", "#c4746e", ... },
    brights = { "#625e5a", "#e46876", ... },
    tab_bar = {
        background = "#181616",
        active_tab = { bg_color = "#1e1b1a", fg_color = "#c5c9c5" },
    },
}
```

Built-in schemes: `config.color_scheme = "Kanagawa Dragon (Gogh)"`. List via `wezterm.get_builtin_color_schemes()`.

## Key Bindings

```lua
config.keys = {
    { key = 't', mods = 'CMD',       action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'CMD',       action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = '\\', mods = 'CMD',      action = wezterm.action.SplitPane { direction = 'Right', size = { Percent = 50 } } },
    { key = 'k', mods = 'CMD',       action = wezterm.action.Multiple {
        wezterm.action.ClearScrollback 'ScrollbackAndViewport',
        wezterm.action.SendKey { key = 'L', mods = 'CTRL' },
    }},
    { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
}
```

Modifier keys: `CTRL`, `SHIFT`, `META` (Alt on Linux), `CMD` (macOS), `OPT` (macOS Alt).

## Tab Title Formatting

```lua
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    return {
        { Background = { Color = "#181616" } },
        { Foreground = { Color = "#c5c9c5" } },
        { Text = " " .. tab.active_pane.title .. " " },
    }
end)
```

## Pane Splitting

```lua
action.SplitPane { direction = 'Right' | 'Left' | 'Up' | 'Down', size = { Percent = 50 } }
action.ActivatePaneDirection 'Left' | 'Right' | 'Up' | 'Down'
action.TogglePaneZoomState
```

## Window Padding

```lua
config.window_padding = { top = 4, left = 4, bottom = 4, right = 4 }
-- or cell-based: left = '1cell', right = '1cell'
```

## Platform Detection

```lua
wezterm.target_triple
-- "x86_64-apple-darwin"        macOS Intel
-- "aarch64-apple-darwin"       macOS ARM
-- "x86_64-unknown-linux-gnu"   Linux x86
-- "aarch64-unknown-linux-gnu"  Linux ARM
```

## Useful Actions

| Action | Description |
|--------|-------------|
| `SpawnTab 'CurrentPaneDomain'` | New tab |
| `SpawnWindow` | New window |
| `CloseCurrentTab { confirm = true }` | Close tab |
| `CloseCurrentPane { confirm = true }` | Close pane |
| `ActivateTab(0)` | Go to tab by index (0-based) |
| `ActivateTabRelative(1)` | Next/prev tab |
| `ActivateCommandPalette` | Command palette |
| `ReloadConfiguration` | Reload config live |
| `IncreaseFontSize` / `DecreaseFontSize` / `ResetFontSize` | Font scaling |
| `ScrollToTop` / `ScrollToBottom` | Scroll |
| `ScrollToPrompt(-1)` | Jump to prev shell prompt |
| `ActivateCopyMode` | Keyboard-driven copy mode |
| `QuickSelect` | Pattern-based quick select |
| `ToggleFullScreen` | Fullscreen |
| `TogglePaneZoomState` | Zoom active pane |

## Nerd Fonts

```lua
wezterm.nerdfonts.seti_lua        -- Lua icon
wezterm.nerdfonts.seti_rust       -- Rust icon
wezterm.nerdfonts.seti_python     -- Python icon
-- etc. All icons via wezterm.nerdfonts.*
```

## Shell Integration

Set `$TERM_PROGRAM=WezTerm` is auto-set. For prompt marks (enables `ScrollToPrompt`):
- fish: `source ~/.config/fish/functions/wezterm.fish`
- bash/zsh: `source <(wezterm shell-integration)`

## Notes on Ghostty Parity

- **Shaders**: Ghostty GLSL shaders (e.g. `cursor-warp.glsl`) cannot be directly ported — WezTerm does not expose a GLSL/WGSL shader API for cursor effects. Use `default_cursor_style = "SteadyBar"` and `cursor_blink_rate` as closest alternative.
- **Quick terminal**: No native equivalent. Approximate with a workspace + `SwitchToWorkspace` keybind.
- **Shell integration features** (cursor, title, sudo, ssh-terminfo, path): Partial — WezTerm handles title and cwd natively; sudo/ssh-terminfo require shell-side setup.
- **`background-opacity`**: Direct equivalent is `window_background_opacity`.
- **`copy-on-select`**: Direct equivalent is `copy_on_select = true`.
- **`mouse-hide-while-typing`**: Direct equivalent is `hide_mouse_cursor_when_typing = true`.
