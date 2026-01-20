#!/bin/sh

echo "Enabling locales..."
sudo sed -i 's/^#\s*\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sudo sed -i 's/^#\s*\(en_AU.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sudo sed -i 's/^#\s*\(af_ZA.UTF-8 UTF-8\)/\1/' /etc/locale.gen

echo "Regenerating locales..."
sudo locale-gen

echo "Setting default locale to en_AU.UTF-8..."
echo "LANG=en_AU.UTF-8" | sudo tee /etc/locale.conf
