#!/usr/bin/env bash

set -euxo pipefail

# install the bootstrap tools
sudo pacman -S just git curl

# deploy CARBS
just deploy
