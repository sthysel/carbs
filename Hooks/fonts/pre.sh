#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing fonts..."
yay -S --needed --noconfirm \
    nerd-fonts-complete \
    noto-fonts \
    terminus-font \
    ttf-dejavu \
    ttf-droid \
    ttf-fira-code \
    ttf-fira-code-symbol \
    ttf-firacode-nerd \
    ttf-font-awesome \
    ttf-inconsolata \
    ttf-joypixels \
    ttf-liberation \
    ttf-nerd-fonts-symbols \
    ttf-roboto \
    ttf-ubuntu-font-family
