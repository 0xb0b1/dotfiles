-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Frappe"
-- config.color_scheme = "tokyonight_moon"
-- config.color_scheme = 'Oceanic-Next'

config.font = wezterm.font("GeistMono Nerd Font Propo")
-- config.font = wezterm.font("MonoLisa")
-- config.font = wezterm.font("Jetbrains Mono")
config.dpi = 96.0

config.window_background_opacity = 0.98
config.macos_window_background_blur = 90

config.font_size = 14
config.line_height = 1.5
config.font_shaper = "Harfbuzz"

config.enable_tab_bar = false

config.window_padding = {
	top = 0,
	left = 0,
	right = 0,
	bottom = 0,
}

config.keys = {
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Ctrl+1 through Ctrl+8 to switch to tabs 1-8
	{ key = "1", mods = "CTRL", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "CTRL", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "CTRL", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "CTRL", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "CTRL", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "CTRL", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "CTRL", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "CTRL", action = wezterm.action.ActivateTab(7) },

	-- Ctrl+9 to switch to the last tab
	{ key = "9", mods = "CTRL", action = wezterm.action.ActivateTab(-1) },

	-- Optional: Ctrl+Tab and Ctrl+Shift+Tab to cycle through tabs
	{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
}

-- and finally, return the configuration to wezterm
return config
