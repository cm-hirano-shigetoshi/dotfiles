function LeftDoubleClick()
    local mp = hs.mouse.absolutePosition()
    local point = { x = mp["x"], y = mp["y"] }
    local clickState = hs.eventtap.event.properties.mouseEventClickState
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseDown"], point):setProperty(clickState, 1):post()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseUp"], point):setProperty(clickState, 1):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseDown"], point):setProperty(clickState, 2):post()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseUp"], point):setProperty(clickState, 2):post()
end

function FocusApp(modifier, key, app_str)
    hs.hotkey.bind(modifier, key, function()
        hs.application.launchOrFocus(app_str)
    end)
end

-- 特定アプリが前面のときだけ、あるホットキーを別のホットキーへ変換する
-- rules = { { app = "Google Chrome", from = { mods = {...}, key = "j" }, to = { mods = {...}, key = "p" } }, ... }
local RemapModifierNames = { "cmd", "ctrl", "alt", "shift" }

local function HasSameModifiers(actual, expected)
    for _, modifier in ipairs(RemapModifierNames) do
        local shouldBePressed = false

        for _, expectedModifier in ipairs(expected) do
            if expectedModifier == modifier then
                shouldBePressed = true
                break
            end
        end

        if (actual[modifier] or false) ~= shouldBePressed then
            return false
        end
    end

    return true
end

local function IsTargetApp(appName)
    local app = hs.application.frontmostApplication()
    if app == nil then
        return false
    end

    -- FocusApp と同じく大文字小文字を気にせず書けるようにする
    return string.lower(app:name() or "") == string.lower(appName)
end

-- true にすると変換の判定結果が Hammerspoon Console に出る
RemapDebug = false

function RemapKeys(rules)
    local remappedKeys = {}

    local tap = hs.eventtap.new(
        {
            hs.eventtap.event.types.keyDown,
            hs.eventtap.event.types.keyUp,
        },
        function(event)
            local eventType = event:getType()
            local keyCode = event:getKeyCode()

            -- 変換したキーの keyUp もアプリへ渡さない
            if eventType == hs.eventtap.event.types.keyUp and remappedKeys[keyCode] then
                remappedKeys[keyCode] = nil
                return true
            end

            if eventType ~= hs.eventtap.event.types.keyDown then
                return false
            end

            local flags = event:getFlags()

            for _, rule in ipairs(rules) do
                local fromKeyCode = hs.keycodes.map[rule.from.key]

                if keyCode == fromKeyCode then
                    local modsMatched = HasSameModifiers(flags, rule.from.mods)
                    local appMatched = IsTargetApp(rule.app)

                    if RemapDebug then
                        print(string.format(
                            "[remap] key=%s mods=%s app=%s / rule=%s modsMatched=%s appMatched=%s",
                            rule.from.key,
                            hs.inspect(flags),
                            hs.application.frontmostApplication():name(),
                            rule.app,
                            tostring(modsMatched),
                            tostring(appMatched)
                        ))
                    end

                    if modsMatched and appMatched then
                        remappedKeys[keyCode] = true

                        -- 元のキーを変換後のキーそのものに差し替えて返す。
                        -- keyStroke で別途送ると、押しっぱなしの元モディファイアが
                        -- 合成イベントに混ざって別のショートカットになってしまう
                        local down = hs.eventtap.event.newKeyEvent(rule.to.mods, rule.to.key, true)
                        local up = hs.eventtap.event.newKeyEvent(rule.to.mods, rule.to.key, false)

                        return true, { down, up }
                    end
                end
            end

            -- 条件に合わないキー入力はそのまま通す
            return false
        end
    )

    tap:start()

    -- GCで eventtap が消えないよう保持する
    RemapTap = tap
end

function MoveMouseToNextScreen(modifier, key)
    hs.hotkey.bind(modifier, key, function()
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
end
