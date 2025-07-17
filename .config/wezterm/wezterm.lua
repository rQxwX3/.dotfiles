-- Get the wezterm API
local wezterm = require("wezterm")

-- This will hold the multiplexer
local mux = wezterm.mux

-- This will hold the configuration
local config = wezterm.config_builder()

-- Set styling options
config.font = wezterm.font("CommitMono Nerd Font")
config.font_size = 18

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.color_scheme = "tokyonight_night"

config.colors = {
	foreground = "rgb(209 218 242)",
}

config.window_background_opacity = 1.0
config.macos_window_background_blur = 30
config.audible_bell = "Disabled"

-- Same as "reasonable size" in Raycast Rectangle Ext
config.initial_rows = 27
config.initial_cols = 80

-- Automatically position the window to the center of the screen
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()

	window:gui_window():set_position(610, 460) --(for size 20 font)
end)

return config
