#!/bin/bash
# shellcheck source=/dev/null
. ../../lib/lib.sh
# Install yazi plugins from package.toml

echo "🚀 Setting up yazi plugins..."

# Check if yazi is available
if ! installed yazi; then
    echo "❌ Yazi not found! Install it first."
    exit 1
fi

# Check if ya (yazi plugin manager) is available
if ! installed ya; then
    echo "❌ 'ya' command not found! Make sure yazi is properly installed."
    exit 1
fi

# Install all plugins from package.toml (new command)
echo "📦 Installing yazi plugins..."
ya pkg install

# Upgrade plugins to versions specified in package.toml
echo "🔄 Upgrading plugins to locked versions..."
ya pkg upgrade

echo "✓ Yazi ready! Run 'yazi' to start."
