#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FILES_DIR="$SCRIPT_DIR/files"

echo "Installing nvidia drivers..."
yay_install nvidia

HOOKS_DIR="/etc/pacman.d/hooks"
HOOK_FILE="$HOOKS_DIR/nvidia.hook"

if [ -f "$HOOK_FILE" ]; then
    echo "Nvidia pacman hook already exists, skipping..."
else
    echo "Installing nvidia pacman hook..."
    sudo mkdir -p "$HOOKS_DIR"
    sudo cp "$FILES_DIR/nvidia.hook" "$HOOK_FILE"
fi
