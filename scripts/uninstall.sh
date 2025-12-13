#!/bin/bash

# Claude Skills Collection Uninstallation Script
# Usage: ./scripts/uninstall.sh

set -e  # Exit on any error

echo "🗑️  Uninstalling Claude Skills Collection..."
echo

CLAUDE_DIR="$HOME/.claude"
SKILLS_LINK="$CLAUDE_DIR/skills"

# Check if skills link exists
if [ ! -L "$SKILLS_LINK" ]; then
    echo "ℹ️  No Claude Skills symlink found at $SKILLS_LINK"
    echo "   Nothing to uninstall."
    exit 0
fi

# Get the actual path from symlink
ACTUAL_PATH=$(readlink "$SKILLS_LINK")
echo "🔗 Removing symlink: $SKILLS_LINK"
echo "   Points to: $ACTUAL_PATH"

# Remove the symlink
rm "$SKILLS_LINK"

# Check if there's a backup to restore
BACKUP_DIR=$(ls -t "$CLAUDE_DIR/skills.backup."* 2>/dev/null | head -1)
if [ -n "$BACKUP_DIR" ]; then
    echo
    echo "📦 Found backup: $(basename "$BACKUP_DIR")"
    echo "💾 Restoring backup..."
    mv "$BACKUP_DIR" "$SKILLS_LINK"
    echo "✅ Backup restored"
else
    echo
    echo "ℹ️  No backup found to restore"
fi

echo
echo "✅ Uninstallation complete!"
echo
echo "⚠️  IMPORTANT: Restart Claude Code to remove the skills from memory"