#!/bin/bash
# dispatch.sh - Dispatch parallel agent tasks
# Usage: dispatch.sh [--concurrency=N] [--timeout=S] < tasks.ndjson
#        cat tasks.ndjson | dispatch.sh --concurrency=4

set -e

CONCURRENCY=${CONCURRENCY:-4}
TIMEOUT=${TIMEOUT:-300}
WORKER_SCRIPT="${0%/*}/worker-template.sh"

# Parse args
while [[ $# -gt 0 ]]; do
  case $1 in
    --concurrency=*)
      CONCURRENCY="${1#*=}"
      shift
      ;;
    --timeout=*)
      TIMEOUT="${1#*=}"
      shift
      ;;
    --worker=*)
      WORKER_SCRIPT="${1#*=}"
      shift
      ;;
    *)
      echo "[error] Unknown option: $1. Usage: dispatch.sh [--concurrency=N] [--timeout=S]" >&2
      exit 1
      ;;
  esac
done

# Check for stdin or file
if [ -t 0 ]; then
  echo "[error] No input provided. Usage: cat tasks.ndjson | dispatch.sh --concurrency=4" >&2
  exit 1
fi

# Create temp directory for results
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# Read tasks from stdin
TASK_COUNT=0
while IFS= read -r line; do
  # Skip empty lines
  [ -z "$line" ] && continue
  
  # Validate JSON
  if ! echo "$line" | jq -e . >/dev/null 2>&1; then
    echo "[error] Invalid JSON: $line" >&2
    continue
  fi
  
  TASK_COUNT=$((TASK_COUNT + 1))
  echo "$line" > "$TMPDIR/task_$TASK_COUNT.json"
done

if [ "$TASK_COUNT" -eq 0 ]; then
  echo '{"error": "No valid tasks provided"}'
  exit 1
fi

echo "[info] Dispatching $TASK_COUNT tasks with concurrency $CONCURRENCY (timeout: ${TIMEOUT}s)" >&2

# Process tasks with parallel execution
run_task() {
  local task_file=$1
  local task_id=$2
  local task=$(cat "$task_file")
  local id=$(echo "$task" | jq -r '.id // "task_'$task_id'"')
  local scope=$(echo "$task" | jq -r '.scope // "general"')
  
  local start_time=$(date +%s%N)
  
  # Run worker with timeout
  local result
  if timeout "$TIMEOUT" "$WORKER_SCRIPT" "$task_file" > "$TMPDIR/result_$task_id.json" 2>&1; then
    local exit_code=0
  else
    local exit_code=$?
  fi
  
  local end_time=$(date +%s%N)
  local duration=$(( (end_time - start_time) / 1000000 )) # Convert to ms
  
  # Enhance result with metadata
  if [ -f "$TMPDIR/result_$task_id.json" ]; then
    cat "$TMPDIR/result_$task_id.json" | jq --arg id "$id" \
      --arg scope "$scope" \
      --argjson exit_code $exit_code \
      --argjson duration $duration \
      '. + {
        "id": $id,
        "scope": $scope,
        "exit_code": $exit_code,
        "duration_ms": $duration
      }'
  else
    echo "{\"id\": \"$id\", \"scope\": \"$scope\", \"exit_code\": $exit_code, \"duration_ms\": $duration, \"error\": \"Worker failed to produce output\"}"
  fi
}

export -f run_task
export WORKER_SCRIPT TMPDIR TIMEOUT

# Run tasks in parallel using background jobs
for i in $(seq 1 $TASK_COUNT); do
  # Wait if at concurrency limit
  while [ $(jobs -r | wc -l) -ge $CONCURRENCY ]; do
    sleep 0.1
  done
  
  run_task "$TMPDIR/task_$i.json" $i > "$TMPDIR/result_$i.json" &
done

# Wait for all jobs
wait

# Output results as NDJSON
for i in $(seq 1 $TASK_COUNT); do
  cat "$TMPDIR/result_$i.json"
done

# Output summary to stderr
SUCCESS_COUNT=$(cat "$TMPDIR"/result_*.json | jq -s '[.[] | select(.exit_code == 0)] | length')
FAIL_COUNT=$((TASK_COUNT - SUCCESS_COUNT))
TOTAL_DURATION=$(cat "$TMPDIR"/result_*.json | jq -s '[.[].duration_ms] | add')

echo "[exit:0 | ${TOTAL_DURATION}ms] Summary: $SUCCESS_COUNT success, $FAIL_COUNT failed" >&2
