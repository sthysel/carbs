#!/bin/sh

AVASSA_HOST="${AVASSA_HOST:-api.trial.bhp.avassa.net}"

arch(){
    yay_install python-websockets
}

linux() {
    if has supctl; then
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
