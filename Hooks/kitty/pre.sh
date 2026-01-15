#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

if ! installed kitty; then
    echo "Installing kitty..."
    yay -S --noconfirm kitty
fi
