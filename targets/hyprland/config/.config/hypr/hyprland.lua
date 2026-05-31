-- Hyprland Lua configuration (0.55+).

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Per-output scale is derived from each panel's EDID/DPI at parse time; see
-- monitors.lua. local.lua (loaded last) can still override any output by hand.
require("monitors")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- SSH agent socket, exported to all Hyprland children. NOTE: verify
-- $XDG_RUNTIME_DIR gets expanded; if SSH_AUTH_SOCK ends up containing a literal
-- "$XDG_RUNTIME_DIR", switch to os.getenv() instead.
hl.env("SSH_AUTH_SOCK", "$XDG_RUNTIME_DIR/ssh-agent.socket")

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- wl-paste --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --primary --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-clip-persist --clipboard regular")
	hl.exec_cmd("uwsm app -- wl-clip-persist --clipboard primary")
	hl.exec_cmd("uwsm app -- waypaper --restore")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,

		border_size = 1,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a, -- rgba(1a1a1aee)
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Animation curves & leaves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Layouts
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
	master = {
		new_status = "master",
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		middle_click_paste = true,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "ctrl:nocaps",
		kb_rules = "",

		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},
	},
})

-- Per-device input config. See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
	name = "logitech-usb-receiver-mouse", -- exact name from `hyprctl devices`
	scroll_method = "no_scroll", -- 2fg, edge, on_button_down, no_scroll
	accel_profile = "adaptive", -- adaptive, flat, or custom
	sensitivity = 0.0, -- -1.0 to 1.0
	scroll_factor = 1.0,
})

-- XWayland
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

-- Scratchpad: float windows and center them
hl.workspace_rule({ workspace = "special:magic", on_created_empty = "kitty" })
hl.window_rule({ match = { workspace = "special:magic" }, float = true })
hl.window_rule({ match = { workspace = "special:magic" }, size = { "(monitor_w*0.75)", "(monitor_h*0.75)" } })
hl.window_rule({ match = { workspace = "special:magic" }, center = true })

-- Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	name = "windowrule-1",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "windowrule-2",
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({
	name = "windowrule-3",
	match = { title = "udiskie$" },
	float = true,
	center = true,
})

hl.window_rule({
	name = "windowrule-4",
	match = { class = "^(.*polkit.*|.*auth.*|.*Password.*)$" },
	float = true,
})

-- Force Webex main window to be tiled
-- (Known to be ineffective vs Webex's float request; preserved from the .conf.)
hl.window_rule({
	name = "windowrule-5",
	match = { class = "^(webex)$", title = "^(Webex)$" },
	tile = true,
})

---------------
---- BINDS ----
---------------

require("binds")
-- Machine-specific overrides (optional; created by the target's post.sh hook).
-- Optional, hand-created. pcall so a missing local.lua is not fatal. Loaded
-- last so a machine-specific hl.monitor{}/etc. here overrides the defaults above.
pcall(require, "local")
