#!/bin/sh

echo "Enabling mpd user service..."
systemctl --user enable --now mpd.service
