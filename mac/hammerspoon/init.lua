require 'functions'


hs.hotkey.bind({ "ctrl", "command" }, "m", function()
    local n = 1
    for _ = 1, n, 1 do
        LeftDoubleClick();
        hs.timer.usleep(100000)
        hs.eventtap.keyStroke({}, "f");
        hs.timer.usleep(100000)
        hs.eventtap.keyStroke({}, "l");
        hs.timer.usleep(100000)
    end
end)


hs.hotkey.bind({ "ctrl", "command" }, "c", function()
    hs.application.launchOrFocus("wezterm")
    hs.eventtap.keyStroke({ "cmd", "ctrl", "shift" }, "1")
end)

hs.hotkey.bind({ "ctrl", "command" }, "g", function()
    hs.application.launchOrFocus("wezterm")
    hs.eventtap.keyStroke({ "cmd", "ctrl", "shift" }, "2")
end)

hs.hotkey.bind({ "ctrl", "command" }, "v", function()
    hs.application.launchOrFocus("wezterm")
    hs.eventtap.keyStroke({ "cmd", "ctrl", "shift" }, "3")
end)


-- アプリのフォーカス
FocusApp({ "ctrl", "command" }, "a", "google chrome")
FocusApp({ "ctrl", "command" }, "s", "slack")
FocusApp({ "ctrl", "command" }, "w", "obsidian")
FocusApp({ "ctrl", "command" }, "e", "microsoft edge")
FocusApp({ "ctrl", "command" }, "z", "oreno-todo-app")



-- 以下、自動リロードの設定
function ReloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", ReloadConfig):start()
hs.alert.show("Config loaded")
