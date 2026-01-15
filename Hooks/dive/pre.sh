#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

if ! installed dive; then
    echo "Installing dive..."
    yay -S --noconfirm dive
fi
