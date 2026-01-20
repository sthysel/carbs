#!/usr/bin/bash

bat="$(solaar show | grep -m1 Battery | sed 's/[^0-9]*//g')"
[ -z "$bat" ] && exit
[ "$bat" -lt 80 ] && dunstify -a mousebat "Warning" "Mouse battery is low ($bat%)"
