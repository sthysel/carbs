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

# Install yay if not available
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmp_dir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "${tmp_dir}/yay"
    (cd "${tmp_dir}/yay" && makepkg -si --noconfirm)
    rm -rf "${tmp_dir}"
fi

# Install tuckr if not available
if ! command -v tuckr &>/dev/null; then
    echo "Installing tuckr..."
    yay -S --noconfirm tuckr
fi

# Bootstrap dotfiles
cd "${INSTALL_DIR}"
tuckr set bootstrap

echo "Done! Next steps:"
echo "  cd ${INSTALL_DIR}"
echo "  just bootstrap"
