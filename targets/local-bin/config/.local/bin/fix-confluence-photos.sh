#!/usr/bin/env bash
# cheatsheet: Resize images for Confluence

# fix infuriating shit confluence fucking 2019! exif ignoring bug

for f in *
do
    echo fixing "$f"
    convert -resize 50% -auto-orient "$f" "$f"
done
