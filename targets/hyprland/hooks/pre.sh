#!/bin/sh
# Install Hyprland and dependencies

arch() {
    log_info "Installing Hyprland dependencies..."

    # Core Hyprland packages
    yay_install \
        hyprland \
        hypridle \
        xdg-desktop-portal-hyprland

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
        xclip

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

    # Laptop-specific packages
    if is_mobile; then
        log_info "Laptop detected, installing NetworkManager..."
        yay_install networkmanager
    fi
}
