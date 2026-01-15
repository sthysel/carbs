#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh


ARCH_PACKAGES="
    archlinux-keyring
    aspell-en
    aspell-uk
    base-devel
    bat
    btop
    curl
    direnv
    htop
    imagemagick
    lsd
    make
    neofetch
    networkmanager
    pacman-contrib
    rsync
    shellcheck
    sysz
    thefuck
    trash-cli
    tree
    wget
"

install_uv() {
    if ! installed uv; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
}

arch() {
    # the very basics needed to bootstrap
    rootdo pacman -S --needed --noconfirm base-devel jq curl git

    # yay, to install the good shit
    if ! installed yay; then
        git clone https://aur.archlinux.org/yay.git yay
        makepkg -si --noconfirm
        yay -S yay
    fi

    # install all the essentials
    # shellcheck disable=SC2086
    yay -S --needed --noconfirm $ARCH_PACKAGES

    # uv cause that's where its at
    install_uv
}

steamos() {
    rootdo steamos-readonly disable
    rootdo pacman-key --init
    rootdo pacman-key --populate archlinux
    rootdo pacman-key --populate holo
    rootdo pacman -S --noconfirm jq git curl
}

debian() {
    rootdo apt install -y jq curl git
    install_uv
}
