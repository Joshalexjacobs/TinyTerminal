--events.lua

local events = {
  require "adventures/room/events/event1"
}

function loadRoomEvents(n)
  print(n)
end

function updateRoomEvents(dt)
  for _, newEvent in ipairs(events) do
    newEvent.update(dt)
  end
end

function drawRoomEvents() -- might not even need this tbh
  for _, newEvent in ipairs(events) do
    newEvent.draw()
  end
end
