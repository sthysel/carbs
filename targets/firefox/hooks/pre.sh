#!/bin/sh
# Install Firefox

arch() {
    yay_install firefox
    yay_install libnotify
    yay_install onnxruntime-cuda
    yay_install speech-dispatcher
    yay_install xdg-desktop-portal
}
