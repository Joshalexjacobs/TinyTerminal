-- box.lua

local box = {
  x = 250,
  y = 210,
  w = 0,
  h = 0,
  idNum = "", -- id number "X000-XX0-000"
  corp = "corp", -- corporation
  weight = 00.00, -- lbs
  eventBox = false, -- is this an event box?
  event = nil, -- event object
  idEntry = false,
  corpEntry = false,
  weightEntry = false,
  sprite = "adventures/room/img/boxes/box"
}

local boxes = {} -- a home for our boxes, maybe 15-30 boxes max? an event box every 3-5?

local corps = { -- possible corporations
  "Meunster",
  "Pepperidge",
  "Wee Wisp LLC",
}

local function randomLetter(n)
  local x = ""
  for i = 1, n do
    x = x .. string.char(love.math.random(97, 122))
  end

  return x:upper()
end

function addBox()
  local newBox = copy(box, newBox) -- copy base box object

  -- set idNum
  newBox.idNum = randomLetter(1) .. tostring(love.math.random(100, 999)) .. "-" ..
                 randomLetter(2) .. tostring(love.math.random(1, 9)) .. "-" .. love.math.random(100, 999)

  -- set Corporation and weight
  newBox.corp = corps[love.math.random(1, 3)]
  newBox.weight = tostring(love.math.random(500, 1500) * 0.11)

  -- load random box img
  newBox.sprite = maid64.newImage(newBox.sprite .. tostring(love.math.random(1, 6)) .. ".png")

  if newBox.sprite:getHeight() + newBox.y > 306 then  -- 306 is on the conveyor belt
    newBox.y = newBox.y - ((newBox.sprite:getHeight() + newBox.y) - 306) -- correct the image if needed
  end

  table.insert(boxes, newBox)
end

function checkBox(x, text)
  if boxes[x].idNum:lower() == text:lower() then
    print("correct ID")
    boxes[x].idEntry = true
  elseif boxes[x].corp:lower() == text:lower() then
    print("correct corp")
    boxes[x].corpEntry = true
  elseif boxes[x].weight == text then
    print("correct weight")
    boxes[x].weightEntry = true
  else
    print("incorrect")
  end
end

function updateBox(x)
  if x <= 0 then return end

  if boxes[x].idEntry and boxes[x].corpEntry and boxes[x].weightEntry then
    boxes[x].idEntry = false
    boxes[x].corpEntry = false
    boxes[x].weightEntry = false

    addLine("Box Complete", 0.0, false, false, {true, "boxGen"}) -- generates the next box
  end
end

function drawBox(x) -- only draw the current box
  maid64.start()
  love.graphics.draw(boxes[x].sprite, boxes[x].x, boxes[x].y)
  maid64.finish()

  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.rectangle("fill", 85, 85, 185, 150)

  love.graphics.setColor({0, 0, 0, 255})
  love.graphics.rectangle("line", 90, 90, 175, 140)

  love.graphics.printf(boxes[x].idNum, 100, 100, 800)
  if boxes[x].idEntry then
    love.graphics.rectangle("fill", 100, 110, 100, 2)
  end

  love.graphics.printf(boxes[x].corp, 100, 150, 800)
  if boxes[x].corpEntry then
    love.graphics.rectangle("fill", 100, 160, 100, 2)
  end

  love.graphics.printf(boxes[x].weight .. " lbs", 100, 200, 800)
  if boxes[x].weightEntry then
    love.graphics.rectangle("fill", 100, 210, 100, 2)
  end
end
