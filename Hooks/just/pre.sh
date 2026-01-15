#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

arch() {
    uv_install rust-just
    yay_install just-lsp
}

linux() {
    LATEST_VERSION=$(github_latest_tag "terror/just-lsp")
    VERSION=${JUST_LSP_VERSION:=$LATEST_VERSION}

    FILENAME=just-lsp-${VERSION}-x86_64-unknown-linux-gnu.tar.gz
    curl -sLO "https://github.com/terror/just-lsp/releases/download/${VERSION}/${FILENAME}"
    tar -xzf "${FILENAME}"
    mv just-lsp ~/.local/bin/
    chmod +x ~/.local/bin/just-lsp
}
