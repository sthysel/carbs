#!/bin/sh

HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
SOURCE_LINE="source = ~/.config/hypr/nvidia.conf"

add_line_to_file "$SOURCE_LINE" "$HYPRLAND_CONF"
