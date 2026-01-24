#!/bin/sh

echo "Enabling and starting libvirtd service..."
sudo systemctl enable --now libvirtd.service

echo "Starting default NAT network..."
sudo virsh net-autostart default 2>/dev/null || true
sudo virsh net-start default 2>/dev/null || true
