-- event1.lua -- will change the name later

local thisEvent = {
  load = nil,
  update = nil,
  draw = nil
}

thisEvent.load = function()
  --addEntity(0, 0, "creep")
end

thisEvent.update = function(dt)
  --print("event test")
end

thisEvent.draw = function()
  love.graphics.printf("testing this event lol", 0, 0, 100)
end

return thisEvent
