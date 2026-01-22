#!/bin/sh

echo "Installing nvidia drivers..."
arch() {
    yay_install nvidia-dkms nvidia-utils
}
