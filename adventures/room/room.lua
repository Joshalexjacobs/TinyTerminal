-- room.lua

require "adventures/room/box"

local adventure = {
  name = "Room", -- name of our adventure
  state = "enter", -- determines which function to call (unused rn)
  enter = nil, -- our load function
  update = nil, -- update function
  draw = nil, -- draw function
  input = nil, -- input function
  changeState = nil, -- change current state function
  timers = {} -- adventure timers
}

local assets = { -- a list of paths for our assets
  employeeID = "adventures/room/img/employeeID.png",
}

local boxTally = 0

adventure.enter = function(adventure)
  addTimer(3.0, "pause", adventure.timers) -- add a timer that blocks user input
  setLineMax(3) -- set our line max to 3, make room for images/graphics

  -- set up scenario:
  addLine("Loading Adventure: '" .. adventure.name .. "'. . .", 1.0)
  addLine(adventure.name .. " Loaded!", 2.0)

  pauseLines() -- and all future lines

  addLine("Your daily duties include:")
  addLine("Logging all incoming packages to your Portable Receiving Unit.")
  addLine("Shipping labels will contain the following:")
  addLine("1. Delivery ID Number")
  addLine("2. Corporation")
  addLine("3. Weight (lbs)")
  addLine("", 0.0, true, false, {true, "boxGen"}) -- if you need to clear the screen on user input

  -- load images:
  assets.employeeID = love.graphics.newImage(assets.employeeID)
end

adventure.update = function(dt, adventure)
  updateTimer(dt, "pause", adventure.timers) -- update pause timer

  if adventure.state == "boxGen" then
    addBox()
    boxTally = boxTally + 1
    adventure.state = "box" .. tostring(boxTally)
  end
end

adventure.draw = function(adventure)
  -- draws a box that shows our draw range
  --love.graphics.setColor({255, 255, 255, 100})
  --love.graphics.rectangle("line", -1, 90, love.graphics.getWidth() + 2, 245)

  if adventure.state == "enter" then
    love.graphics.setColor({255, 255, 255, 255})
    love.graphics.setFont(bigTerminalFont)
    love.graphics.printf("WELCOME", 0, 100, love.graphics.getWidth(), "center")
  end

  -- employee ID
  if adventure.state == "enter" then
    love.graphics.draw(assets.employeeID, 110, 150)
  end

  love.graphics.setFont(terminalFont)

  -- draw a box
  if adventure.state == "box" .. tostring(boxTally) then
    drawBox(boxTally)
  end
end

adventure.input = function(adventure, input)
  if isTimerDone("pause", adventure.timers) and adventure.state ~= "box" .. tostring(boxTally) then
    unpauseLines() -- this'll work for now
  elseif adventure.state == "box" .. tostring(boxTally) then -- might need more on this if..
    checkBox(boxTally, input)
  end
end

adventure.changeState = function(newState) -- takes 1 string
  adventure.state = newState
end

return adventure

--[[

1) there's going to be a ton of text to output, i should consider storing that in a seperate file somewhere and store that
somewhere inside our adventure (should figure out a good file type, def not .txt and maybe avoid .lua).

local event = { -- contains all info needed for the play to experience an event box
  -- functions, possible commands, results, etc...
}

--]]
