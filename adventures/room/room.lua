-- room.lua

local adventure = {
  name = "Room", -- name of our adventure
  state = "enter", -- determines which function to call (unused rn)
  enter = nil, -- our load function
  update = nil, -- update function
  draw = nil, -- draw function
  input = nil, -- input function
  timers = {} -- adventure timers
}

adventure.enter = function(adventure)
  addTimer(8.0, "pause", adventure.timers) -- add a timer that blocks user input
  setLineMax(3) -- set our line max to 3, make room for images/graphics

  -- set up scenario:
  addLine("Loading Adventure: '" .. adventure.name .. "'. . .", 1.0)
  addLine(adventure.name .. " Loaded!", 2.0, true)

  addLine("Your daily duties include:", 0.5)
  addLine("Logging all incoming packages to your Portable Receiving Unit.", 2.0)
  addLine("Shipping labels will cotain the following:", 2.0)
  addLine("1. Delivery ID Number")
  addLine("2. Corporation")
  addLine("3. Weight (lbs)")
end

adventure.update = function(dt, adventure)
  updateTimer(dt, "pause", adventure.timers)
end

adventure.draw = function(adventure)
  -- draws a box that shows our draw range
  love.graphics.setColor({255, 255, 255, 100})
  love.graphics.rectangle("line", -1, 90, love.graphics.getWidth() + 2, 245)

  -- incase we want to draw text outside of the terminal log
  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.setFont(bigTerminalFont)
  love.graphics.printf("WELCOME", 0, 100, love.graphics.getWidth(), "center")
  love.graphics.setFont(detailFont)

  -- employee profile
  --love.graphics.rectangle("line", 50, 150, 410, 150)
  love.graphics.rectangle("line", 100, 150, 310, 140)
  love.graphics.printf("Employee #259245", 0, 150, love.graphics.getWidth(), "center")
  love.graphics.rectangle("line", 120, 175, 90, 90)
  love.graphics.printf("Jason Smith", 220, 170, love.graphics.getWidth(), "left")
  love.graphics.printf("Shipping and Receiving", 220, 185, love.graphics.getWidth(), "left")
  love.graphics.printf("Facility - #339", 220, 200, love.graphics.getWidth(), "left")
  love.graphics.printf("Inventory Technician", 218, 215, love.graphics.getWidth(), "left")

  -- get the block text font for the future
  love.graphics.setFont(blockFont)
  love.graphics.printf("BBBBB BBBBB BB BBBBB", 220, 235, 100, "left")

  love.graphics.setFont(terminalFont)
end

adventure.input = function(adventure, input)
  if isTimerDone("pause", adventure.timers) then
    addLine(input)
  end
end

return adventure

--[[

1) there's going to be a ton of text to output, i should consider storing that in a seperate file somewhere and store that
somewhere inside our adventure (should figure out a good file type, def not .txt and maybe avoid .lua).

2) i need a way to jump from screen to screen/event to event.

3) going to need to limit the max # of lines displayed.

local event = { -- contains all info needed for the play to experience an event box
  -- functions, possible commands, results, etc...
}

local box = {
  idNum = XXXXXXX, -- should be somewhat random
  corp = XXXXXXX,
  lbs = XX.XX,
  eventBox = false, -- if true...
  event = event, -- events are seperate objects
}

local boxes = {} -- a home for our boxes, maybe 15-30 boxes max? an event box every 3-5?

local function drawBoxes()
  for _, newBox in ipairs(boxes) do
    love.graphics.rectangle(...)
    -- draw our boxes... not sure what they'll look like just yet.
    -- I was thinking vector graphics, but not sure how to pull that off just yet
  end
end

--]]
