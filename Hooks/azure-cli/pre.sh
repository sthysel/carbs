#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

arch() {
    yay_install python-argcomplete
}

generic() {
    uv_install --prerelease allow azure-cli@latest
}
