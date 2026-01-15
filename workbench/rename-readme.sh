#!/bin/sh
# Rename README.org to readme.org in all Config packages

for file in Configs/*/README.org; do
  if [ -f "$file" ]; then
    dir=$(dirname "$file")
    mv "$file" "$dir/readme.org"
    echo "Renamed: $file -> $dir/readme.org"
  fi
done
