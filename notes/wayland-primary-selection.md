# Wayland PRIMARY Selection Fix

**Date:** 2026-01-26
**Issue:** Highlight-to-copy and middle-click-to-paste not working between Emacs and Kitty (or other apps)

## Background

In X11, there are two clipboard mechanisms:
- **CLIPBOARD**: Explicit copy/paste (Ctrl+C/Ctrl+V)
- **PRIMARY**: Implicit selection - highlighting text copies it, middle-click pastes it

This "highlight and middle-click" workflow has been standard Unix behavior for decades. On Wayland, PRIMARY selection exists but requires explicit support from both applications and the compositor.

## Root Cause

1. **Emacs** wasn't configured to use PRIMARY selection on Wayland
2. **Hyprland** was only persisting CLIPBOARD, not PRIMARY selection

When the source application closes on Wayland, selections are lost unless a clipboard manager persists them. `wl-clip-persist` was only running for regular clipboard.

## Solution

### 1. Emacs/Spacemacs Configuration

**File:** `targets/spacemacs/config/.config/spacemacs/init.el`

Added to `dotspacemacs/user-config`:
```elisp
;; Wayland clipboard: enable PRIMARY selection (highlight-to-copy, middle-click-to-paste)
(setq select-enable-primary t)
(setq select-enable-clipboard t)
;; Selecting text copies to PRIMARY immediately (like X11)
(setq select-active-regions t)
```

### 2. Hyprland PRIMARY Persistence

**File:** `targets/hyprland/config/.config/hypr/hyprland.conf`

Added alongside existing clipboard persistence:
```bash
exec-once = uwsm app -- wl-clip-persist --clipboard primary
```

### 3. Neovim Configuration

**File:** `targets/nvim/config/.config/nvim/lua/config/options.lua`

Changed from `unnamedplus` only to both registers:
```lua
-- Enable both clipboard registers:
-- unnamedplus = CLIPBOARD (Ctrl+C/V, "+)
-- unnamed = PRIMARY (highlight/middle-click, "*)
-- Yanks go to both; mouse selection in Kitty uses PRIMARY directly
vim.opt.clipboard = "unnamed,unnamedplus"
```

Note: When running nvim in Kitty, mouse selections are handled by Kitty directly (goes to PRIMARY). Vim visual mode with keyboard is different - yanking (`y`) now copies to both PRIMARY and CLIPBOARD.

### 4. Kitty (Already Configured)

Kitty was already set up correctly in `targets/kitty/config/.config/kitty/kitty.conf`:
```
copy_on_select yes
mouse_map middle release ungrabbed paste_from_selection
clipboard_control write-clipboard read-clipboard write-primary read-primary
```

## How It Works Now

1. **Highlight text** in any app → copied to PRIMARY selection
2. **wl-clip-persist** keeps PRIMARY alive even if source app closes
3. **Middle-click** in any app → pastes from PRIMARY

## Deployment

```bash
caifs add -d targets -f spacemacs
caifs add -d targets -f nvim
caifs add -d targets -f hyprland
# Or restart Hyprland session
```

## Testing

1. Highlight text in Emacs
2. Middle-click in Kitty → should paste
3. Highlight text in Kitty
4. Middle-click in Emacs → should paste
5. Mouse-select text in nvim (via Kitty) → middle-click elsewhere → should paste
6. Yank text in nvim (`y`) → middle-click elsewhere → should paste
7. Highlight text elsewhere → middle-click in nvim → should paste
8. Close the source app, middle-click elsewhere → should still paste (persistence working)

## Related Tools

- `wl-clipboard` - Wayland clipboard utilities (wl-copy, wl-paste)
- `wl-clip-persist` - Keeps clipboard/primary alive after source closes
- `cliphist` - Clipboard history manager (only for CLIPBOARD, not PRIMARY)
