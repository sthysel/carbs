#!/bin/bash
# Install yazi and preview dependencies

echo "🔧 Installing yazi and preview dependencies..."

yay_install \
    yazi \
    ffmpegthumbnailer \
    imagemagick \
    poppler \
    fd \
    ripgrep \
    fzf \
    zoxide \
    jq \
    mediainfo \
    perl-image-exiftool

echo "✓ Yazi dependencies ready"
