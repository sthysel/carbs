#!/bin/bash
# Enable mouse battery monitoring

echo "Enabling mouse battery monitor..."

# Make script executable
chmod +x "$HOME/.local/bin/mouse-battery-monitor"

# Reload systemd and enable timer
systemctl --user daemon-reload
systemctl --user enable --now mouse-battery-monitor.timer

echo "Mouse battery monitoring active (checks every 30 minutes)"
echo "Configure thresholds via environment variables:"
echo "  MOUSE_BATTERY_LOW (default: 20)"
echo "  MOUSE_BATTERY_CRITICAL (default: 10)"
