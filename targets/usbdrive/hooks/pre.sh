#!/bin/sh

echo "Adding $USER to storage group..."
sudo usermod -aG storage "$USER"

yay_install \
    udisks2 \
    udiskie
