#!/bin/bash
# Install yazi plugins from package.toml

echo "🚀 Setting up yazi plugins..."

# Install all plugins from package.toml (new command)
echo "📦 Installing yazi plugins..."
ya pkg install

# Upgrade plugins to versions specified in package.toml
echo "🔄 Upgrading plugins to locked versions..."
ya pkg upgrade

echo "✓ Yazi ready! Run 'yazi' to start."
