-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "AdventureTime"
config.color_scheme = "Tokyo Night Storm"

-- Font
config.font = wezterm.font "Maple Mono NF"

local act = wezterm.action
-- Note that the leader `CTRL+a` overwrites the same keymap for increasing a number in Neovim
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = "_",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "F9",
    mods = "CTRL",
    action = act.ShowTabNavigator,
  },
  {
    key = "[",
    mods = "CTRL",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "]",
    mods = "CTRL",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Left", 5 },
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Down", 5 },
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Up", 5 },
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize { "Right", 5 },
  },
  {
    key = "h",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = "j",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Up",
  },
  { -- foo bar
    key = "l",
    mods = "CTRL",
    action = act.ActivatePaneDirection "Right",
  },
  -- create new tab
  {
    key = "t",
    mods = "CTRL",
    action = act.SpawnTab "CurrentPaneDomain",
  },
}

-- and finally, return the configuration to wezterm
return config
