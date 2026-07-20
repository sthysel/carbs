#!/bin/sh

echo "Enabling and starting dictd service..."
sudo systemctl enable --now dictd.service
