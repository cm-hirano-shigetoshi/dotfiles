require 'functions'


-- KarabinerでChoiClipに絞って平易なキーバインドにしている
hs.hotkey.bind({ "command", "option", "shift" }, "return", function()
    hs.eventtap.keyStroke({}, "escape")
    hs.timer.usleep(5000)
    hs.eventtap.keyStroke({ "cmd" }, "v")
end)

hs.hotkey.bind({ "command", "option", "shift", "ctrl" }, "return", function()
    hs.eventtap.keyStroke({}, "escape")
    hs.eventtap.keyStroke({ "cmd" }, "v")
    hs.eventtap.keyStroke({ "cmd" }, "return")
end)


hs.hotkey.bind({ "ctrl", "command" }, "c", function()
    hs.application.launchOrFocus("wezterm")
    hs.eventtap.keyStroke({ "cmd", "ctrl", "shift" }, "1")
end)

hs.hotkey.bind({ "ctrl", "command" }, "g", function()
    hs.application.launchOrFocus("wezterm")
    hs.eventtap.keyStroke({ "cmd", "ctrl", "shift" }, "2")
end)


-- アプリのフォーカス
FocusApp({ "ctrl", "command" }, "a", "google chrome")
FocusApp({ "ctrl", "command" }, "s", "slack")
FocusApp({ "ctrl", "command" }, "w", "obsidian")
FocusApp({ "ctrl", "command" }, "e", "microsoft edge")
FocusApp({ "ctrl", "command" }, "z", "OrenoTodo")
FocusApp({ "ctrl", "command" }, "d", "Logseq")
FocusApp({ "ctrl", "command" }, "r", "GoogleCalendar")
FocusApp({ "ctrl", "command" }, "v", "ChoiClip")
FocusApp({ "ctrl", "command" }, "x", "Terminal")


hs.hotkey.bind({ "alt" }, "5", function()
    local screens = hs.screen.allScreens()
    local currentPos = hs.mouse.absolutePosition()

    -- 現在のマウス位置がどのディスプレイにあるか判定
    local currentScreen = nil
    for _, screen in ipairs(screens) do
        local frame = screen:frame()
        if currentPos.x >= frame.x and currentPos.x < frame.x + frame.w and
            currentPos.y >= frame.y and currentPos.y < frame.y + frame.h then
            currentScreen = screen
            break
        end
    end

    -- currentScreenが見つからなければ終了
    if not currentScreen then
        hs.alert.show("現在のディスプレイを検出できません", 1)
        return
    end

    -- 次のディスプレイを探す
    local nextIndex = 1
    for i, screen in ipairs(screens) do
        if screen:id() == currentScreen:id() then
            nextIndex = (i % #screens) + 1
            break
        end
    end

    -- 次のディスプレイの中央に移動
    local nextScreen = screens[nextIndex]
    local nextFrame = nextScreen:frame()
    hs.mouse.absolutePosition({
        x = nextFrame.x + nextFrame.w / 2,
        y = nextFrame.y + nextFrame.h / 2
    })
end)


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
