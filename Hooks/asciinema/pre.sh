#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing asciinema and asciinema-agg..."
yay_install asciinema asciinema-agg
