#!/usr/bin/env bash
# cheatsheet: Browse installed Arch packages with fzf

set -euo pipefail

yay -Qq | fzf --preview 'yay -Qil {}' --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'
