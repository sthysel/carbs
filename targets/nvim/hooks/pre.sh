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
