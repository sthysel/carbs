#!/bin/bash
# Install neovim and essential dependencies for LazyVim

echo "🔧 Installing neovim dependencies..."

REQUIRED_PKGS=(
    "neovim"
    "git"
    "ripgrep"      # Telescope grep
    "fd"           # Telescope file finder
    "lazygit"      # Git integration
    "nodejs"       # LSP servers
    "npm"          # Mason package manager
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    fi
done

echo "✓ Dependencies ready"
