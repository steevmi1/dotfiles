local wezterm = require 'wezterm'
return {
  font = wezterm.font('B612 Mono'),
  font_size = 13.25,
  color_scheme = "Gruvbox dark, hard (base16)",
  initial_rows = 45,
  initial_cols = 120,
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
}
