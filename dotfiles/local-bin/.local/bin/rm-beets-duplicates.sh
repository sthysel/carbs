#!/bin/env bash

BEETS_LOG=~/.config/beets/beetslog.txt

grep "duplicate-skip" "$BEETS_LOG" |
  sed 's/duplicate-skip //' |
  while read -r path; do
    echo "Would fucking delete: $path"
    rm "$path"
  done
