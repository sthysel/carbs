#!/bin/sh

echo "Removing pulseaudio if present..."
yay_uninstall \
    pulseaudio \
    pulseaudio-alsa \
    pulseaudio-bluetooth \
    jack

echo "Installing pipewire and audio tooling..."
yay_install \
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
yay_install \
    mplayer \
    pavucontrol \
    pulsemixer \
    playerctl \
    mpv
