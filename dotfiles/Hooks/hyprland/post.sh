#!/bin/bash
# Reload Hyprland configuration if running

echo "🚀 Finalizing Hyprland setup..."

# Check if Hyprland is running
if pgrep -x "Hyprland" > /dev/null; then
    echo "✓ Hyprland is running"

    # Reload Hyprland config (this will re-source everything)
    echo "🔄 Reloading Hyprland configuration..."
    hyprctl reload

    echo "✓ Configuration reloaded"
    echo "   uwsm will handle starting/restarting apps automatically"
else
    echo "ℹ️  Hyprland not running"

    # Ensure audio services are enabled
    echo "🔧 Enabling audio services for next session..."
    systemctl --user enable --now pipewire.service 2>/dev/null || true
    systemctl --user enable --now pipewire-pulse.service 2>/dev/null || true
    systemctl --user enable --now wireplumber.service 2>/dev/null || true

    echo "✓ Services configured"
fi

echo ""
echo "✓ Hyprland setup complete!"
echo ""
echo "💡 To start Hyprland:"
echo "   uwsm start hyprland.desktop"
echo ""
echo "💡 Key bindings:"
echo "   Super + Return  - Terminal (kitty)"
echo "   Super + Space   - Launcher (rofi)"
echo "   Super + Q       - Close window"
echo "   Super + E       - File manager"
echo "   Super + R       - File manager (yazi)"
echo "   Super + X       - Screenshot (grim/slurp/satty)"
echo "   Super + Shift+L - Lock screen (hyprlock)"
