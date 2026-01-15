#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing common dev tools..."
yay_install base-devel curl git make just wget direnv tldr btop

if ! installed uv; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

echo "Installing/upgrading Python tools via uv..."
uv_install ruff
uv_install pytest
uv_install poetry
uv_install marimo
uv_install pyrefly
uv_install yt-dlp

echo "Installing python-argcomplete..."
yay_install python-argcomplete

echo "Activating global python-argcomplete..."
sudo /usr/bin/activate-global-python-argcomplete
