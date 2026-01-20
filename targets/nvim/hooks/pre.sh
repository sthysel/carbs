#!/bin/bash
# Install neovim and essential dependencies for LazyVim

echo "🔧 Installing neovim dependencies..."

yay_install \
    neovim \
    git \
    ripgrep \
    fd \
    lazygit \
    nodejs \
    npm

echo "✓ Dependencies ready"
