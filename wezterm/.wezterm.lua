local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Main appearance
config.font_size = 16
config.font = wezterm.font 'JetBrains Mono NL'
config.color_scheme = 'Tokyo Night Moon'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 1
config.inactive_pane_hsb = {
  brightness = 0.5,
}
config.window_padding = {
  left = 2,
  right = 2,
  top = 20,
  bottom = 0,
}

-- Default modifier key for keybinds
local mod_key = 'ALT'

-- MacOS specific settings
if wezterm.target_triple:find("apple%-darwin") then
  mod_key = 'CMD'
end

-- Windows specific settings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 12
  config.default_prog = { "wsl.exe" }
end

-- Keybinds
local keys = {
  {
    key = 'r',
    mods = mod_key,
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }
  },
  {
    key = "n",
    mods = mod_key,
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "=",
    mods = mod_key,
    action = act.SplitPane { direction = "Right" },
  },
  {
    key = "-",
    mods = mod_key,
    action = act.SplitPane { direction = "Down" },
  },
  {
    key = "h",
    mods = mod_key,
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = mod_key,
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = mod_key,
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = mod_key,
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = 'h',
    mods = mod_key .. "|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = 'l',
    mods = mod_key .. "|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = "q",
    mods = mod_key,
    action = act.CloseCurrentPane { confirm = false },
  },
  {
    key = 'z',
    mods = mod_key,
    action = wezterm.action.TogglePaneZoomState,
  },
}

for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = mod_key,
    action = act.ActivateTab(i - 1),
  })
end

config.keys = keys
return config
