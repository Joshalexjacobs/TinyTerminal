-- noLabel.lua

local thisEvent = {
  name = "noLabel",
  load = nil,
  update = nil,
  draw = nil,
  timers = {},
  sprite = "adventures/room/img/boxes/box_noLabel.png"
}

thisEvent.load = function()
  
end

thisEvent.update = function(dt, event)
  if checkTimer("start", event.timers) == false then
    addTimer(0.0, "start", event.timers)
    addBox(event.sprite)
  end
end

thisEvent.draw = function(event)
  love.graphics.printf(event.name, 0, 0, 100)
end

return thisEvent
