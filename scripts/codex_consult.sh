#!/usr/bin/env bash
# codex_consult.sh - Ask Codex CLI for a second opinion (diagnosis only, no fixes)
#
# Usage: codex_consult.sh [-C <dir>] [-i <image>] "<prompt>"
#
# All arguments before the final positional are optional flags.
# The prompt should describe the problem/question for Codex to diagnose.

set -euo pipefail

CODEX="${CODEX_BIN:-codex}"
MODEL="gpt-5.3-codex"
EFFORT="xhigh"

# Defaults
WORK_DIR=""
IMAGES=()

# Parse flags
while [[ $# -gt 1 ]]; do
  case "$1" in
    -C)
      WORK_DIR="$2"
      shift 2
      ;;
    -i)
      IMAGES+=(-i "$2")
      shift 2
      ;;
    *)
      break
      ;;
  esac
done

PROMPT="${1:-}"

if [[ -z "$PROMPT" ]]; then
  echo "Error: No prompt provided." >&2
  echo "Usage: codex_consult.sh [-C <dir>] [-i <image>] \"<prompt>\"" >&2
  exit 1
fi

# Build command
CMD=("$CODEX" exec)
CMD+=(-m "$MODEL")
CMD+=(-c "model_reasoning_effort=\"$EFFORT\"")
CMD+=(-s read-only)

if [[ -n "$WORK_DIR" ]]; then
  CMD+=(-C "$WORK_DIR")
fi

CMD+=("${IMAGES[@]}")
CMD+=("$PROMPT")

# Execute and capture output
exec "${CMD[@]}"
