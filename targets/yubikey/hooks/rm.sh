#!/bin/sh

echo "Disabling pcscd socket..."
sudo systemctl disable --now pcscd.socket 2>/dev/null || true
