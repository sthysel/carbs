#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing beets dependencies..."
yay -S --needed --noconfirm chromaprint fcalc

if ! installed uv; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if ! installed beet; then
    echo "Installing beets via uv..."
    uv tool install --with beets-ytimport,ytmusicapi,yt-dlp,pyacoustid,chromaprint \
        "beets[fetchart,lyrics,lastgenre,discogs,web,embedart,replaygain,thumbnails,scrub]"
fi
