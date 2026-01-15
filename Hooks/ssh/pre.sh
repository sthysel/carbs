#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing openssh..."
yay -S --needed --noconfirm openssh
