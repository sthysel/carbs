#!/bin/bash
# Bootstrap lazy.nvim and install all plugins from lazy-lock.json

echo "🚀 Bootstrapping LazyVim..."

# Check if nvim is available
if ! command -v nvim &> /dev/null; then
    echo "❌ Neovim not found! Install it first."
    exit 1
fi

# Install all plugins from lazy-lock.json (respects pinned versions)
echo "📦 Installing plugins..."
nvim --headless "+Lazy! restore" +qa

echo "✓ LazyVim ready! Run 'nvim' to start."
