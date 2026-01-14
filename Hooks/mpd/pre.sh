#!/bin/sh

if ! command -v mpd >/dev/null 2>&1; then
    echo "Installing mpd..."
    yay -S --noconfirm mpd
fi
