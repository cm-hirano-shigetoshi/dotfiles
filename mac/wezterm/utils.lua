local wezterm = require 'wezterm'


wezterm.on("invoke-clipboard-history", function(window, pane)
    window:perform_action(wezterm.action.SpawnCommandInNewTab {
        args = {
            'bash',
            '-c',
            os.getenv("HOME") .. '/.local/share/zinit/plugins/cm-hirano-shigetoshi---clipboard-history/main/wezterm.sh ' .. pane:pane_id()
        },
    }, pane)
end)

wezterm.on("invoke-snippet", function(window, pane)
    window:perform_action(wezterm.action.SpawnCommandInNewTab {
        args = {
            'bash',
            '-c',
            os.getenv("HOME") .. '/.local/share/zinit/plugins/cm-hirano-shigetoshi---snippet/main/wezterm.sh ' .. pane:pane_id()
        },
    }, pane)
end)

wezterm.on("invoke-clipboard-editor", function(window, pane)
    window:perform_action(wezterm.action.SpawnCommandInNewTab {
        args = {
            'bash',
            '-c',
            os.getenv("HOME") .. '/.local/share/zinit/plugins/cm-hirano-shigetoshi---clipboard-history/main/wezterm_edit.sh ' .. pane:pane_id()
        },
    }, pane)
end)

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

function getRandomFilePath(directory)
    local files = {}

    -- ディレクトリの内容を取得
    local p = io.popen('ls "' .. directory .. '"')
    for file in p:lines() do
        table.insert(files, directory .. "/" .. file)
    end
    p:close()

    if #files == 0 then
        return '' -- ディレクトリが空だった場合にnilを返す
    end

    -- ランダム選択
    math.randomseed(os.time())
    local randomIndex = math.random(#files)

    return files[randomIndex]
end
