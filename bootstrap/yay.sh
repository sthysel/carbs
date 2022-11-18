#!/bin/zsh -e

# this script bootstraps ansible

install_yay() {
    # bootstrap yay from aur
    git clone https://aur.archlinux.org/yay.git
    cd yay
    (
        makepkg -si
    )
    rm -fr ./yay
    # now use yay to install yay
    yay -S yay
}
