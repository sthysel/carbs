#!/bin/bash
echo "🚀 Bootstrapping Spacemacs..."


echo "📦 Installing Spacemacs packages..."

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
