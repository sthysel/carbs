# Hyprland Scaling Fix Session Notes

**Date:** 2025-11-14
**Issue:** BambuStudio fonts ridiculously large in Hyprland

## Root Cause
- 4K monitor (3840x2160) running at Hyprland scale 1.0
- Manual per-toolkit scaling via environment variables (GDK_SCALE=2, QT_SCALE_FACTOR=1.2)
- BambuStudio (GTK3 + WebKit2GTK app) was getting double/triple scaled
- Different toolkits handled scaling inconsistently

## Solution: Let Hyprland Handle Scaling
Instead of per-app environment variables, use compositor-level scaling that all apps inherit.

## Changes Made

### 1. Hyprland Monitor Scale
**File:** `dotfiles/hyprland/.config/hypr/hyprland.conf:7`
```diff
- monitor=,preferred,auto,auto
+ monitor=,preferred,auto,2
```

### 2. Environment Variables Simplified
**File:** `dotfiles/uwsm/.config/uwsm/env:8-16`
```diff
  export GTK_THEME=Adwaita-dark
- # scales fonts and text in GTK applications
- export GDK_DPI_SCALE=1.2
- export GDK_SCALE=2
+ # Let Hyprland handle scaling via compositor (monitor scale set to 2.0)
+ export GDK_SCALE=1
+ export GDK_DPI_SCALE=1

  export QT_AUTO_SCREEN_SCALE_FACTOR=1
- # export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export QT_QPA_PLATFORMTHEME=qt5ct
  export QT_STYLE_OVERRIDE=Adwaita-Dark
- export QT_AUTO_SCREEN_SCALE_FACTOR=1
  export QT_ENABLE_HIGHDPI_SCALING=1
- export QT_SCALE_FACTOR=1.2
+ # export QT_SCALE_FACTOR=1
```

### 3. XWayland Force Zero Scaling (Already Set)
**File:** `dotfiles/hyprland/.config/hypr/hyprland.conf:166-168`
```
xwayland {
    force_zero_scaling = true
}
```

### 4. Removed BambuStudio Desktop Override
**Deleted:** `~/.local/share/applications/BambuStudio.desktop`
(Was a workaround, no longer needed)

## After Restart - Testing Checklist

### Apps to Test:
- [ ] **BambuStudio** - Should have normal-sized fonts now
- [ ] **Dolphin** (Qt) - Should still look good
- [ ] **Kitty/terminal** - Check font sizes
- [ ] **Firefox/Browser** - Check UI scaling
- [ ] **Any other GTK apps** you use regularly

### Expected Behavior:
- Everything should be properly scaled at 2x
- Wayland apps inherit compositor scale automatically
- XWayland apps get proper DPI info
- No more per-app scaling inconsistencies

### If Things Look Wrong:

#### Too Large Overall:
Try `monitor=,preferred,auto,1.5` in hyprland.conf

#### Too Small Overall:
Revert to `monitor=,preferred,auto,2` (current setting)

#### Specific Apps Still Wrong:
You can add small per-app tweaks, but avoid the 2x multipliers we removed.

#### Qt Apps Look Wrong:
Try uncommenting in uwsm/env:
```bash
export QT_SCALE_FACTOR=1.1  # or 0.9
```

#### GTK Apps Look Wrong:
Try adjusting in uwsm/env:
```bash
export GDK_DPI_SCALE=1.1  # or 0.9
```

## How to Restart UWSM Session

```bash
# Option 1: Logout and login
hyprctl dispatch exit

# Option 2: Restart compositor
uwsm stop
uwsm start hyprland

# Option 3: Full system restart (safest)
reboot
```

## Current Monitor Info
- Display: Samsung U32E850 (32" 4K)
- Resolution: 3840x2160 @ 60Hz
- Current Scale: 2.00
- Connection: HDMI-A-1

## Theory Behind This Fix

**Old Approach (Fragile):**
- Hyprland at 1x scale → apps see full 4K pixels
- Each toolkit manually scales: GTK at 2x, Qt at 1.2x
- Inconsistent results, breaks some apps

**New Approach (Proper Wayland):**
- Hyprland at 2x scale → apps see "1920x1080 logical pixels"
- Apps render at native resolution automatically
- Compositor handles scaling uniformly
- Works like macOS Retina displays

## Files Modified (Dotfiles to Commit)
1. `dotfiles/hyprland/.config/hypr/hyprland.conf`
2. `dotfiles/uwsm/.config/uwsm/env`

## Commands to Stow Changes After Testing
```bash
cd ~/carbs
# If everything looks good after restart:
git add dotfiles/hyprland/.config/hypr/hyprland.conf
git add dotfiles/uwsm/.config/uwsm/env
git commit -m "Fix HiDPI scaling: use compositor scale instead of per-toolkit env vars"
```

---

**Session can be resumed with:** "I restarted my uwsm session after the scaling changes, here's what I'm seeing..."
