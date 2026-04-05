#!/bin/bash
# Claude Code Pre-Tool Hook: Prevent creating components with similar names to existing ones
# Runs BEFORE Write tool to catch duplicate component creation

set -euo pipefail

# Check for jq
if ! command -v jq &>/dev/null; then
  echo "WARNING: jq is not installed. Skipping duplicate component check." >&2
  exit 0
fi

# Read tool input from stdin
INPUT=$(cat)

# Only trigger on Write tool (new file creation)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
if [ "$TOOL_NAME" != "Write" ]; then
  exit 0
fi

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only check component files
case "$FILE_PATH" in
  *.tsx|*.jsx|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

# Only check if file is in a component-like directory
case "$FILE_PATH" in
  */components/*|*/Components/*|*/component/*|*/ui/*|*/UI/*) ;;
  *) exit 0 ;;
esac

# Skip if the file already exists (this would be an overwrite, not a new component)
if [ -f "$FILE_PATH" ]; then
  exit 0
fi

# Extract the new component's base name
NEW_FILENAME=$(basename "$FILE_PATH")
# Remove extension
NEW_NAME="${NEW_FILENAME%.*}"
# Remove common prefixes/suffixes to get the "base" component name
strip_affixes() {
  local name="$1"
  # Convert to lowercase for comparison
  local lower=$(echo "$name" | tr '[:upper:]' '[:lower:]')
  # Remove common prefixes (case-insensitive via lowercase)
  lower=$(echo "$lower" | sed -E 's/^(custom|primary|secondary|base|default|new|my|app|main|core|shared|common|styled|enhanced|basic|simple|abstract|generic)//')
  # Remove common suffixes
  lower=$(echo "$lower" | sed -E 's/(wrapper|container|component|view|screen|page|section|item|list|card|modal|dialog|form|input|button|icon|layout|panel|widget|base|default|custom|primary|new|enhanced|styled|v2|v3)$//')
  # Remove index
  if [ "$lower" = "index" ]; then
    lower=""
  fi
  echo "$lower"
}

NEW_BASE=$(strip_affixes "$NEW_NAME")

# If base name is empty after stripping, use the original lowercase name
if [ -z "$NEW_BASE" ]; then
  NEW_BASE=$(echo "$NEW_NAME" | tr '[:upper:]' '[:lower:]')
fi

# Find the project root (look for package.json, going up from the file's directory)
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

# Fallback: use 3 levels up from file
if [ -z "$PROJECT_ROOT" ]; then
  PROJECT_ROOT=$(dirname "$(dirname "$(dirname "$FILE_PATH")")")
fi

# Search for existing component files in common component directories
COMPONENT_DIRS=("src/components" "components" "app/components" "src/ui" "lib/components" "packages" "src/common" "src/shared")
MATCHES=""

for comp_dir in "${COMPONENT_DIRS[@]}"; do
  SEARCH_DIR="$PROJECT_ROOT/$comp_dir"
  if [ ! -d "$SEARCH_DIR" ]; then
    continue
  fi

  # Find component files
  while IFS= read -r existing_file; do
    [ -z "$existing_file" ] && continue

    EXISTING_FILENAME=$(basename "$existing_file")
    EXISTING_NAME="${EXISTING_FILENAME%.*}"

    # Skip index files
    if [ "$EXISTING_NAME" = "index" ]; then
      continue
    fi

    EXISTING_BASE=$(strip_affixes "$EXISTING_NAME")
    if [ -z "$EXISTING_BASE" ]; then
      EXISTING_BASE=$(echo "$EXISTING_NAME" | tr '[:upper:]' '[:lower:]')
    fi

    # Compare base names
    if [ "$NEW_BASE" = "$EXISTING_BASE" ]; then
      # Don't match against itself
      if [ "$existing_file" != "$FILE_PATH" ]; then
        MATCHES="${MATCHES}  - ${existing_file}\n"
      fi
    fi
  done < <(find "$SEARCH_DIR" -type f \( -name "*.tsx" -o -name "*.jsx" -o -name "*.vue" -o -name "*.svelte" \) 2>/dev/null)
done

if [ -n "$MATCHES" ]; then
  cat >&2 <<ERRMSG
⚠️ 비슷한 이름의 컴포넌트가 이미 존재합니다.

새 파일: ${FILE_PATH}
기존 파일:
$(printf '%b' "$MATCHES")
기존 컴포넌트를 수정하는 것이 좋겠습니까?
ERRMSG
  exit 1
fi

exit 0
