-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Catppuccin Frappe'
config.color_scheme = 'tokyonight_moon'
-- config.color_scheme = 'Oceanic-Next'

-- config.font = wezterm.font('SFMono Nerd Font Mono', { weight = 'DemiBold' })
-- config.font = wezterm.font('GeistMono Nerd Font Propo')
-- config.font = wezterm.font('JetBrainsMono Nerd Font')
-- config.font = wezterm.font('SFMono Nerd Font Mono')
config.font = wezterm.font('DankMono Nerd Font', { weight = 'Regular'})
-- config.font = wezterm.font('', { weight = 'Regular'})
config.dpi = 96.0

config.window_background_opacity = 0.987
config.macos_window_background_blur = 90

config.font_size = 14
config.line_height = 1.5
config.font_shaper = "Harfbuzz"

config.enable_tab_bar = false


config.window_padding = {
  top = 0,
  left = 0,
  right = 0,
  bottom = 0
}

-- and finally, return the configuration to wezterm
return config
