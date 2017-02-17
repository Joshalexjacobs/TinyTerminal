-- box.lua

local box = {
  x = 512, -- 250
  y = 210,
  w = 0,
  h = 0,
  dx = 0,
  dy = 0,
  speed = 52, -- 40
  state = "current",
  idNum = "", -- id number "X000-XX0-000"
  corp = "corp", -- corporation
  weight = 00.00, -- lbs
  eventBox = false, -- is this an event box?
  event = nil, -- event object
  idEntry = false,
  corpEntry = false,
  weightEntry = false,
  iCount = 0,
  sprite = "adventures/room/img/boxes/box"
}

local boxes = {} -- a home for our boxes, maybe 15-30 boxes max? an event box every 3-5?

local curX = 1

local corps = { -- possible corporations
  "Meunster",
  "Pepperidge",
  "Wee Wisp LLC",
}

local function randomID(n)
  local x = ""
  local lastChar = ''

  for i = 1, n do
    local _, count = string.gsub(x, "%-", "")
    if love.math.random(0, 3) == 3 and count < 3 and lastChar ~= '-' and lastChar ~= '' and i ~= n then
      x = x .. "-"
      lastChar = '-'
    elseif love.math.random(0, 1) == 1 then
      x = x .. string.char(love.math.random(97, 122))
      lastChar = 'A'
    else
      x = x .. tostring(love.math.random(0, 9))
      lastChar = '0'
    end

    if #x == 16 then break end -- just in case
  end

  return x:upper()
end

function addBox()
  local newBox = copy(box, newBox) -- copy base box object

  newBox.idNum = randomID(love.math.random(12, 16)) -- 16 character is the MAX

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

function getiCount()
  if curX <= 0 then return end
  return boxes[curX].iCount
end

function isBoxMoving()
  if curX <= 0 then return
  elseif boxes[curX].x <= 250 then
    return false
  else
    return true
  end
end

function checkBox(text)
  if boxes[curX].idNum:lower() == text:lower() then
    print("correct ID")
    boxes[curX].idEntry = true
    boxes[curX].iCount = boxes[curX].iCount + 1
  elseif boxes[curX].corp:lower() == text:lower() then
    print("correct corp")
    boxes[curX].corpEntry = true
    boxes[curX].iCount = boxes[curX].iCount + 1
  elseif boxes[curX].weight == text then
    print("correct weight")
    boxes[curX].weightEntry = true
    boxes[curX].iCount = boxes[curX].iCount + 1
  else
    print("incorrect")
  end
end

function updateBox(x, dt)
  curX = x -- update current X (boxTally)
  if curX <= 0 then return end

  for _, newBox in ipairs(boxes) do

    if boxes[curX].x > 250 then
      newBox.dx = (dt * newBox.speed)
      newBox.x = newBox.x - newBox.dx
    end

    if boxes[curX].idEntry and boxes[curX].corpEntry and boxes[curX].weightEntry then
      boxes[curX].idEntry = false
      boxes[curX].corpEntry = false
      boxes[curX].weightEntry = false
      boxes[curX].state = "done"
      addLine("Box Complete", 0.0, false, false, {true, "boxGen"}) -- generates the next box
    end

  end
end

function drawBox() -- only draw the current box
  maid64.start()
  for _, newBox in ipairs(boxes) do
    love.graphics.draw(newBox.sprite, newBox.x, newBox.y)
  end
  --love.graphics.draw(boxes[curX].sprite, boxes[curX].x, boxes[curX].y)
  maid64.finish()
end

function drawLabel()
  love.graphics.setColor({255, 255, 255, 255})
  love.graphics.rectangle("fill", 5, 100, 185, 100)

  love.graphics.setColor({0, 0, 0, 255})
  love.graphics.rectangle("line", 10, 105, 175, 90)

  love.graphics.printf(boxes[curX].idNum, 17.5, 110, 800)
  if boxes[curX].idEntry then
    love.graphics.rectangle("fill", 100, 110, 100, 2)
  end

  love.graphics.printf(boxes[curX].corp, 17.5, 135, 800)
  if boxes[curX].corpEntry then
    love.graphics.rectangle("fill", 100, 160, 100, 2)
  end

  love.graphics.printf(boxes[curX].weight .. " lbs", 17.5, 160, 800)
  if boxes[curX].weightEntry then
    love.graphics.rectangle("fill", 100, 210, 100, 2)
  end

  love.graphics.setColor({255, 255, 255, 255})
end
