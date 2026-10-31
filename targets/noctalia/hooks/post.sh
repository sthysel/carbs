#!/bin/sh

is_laptop() {
    ls /sys/class/power_supply/BAT* >/dev/null 2>&1 && return 0
    if [ -f /sys/class/dmi/id/chassis_type ]; then
        case "$(cat /sys/class/dmi/id/chassis_type)" in
            8|9|10|14) return 0 ;;
        esac
    fi
    return 1
}

configure_machine() {
    config_dir="$HOME/.config/noctalia"

    if is_laptop; then
        ln -sf "$config_dir/machines/laptop.toml" "$config_dir/machine.toml"
        echo "Linked laptop Noctalia configuration"
    else
        ln -sf "$config_dir/machines/desktop.toml" "$config_dir/machine.toml"
        echo "Linked desktop Noctalia configuration"
    fi
}

configure_service() {
    echo "Enabling noctalia service..."
    systemctl --user daemon-reload
    systemctl --user disable hyprpanel.service 2>/dev/null || true
    systemctl --user enable --now noctalia.service
}

configure_machine
configure_service
