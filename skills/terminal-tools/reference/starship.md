# Starship Reference

## Core Principle

Configure informative, fast shell prompts: Set up a prompt that shows useful context without slowing down your terminal.

## When to Use This Skill

This skill auto-activates when users request:
- "Configure starship for bash/zsh/fish"
- "Customize my prompt"
- "Show git branch in prompt"
- "Add nodejs version to prompt"
- "Change prompt format"
- "Debug slow starship prompt"
- "Configure starship symbols"

## Quick Start

### Installation

```bash
# Install starship (choose one)
curl -sS https://starship.rs/install.sh | sh

# Or with package managers
brew install starship
cargo install starship
npm install -g starship

# Add to shell config
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'starship init fish | source' >> ~/.config/fish/config.fish
```

### Basic Configuration

```bash
# Create config directory
mkdir -p ~/.config/starship

# Create default config
starship preset gruvbox-rainbow > ~/.config/starship.toml
```

## Essential Configuration

### Config File Structure

```toml
# ~/.config/starship.toml

# Basic format settings
format = """
[┌───────────────────>](bold green)
[│](bold green)$directory$rust$package
[└─>](bold green) $character
"""

# Add new line after prompt
add_newline = true

# Prompt character
[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
```

### Common Modules

**Git status in prompt**:
```toml
[git_branch]
format = "on [$symbol$branch]($style) "
symbol = "🌱 "
style = "bold purple"

[git_status]
format = "([\\[$all_status$ahead_behind\\]]($style) )"
style = "bold yellow"
```

**Directory module**:
```toml
[directory]
truncation_length = 3
truncate_to_repo = true
format = "[$path]($style)[$read_only]($read_only_style) "
style = "bold cyan"
read_only = " 🔒"
```

**Programming languages**:
```toml
[nodejs]
format = "via [⬢ $version](bold green) "

[python]
format = "via [🐍 $version]($style) "
style = "bold yellow"

[rust]
format = "via [🦀 $version]($style) "
style = "bold red"

[golang]
format = "via [🐹 $version]($style) "
style = "bold cyan"
```

## Prompt Customization

### Custom Presets

**Minimal prompt**:
```toml
format = "$directory$character"
right_format = "$git_status"
add_newline = false
```

**Information-rich prompt**:
```toml
format = """
$time$username$hostname$directory$git_branch$git_status$nodejs$python$rust$character
"""
```

**Two-line prompt**:
```toml
format = """
$directory$git_branch
$character
"""
```

### Colors and Symbols

**Custom symbols**:
```toml
[git_branch]
symbol = "git: "

[directory]
read_only = " ro "

[package]
symbol = "pkg "

[conda]
symbol = "conda "
```

**Custom colors**:
```toml
[directory]
style = "fg:#86BBD8"

[git_branch]
style = "fg:#F9CEC3"

[git_status]
style = "fg:#95E1D3"
```

## Performance Optimization

### Speed Tips

```toml
# Disable slow modules
[git_status]
disabled = true

# Reduce git checks
[git_commit]
commit_hash_length = 4

# Timeout for commands
[cmake]
format = "via [$symbol]($style) "
version_format = "v${raw}"
disabled = true
```

### Conditional Modules

```toml
# Only show when in specific directory
[aws]
format = 'on [$symbol($profile )(\($region\) )]($style)'
symbol = "🅰 "
disabled = true

# Enable per directory with:
# export STARSHIP_CONFIG="$HOME/.config/starship-aws.toml"
```

## Advanced Configuration

### Custom Commands

```toml
[custom.cmd_duration]
command = "echo $((`date +%s` - STARSHIP_START_TIME))s"
when = "true"
format = "took [$output]($style) "
style = "bold yellow"
```

### Environment Variables

```toml
# Use environment symbols
[env_var.SHELL]
format = "using [$env_value]($style) "
style = "bold blue"

[env_var.VIRTUAL_ENV]
format = "venv: [$env_value]($style) "
style = "bold green"
```

## Shell-Specific Setup

### Bash Configuration
```bash
# In ~/.bashrc or ~/.bash_profile
eval "$(starship init bash)"

# Set completion
source <(starship completions bash)
```

### Zsh Configuration
```bash
# In ~/.zshrc
eval "$(starship init zsh)"

# Set completion
autoload -U compinit
compinit -i
source <(starship completions zsh)
```

### Fish Configuration
```bash
# In ~/.config/fish/config.fish
starship init fish | source

# Set completion
starship completions fish | source
```

## Common Workflows

### Development Prompt
```toml
format = """
\$directory$git_branch$git_status
[$character](bold green)
"""

[nodejs]
format = "[⬢ $version](bold green) "

[docker_context]
format = "via [🐋 $context](blue bold) "
```

### Server Admin Prompt
```toml
format = """
$hostname$directory$character
"""

[hostname]
ssh_only = true
format = "on [$hostname]($style) "
style = "bold dimmed"
```

### Minimal Prompt
```toml
format = ">$character"
right_format = "$directory"
add_newline = false
```

## Troubleshooting

### Debug Mode

```bash
# Enable debug logging
export STARSHIP_LOG=trace

# Check configuration
starship explain

# Test config file
starship print-config
```

### Common Issues

**Slow prompt**:
1. Disable git_status module
2. Set `disabled = true` for unused modules
3. Use timeout settings

**Module not showing**:
1. Check if tool is installed
2. Verify directory structure
3. Use `starship explain` for debugging

**Symbols not displaying**:
1. Install Nerd Fonts
2. Change to text symbols
3. Check terminal font settings

## Quick Reference

### Essential Commands
```bash
# View configuration
starship config

# Generate completions
starship completions zsh

# Presets
starship preset nerd-font-symbols

# Print configuration
starship print-config

# Explain current prompt
starship explain
```

### Preset Themes
```bash
# Available presets
starship preset no-nerd-font
starship preset bracketed-segments
starship preset gruvbox-rainbow
starship preset pastel-powerline
starship preset tokyo-night
```

### Common Keywords
- `format` - Prompt format string
- `style` - Module styling
- `symbol` - Module symbol
- `disabled` - Enable/disable modules
- `when` - Module condition
- `ssh_only` - Show only on SSH

## Best Practices

1. **Keep it simple**: Start with minimal configuration
2. **Performance first**: Disable slow modules when not needed
3. **Consistent symbols**: Use same style throughout
4. **Test changes**: Use `starship explain` to verify
5. **Version control**: Keep config in dotfiles repo
