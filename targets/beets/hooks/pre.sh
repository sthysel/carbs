#!/bin/sh

echo "Installing beets dependencies..."
yay_install chromaprint

if ! has uv; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! has beet; then
    echo "Installing beets via uv..."
    uv tool install --with beets-ytimport,ytmusicapi,yt-dlp,pyacoustid,chromaprint \
        "beets[fetchart,lyrics,lastgenre,discogs,web,embedart,replaygain,thumbnails,scrub]"
fi
