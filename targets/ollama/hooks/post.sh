#!/bin/sh

echo "Enabling and starting ollama service..."
sudo systemctl enable --now ollama.service
