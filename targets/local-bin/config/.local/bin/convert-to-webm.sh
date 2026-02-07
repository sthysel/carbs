#!/bin/bash
# cheatsheet: Convert video to WebM

# ffmpeg -i input.mp4 -c:v libvpx -b:v 1M -c:a libvorbis output.webm

# Check if the input file is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_video_file>"
  exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.*}.webm"

# Check if ffmpeg is installed
if ! command -v ffmpeg &>/dev/null; then
  echo "ffmpeg is not installed. Please install it and try again."
  exit 1
fi

# Convert the input video file to WebM format
if ffmpeg -i "$INPUT_FILE" -c:v libvpx -b:v 1M -c:a libvorbis "$OUTPUT_FILE"; then
  echo "Conversion successful: $OUTPUT_FILE"
else
  echo "Conversion failed."
  exit 1
fi
