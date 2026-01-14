#!/bin/bash
# Install asciinema and asciinema-agg

echo "🔧 Installing asciinema and asciinema-agg..."

# Install asciinema and related tools
REQUIRED_PKGS=(
    "asciinema"
    "asciinema-agg"  # GIF generator for asciinema recordings
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! yay -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        yay -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    fi
done

echo "✓ asciinema setup complete"
