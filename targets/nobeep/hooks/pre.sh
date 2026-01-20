#!/bin/sh

NOBEEP_CONF="/etc/modprobe.d/nobeep.conf"

if [ -f "$NOBEEP_CONF" ]; then
    echo "PC speaker already disabled, skipping..."
else
    echo "Disabling PC speaker beep..."
    sudo tee "$NOBEEP_CONF" > /dev/null << 'EOF'
# carbs
# https://wiki.archlinux.org/index.php/PC_speaker
blacklist pcspkr
EOF
fi
