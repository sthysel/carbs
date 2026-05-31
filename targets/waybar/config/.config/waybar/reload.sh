#! /bin/bash
while true; do
    inotifywait -e modify ~/.config/waybar/config.jsonc ~/.config/waybar/style.css
    pkill waybar
    hyprctl dispatch 'hl.dsp.exec_cmd("waybar")'
    sleep 1
done
