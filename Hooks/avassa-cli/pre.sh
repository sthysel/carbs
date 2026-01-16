#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

AVASSA_HOST="${AVASSA_HOST:-api.trial.bhp.avassa.net}"

linux() {
    if installed supctl; then
        echo "Updating supctl..."
        supctl update
    else
        echo "Installing supctl from $AVASSA_HOST..."
        curl -sO "https://${AVASSA_HOST}/supctl"
        chmod +x ./supctl
        mv supctl ~/.local/bin/
        echo "supctl installed to ~/.local/bin/supctl"
    fi
}
