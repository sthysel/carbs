#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/sthysel/carbs.git"
INSTALL_DIR="${HOME}/.config/dotfiles"

echo "Installing CARBS dotfiles to ${INSTALL_DIR}"

# Check for git
if ! command -v git &>/dev/null; then
    echo "Error: git is not installed"
    exit 1
fi

# Create ~/.config if needed
mkdir -p "${HOME}/.config"

# Check if directory already exists
if [[ -d "${INSTALL_DIR}" ]]; then
    echo "Error: ${INSTALL_DIR} already exists"
    echo "Remove it first or pull updates manually"
    exit 1
fi

# Clone the repo
git clone "${REPO_URL}" "${INSTALL_DIR}"

echo "Done! Next steps:"
echo "  cd ${INSTALL_DIR}"
echo "  just bootstrap"
