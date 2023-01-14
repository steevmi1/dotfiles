local wezterm = require 'wezterm'
return {
  font = wezterm.font('Firacode Nerd Font Mono'),
  font_size = 16.0,
  color_scheme = "Gruvbox light, hard (base16)",
  initial_rows = 45,
  initial_cols = 120,
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
}
