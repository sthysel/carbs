#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

echo "Installing docker..."
yay_install docker docker-buildx

echo "Ensuring docker group exists..."
sudo groupadd -f docker

echo "Adding $USER to docker group..."
sudo usermod -aG docker "$USER"
