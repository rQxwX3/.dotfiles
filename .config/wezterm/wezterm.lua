local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("CommitMono Nerd Font")
config.font_size = 25

config.enable_tab_bar = false

config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"

config.color_scheme = "tokyonight_night"

config.colors = {
	foreground = "rgb(209 218 242)",
}

config.audible_bell = "Disabled"

return config
