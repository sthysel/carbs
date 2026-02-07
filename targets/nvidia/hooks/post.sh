#!/bin/sh

MKINITCPIO_CONF="/etc/mkinitcpio.conf"
NVIDIA_MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"

# Check if nvidia modules are already in mkinitcpio.conf
if grep -q "^MODULES=.*nvidia" "$MKINITCPIO_CONF" 2>/dev/null; then
    echo "nvidia modules already in mkinitcpio.conf"
else
    echo "Adding nvidia modules to mkinitcpio.conf..."

    # Add nvidia modules to MODULES array
    sudo sed -i "s/^MODULES=(\(.*\))/MODULES=(\1 $NVIDIA_MODULES)/" "$MKINITCPIO_CONF"

    # Clean up any double spaces
    sudo sed -i 's/MODULES=( /MODULES=(/' "$MKINITCPIO_CONF"

    echo "Regenerating initramfs..."
    sudo mkinitcpio -P

    echo "nvidia modules configured. Reboot required."
fi

# Enable nvidia power management services for suspend/resume
# These preserve GPU state across sleep, preventing Firefox and other
# GPU-accelerated apps from crashing on wake
rootdo systemctl enable nvidia-suspend nvidia-resume nvidia-hibernate
