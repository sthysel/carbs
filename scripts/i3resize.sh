#!/usr/bin/env bash

[ -z "$1" ] && echo "No direction provided" && exit 1
distanceStr="2 px or 2 ppt"

move_choice() {
  i3-msg resize "$1" "$2" "$distanceStr" | grep '"success":true' || \
    i3-msg resize "$3" "$4" "$distanceStr"
}

case $1 in
  up)
    move_choice grow up shrink down
    ;;
  down)
    move_choice shrink up grow down
    ;;
  left)
    move_choice shrink right grow left
    ;;
  right)
    move_choice grow right shrink left
    ;;
esac
