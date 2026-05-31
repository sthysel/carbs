-- Key bindings (Hyprland 0.55+ Lua). Migrated from binds.conf.
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- and https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local mainMod     = "SUPER" -- "Windows/Super" key as main modifier
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"

-- Session / system ---------------------------------------------------------
-- Exit uwsm session
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
-- Lock screen
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))
-- Reload hyprland config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Screenshot (region -> satty)
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd([[uwsm app -- grim -g "$(slurp)" - | satty -f -]]))

-- Launchers / apps ---------------------------------------------------------
-- Show system cheatsheet
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("~/.local/bin/cheatsheet.sh"))
-- Emoji picker
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("uwsm app -- ~/.local/bin/rofi-emoji.sh"))
-- Terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
-- Kill active window (force kill for Webex, normal kill otherwise)
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("~/.config/hypr/scripts/smart-kill.sh"))
-- Fullscreen active window (old: fullscreen,0)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
-- File managers
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("uwsm app -- kitty -e yazi"))
-- Toggle floating
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- Application launcher
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("uwsm app -- " .. menu))
-- Toggle pseudo tiling (dwindle)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Focus movement -----------------------------------------------------------
-- Arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))
-- Vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Swap active window with neighbor
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Workspaces ---------------------------------------------------------------
-- Switch (SUPER + [0-9]) and move window (SUPER + SHIFT + [0-9]). Key 0 -> ws 10.
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with SUPER + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with SUPER + LMB/RMB drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media / brightness keys (locked = works on lock screen, repeating = key repeat)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"),                           { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"),                           { locked = true, repeating = true })

-- Media playback (locked; requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
