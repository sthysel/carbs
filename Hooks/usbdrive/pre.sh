#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../../Configs/usbdrive"

echo "Installing udisks2 and udiskie..."
yay -S --needed --noconfirm udisks2 udiskie

POLKIT_RULES="/etc/polkit-1/rules.d/50-udiskie.rules"

if [ -f "$POLKIT_RULES" ]; then
    echo "Polkit rules already exist, skipping..."
else
    echo "Creating polkit rules for udiskie mounting..."
    sudo cp "$CONFIG_DIR/50-udiskie.rules" "$POLKIT_RULES"
fi

echo "Adding $USER to storage group..."
sudo usermod -aG storage "$USER"
