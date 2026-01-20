#!/bin/sh

echo "Installing openssh..."
yay_install openssh

mkdir -p ~/.ssh/config.d
