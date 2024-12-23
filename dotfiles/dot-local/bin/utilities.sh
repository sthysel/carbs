#!/usr/bin/env bash

# is $1 installed
function have {
  command -v "$1" &>/dev/null
}

# If $1 command is not available, error code and notify.
function have_notify {
  command -v "$1" >/dev/null || { notify-send "📦 $1" "must be installed for this function." && exit 1 ;}
}

# Get the focused window information from i3-msg
function i3_get_focused_window_name() {
    i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .name'
}
