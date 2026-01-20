#!/bin/sh

echo "Enabling and starting docker service..."
sudo systemctl enable --now docker.service
