#!/bin/sh

arch() {
  yay_install python-argcomplete
}

generic() {
  uv tool install --prerelease allow azure-cli@latest
}
