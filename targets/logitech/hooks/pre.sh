#!/bin/bash
# Install Logitech device management tools

echo "Installing Logitech tools..."

arch() {
    yay_install solaar libnotify
}

steamos() {
    # solaar available in flatpak on Steam Deck
    flatpak install -y flathub io.github.pwr_solaar.solaar
}
