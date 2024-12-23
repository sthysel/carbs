#!/usr/bin/env bash

set -euo pipefail

yay -Qq | fzf --preview 'yay -Qil {}' --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'
