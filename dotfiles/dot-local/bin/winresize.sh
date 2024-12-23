#!/usr/bin/env bash

# echo "📐" | rofi -dmenu -p "Give width and height:" | xargs xdotool windowsize "$(xdotool getwindowfocus)"

window=$(xdotool getwindowfocus)
notify-send "Window to resize" $window
dimensions=$(zenity --entry --title="📐 Window Size" --text="Enter width and height (e.g., 800 600):")
xdotool windowsize "$window" $dimensions
