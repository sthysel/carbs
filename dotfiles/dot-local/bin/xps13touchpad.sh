#!/bin/sh
# Touchpad config

touchpad="DLL0704:01 06CB:76AE Touchpad"
xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$touchpad" "libinput Disable While Typing Enabled" 0
xinput set-prop "$touchpad" "libinput Accel Speed" 1
