#!/bin/sh

echo "Enabling udiskie service..."
systemctl --user daemon-reload
systemctl --user enable --now udiskie.service
