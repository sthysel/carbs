#!/bin/sh
# Check which Config packages have/don't have readme.org

for dir in Configs/*/; do
  pkg=$(basename "$dir")
  if [ -f "$dir/readme.org" ]; then
    echo "EXISTS: $pkg"
  else
    echo "MISSING: $pkg"
  fi
done
