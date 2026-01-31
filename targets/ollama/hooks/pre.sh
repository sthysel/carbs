#!/bin/sh

arch() {
    yay_install ollama
    # For NVIDIA GPU support
    yay_install ollama-cuda
}

linux() {
    curl -fsSL https://ollama.com/install.sh | sh
}
