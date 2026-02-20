#!/bin/bash

# Commands Symlink Script
# Usage: ./scripts/symlink-commands.sh [--uninstall]
# Interactive script - asks user where to install commands
# Supports any CLI tool: claude, opencode, codex, gemini, etc.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
COMMANDS_DIR="$SKILL_DIR/commands"

echo "=== Commands Symlink Script ==="
echo ""

if [ ! -d "$COMMANDS_DIR" ]; then
    echo "Error: commands directory not found at $COMMANDS_DIR"
    exit 1
fi

uninstall() {
    echo "Enter the commands directory to uninstall (e.g., ~/.claude/commands, ~/.opencode/commands):"
    read -r TOOL_DIR
    TOOL_DIR="${TOOL_DIR/#\~/$HOME}"

    if [ ! -d "$TOOL_DIR" ]; then
        echo "Directory $TOOL_DIR does not exist"
        exit 1
    fi

    echo "Unlinking commands from $TOOL_DIR..."
    for cmd in "$COMMANDS_DIR"/*.md; do
        if [[ -f "$cmd" ]]; then
            filename=$(basename "$cmd")
            if [[ -L "$TOOL_DIR/$filename" ]]; then
                rm "$TOOL_DIR/$filename"
                echo "  Removed: $filename"
            fi
        fi
    done
    echo "Done!"
}

install() {
    echo "Enter the commands directory (e.g., ~/.claude/commands, ~/.opencode/commands):"
    read -r TOOL_DIR
    TOOL_DIR="${TOOL_DIR/#\~/$HOME}"

    # Create directory if it doesn't exist
    mkdir -p "$TOOL_DIR"

    echo "Symlinking commands to $TOOL_DIR..."
    for cmd in "$COMMANDS_DIR"/*.md; do
        if [[ -f "$cmd" ]]; then
            filename=$(basename "$cmd")
            ln -sf "$cmd" "$TOOL_DIR/$filename"
            echo "  -> $filename"
        fi
    done

    echo ""
    echo "Commands installed! Available commands:"
    ls -1 "$COMMANDS_DIR"/*.md | xargs -I {} basename {} .md | sed 's/^/\//'
}

echo "Choose action:"
echo "  1) Install commands"
echo "  2) Uninstall commands"
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
