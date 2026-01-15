#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing entropy tools..."
yay_install rng-tools opensc
