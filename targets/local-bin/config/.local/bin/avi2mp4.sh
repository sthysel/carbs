#!/usr/bin/env bash
# cheatsheet: Convert AVI to MP4 (h264)

set -euo pipefail
IFS=$'\n\t'

error_exit() {
  echo "Error: $1" >&2
  exit 1
}

# Cleanup function to be called on exit
cleanup() {
  if [ -n "${OUT-}" ] && [ -f "$OUT" ]
  then
    rm -f "$OUT"
  fi
}
trap cleanup EXIT

# Check if input file is provided
if [ -z "${1-}" ]
then
  error_exit "Usage: $0 input.avi"
fi

IN="$1"

# Check if the input file exists
if [ ! -f "$IN" ]
then
  error_exit "Input file $IN not found"
fi

OUT="${IN%.avi}.mkv"

# Check if sed successfully created the output filename
if [ -z "$OUT" ]
then
  error_exit "Failed to create output filename"
fi

echo "$IN -> $OUT"

if ffmpeg -i "$IN" -acodec aac -b:a 128k -vcodec libx264 -b:v 1200k -preset slow -movflags +faststart "$OUT"
then
  echo "Conversion successful: $OUT"
  trap - EXIT  # Disable cleanup on successful completion
else
  error_exit "ffmpeg failed to convert $IN to $OUT"
fi
