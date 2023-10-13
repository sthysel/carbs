#!/bin/bash

if [ -z "$1" ]
then
  echo "Usage: $0 ~/path/to/image/directory"
  echo "Example: $0 ."
  exit 1
fi

cd "$1" || exit 1

for img_file in *.png *.jpg *.jpeg *.wepp
do
  [ -f "$img_file" ] || continue

  extension="${img_file##*.}"
  caption=$(blip-caption --large "$img_file")
  new_filename=$(echo "$caption" | tr ' ' '-' | sed "s/[^a-zA-Z0-9-]//g").$extension
  echo "$img_file" "$new_filename"
  # mv "$img_file" "$new_filename"
done

