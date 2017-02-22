-- noLabel.lua

-- player opens box -> bomb is found inside with 4 different wires
-- blue (counts upwards instead of down)
-- red (stops)
-- yellow (speed up)
-- green (slows down)

-- once the blue or red wires are cut, the play can return the bomb to the package and continue to the next one

-- if the player does not cut the wire in time...

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
