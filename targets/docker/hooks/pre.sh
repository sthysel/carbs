#!/bin/sh

echo "Ensuring docker group exists..."
sudo groupadd -f docker

echo "Adding $USER to docker group..."
sudo usermod -aG docker "$USER"

echo "Installing docker and related tooling"
yay_install \
    docker \
    docker-buildx \
    dive \
    lazydocker \
    oras
