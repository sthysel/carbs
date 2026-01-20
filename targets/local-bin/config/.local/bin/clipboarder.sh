#!/usr/bin/env bash

set -euo pipefail

# Stolen from Luke Smith's LARBS
# Do something with the string in the primary clipboard
# Dependencies are xclip and xorg-xprop.
# qrencode required for qrcode generation.
# groff/zathura required for man pages.

primary="$(xclip -o)"; [ -z "$primary" ] && exit

PID=$(xprop -id "$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')" | grep -m 1 PID | cut -d " " -f 3)
PID=$(pstree -lpA "$PID" | tail -n 1 | awk -F'---' '{print $NF}' | sed -re 's/[^0-9]//g')
cd "$(readlink /proc/"$PID"/cwd)"
[ -f "$primary" ] && xdg-open "$primary" && exit
[ -d "$primary" ] && "$TERMINAL" "$primary" && exit

websearch() { "$BROWSER" "https://duckduckgo.com/?q=$*" ;}
wikipedia() { "$BROWSER" "https://en.wikipedia.org/wiki/$*" ;}
wiktionary() { "$BROWSER" "https://en.wiktionary.org/wiki/$*" ;}
maps() { "$BROWSER" "https://www.openstreetmap.org/search?query=$*" ;}
ebay() { "$BROWSER" "https://www.ebay.com/sch/$*" ;}

echo "$primary" | grep "^.*\.[A-Za-z]\+.*" >/dev/null && gotourl() { "$BROWSER" "$@" ;}
echo "$primary" | grep "^.*@.*\.[A-Za-z]\+$" >/dev/null && email() { xdg-email "$@" ;}
command -v qrencode >/dev/null && qrcode() { qrencode "$@" -s 10 -o /tmp/qr.png && xdg-open /tmp/qr.png ;}
man -k "^$primary$" >/dev/null && manual() { man -Tpdf "$primary" | zathura - ;}

func="$(declare -F | awk '{print $3}' | rofi -dmenu -p "Plumb \"$(echo "$primary" | cut -c -30)\" to?" -i -l 15)"

[ -z "$func" ] || "$func" "$primary"
