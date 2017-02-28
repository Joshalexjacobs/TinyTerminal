--events.lua

local events = {
  require "adventures/box_factory/events/noLabel",
}

local isActive = false
local curEvent = 1

function loadRoomEvents()
  events[curEvent].load()
end

function activateEvent(bool)
  isActive = bool
end

function getCurEvent()
  return events[curEvent]
end

function passEventInput(input)
  if isActive then
    events[curEvent].input = input
    events[curEvent].newInput = true
  end
end

function updateBoxFactEvents(dt)
  if isActive then
    events[curEvent].update(dt, events[curEvent])
  end
end

function drawRoomEvents() -- might not even need this tbh
  if isActive then
    events[curEvent].draw(events[curEvent])
  end
end
