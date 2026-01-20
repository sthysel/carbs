#!/bin/bash
# Bootstrap lazy.nvim and install all plugins from lazy-lock.json

echo "🚀 Bootstrapping LazyVim..."

# Install all plugins from lazy-lock.json (respects pinned versions)
echo "📦 Installing plugins..."
nvim --headless "+Lazy! restore" +qa

echo "✓ LazyVim ready! Run 'nvim' to start."
