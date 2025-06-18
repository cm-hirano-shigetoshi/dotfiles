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

config.initial_cols = 80;
config.initial_rows = 24;

--
-- フォント
--
config.font = wezterm.font_with_fallback({ "Moralerspace Neon NF" })
config.font_size = 16.0
config.color_scheme = 'Abernathy'

config.inactive_pane_hsb = {
    saturation = 0.6,
    brightness = 0.6,
}

config.window_background_image = ''
if config.window_background_image == '' then
    config.window_background_opacity = 0.80
    config.text_background_opacity = 0.5
else
    config.window_background_image_hsb = {
        brightness = 0.1
    }
    config.window_background_opacity = 1
    config.text_background_opacity = 0.8
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
        key = 'r',
        mods = 'CMD|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
    {
        key = "w",
        mods = "CMD",
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = "w",
        mods = "CMD|SHIFT",
        action = wezterm.action.CloseCurrentTab { confirm = true },
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
        action = wezterm.action.AdjustPaneSize { 'Down', 1 },
    },
    {
        key = 'k',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Up', 1 },
    },
    {
        key = 'l',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.AdjustPaneSize { 'Right', 2 },
    },
    {
        key = 'Z',
        mods = 'CMD|CTRL|SHIFT',
        action = wezterm.action.TogglePaneZoomState,
    },
    {
        key = "n",
        mods = "CMD|SHIFT",
        action = wezterm.action_callback(function(_, pane)
            pane:move_to_new_window()
        end),
    },
    {
        key = "t",
        mods = "CMD|SHIFT",
        action = wezterm.action_callback(function(_, pane)
            local tab, _ = pane:move_to_new_tab()
            tab:activate()
        end),
    },
    {
        key = "UpArrow",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "decrease-opacity" },
    },
    {
        key = "DownArrow",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "increase-opacity" },
    },
    {
        -- Hammerspoonのホットキーから呼ばれる前提なので使いづらいキーバインド
        key = "!",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "invoke-clipboard-history" },
    },
    {
        -- Hammerspoonのホットキーから呼ばれる前提なので使いづらいキーバインド
        key = '"',
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "invoke-snippet" },
    },
    {
        -- Hammerspoonのホットキーから呼ばれる前提なので使いづらいキーバインド
        key = "#",
        mods = "CMD|CTRL|SHIFT",
        action = wezterm.action { EmitEvent = "invoke-clipboard-editor" },
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
