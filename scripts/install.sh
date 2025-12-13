#!/bin/bash

# Claude Skills Collection Installation Script
# Usage: ./scripts/install.sh
# Creates symlink from current directory to ~/.claude/skills

set -e  # Exit on any error

echo "🚀 Installing Claude Skills Collection..."
echo

# Get the absolute path of the current directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

# Check if we're in the right directory
if [ ! -f "$REPO_DIR/README.md" ] || [ ! -f "$REPO_DIR/plugin.json" ]; then
    echo "❌ Error: Not in the Claude Skills Collection root directory!"
    echo "   Please run this script from the repository root: ./scripts/install.sh"
    exit 1
fi

# Backup existing skills if present
if [ -d "$CLAUDE_DIR/skills" ]; then
    echo "📦 Backing up existing skills..."
    BACKUP_DIR="$CLAUDE_DIR/skills.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$CLAUDE_DIR/skills" "$BACKUP_DIR"
    echo "   Backup saved to: $BACKUP_DIR"
fi

# Create .claude directory if it doesn't exist
echo "📁 Creating Claude directory..."
mkdir -p "$CLAUDE_DIR"

# Remove existing symlink if exists
if [ -L "$CLAUDE_DIR/skills" ]; then
    echo "🔗 Removing existing symlink..."
    rm "$CLAUDE_DIR/skills"
fi

# Create symlink from current directory to ~/.claude/skills
echo "🔗 Creating symlink to repository..."
ln -s "$REPO_DIR" "$CLAUDE_DIR/skills"

# Verify installation
echo
echo "✅ Installation complete!"
echo
echo "📍 Skills location: $CLAUDE_DIR/skills"
echo "📂 Repository: $REPO_DIR"
echo
echo "📋 Installed skills:"
ls "$REPO_DIR/skills" | grep -v "^_" | while read -r skill; do
    if [ -d "$REPO_DIR/skills/$skill" ]; then
        echo "   - $skill"
    fi
done
echo
echo "📌 Commands available:"
echo "   - /pr-review - Complete PR review workflow"
echo "   - /list-skills - Show all available skills"
echo "   - /skill-info - Get details about a skill"
echo
echo "🔄 To update: cd $REPO_DIR && git pull"
echo
echo "⚠️  IMPORTANT: Restart Claude Code to load the new skills!"
echo
echo "🎯 The skills will activate automatically based on what you ask."
echo "   Example: 'Help me debug this' → activates debugging skill"
echo "   Example: 'Configure starship' → activates starship skill"