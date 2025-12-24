#!/bin/bash
# Install git-delta for better diffs

echo "🔧 Installing git-delta..."

REQUIRED_PKGS=(
    "git-delta"
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    fi
done

echo "✓ git-delta ready"
