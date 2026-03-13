#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: ./setup.sh <name> [github-owner] [description]"
  echo ""
  echo "Example: ./setup.sh mcp-server-github vaporif \"MCP server for GitHub\""
  exit 1
fi

NAME="$1"
OWNER="${2:-REPLACE_ME_GITHUB_OWNER}"
DESC="${3:-$NAME}"

# Rust crate names use underscores
CRATE_NAME="${NAME//-/_}"

FILES=(
  Cargo.toml
  pyproject.toml
  flake.nix
  smithery.yaml
  src/main.rs
  src/server.rs
  src/config.rs
  .github/workflows/release.yaml
  Dockerfile
)

# macOS sed requires -i '', GNU sed requires -i
if sed --version 2>/dev/null | grep -q GNU; then
  SED_INPLACE=(sed -i)
else
  SED_INPLACE=(sed -i '')
fi

for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    "${SED_INPLACE[@]}" \
      -e "s|REPLACE_ME_DESCRIPTION|${DESC}|g" \
      -e "s|REPLACE_ME_GITHUB_OWNER|${OWNER}|g" \
      -e "s|REPLACE_ME|${NAME}|g" \
      "$f"
  fi
done

# Fix Rust crate import (underscores)
find src -name '*.rs' -exec "${SED_INPLACE[@]}" "s|use ${NAME}::|use ${CRATE_NAME}::|g" {} +

# Remove template workaround
"${SED_INPLACE[@]}" '/REMOVE_AFTER_SETUP/d' src/lib.rs

echo "Renamed to: ${NAME}"
echo "Crate import: ${CRATE_NAME}"
echo ""
echo "Next steps:"
echo "  cargo build"
echo "  rm setup.sh"
