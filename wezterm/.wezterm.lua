local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- Main appearance
config.font_size = 16
config.font = wezterm.font 'JetBrains Mono NL'
config.color_scheme = 'Tokyo Night Moon'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 20,
  bottom = 0,
}

-- Keybinds (note that SUPER == CMD == WIN keys)
config.keys = {
  {
    key = 'r',
    mods = 'SUPER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

return config

