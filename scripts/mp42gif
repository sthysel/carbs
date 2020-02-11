#!/bin/bash

IN=$1
OUT=$(sed "s/mp4/gif/" <<< $1)
echo "$IN -> $OUT"

ffmpeg \
  -i $IN \
  -r 15 \
  -ss 00:00:0 -to 00:00:30 \
  $OUT
