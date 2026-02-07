#!/usr/bin/env bash
# cheatsheet: Check if command is installed

# If $1 command is not available, error code and notify.
command -v "$1" >/dev/null || { notify-send "📦 $1" "must be installed for this function." && exit 1 ;}
