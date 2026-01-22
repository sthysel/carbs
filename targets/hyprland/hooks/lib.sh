# shellcheck shell=sh
# Shared functions for hyprland hooks (sourced, not executed)

is_laptop() {
    # Check for battery
    ls /sys/class/power_supply/BAT* >/dev/null 2>&1 && return 0
    # Check chassis type (8=Portable, 9=Laptop, 10=Notebook, 14=Sub Notebook)
    if [ -f /sys/class/dmi/id/chassis_type ]; then
        case "$(cat /sys/class/dmi/id/chassis_type)" in
            8|9|10|14) return 0 ;;
        esac
    fi
    return 1
}
