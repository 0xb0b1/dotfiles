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
-- config.color_scheme = 'Catppuccin Macchiato'
config.color_scheme = 'tokyonight_moon'
-- config.color_scheme = 'Oceanic-Next'

-- config.font = wezterm.font('ComicShannsMono Nerd Font', { weight = 'DemiBold' })
-- config.font = wezterm.font('Operator Mono Lig', { weight = 'DemiBold' })
-- config.font = wezterm.font('MonoLisa', { weight = 'DemiBold' })
config.font = wezterm.font('MonoLisa')
-- config.font = wezterm.font('PT Mono')
-- config.font = wezterm.font('SFMono Nerd Font Mono')
-- config.font = wezterm.font('Liga SFMono Nerd Font')
-- config.font = wezterm.font('The Mix iScript')
config.dpi = 96.0

config.window_background_opacity = 0.975
config.macos_window_background_blur = 90

-- config.font_size = 14
config.line_height = 1.45
config.font_shaper = "Harfbuzz"

config.enable_tab_bar = false

config.window_padding = {
  top = 20,
  left = 15,
  right = 15,
  bottom = 5
}

-- and finally, return the configuration to wezterm
return config
