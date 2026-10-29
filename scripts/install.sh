#!/usr/bin/env bash
# ==============================================================================
# Script: install.sh
# Purpose: Installs g14-game-boost into user ~/.local/bin/
# Author: Patrick Isles
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(dirname "$0")"
BIN_SRC="${SCRIPT_DIR}/../bin/g14-game-boost"
BIN_DEST="${HOME}/.local/bin/g14-game-boost"

mkdir -p "${HOME}/.local/bin"
install -m 755 "$BIN_SRC" "$BIN_DEST"

echo "==> g14-game-boost successfully installed to ${BIN_DEST}"
echo "    Verify with: g14-game-boost status"
