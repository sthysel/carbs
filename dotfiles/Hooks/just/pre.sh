#!/bin/bash
# Install just command runner via uv if not present

echo "🔧 Checking for just..."

if ! command -v just &> /dev/null; then
    echo "  just not found, installing via uv..."

    # Ensure uv is installed
    if ! command -v uv &> /dev/null; then
        echo "  ⚠️  uv not found. Installing uv first..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        # Source the env to get uv in PATH
        export PATH="$HOME/.local/bin:$PATH"
    fi

    # Install just using uv tool install
    uv tool install just || echo "  ⚠️  Failed to install just via uv"
else
    echo "  ✓ just already installed"
fi

echo "✓ just ready"
