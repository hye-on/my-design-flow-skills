#!/bin/bash
# Claude Code Post-Tool Hook: Flag knowledge-base files needing updates after UI edits
# Runs AFTER Edit/Write tools to maintain design documentation sync

# Post-hooks should never block, so we don't use set -e
set +e

# Check for jq
if ! command -v jq &>/dev/null; then
  echo "WARNING: jq is not installed. Skipping design sync check." >&2
  exit 0
fi

# Read tool input from stdin
INPUT=$(cat)

# Extract file_path from tool input
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ] || [ -z "$TOOL_NAME" ]; then
  exit 0
fi

# Only process UI files
case "$FILE_PATH" in
  *.tsx|*.jsx|*.vue|*.svelte|*.css|*.scss) ;;
  *) exit 0 ;;
esac

# Find the project root
DIR=$(dirname "$FILE_PATH")
PROJECT_ROOT=""
CHECK_DIR="$DIR"
while [ "$CHECK_DIR" != "/" ]; do
  if [ -f "$CHECK_DIR/package.json" ] || [ -f "$CHECK_DIR/pnpm-workspace.yaml" ] || [ -d "$CHECK_DIR/.git" ]; then
    PROJECT_ROOT="$CHECK_DIR"
    break
  fi
  CHECK_DIR=$(dirname "$CHECK_DIR")
done

if [ -z "$PROJECT_ROOT" ]; then
  PROJECT_ROOT=$(dirname "$(dirname "$(dirname "$FILE_PATH")")")
fi

KB_DIR="$PROJECT_ROOT/docs/knowledge-base"

# If knowledge-base directory doesn't exist, skip silently
if [ ! -d "$KB_DIR" ]; then
  exit 0
fi

TODAY=$(date +%Y-%m-%d)
FILENAME=$(basename "$FILE_PATH")
REL_PATH="${FILE_PATH#$PROJECT_ROOT/}"

# Determine what type of change this is and which KB files need updating
FILES_TO_FLAG=""
DESCRIPTION=""

# Check if this is a new component file (Write tool to components directory)
if [ "$TOOL_NAME" = "Write" ]; then
  case "$FILE_PATH" in
    */components/*|*/Components/*|*/component/*|*/ui/*|*/UI/*)
      DESCRIPTION="New component added: ${REL_PATH}"
      FILES_TO_FLAG="component-graph.md"
      # Append sync flag to component-graph.md if it exists
      if [ -f "$KB_DIR/component-graph.md" ]; then
        echo "<!-- SYNC_NEEDED: ${REL_PATH} added ${TODAY} -->" >> "$KB_DIR/component-graph.md"
      fi
      ;;
  esac
fi

# Check if this is a page/screen file
case "$FILE_PATH" in
  */pages/*|*/Pages/*|*/views/*|*/Views/*|*/routes/*|*/app/*)
    # Narrow down app/ to actual page files (not components within app)
    case "$FILE_PATH" in
      */app/components/*|*/app/ui/*) ;;
      */pages/*|*/Pages/*|*/views/*|*/Views/*|*/routes/*|*/app/*)
        if [ -z "$DESCRIPTION" ]; then
          DESCRIPTION="Page/screen modified: ${REL_PATH}"
        fi
        FILES_TO_FLAG="${FILES_TO_FLAG:+$FILES_TO_FLAG, }screen-inventory.md"
        if [ -f "$KB_DIR/screen-inventory.md" ]; then
          echo "<!-- SYNC_NEEDED: ${REL_PATH} modified ${TODAY} -->" >> "$KB_DIR/screen-inventory.md"
        fi
        ;;
    esac
    ;;
esac

# Check if this is a token/style/theme change
BASENAME=$(basename "$FILE_PATH")
case "$BASENAME" in
  tailwind.config.*|theme.*|*.config.*|globals.css|global.css|variables.css|variables.scss|tokens.*)
    if [ -z "$DESCRIPTION" ]; then
      DESCRIPTION="Token/style modified: ${REL_PATH}"
    fi
    FILES_TO_FLAG="${FILES_TO_FLAG:+$FILES_TO_FLAG, }visual-language.md"
    if [ -f "$KB_DIR/visual-language.md" ]; then
      echo "<!-- SYNC_NEEDED: ${REL_PATH} modified ${TODAY} -->" >> "$KB_DIR/visual-language.md"
    fi
    ;;
esac

# If no specific category matched but it's a UI file edit, still log it
if [ -z "$DESCRIPTION" ]; then
  DESCRIPTION="UI file modified: ${REL_PATH}"
fi

if [ -z "$FILES_TO_FLAG" ]; then
  FILES_TO_FLAG="(none specific)"
fi

# Append to sync log
SYNC_LOG="$KB_DIR/_sync-log.md"
if [ -f "$SYNC_LOG" ]; then
  echo "| ${TODAY} | ${DESCRIPTION} | ${FILES_TO_FLAG} |" >> "$SYNC_LOG"
elif [ -d "$KB_DIR" ]; then
  # Create the sync log with header if KB dir exists but log doesn't
  cat > "$SYNC_LOG" <<HEADER
# Design Sync Log

| Date | Description | Files Needing Update |
|------|-------------|---------------------|
| ${TODAY} | ${DESCRIPTION} | ${FILES_TO_FLAG} |
HEADER
fi

exit 0
