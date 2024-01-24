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

config.color_scheme = "Gruvbox light, soft (base16)"
config.default_cwd = "/Users/steevesm/"
config.font = wezterm.font 'Inconsolata Nerd Font Mono'
config.font_size = 15.25
config.initial_rows = 45
config.initial_cols = 120
config.window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  }

return config


