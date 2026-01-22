#!/bin/sh
# Install Hyprland and dependencies

is_laptop() {
    ls /sys/class/power_supply/BAT* >/dev/null 2>&1 && return 0
    if [ -f /sys/class/dmi/id/chassis_type ]; then
        case "$(cat /sys/class/dmi/id/chassis_type)" in
            8|9|10|14) return 0 ;;
        esac
    fi
    return 1
}

arch() {
    log_info "Installing Hyprland dependencies..."

    # Core Hyprland packages
    yay_install \
        hyprland \
        hyprlock \
        hypridle \
        hyprpaper \
        xdg-desktop-portal-hyprland

    yay_install waypaper

    # Panel/Bar
    yay_install waybar

    # Essential utilities
    yay_install \
        rofi-wayland \
        kitty \
        dolphin

    # Screenshot tools
    yay_install \
        grim \
        slurp \
        satty

    # Clipboard management
    yay_install \
        wl-clipboard \
        cliphist \
        wl-clip-persist

    # Display manager and session management
    yay_install \
        gdm \
        uwsm \
        polkit-kde-agent

    # Audio/Media control
    yay_install \
        pipewire \
        wireplumber \
        pipewire-pulse \
        pipewire-audio \
        playerctl

    # Display/Power management
    yay_install \
        brightnessctl \
        udiskie

    # Fonts
    yay_install \
        ttf-font-awesome \
        ttf-nerd-fonts-symbols \
        ttf-sourcecodepro-nerd

    # AUR packages
    yay_install \
        ags-hyprpanel-git \
        aylurs-gtk-shell-git

    # Laptop-specific packages
    if is_laptop; then
        log_info "Laptop detected, installing NetworkManager..."
        yay_install networkmanager
    fi
}
