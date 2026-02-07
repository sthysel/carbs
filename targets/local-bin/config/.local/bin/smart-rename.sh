#!/bin/bash
# cheatsheet: AI-rename images using blip-caption

if [ -z "$1" ]; then
	echo "Usage: $0 ~/path/to/image/directory"
	echo "Example: $0 ."
	exit 1
fi

IMAGE_DIR=$1
# Create the 'renamed' directory if it does not exist
RENAME_DIR="$IMAGE_DIR/renamed"
mkdir -p "$RENAME_DIR"

cd "$IMAGE_DIR" || exit 1

for img_file in *.png *.jpg *.jpeg *.wepp; do
	[ -f "$img_file" ] || continue

	extension="${img_file##*.}"
	caption=$(blip-caption --large "$img_file")
	new_filename=$(echo "$caption" | tr ' ' '-' | sed "s/[^a-zA-Z0-9-]//g").$extension
	echo "$img_file -> $new_filename"
	mv "$img_file" "$RENAME_DIR/$new_filename"
done

delete_small_images() {
	find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec sh -c '                                         ─╯
  for img; do
    read width height < <(identify -format "%w %h" "$img")
    if [ "$width" -lt 1920 ] || [ "$height" -lt 1080 ]; then
      echo "Deleting $img, size: ${width}x${height}"
      rm "$img"
    fi
  done
' sh {} +
}
