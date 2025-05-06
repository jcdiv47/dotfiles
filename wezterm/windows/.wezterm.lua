-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
config.color_scheme = "Tokyo Night Moon"

config.window_background_opacity = 1.0

-- Font
config.font = wezterm.font("Maple Mono NF")

local act = wezterm.action
config.leader = { key = "a", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "_", mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "F9", mods = "CTRL", action = act.ShowTabNavigator },
	{ key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },
	{ key = "h", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
	-- create new tab
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
}

-- and finally, return the configuration to wezterm
return config