#!/bin/sh

generic() {
    uv_uninstall rust-just
}

linux() {
    rm -f ~/.local/bin/just-lsp
}
