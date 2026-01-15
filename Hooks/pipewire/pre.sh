#!/bin/sh

echo "Removing pulseaudio if present..."
sudo pacman -Rs --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth jack 2>/dev/null || true

echo "Installing pipewire and audio tooling..."
yay -S --needed --noconfirm \
    pipewire \
    pipewire-utils \
    pipewire-audio \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    pipewire-jack \
    pipewire-bluetooth \
    qpwgraph \
    helvum \
    coppwr

echo "Installing music and video players..."
yay -S --needed --noconfirm \
    mplayer \
    pavucontrol \
    pulsemixer \
    playerctl \
    mpv
