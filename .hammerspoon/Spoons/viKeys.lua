local module = {}

module.debugging = false -- whether to print status updates

local eventtap  = require "hs.eventtap"
local event     = eventtap.event
local inspect   = require "hs.inspect"
local watchable = require "hs.watchable"


local keyHandler = function(e)
    local watchFor = { h = "left", j = "down", k = "up", l = "right" }
    local actualKey = e:getCharacters(true)
    local replacement = watchFor[actualKey:lower()]
    if replacement then
        local isDown = e:getType() == event.types.keyDown
        local flags  = {}
        for k, v in pairs(e:getFlags()) do
            if v and k ~= "ctrl" then -- ctrl will be down because that's our "wrapper", so ignore it
                table.insert(flags, k)
            end
        end
        if module.debugging then print("viKeys: " .. replacement, inspect(flags), isDown) end
        local replacementEvent = event.newKeyEvent(flags, replacement, isDown)
        if isDown then
            -- allow for auto-repeat
            replacementEvent:setProperty(event.properties.keyboardEventAutorepeat, e:getProperty(event.properties.keyboardEventAutorepeat))
        end
        return true, { replacementEvent }
    else
        return false -- do nothing to the event, just pass it along
    end
end

local modifierHandler = function(e)
    local flags = e:getFlags()
    local onlyCTRLPressed = false
    for k, v in pairs(flags) do
        onlyCTRLPressed = v and k == "ctrl"
        if not onlyCTRLPressed then break end
    end
    -- you must tap and hold ctrl by itself to turn this on
    if onlyCTRLPressed and not module.keyListener then
        if module.debugging then print("viKeys: keyhandler on") end
        module.keyListener = eventtap.new({ event.types.keyDown, event.types.keyUp }, keyHandler):start()
    -- however, adding additional modifiers afterwards is ok... its only when ctrl isn't down that we switch back off
    elseif not flags.ctrl and module.keyListener then
        if module.debugging then print("viKeys: keyhandler off") end
        module.keyListener:stop()
        module.keyListener = nil
    end
    return false
end

module.watchables = watchable.new("viKeys", true)

module.modifierListener = eventtap.new({ event.types.flagsChanged }, modifierHandler)

module.start = function()
    module.watchables.enabled = true
    module.modifierListener:start()
end

module.stop = function()
    if module.keyListener then
        module.keyListener:stop()
        module.keyListener = nil
    end
    module.modifierListener:stop()
    module.watchables.enabled = false
end

module.toggle = function()
    if module.watchable.enabled then
        module.stop()
    else
        module.start()
    end
end

module.watchExternalToggle = watchable.watch("viKeys.enabled", function(w, p, k, o, n)
    if not o and n then
        module.start()
    elseif o and not n then
        module.stop()
    end
end)

module.start() -- autostart

return module
