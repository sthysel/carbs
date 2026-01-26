#!/bin/bash
# Install neovim and essential dependencies for LazyVim

echo "🔧 Installing neovim dependencies..."

yay_install \
    neovim \
    git \
    ripgrep \
    fd \
    lazygit \
    nodejs \
    npm

# Lua development
yay_install lua-language-server

# Rust development (rust-analyzer comes with rustup)
if command -v rustup &>/dev/null; then
    echo "📦 Installing rust-analyzer via rustup..."
    rustup component add rust-analyzer
else
    echo "⚠️  rustup not found, install Rust toolchain for rust-analyzer"
fi

# Python tools via uv
if command -v uv &>/dev/null; then
    echo "📦 Installing Python tools via uv..."
    uv tool install ruff
    uv tool install basedpyright
else
    echo "⚠️  uv not found, skipping Python tools"
fi

# Backup existing lazy-lock.json to preserve local plugin versions
NVIM_CONFIG="$HOME/.config/nvim"
LOCK_FILE="$NVIM_CONFIG/lazy-lock.json"
LOCK_BACKUP="/tmp/lazy-lock.json.backup.$$"

if [ -f "$LOCK_FILE" ]; then
    echo "📦 Backing up existing lazy-lock.json..."
    cp "$LOCK_FILE" "$LOCK_BACKUP"
    # Store backup path for post.sh
    echo "$LOCK_BACKUP" > /tmp/lazy-lock-backup-path.$$
    echo "✓ Plugin versions backed up"
fi

echo "✓ Dependencies ready"
