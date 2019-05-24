#!/bin/bash

IN=$1
OUT=$(sed "s/avi/mp4/" <<< $1)
echo "$IN -> $OUT"

# mencoder $IN -o $OUT -oac copy -ovc lavc -lavcopts vcodec=mpeg1video -of mpeg
ffmpeg -i $IN -acodec libfaac -b:a 128k -vcodec mpeg4 -b:v 1200k -flags +aic+mv4 $OUT
