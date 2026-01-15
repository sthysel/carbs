#!/bin/sh

echo "Installing entropy tools..."
yay -S --needed --noconfirm rng-tools opensc
