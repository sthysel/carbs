#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing gpsd..."
yay -S --needed --noconfirm gpsd
