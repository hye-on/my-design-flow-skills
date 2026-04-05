#!/bin/bash
# Claude Code Pre-Tool Hook: Block hardcoded colors, px values, font-family in UI files
# Runs BEFORE Edit/Write tools to enforce design token usage

set -euo pipefail

# Check for jq
if ! command -v jq &>/dev/null; then
  echo "WARNING: jq is not installed. Skipping hardcoded value check." >&2
  exit 0
fi

# Read tool input from stdin
INPUT=$(cat)

# Extract tool_name, file_path, and content
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Extract content: for Write tool it's .content, for Edit tool it's .new_string
if [ "$TOOL_NAME" = "Write" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty')
elif [ "$TOOL_NAME" = "Edit" ]; then
  CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty')
else
  exit 0
fi

# Exit if no file path or content
if [ -z "$FILE_PATH" ] || [ -z "$CONTENT" ]; then
  exit 0
fi

# Only check UI files
case "$FILE_PATH" in
  *.tsx|*.jsx|*.css|*.scss|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

# Skip config files
BASENAME=$(basename "$FILE_PATH")
case "$BASENAME" in
  tailwind.config.*|design-system.md|theme.*|*.config.*) exit 0 ;;
esac

DETECTED=""
LINE_NUM=0

# Process content line by line
while IFS= read -r line; do
  LINE_NUM=$((LINE_NUM + 1))

  # Skip comment lines (// or /* or * or <!-- )
  TRIMMED=$(echo "$line" | sed 's/^[[:space:]]*//')
  case "$TRIMMED" in
    //*|"/*"*|\**|"<!--"*) continue ;;
  esac

  # Check for hex colors: #xxx, #xxxx, #xxxxxx, #xxxxxxxx
  HEX_MATCHES=$(echo "$line" | grep -oE '#[0-9a-fA-F]{3,8}\b' 2>/dev/null || true)
  if [ -n "$HEX_MATCHES" ]; then
    while IFS= read -r match; do
      # Validate it's actually a hex color (3, 4, 6, or 8 hex digits)
      HEX_LEN=${#match}
      if [ "$HEX_LEN" -eq 4 ] || [ "$HEX_LEN" -eq 5 ] || [ "$HEX_LEN" -eq 7 ] || [ "$HEX_LEN" -eq 9 ]; then
        DETECTED="${DETECTED}  Line ${LINE_NUM}: ${match} (hex color)\n"
      fi
    done <<< "$HEX_MATCHES"
  fi

  # Check for raw px values (number followed by px)
  PX_MATCHES=$(echo "$line" | grep -oE '[0-9]+px' 2>/dev/null || true)
  if [ -n "$PX_MATCHES" ]; then
    while IFS= read -r match; do
      DETECTED="${DETECTED}  Line ${LINE_NUM}: ${match} (raw pixel value)\n"
    done <<< "$PX_MATCHES"
  fi

  # Check for font-family declarations
  if echo "$line" | grep -qiE 'font-family\s*:' 2>/dev/null; then
    DETECTED="${DETECTED}  Line ${LINE_NUM}: font-family declaration\n"
  fi
  # Also check fontFamily in JS/TS objects
  if echo "$line" | grep -qE 'fontFamily\s*[:=]' 2>/dev/null; then
    DETECTED="${DETECTED}  Line ${LINE_NUM}: fontFamily declaration\n"
  fi

done <<< "$CONTENT"

if [ -n "$DETECTED" ]; then
  cat >&2 <<ERRMSG
⚠️ 하드코딩된 값이 감지되었습니다. design-system.md의 토큰을 사용하세요.

감지된 값:
$(printf '%b' "$DETECTED")
제안:
  - Hex colors -> CSS 변수 (예: var(--color-primary)) 또는 Tailwind 클래스 (예: text-primary) 사용
  - Raw px values -> 디자인 토큰 spacing/sizing 변수 사용 (예: var(--spacing-4), gap-4)
  - font-family -> CSS 변수 (예: var(--font-sans)) 또는 Tailwind 클래스 (예: font-sans) 사용

파일: ${FILE_PATH}
ERRMSG
  exit 1
fi

exit 0
