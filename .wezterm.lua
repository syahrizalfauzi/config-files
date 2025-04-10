local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

-- Function to toggle background blur
local function toggle_background_blur(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		-- Enable blur
		overrides.window_background_opacity = 0.8
		overrides.macos_window_background_blur = 30
	else
		-- Disable blur
		overrides.window_background_opacity = nil
		overrides.macos_window_background_blur = nil
	end
	window:set_config_overrides(overrides)
end

-- Key binding to toggle background blur
config.keys = {
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(toggle_background_blur),
	},
}
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0

config.animation_fps = 120
config.cursor_blink_rate = 400

return config
