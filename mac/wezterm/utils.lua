local wezterm = require 'wezterm'


wezterm.on("increase-opacity", function(window)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 1.0
    end
    overrides.window_background_opacity = overrides.window_background_opacity + 0.1
    if overrides.window_background_opacity > 1.0 then
        overrides.window_background_opacity = 1.0
    end
    window:set_config_overrides(overrides)
end)

wezterm.on("decrease-opacity", function(window)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
        overrides.window_background_opacity = 1.0
    end
    overrides.window_background_opacity = overrides.window_background_opacity - 0.1
    if overrides.window_background_opacity < 0.1 then
        overrides.window_background_opacity = 0.1
    end
    window:set_config_overrides(overrides)
end)
