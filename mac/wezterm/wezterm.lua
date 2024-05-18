-- Pull in the wezterm API
local wezterm = require 'wezterm'

require 'utils'

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
config.font = wezterm.font_with_fallback({ "Moralerspace Neon NF" })
config.font_size = 17.0
config.color_scheme = 'Ibm 3270 (High Contrast) (Gogh)'

--config.window_background_image = '/path/to/wallpaper01.jpg'
config.window_background_image = ''
if config.window_background_image == '' then
    config.window_background_opacity = 0.80
    config.text_background_opacity = 0.5
else
    config.window_background_image_hsb = {
        brightness = 0.3
    }
    config.window_background_opacity = 1
    config.text_background_opacity = 0.3
end

config.keys = {
    {
        key = "Enter",
        mods = "ALT",
        action = wezterm.action.SendKey { key = 'Enter', mods = "ALT" },
    },
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
        key = ",",
        mods = "CTRL",
        action = wezterm.action.SendKey { key = 'b', mods = 'ALT' },
    },
    {
        key = ".",
        mods = "CTRL",
        action = wezterm.action.SendKey { key = 'f', mods = 'ALT' },
    },
    {
        key = ",",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
    },
    {
        key = ".",
        mods = "CMD|CTRL",
        action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
    },
    {
        key = "o",
        mods = "CMD|CTRL",
        action = wezterm.action.RotatePanes 'Clockwise'
    },
    {
        key = "[",
        mods = "CMD|CTRL",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "]",
        mods = "CMD|CTRL",
        action = wezterm.action.ActivateTabRelative(1),
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
    {
        key = 'h',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Left', 2 },
    },
    {
        key = 'j',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Down', 2 },
    },
    {
        key = 'k',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 2 },
    },
    {
        key = 'l',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
    {
        key = "n",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "decrease-opacity" },
    },
    {
        key = "m",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "increase-opacity" },
    },
}

config.mouse_bindings = {
    {
        event = { Down = { streak = 1, button = 'Right' } },
        mods = 'NONE',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
}

--
-- 細かい見た目
--
config.tab_bar_at_bottom = true

return config
