#!/bin/bash
# Bootstrap Spacemacs and install all packages

echo "🚀 Bootstrapping Spacemacs..."

# Check if emacs is available
if ! command -v emacs &> /dev/null; then
    echo "❌ Emacs not found! Install it first."
    exit 1
fi

# Check if Spacemacs is installed
if [ ! -d "$HOME/.emacs.d" ]; then
    echo "❌ Spacemacs not found at ~/.emacs.d! Run pre-hook first."
    exit 1
fi

echo "📦 Installing Spacemacs packages..."
echo "   This will bootstrap Spacemacs and install all layers..."
echo ""

# Method 1: Let Spacemacs bootstrap on first run (daemon mode)
# This is more reliable than batch mode
echo "🔄 Starting Emacs daemon for package installation..."

# Kill any existing daemon
emacs --batch --eval "(kill-emacs)" 2>/dev/null || true

# Start daemon which will trigger package installation
timeout 300 emacs --daemon 2>&1 | tee /tmp/spacemacs-install.log &
EMACS_PID=$!

echo "   Waiting for package installation to complete..."
echo "   (This can take 2-5 minutes on first run)"

# Wait for daemon to finish
wait $EMACS_PID
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "✓ Spacemacs daemon started and packages installed"

    # Stop the daemon
    emacsclient -e "(kill-emacs)" 2>/dev/null || true

    echo "✓ Setup complete! You can now run 'emacs' to start Spacemacs"
    echo ""
    echo "💡 Quick start:"
    echo "   SPC f e d - Edit config"
    echo "   SPC h SPC - Search help"
    echo "   SPC ?     - Discover commands"
    echo "   SPC q q   - Quit"
else
    echo ""
    echo "⚠️  Installation may need completion. Log: /tmp/spacemacs-install.log"
    echo "   Run 'emacs' once to complete setup manually"

    # Clean up daemon if it's still running
    emacsclient -e "(kill-emacs)" 2>/dev/null || true
fi
