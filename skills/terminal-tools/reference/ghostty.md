# Ghostty Reference

> **Docs**: [ghostty.org/docs](https://ghostty.org/docs) — config reference at [ghostty.org/docs/config/reference](https://ghostty.org/docs/config/reference). Always check there for the latest options; this file is a curated subset.

## When to Use This Skill

- "Configure Ghostty terminal"
- "Change Ghostty theme"
- "Set terminal font / padding / opacity"
- "Configure keybindings in Ghostty"
- "Ghostty quick terminal / keybinds"

## Getting Started

### Installation

**macOS**:

```bash
brew install --cask ghostty
```

**Linux** (Fedora — Terra repo omits themes by design, see Themes section):

```bash
# COPR (ships the full theme DB)
sudo dnf copr enable scottames/ghostty
sudo dnf install --disablerepo='terra*' ghostty
# Terra (no bundled themes)
sudo dnf install ghostty
```

**Arch**: `paru -S ghostty-bin` · **Debian/Ubuntu**: see [ghostty.org/docs/install](https://ghostty.org/docs/install).

### First Launch

1. Open Ghostty (macOS: `Cmd+,` opens settings · Linux: config file only)
2. Edit `~/.config/ghostty/config`
3. Reload: `ghostty +reload-config` or the `reload_config` action

## Configuration

### Config File

```bash
~/.config/ghostty/config        # macOS + Linux
```

Supports splitting configs with `config-file` (loaded **after** the main file, so it can override):

```conf
config-file = ~/.config/ghostty/os/linux.conf
config-file = ~/.config/ghostty/theme.conf
```

### Basic Configuration (REAL KEYS)

```conf
# Appearance
theme = kanagawa-dragon          # any name from `ghostty +list-themes`
font-family = JetBrains Mono
font-size = 14
background-opacity = 0.88        # NOT `opacity`
padding = 4                      # or padding = 8,4 (top/bottom, left/right)

# Terminal behavior
shell-integration = auto         # auto|zsh|bash|fish|none
confirm-close-surface = false
mouse-hide-while-typing = true
scrollback-limit = 350000        # lines of scrollback

# Cursor
cursor-style = block             # block|underline|bar
cursor-color = #dcd7ba
```

**Invalid keys to AVOID** (do not exist): `opacity`, `blur`, `gpu-acceleration`, `fps`, `buffer-lines`, `shell-integration-full`, `fi-command`, `show-tab-bar`, `tab-bar-position`, `tab-width`, `tab-close-buttons`. Use the real equivalents above.

## Themes

### Built-in Themes

Ghostty ships 400+ themes sourced from [iterm2-color-schemes](https://iterm2colorschemes.com) (updated weekly upstream):

```conf
theme = Catppuccin Frappe
theme = dark:Catppuccin Frappe,light:Catppuccin Latte   # auto light/dark
theme = kanagawa-dragon
```

List installed themes: `ghostty +list-themes`. Theme lookup dirs: `$XDG_CONFIG_HOME/ghostty/themes` and `$PREFIX/share/ghostty/themes`.

> **License note**: the theme _collection_ is MIT, but **each theme's copyright belongs to its original author**; some are non-redistributable (e.g. Monokai Pro) or unlicensed (mbadolato/iTerm2-Color-Schemes#638). Terra deliberately does not bundle themes for this reason; the COPR build (`-Demit-themes=true`) does. Upstream binaries ship them.

### Custom Theme (REAL palette syntax)

```conf
palette = 0=#51576d
palette = 1=#e78284
palette = 2=#a6d189
palette = 3=#e5c890
palette = 4=#8caaee
palette = 5=#f4b8e4
palette = 6=#81c8be
palette = 7=#a5adce
palette = 8=#626880
palette = 9=#e67172
palette = 10=#8ec772
palette = 11=#d9ba73
palette = 12=#7b9ef0
palette = 13=#f2a4db
palette = 14=#5abfb5
palette = 15=#b5bfe2
background = #303446
foreground = #c6d0f5
cursor-color = #f2d5cf
cursor-text = #c6d0f5
selection-background = #626880
selection-foreground = #c6d0f5
```

## Fonts and Typography

```conf
font-family = "JetBrains Mono Nerd Font, SF Mono, Monaco"   # comma fallbacks
font-size = 14
font-weight = 500                    # 1-999
font-style = normal
font-feature = +calt                 # contextual alternates (repeatable)
font-feature = +liga                 # ligatures
line-height = 1.2
letter-spacing = 0
```

Check fonts: `fc-list | grep -i jetbrains`.

## Keybindings

Syntax: `keybind = <mods>+<key>=<action>`. Modifiers: `super` (Cmd on macOS / Meta on Linux), `ctrl`, `shift`, `alt`. Prefix `global:` for system-wide binds (e.g. quick terminal):

```conf
# Copy/Paste
keybind = ctrl+shift+c=copy_to_clipboard
keybind = ctrl+shift+v=paste_from_clipboard

# Window/Tab
keybind = super+n=new_window
keybind = super+t=new_tab
keybind = super+w=close_window
keybind = super+shift+d=close_tab

# Splits (since 1.2)
keybind = super+d=new_split_right
keybind = super+shift+d=new_split_below
keybind = super+[=goto_split_previous
keybind = super+]=goto_split_next

# Font size
keybind = super+plus=increase_font_size
keybind = super+minus=decrease_font_size
keybind = super+0=reset_font_size

# Misc
keybind = super+k=clear_screen
keybind = super+shift+p=toggle_command_palette
keybind = ctrl+shift+r=reload_config

# Quick terminal (global, works headless — requires global keybind in D-Bus mode)
keybind = global:super+grave_accent=toggle_quick_terminal
```

Useful actions: `new_window`, `new_tab`, `new_split_right`, `new_split_below`, `new_split_left`, `new_split_above`, `goto_split_*`, `close_window`, `close_tab`, `increase_font_size`, `decrease_font_size`, `reset_font_size`, `copy_to_clipboard`, `paste_from_clipboard`, `clear_screen`, `toggle_quick_terminal`, `reload_config`, `toggle_command_palette`.

## Quick Terminal (quake mode)

```conf
quick-terminal-position = top          # top|bottom|left|right|center
quick-terminal-size = 55%,700px
quick-terminal-animation-duration = 0.18
quick-terminal-keyboard-interactivity = on-demand
# gtk only:
gtk-quick-terminal-layer = overlay

# Known bug (ghostty #11679, fixed in 1.3.2): autohide=true breaks manual toggle-off
# on KDE — window doesn't fully hide and keeps focus. Workaround:
quick-terminal-autohide = false
```

Note: in headless/D-Bus mode (`--initial-window=false`) the quick terminal only works if you have a **global** keybind registered (rhodes-b, ghostty #11534).

## Linux (GTK) Specifics

```conf
# Window chrome
gtk-titlebar = true
gtk-tabs-location = top
gtk-single-instance = true          # see D-Bus warning below

# D-Bus activation gotcha: ghostty's default is `detect`, which resolves to
# false when the D-Bus service launches headless (--initial-window=false + flags
# => probable_cli) -> app never claims com.mitchellh.ghostty -> KRunner/app-menu
# launch fails with "Did not receive a reply". Keep it explicitly `true`.
```

## Performance

```conf
# Real keys only
scrollback-limit = 350000
background-opacity = 0.88
max-fps = 60                          # 0 = uncapped
```

> Ghostty has **no** `gpu-acceleration`/`fps`/`buffer-lines` options. Rendering is always GPU-accelerated (OpenGL/Vulkan via Metal on macOS).

## Background Blur (macOS only in practice)

Key: `background-blur` (renamed from `background-blur-radius` in 1.1 — old name is a compat alias).

- **macOS**: fully supported (CoreGraphics). Requires `background-opacity < 1`.
- **Linux Wayland (KDE Plasma)**: broken on Plasma 6.7+ (Fedora 44) — Plasma dropped `org_kde_kwin_blur_manager` for `ext-background-effect-v1`; ghostty 1.3.1 only supports the old protocol. Blur silently stops working. Fixed on tip/main (PR #10727, issue #10721). Tracked in ghostty discussions #13041/#13068.
- **Linux X11**: works only on KWin via `_KDE_NET_WM_BLUR_BEHIND_REGION`.
- **Mutter (GNOME)**: NOT supported.

Value forms: `background-blur = true|false`, an integer blur intensity (macOS), or `macos-glass-regular|macos-glass-clear` (macOS 26+ only).

## Command Palette

```
super+shift+p   # toggle_command_palette
```

Contains: New Window, New Tab, New Split, Change Theme, Copy URL, Clear Screen, Open Config, Toggle Quick Terminal, Reload Configuration.

## Troubleshooting

**Config validation / debugging**:

```bash
ghostty +show-config          # dump effective config
ghostty +list-themes          # list available themes
ghostty +list-actions         # list all keybind actions
ghostty --version             # version + build info (channel: tip/stable)
```

**D-Bus launch failure from app menu (KDE)**:

1. `busctl --user list | grep -i ghostty` — if it shows `(activatable)` only, the name is NOT claimed.
2. Ensure `gtk-single-instance = true` (not `detect`) in config; restart `systemctl --user restart app-com.mitchellh.ghostty`.
3. Verify service files exist: `/usr/share/dbus-1/services/com.mitchellh.ghostty.service` + `/usr/share/systemd/user/app-com.mitchellh.ghostty.service`.

**Theme not found** (Terra package): Terra doesn't bundle themes. Install from COPR or drop themes into `~/.config/ghostty/themes/`.

## Workflows

1. **Setup**: theme + font-family + font-size + background-opacity + padding in one config.
2. **Tabs/splits**: `super+t` new tab, `super+d`/`super+shift+d` splits, `super+[`/`]` navigate.
3. **Quick terminal**: global `super+grave_accent` toggle for a quake-style drop-down.
4. **SSH**: `ssh host` works natively; shell integration auto-injects over SSH.
