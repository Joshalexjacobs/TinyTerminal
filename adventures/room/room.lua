-- room.lua

-- your a new employee at an online toy company
-- they get shipments everyday and 3 big ones just came in.
-- all you have to do is read the label of each one and input
-- all the label's info into the terminal. Don't mess up

local adventure = {
  name = "Room",
  state = "enter", -- determines which function to call
  enter = nil,
  update = nil,
  draw = nil,
  timers = {}
}

adventure.enter = function(adventure)
  addLine("Loading Adventure: " .. adventure.name .. ". . .", 1.0)
  addLine(adventure.name .. " Loaded!", 2.0, true)
  -- temporarily change lineMax in lines.lua -- maybe create a seperate function for this

  --setLineMax(3)
  --addLine("This is a test 1", 0.5)
  --addLine("This is a test 2", 0.5)
  --addLine("This is a test 3", 0.5)
  --addLine("This is a test 4", 0.5)
  --addLine("This is a test 5", 0.5)
  --addLine("This is a test 6", 0.5)
end

adventure.update = function(adventure)

end

adventure.draw = function(adventure)
  --love.graphics.rectangle("line", 25, 25, 100, 100)
  --love.graphics.printf("room", 30, 30, 100)
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
