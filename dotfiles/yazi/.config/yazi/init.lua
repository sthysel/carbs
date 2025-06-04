require("bunny"):setup({
	hops = {
		{ key = "/", path = "/" },
		{ key = "t", path = "/tmp" },
		{ key = "~", path = "~", desc = "Home" },
		{ key = "m", path = "~/Music", desc = "Music" },
		{ key = "c", path = "~/.config", desc = "Config files" },
		{ key = { "l", "b" }, path = "~/.local/bin", desc = "Local bin" },
		{ key = { "b" }, path = "/run/media/thys/crochet/beets/music", desc = "beets processing" },
		-- key and path attributes are required, desc is optional
	},
	desc_strategy = "path", -- If desc isn't present, use "path" or "filename", default is "path"
	ephemeral = true, -- Enable ephemeral hops, default is true
	tabs = true, -- Enable tab hops, default is true
	notify = false, -- Notify after hopping, default is false
	fuzzy_cmd = "fzf", -- Fuzzy searching command, default is "fzf"
})
