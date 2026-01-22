#!/bin/bash
# Reload Hyprland configuration if running

echo "Finalizing Hyprland setup..."

# Disable other display managers if running, then enable GDM
echo "Configuring GDM as display manager..."
for dm in sddm lightdm ly greetd; do
    if systemctl is-enabled "$dm.service" 2>/dev/null | grep -q enabled; then
        echo "Disabling $dm..."
        sudo systemctl disable --now "$dm.service" 2>/dev/null || true
    fi
done
sudo systemctl enable gdm.service 2>/dev/null || true

# Select Hyprland (uwsm) as default session for GDM
echo "Configuring UWSM for Hyprland..."
uwsm select hyprland 2>/dev/null || true

# Enable hyprpanel systemd service
echo "Enabling hyprpanel service..."
systemctl --user daemon-reload
systemctl --user enable hyprpanel.service 2>/dev/null || true

# Create local.conf if it doesn't exist (for machine-specific overrides)
if [ ! -f "$HOME/.config/hypr/local.conf" ]; then
    echo "# Machine-specific Hyprland overrides" > "$HOME/.config/hypr/local.conf"
    echo "Created ~/.config/hypr/local.conf for local overrides"
fi

# Detect machine type and link appropriate HyprPanel config.json
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(dirname "$SCRIPT_DIR")"
HYPRPANEL_DIR="$HOME/.config/hyprpanel"
CONFIG_DESKTOP="$TARGET_DIR/config/.config/hyprpanel/config-desktop.json"
CONFIG_LAPTOP="$TARGET_DIR/config/.config/hyprpanel/config-laptop.json"
CONFIG_TARGET="$HYPRPANEL_DIR/config.json"

echo "Detecting machine type..."

# Detect if machine is a laptop (check for battery or chassis type)
IS_LAPTOP=false

# Method 1: Check for battery
if compgen -G "/sys/class/power_supply/BAT*" > /dev/null; then
    IS_LAPTOP=true
    echo "Battery detected - this is a laptop"
# Method 2: Check chassis type (8=Portable, 9=Laptop, 10=Notebook, 14=Sub Notebook)
elif [ -f /sys/class/dmi/id/chassis_type ]; then
    CHASSIS_TYPE=$(cat /sys/class/dmi/id/chassis_type)
    if [ "$CHASSIS_TYPE" = "8" ] || [ "$CHASSIS_TYPE" = "9" ] || [ "$CHASSIS_TYPE" = "10" ] || [ "$CHASSIS_TYPE" = "14" ]; then
        IS_LAPTOP=true
        echo "Chassis type $CHASSIS_TYPE detected - this is a laptop"
    fi
fi

# Remove existing symlink if it exists
[ -L "$CONFIG_TARGET" ] && rm "$CONFIG_TARGET"

# Create appropriate symlink
if [ "$IS_LAPTOP" = true ]; then
    ln -sf "$CONFIG_LAPTOP" "$CONFIG_TARGET"
    echo "Done: Linked laptop HyprPanel configuration"
else
    ln -sf "$CONFIG_DESKTOP" "$CONFIG_TARGET"
    echo "Done: Linked desktop HyprPanel configuration"
fi
echo ""

# Check if Hyprland is running
if pgrep -x "Hyprland" > /dev/null; then
    echo "Done: Hyprland is running"

    # Reload Hyprland config (this will re-source everything)
    echo "... Reloading Hyprland configuration..."
    hyprctl reload

    echo "Done: Configuration reloaded"
    echo "   uwsm will handle starting/restarting apps automatically"
else
    echo "Hyprland not running"

    # Ensure audio services are enabled
    echo "Enabling audio services for next session..."
    systemctl --user enable --now pipewire.service 2>/dev/null || true
    systemctl --user enable --now pipewire-pulse.service 2>/dev/null || true
    systemctl --user enable --now wireplumber.service 2>/dev/null || true

    echo "Done: Services configured"
fi

echo ""
echo "Done: Hyprland setup complete!"
echo ""
echo "To start Hyprland:"
echo "   uwsm start hyprland.desktop"
echo ""
echo "Key bindings:"
echo "   Super + Return  - Terminal (kitty)"
echo "   Super + Space   - Launcher (rofi)"
echo "   Super + Q       - Close window"
echo "   Super + E       - File manager"
echo "   Super + R       - File manager (yazi)"
echo "   Super + X       - Screenshot (grim/slurp/satty)"
echo "   Super + Shift+L - Lock screen (hyprlock)"
