#!/bin/sh

echo "Enabling pcscd socket..."
sudo systemctl enable --now pcscd.socket

echo "Reloading udev rules for YubiKey devices..."
sudo udevadm control --reload-rules
sudo udevadm trigger --subsystem-match=usb --subsystem-match=hidraw
