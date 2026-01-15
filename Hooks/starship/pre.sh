#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

if ! installed starship; then
    echo "Installing starship..."
    yay -S --noconfirm starship
fi
