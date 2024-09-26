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
