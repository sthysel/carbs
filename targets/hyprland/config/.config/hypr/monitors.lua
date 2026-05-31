-- Auto-scaling monitor configuration.
--
-- Hyprland's native `scale = "auto"` is too conservative (it picks 1.0 on a 32"
-- 4K panel, leaving everything tiny). Since the Lua config is a real program we
-- instead read each connected output's EDID from sysfs at parse time, derive the
-- panel's true DPI from its physical size + preferred resolution, and choose a
-- scale from that. No machine-specific override file is needed.
--
-- A monitor can still be overridden by hand in local.lua, which hyprland.lua
-- loads last (last matching rule for an output wins).

local DRM = "/sys/class/drm"

-- Snap to quarter steps and clamp to [1.0, 2.0]. Quarter scales keep clean,
-- integer-ish framebuffers on common panels (e.g. 3840 / 1.5 = 2560).
local function dpi_to_scale(dpi)
	local s = math.floor((dpi / 96) * 4 + 0.5) / 4
	if s < 1 then return 1 end
	if s > 2 then return 2 end
	return s
end

-- Preferred WxH (px) and physical size (mm) for a DRM output dir, or nil.
local function read_output(dir)
	local mf = io.open(dir .. "/modes", "r")
	if not mf then return nil end
	local first = mf:read("*l")
	mf:close()
	if not first then return nil end
	local w, h = first:match("^(%d+)x(%d+)")
	w, h = tonumber(w), tonumber(h)
	if not w then return nil end

	local hmm, vmm = 0, 0
	local ef = io.open(dir .. "/edid", "rb")
	if ef then
		local e = ef:read("*a")
		ef:close()
		if e and #e >= 68 then
			local function byte(i) return e:byte(i + 1) end -- 0-based EDID offset
			-- Detailed Timing Descriptor #1 image size (mm); high bits in byte 68.
			hmm = byte(66) + math.floor(byte(68) / 16) * 256
			vmm = byte(67) + (byte(68) % 16) * 256
			if hmm == 0 or vmm == 0 then -- coarse cm fields as a fallback
				hmm, vmm = byte(21) * 10, byte(22) * 10
			end
		end
	end
	return w, h, hmm, vmm
end

-- "card1-HDMI-A-1" -> "HDMI-A-1" (the name Hyprland uses for the output).
local function connector_name(entry)
	return entry:match("^card%d+%-(.+)$")
end

local function apply()
	local p = io.popen('ls -1 "' .. DRM .. '" 2>/dev/null')
	if not p then return 0 end
	local applied = 0
	for entry in p:lines() do
		local dir = DRM .. "/" .. entry
		local sf = io.open(dir .. "/status", "r")
		if sf then
			local status = sf:read("*l")
			sf:close()
			local name = connector_name(entry)
			if status == "connected" and name then
				local w, h, hmm, vmm = read_output(dir)
				local scale = 1
				if w and hmm > 0 and vmm > 0 then
					local dpi = ((w / (hmm / 25.4)) + (h / (vmm / 25.4))) / 2
					scale = dpi_to_scale(dpi)
				end
				hl.monitor({
					output = name,
					mode = "preferred",
					position = "auto",
					scale = scale,
				})
				applied = applied + 1
			end
		end
	end
	p:close()
	return applied
end

-- Catch-all first (least specific) so any unknown/hotplugged output still comes
-- up; named per-output rules emitted by apply() override it for known panels.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

pcall(apply)
