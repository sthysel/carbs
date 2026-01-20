#!/bin/bash
# Smart window killer - force kills Webex, normal kill for everything else

window_info=$(hyprctl activewindow -j)
class=$(echo "$window_info" | jq -r '.class')
pid=$(echo "$window_info" | jq -r '.pid')

# Check if it's Webex (case insensitive)
if echo "$class" | grep -iq "webex\|cisco"; then
    # Nuke Webex from orbit
    kill -9 "$pid"
else
    # Normal polite close for everything else
    hyprctl dispatch killactive
fi
