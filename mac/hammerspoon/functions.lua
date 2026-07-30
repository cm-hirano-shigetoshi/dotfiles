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
