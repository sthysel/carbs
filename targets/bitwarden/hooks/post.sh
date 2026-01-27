#!/bin/bash
# Setup bw-ssh-sync

chmod +x "$HOME/.local/bin/bw-ssh-sync"
chmod +x "$HOME/.local/bin/bw-ssh-add"
chmod +x "$HOME/.local/bin/bw-session"

# Configure EU server by default
BW_SERVER="${BW_SERVER:-https://vault.bitwarden.eu}"
echo "Configuring Bitwarden server: $BW_SERVER"
bw config server "$BW_SERVER"

echo ""
echo "Bitwarden SSH tools installed."
echo ""
echo "Commands:"
echo "  eval \$(bw-session)        # Unlock and cache session"
echo "  bw-ssh-add <key> <name>   # Add key to Bitwarden"
echo "  bw-ssh-sync               # Sync keys to ~/.ssh/"
echo "  bw-ssh-sync --list        # List available keys"
echo ""
echo "First time setup:"
echo "  bw login"
echo ""
echo "Example:"
echo "  bw-ssh-add ~/.ssh/id_github 'GitHub Personal'"
echo "  bw-ssh-sync"
