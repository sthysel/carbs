#!/usr/bin/env bash

# fix infuriating shit confluence fucking 2019! exif ignoring bug

for f in $(ls $(pwd))
do
    echo fixing $f
    convert -resize 50% -auto-orient $f $f
done
