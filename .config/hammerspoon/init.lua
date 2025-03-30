-- Source:https://github.com/tekezo/Karabiner/issues/814#issuecomment-415388742

-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local backMouseButton = 3
local forwardMouseButton = 4
local deferred = false

function setOverrides(e)
    overrideOtherMouseDown:stop()
    overrideOtherMouseUp:stop()
    hs.eventtap.otherClick(e:location(), 0, pressedMouseButton)
    overrideOtherMouseDown:start()
    overrideOtherMouseUp:start()
end

overrideOtherMouseDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    -- print("down")
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if backMouseButton == pressedMouseButton or forwardMouseButton == pressedMouseButton then
        deferred = true
        return true
    end
end)

overrideOtherMouseUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    -- print("up")
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if backMouseButton == pressedMouseButton then
        if deferred then
            setOverrides(e)
            --hs.eventtap.middleClick(e:location(), 0)
            return true
        end
        return false
    end

    if forwardMouseButton == pressedMouseButton then
        if deferred then
            setOverrides(e)
            hs.eventtap.keyStroke({ 'cmd' }, '[')
            return true
        end
        return false
    end
    return false
end)

local oldmousepos = {}
local scrollmult = -4 -- negative multiplier makes mouse work like traditional scrollwheel

dragOtherToScroll = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    -- print ("pressed mouse " .. pressedMouseButton)
    if backMouseButton == pressedMouseButton or forwardMouseButton == pressedMouseButton then
        -- print("scroll");
        deferred = false
        oldmousepos = hs.mouse.absolutePosition()
        local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
        local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
        local scroll = hs.eventtap.event.newScrollEvent({ dx * scrollmult, dy * scrollmult }, {}, 'pixel')
        -- put the mouse back
        hs.mouse.absolutePosition(oldmousepos)
        return true, { scroll }
    else
        return false, {}
    end
end)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()
