#!/usr/bin/env bash

set -euxo pipefail

function have {
	  command -v "$1" &>/dev/null
}

# install the bootstrap tools
sudo pacman -S just git
