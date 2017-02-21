--events.lua

local events = {
  require "adventures/room/events/noLabel",
  require "adventures/room/events/event1"
}

local isActive = false
local curEvent = 1

function loadRoomEvents(n)
  print(n)
end

function activateEvent(bool)
  isActive = bool
end

function updateRoomEvents(dt)
  if isActive then
    events[curEvent].update(dt, events[curEvent])
  end
end

function drawRoomEvents() -- might not even need this tbh
  if isActive then
    events[curEvent].draw(events[curEvent])
  end
end
