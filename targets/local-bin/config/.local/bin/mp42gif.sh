#!/bin/bash

IN="$1"
OUT="${1/mp4/gif}"
echo "$IN -> $OUT"

ffmpeg \
  -i "$IN" \
  -r 15 \
  -ss 00:00:0 -to 00:00:30 \
  "$OUT"
