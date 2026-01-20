#!/bin/sh

echo "Enabling gpsd service..."
sudo systemctl enable --now gpsd.socket
