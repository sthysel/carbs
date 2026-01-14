#!/bin/bash
# Setup Spacemacs environment

echo "🔧 Installing Emacs and Spacemacs dependencies..."

# Install Emacs and core tools
REQUIRED_PKGS=(
    "emacs"
    "git"
    "ripgrep"
    "fd"
    "shellcheck"      # Shell layer
    "python-lsp-server" # Python LSP
    "aspell"          # Spell checking
    "aspell-en"       # English dictionary
    "ttf-sourcecodepro-nerd" # Recommended font
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    fi
done

# Clone Spacemacs if not already present
if [ ! -d "$HOME/.emacs.d" ]; then
    echo "📦 Cloning Spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d --depth 1
    echo "✓ Spacemacs cloned"
else
    echo "✓ Spacemacs already exists at ~/.emacs.d"
fi

echo "✓ Spacemacs environment ready"
