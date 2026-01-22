#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$(dirname "$SCRIPT_DIR")"
# shellcheck disable=SC1091
. "$SCRIPT_DIR/lib.sh"

configure_display_manager() {
    echo "Configuring GDM as display manager..."
    for dm in sddm lightdm ly greetd; do
        if systemctl is-enabled "$dm.service" 2>/dev/null | grep -q enabled; then
            echo "Disabling $dm..."
            sudo systemctl disable --now "$dm.service" 2>/dev/null || true
        fi
    done
    sudo systemctl enable gdm.service 2>/dev/null || true
}

configure_network() {
    if is_laptop; then
        echo "Laptop detected, enabling NetworkManager..."
        sudo systemctl enable --now NetworkManager.service 2>/dev/null || true
    fi
}

configure_uwsm() {
    echo "Configuring UWSM for Hyprland..."
    uwsm select hyprland 2>/dev/null || true
}

configure_hyprpanel() {
    echo "Enabling hyprpanel service..."
    systemctl --user daemon-reload
    systemctl --user enable hyprpanel.service 2>/dev/null || true

    config_target="$HOME/.config/hyprpanel/config.json"
    [ -L "$config_target" ] && rm "$config_target"

    if is_laptop; then
        ln -sf "$TARGET_DIR/config/.config/hyprpanel/config-laptop.json" "$config_target"
        echo "Linked laptop HyprPanel configuration"
    else
        ln -sf "$TARGET_DIR/config/.config/hyprpanel/config-desktop.json" "$config_target"
        echo "Linked desktop HyprPanel configuration"
    fi
}

configure_local_overrides() {
    if [ ! -f "$HOME/.config/hypr/local.conf" ]; then
        echo "# Machine-specific Hyprland overrides" > "$HOME/.config/hypr/local.conf"
        echo "Created ~/.config/hypr/local.conf for local overrides"
    fi
}

configure_audio() {
    echo "Enabling audio services..."
    systemctl --user enable --now pipewire.service 2>/dev/null || true
    systemctl --user enable --now pipewire-pulse.service 2>/dev/null || true
    systemctl --user enable --now wireplumber.service 2>/dev/null || true
}

reload_hyprland() {
    if pgrep -x "Hyprland" > /dev/null; then
        echo "Reloading Hyprland configuration..."
        hyprctl reload
    fi
}

show_summary() {
    echo ""
    echo "Hyprland setup complete!"
    echo ""
    echo "To start Hyprland: uwsm start hyprland.desktop"
    echo ""
    echo "Key bindings:"
    echo "  Super + Return  - Terminal (kitty)"
    echo "  Super + Space   - Launcher (rofi)"
    echo "  Super + Q       - Close window"
    echo "  Super + E       - File manager"
    echo "  Super + R       - File manager (yazi)"
    echo "  Super + X       - Screenshot"
    echo "  Super + Shift+L - Lock screen"
}

echo "Finalising Hyprland setup..."
configure_display_manager
configure_network
configure_uwsm
configure_hyprpanel
configure_local_overrides
configure_audio
reload_hyprland
show_summary
