-- noLabel.lua

-- player opens box -> bomb is found inside with 4 different wires
-- blue (counts upwards instead of down)
-- red (stops)
-- yellow (speed up)
-- green (slows down)

-- once the blue or red wires are cut, the play can return the bomb to the package and continue to the next one

-- if the player does not cut the wire in time...

local commands = require "commands/noLabel/noLabelCmds"

local thisEvent = {
  name = "noLabel",
  desc = "",
  state = "close",
  load = nil,
  update = nil,
  draw = nil,
  timers = {},
  sprite = "adventures/box_factory/img/boxes/box_noLabel.png",
  input = nil,
  newInput = false,
  checkInput = nil,
  getState = nil
}

thisEvent.load = function()
  --addEntity(0, 0, "noLabelEntity")
  addEntity(250, 150, "bomb", true)
end

thisEvent.checkInput = function(event)
  for _, command in ipairs(commands) do
    if command.name == event.input:lower() then
      command.call(event)
      return
    else
      for i = 1, #command.alias do
        if command.alias[i] == event.input:lower() then
          command.call(event)
          return
        end
      end
    end
  end

  addLine("I don't think I can do that.")
end

thisEvent.getState = function() return thisEvent.state end

thisEvent.update = function(dt, event)
  if checkTimer("start", event.timers) == false then
    addTimer(0.0, "start", event.timers)
    addBox(event.sprite)
    addLine("Enter 1 word commands to interact.")
    event.desc = "This box doesn't appear to have a label."
  end

  if event.newInput then
    event.checkInput(event)
    event.newInput = false
  end
end

thisEvent.draw = function(event)
  love.graphics.printf(event.name, 0, 0, 100)
end

return thisEvent
