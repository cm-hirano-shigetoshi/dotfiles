-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

--
-- フォント
--
config.font = wezterm.font_with_fallback({family="HackGen", weight="Regular", stretch="Normal", style="Normal"})
config.font_size = 13.0
config.window_background_opacity = 0.80
config.color_scheme = 'Dracula'

config.keys = {
    {
        key = "¥",
        action = wezterm.action.SendKey { key = '\\' },
    },
    {
        key = "¥",
        mods = "ALT",
        action = wezterm.action.SendKey { key = '¥' },
    },
    {
        key = "+",
        mods = "CMD|SHIFT",
        action = wezterm.action.IncreaseFontSize,
    },
    {
         key = "w",
         mods = "CMD",
         action = wezterm.action.CloseCurrentPane { confirm = true },
   },
   {
         key = "n",
         mods = "CMD|CTRL",
         action = wezterm.action{SplitVertical={domain="CurrentPaneDomain"}},
    },
   {
         key = "m",
         mods = "CMD|CTRL",
         action = wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}},
    },
    {
        key = 'h',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'CMD|CTRL',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
}

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

return config
