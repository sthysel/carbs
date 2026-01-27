#!/bin/bash
# Install Bitwarden CLI

echo "Installing Bitwarden CLI..."

arch() {
    yay_install nodejs npm jq

    mkdir -p ~/.local/lib/node_modules
    npm config set prefix '~/.local'
    npm install -g @bitwarden/cli
}

steamos() {
    npm install -g @bitwarden/cli
}
