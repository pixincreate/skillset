#!/bin/bash

# Skills Installation Script
# Usage: ./scripts/symlink.sh [--uninstall]
# Interactive script - asks user where to install skills
# Supports any CLI tool: claude, opencode, codex, gemini, etc.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_DIR/skills"

echo "=== Skills Installation Script ==="
echo ""
echo "This script symlinks your skills to CLI tools."
echo ""

if [ ! -f "$SKILLS_DIR/AGENTS.md" ]; then
    echo "Error: AGENTS.md not found in skills directory"
    echo "Please ensure you're in the skills repository"
    exit 1
fi

uninstall() {
    echo "Enter the installation path to uninstall (e.g., ~/.claude/skills, ~/.opencode/skills):"
    read -r INSTALL_PATH
    INSTALL_PATH="${INSTALL_PATH/#\~/$HOME}"

    if [ ! -L "$INSTALL_PATH" ]; then
        echo "No symlink found at $INSTALL_PATH"
        exit 0
    fi

    rm "$INSTALL_PATH"
    echo "Removed symlink: $INSTALL_PATH"

    # Restore backup if exists
    PARENT_DIR="$(dirname "$INSTALL_PATH")"
    BACKUP=$(ls -t "$PARENT_DIR"/skills.backup.* 2>/dev/null | head -1)
    if [ -n "$BACKUP" ]; then
        mv "$BACKUP" "$INSTALL_PATH"
        echo "Restored backup: $(basename "$BACKUP")"
    fi

    echo "Uninstall complete."
}

install() {
    echo "Enter installation path for skills (e.g., ~/.claude/skills, ~/.opencode/skills):"
    read -r INSTALL_PATH
    INSTALL_PATH="${INSTALL_PATH/#\~/$HOME}"

    # Create parent directory
    mkdir -p "$(dirname "$INSTALL_PATH")"

    # Backup existing skills
    if [ -d "$INSTALL_PATH" ] && [ ! -L "$INSTALL_PATH" ]; then
        BACKUP_DIR="$(dirname "$INSTALL_PATH")/skills.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$INSTALL_PATH" "$BACKUP_DIR"
        echo "Backed up existing skills to: $BACKUP_DIR"
    fi

    # Remove existing symlink
    [ -L "$INSTALL_PATH" ] && rm "$INSTALL_PATH"

    # Create symlink to skills directory
    ln -s "$SKILLS_DIR" "$INSTALL_PATH"

    echo ""
    echo "Installed skills at: $INSTALL_PATH"
    echo "Run 'ls $INSTALL_PATH' to see available skills"
}

echo "Choose action:"
echo "  1) Install skills"
echo "  2) Uninstall skills"
echo ""
read -r choice

case "$choice" in
    1)
        install
        ;;
    2)
        uninstall
        ;;
    *)
        echo "Invalid choice. Running install..."
        install
        ;;
esac
