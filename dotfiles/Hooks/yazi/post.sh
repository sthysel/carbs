#!/bin/bash
# Install yazi plugins from package.toml

echo "🚀 Setting up yazi plugins..."

# Check if yazi is available
if ! command -v yazi &> /dev/null; then
    echo "❌ Yazi not found! Install it first."
    exit 1
fi

# Check if ya (yazi plugin manager) is available
if ! command -v ya &> /dev/null; then
    echo "❌ 'ya' command not found! Make sure yazi is properly installed."
    exit 1
fi

# Install all plugins from package.toml
echo "📦 Installing yazi plugins..."
ya pack -i

# Upgrade plugins to versions specified in package.toml
echo "🔄 Upgrading plugins to locked versions..."
ya pack -u

echo "✓ Yazi ready! Run 'yazi' to start."
