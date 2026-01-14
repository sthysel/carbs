#!/bin/bash
# Install yazi and preview dependencies

echo "🔧 Installing yazi and preview dependencies..."

REQUIRED_PKGS=(
    "yazi"
    "ffmpegthumbnailer"  # Video thumbnails
    "imagemagick"        # Image previews
    "poppler"            # PDF previews
    "fd"                 # File finding
    "ripgrep"            # Content search
    "fzf"                # Fuzzy finder
    "zoxide"             # Smart directory jumping
    "jq"                 # JSON handling
    "mediainfo"          # Media file info (for plugin)
    "perl-image-exiftool" # EXIF data (for exifaudio plugin)
)

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    fi
done

echo "✓ Yazi dependencies ready"
