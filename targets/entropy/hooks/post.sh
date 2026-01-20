#!/bin/sh

echo "Enabling rngd service..."
sudo systemctl enable --now rngd.service
