#!/usr/bin/env bash
# cheatsheet: Auto-configure external monitors

export DISPLAY=:0
export XAUTHORITY=~.Xauthority

set -e
MONITOR='DP-3'

function wait_for_monitor {
    while ! xrandr | grep "$MONITOR" | grep -q '\bconnected'
    do
            logger -t "waiting for 100ms"
            sleep 0.1
    done
 }

EXTERNAL_MONITOR_STATUS=$(cat /sys/class/drm/card0-"$MONITOR"/status )
if [ "$EXTERNAL_MONITOR_STATUS"  == "connected" ]
then
    wait_for_monitor
    xrandr --output "$MONITOR" --auto --primary --output LVDS-1 --auto --left-of "$MONITOR"
    ~/.local/bin/i3plug.py restore
else
    ~/.local/bin/i3plug.py save
    xrandr --output "$MONITOR" --off
fi

feh --bg-scale ~/.config/carbs/wall
