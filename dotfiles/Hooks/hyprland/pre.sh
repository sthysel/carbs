#!/bin/bash
# Check Hyprland dependencies are installed

echo "🔍 Checking Hyprland dependencies..."
echo ""

# Core Hyprland packages
HYPR_CORE=(
    "hyprland"
    "hyprlock"
    "hypridle"
    "hyprpaper"
    "xdg-desktop-portal-hyprland"
)

# Panel/Bar options (hyprpanel installed via Ansible AUR role)
PANELS=(
    "waybar"
)

# Essential utilities
UTILITIES=(
    "rofi-wayland"          # Launcher
    "kitty"                 # Terminal
    "dolphin"               # File manager
)

# Screenshot tools
SCREENSHOT=(
    "grim"                  # Screenshot
    "slurp"                 # Area selection
    "satty"                 # Annotation
)

# Clipboard management
CLIPBOARD=(
    "wl-clipboard"
    "cliphist"
    "wl-clip-persist"
)

# Session management
SESSION=(
    "uwsm"                  # Universal Wayland Session Manager
    "polkit-kde-agent"      # Authentication agent
)

# Audio/Media control
MEDIA=(
    "pipewire"
    "wireplumber"
    "pipewire-pulse"
    "pipewire-audio"
    "playerctl"             # Media player control
)

# Display/Power management
POWER=(
    "brightnessctl"         # Brightness control
    "udiskie"               # USB automount
)

# Fonts
FONTS=(
    "ttf-font-awesome"
    "ttf-nerd-fonts-symbols"
    "ttf-sourcecodepro-nerd"
)

# Combine all packages
ALL_PKGS=(
    "${HYPR_CORE[@]}"
    "${PANELS[@]}"
    "${UTILITIES[@]}"
    "${SCREENSHOT[@]}"
    "${CLIPBOARD[@]}"
    "${SESSION[@]}"
    "${MEDIA[@]}"
    "${POWER[@]}"
    "${FONTS[@]}"
)

MISSING=()
INSTALLED=0

for pkg in "${ALL_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        MISSING+=("$pkg")
    else
        ((INSTALLED++))
    fi
done

# Check for AUR packages
AUR_PKGS=(
    "ags-hyprpanel-git"
    "aylurs-gtk-shell-git"
)

for pkg in "${AUR_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        MISSING+=("$pkg")
    else
        ((INSTALLED++))
    fi
done

TOTAL=$((${#ALL_PKGS[@]} + ${#AUR_PKGS[@]}))

echo "📊 Status: $INSTALLED/$TOTAL packages installed"
echo ""

if [ ${#MISSING[@]} -eq 0 ]; then
    echo "✓ All Hyprland dependencies are installed"
else
    echo "⚠️  Missing ${#MISSING[@]} package(s):"
    for pkg in "${MISSING[@]}"; do
        echo "   - $pkg"
    done
    echo ""
    echo "💡 To install missing packages, run:"
    echo "   just deploy localhost hyprland desktop"
    echo ""
fi
