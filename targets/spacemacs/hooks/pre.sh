#!/bin/sh
# Setup Spacemacs environment

echo "🔧 Installing Emacs and Spacemacs dependencies..."

yay_install \
    emacs \
    git \
    ripgrep \
    fd \
    shellcheck \
    python-lsp-server \
    spell \
    aspell-en \
    ttf-sourcecodepro-nerd \
    wl-clipboard

# Clone Spacemacs if not already present
if [ ! -d "$HOME/.emacs.d" ]; then
    echo "📦 Cloning Spacemacs..."
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d --depth 1
    echo "✓ Spacemacs cloned"
else
    echo "✓ Spacemacs already exists at ~/.emacs.d"
fi

echo "✓ Spacemacs environment ready"
