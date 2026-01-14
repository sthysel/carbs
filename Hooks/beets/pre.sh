#!/bin/sh

if ! command -v beet >/dev/null 2>&1; then
    echo "Installing beets..."
    yay -S --noconfirm beets
fi
