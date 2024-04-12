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
}

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

return config
