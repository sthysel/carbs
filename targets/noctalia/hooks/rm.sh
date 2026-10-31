#!/bin/sh

echo "Disabling noctalia service..."
systemctl --user disable --now noctalia.service 2>/dev/null || true
rm -f "$HOME/.config/noctalia/machine.toml"
