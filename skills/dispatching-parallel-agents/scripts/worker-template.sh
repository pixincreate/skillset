#!/bin/bash
# worker-template.sh - Template for agent workers
# Usage: worker-template.sh <task.json>
# Reads task from file, processes, outputs JSON result

set -e

TASK_FILE="${1:-/dev/stdin}"

# Read and validate task
TASK=$(cat "$TASK_FILE")
if ! echo "$TASK" | jq -e . >/dev/null 2>&1; then
  echo '{"error": "Invalid task JSON"}'
  exit 1
fi

# Extract task fields
TASK_ID=$(echo "$TASK" | jq -r '.id // "unknown"')
TITLE=$(echo "$TASK" | jq -r '.title // "Untitled"')
SCOPE=$(echo "$TASK" | jq -r '.scope // "general"')
CONSTRAINTS=$(echo "$TASK" | jq -r '.constraints // [] | join(", ")')

# Worker implementation goes here
# This template provides the structure - customize for specific domains

cat << EOF
{
  "id": "$TASK_ID",
  "status": "completed",
  "title": "$TITLE",
  "scope": "$SCOPE",
  "result": {
    "summary": "Task processed successfully",
    "findings": [],
    "recommendations": []
  },
  "constraints_applied": [$CONSTRAINTS]
}
EOF
