#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing ranger via uv..."
uv_install ranger-fm
