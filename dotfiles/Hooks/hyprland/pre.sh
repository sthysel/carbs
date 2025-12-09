#!/bin/bash
# Install Hyprland and entire ecosystem

echo "🔧 Installing Hyprland and dependencies..."

# Core Hyprland packages
HYPR_CORE=(
    "hyprland"
    "hyprlock"
    "hypridle"
    "hyprpaper"
    "xdg-desktop-portal-hyprland"
)

# Panel/Bar options
PANELS=(
    "waybar"
    "hyprpanel"
)

# Essential utilities
UTILITIES=(
    "rofi-wayland"          # Launcher
    "dunst"                 # Notifications
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

echo "📦 Installing ${#ALL_PKGS[@]} packages..."
echo ""

for pkg in "${ALL_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &> /dev/null; then
        echo "  Installing $pkg..."
        sudo pacman -S --noconfirm "$pkg" || echo "  ⚠️  Failed to install $pkg"
    else
        echo "  ✓ $pkg already installed"
    fi
done

echo ""
echo "✓ Hyprland ecosystem ready"
echo ""
echo "💡 Components installed:"
echo "   - Hyprland compositor + lock/idle/paper"
echo "   - Waybar + HyprPanel"
echo "   - Rofi launcher + Dunst notifications"
echo "   - Screenshot suite (grim/slurp/satty)"
echo "   - Clipboard management"
echo "   - Audio/media controls"
echo "   - Session management (uwsm)"
