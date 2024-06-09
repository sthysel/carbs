#!/bin/sh

echo "📐" | rofi -dmenu -p "Give width and height:" | xargs xdotool windowsize "$(xdotool getwindowfocus)"
