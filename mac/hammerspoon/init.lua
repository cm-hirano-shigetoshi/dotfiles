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
FocusApp({ "ctrl", "command" }, "x", "Ghostty")


-- Ghostty
-- ペインを閉じる
RemapKeys({ { app = "Ghostty", from = { mods = { "cmd" }, key = "w", }, to = { mods = { "cmd", "ctrl" }, key = "/", } } })
-- 新規タブ
RemapKeys({ { app = "Ghostty", from = { mods = { "cmd" }, key = "t", }, to = { mods = { "cmd", "ctrl" }, key = ";", } } })
-- タブ切り替え
RemapKeys({ { app = "Ghostty", from = { mods = { "ctrl" }, key = "tab", }, to = { mods = { "cmd", "ctrl" }, key = "]", } } })
RemapKeys({ { app = "Ghostty", from = { mods = { "ctrl", "shift" }, key = "tab", }, to = { mods = { "cmd", "ctrl" }, key = "[", } } })


-- マウスポインタを次のディスプレイへ移動
MoveMouseToNextScreen({ "alt" }, "5")

-- Cmd + Shift + M でマウスをアクティブウィンドウの中央に移動
hs.hotkey.bind({ "alt" }, "6", function()
    local win = hs.window.focusedWindow()
    if win then
        local frame = win:frame()
        hs.mouse.absolutePosition({
            x = frame.x + frame.w / 2,
            y = frame.y + frame.h / 2
        })
    end
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
