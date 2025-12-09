#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=~.Xauthority

set -e
MONITOR='DP-3'

function wait_for_monitor {
    xrandr | grep $MONITOR | grep '\bconnected'
    while [ $? -ne 0 ]
    do
            logger -t "waiting for 100ms"
            sleep 0.1
            xrandr | grep $MONITOR | grep '\bconnected'
    done
 }

EXTERNAL_MONITOR_STATUS=$(cat /sys/class/drm/card0-$MONITOR/status )
if [ $EXTERNAL_MONITOR_STATUS  == "connected" ]
then
    wait_for_monitor
    xrandr --output $MONITOR --auto --primary --output LVDS-1 --auto --left-of $MONITOR
    ~/.local/bin/i3plug.py restore
else
    ~/.local/bin/i3plug.py save
    xrandr --output $MONITOR --off
fi

feh --bg-scale ~/.config/carbs/wall
