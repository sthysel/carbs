#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

if ! installed mpd; then
    echo "Installing mpd..."
    yay -S --noconfirm mpd
fi
