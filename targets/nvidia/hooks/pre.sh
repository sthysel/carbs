#!/bin/bash

echo "Installing nvidia drivers..."

# Detect GPU architecture from lspci
# Pascal (GP10x) and older need proprietary driver, Turing+ can use open driver
detect_nvidia_gpu() {
    lspci | grep -i nvidia | grep -ioE 'G[PTAV][0-9]{3}|TU[0-9]{3}|GA[0-9]{3}|AD[0-9]{3}' | head -1
}

is_pascal_or_older() {
    local gpu_arch
    gpu_arch=$(detect_nvidia_gpu)

    case "$gpu_arch" in
        GP*|GV*|GT*|GK*|GF*|G[0-9]*)
            # Pascal (GP), Volta (GV), or older (GT=Fermi/Kepler, GK=Kepler, GF=Fermi)
            return 0
            ;;
        *)
            # Turing (TU), Ampere (GA), Ada (AD), or unknown - use open driver
            return 1
            ;;
    esac
}

arch() {
    if is_pascal_or_older; then
        echo "Detected Pascal or older GPU, installing proprietary driver..."
        yay_install nvidia-580xx-dkms nvidia-580xx-utils
    else
        echo "Detected Turing or newer GPU, installing open driver..."
        yay_install nvidia-open nvidia-utils
    fi
}
