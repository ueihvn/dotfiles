local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

-- color scheme
config.color_scheme = "One Half Black (Gogh)"
-- font
config.font = wezterm.font("FiraCode Nerd Font Mono", {
	weight = "Regular",
	stretch = "Normal",
	style = "Normal",
})

config.font_size = 13.0

-- tab bar
config.enable_tab_bar = false

-- window setting
config.window_background_opacity = 0.75
config.macos_window_background_blur = 30

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

config.keys = {
	{
		key = "UpArrow",
		mods = "SHIFT",
		action = act.ScrollByLine(-2),
	},
	{
		key = "DownArrow",
		mods = "SHIFT",
		action = act.ScrollByLine(2),
	},
}

return config
