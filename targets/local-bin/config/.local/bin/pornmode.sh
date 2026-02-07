#!/bin/bash
# cheatsheet: Panic button - hide everything
#STOP/HIDE EVERYTHING
set -euo pipefail
term=kitty

i3-msg "workspace 0"
lmc truemute
lmc pause
pauseallmpv
"$term" -e htop
"$term" -e "$FILE"
