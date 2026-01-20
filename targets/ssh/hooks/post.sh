#!/bin/sh

echo "Enabling ssh-agent user service..."
systemctl --user enable --now ssh-agent.service
