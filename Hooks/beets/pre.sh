#!/bin/sh

echo "Installing beets dependencies..."
yay -S --needed --noconfirm chromaprint fcalc

if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! command -v beet >/dev/null 2>&1; then
    echo "Installing beets via uv..."
    uv tool install --with beets-ytimport,ytmusicapi,yt-dlp,pyacoustid,chromaprint \
        "beets[fetchart,lyrics,lastgenre,discogs,web,embedart,replaygain,thumbnails,scrub]"
fi
