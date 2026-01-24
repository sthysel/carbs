#!/bin/sh

echo "Ensuring libvirt group exists..."
sudo groupadd -f libvirt

echo "Adding $USER to libvirt group..."
sudo usermod -aG libvirt "$USER"

echo "Installing virtualization tools..."
yay_install \
    virt-manager \
    qemu-desktop \
    libvirt \
    edk2-ovmf \
    dnsmasq \
    swtpm
