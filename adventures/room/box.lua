-- box.lua

local box = {
  x = 0,
  y = 0,
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

  table.insert(boxes, newBox)
end

function checkBox(x, text)
  if boxes[x].idNum:lower() == text:lower() then
    print("correct ID")
    idEntry = true
  elseif boxes[x].corp:lower() == text:lower() then
    print("correct corp")
    corpEntry = true
  elseif boxes[x].weight == text then
    print("correct weight")
    weightEntry = true
  else
    print("incorrect")
  end
end

function updateBox()
  -- update?
end

function drawBox(x) -- only draw the current box
  love.graphics.printf(boxes[x].idNum, 100, 100, 800)
  if idEntry then
    love.graphics.rectangle("fill", 100, 110, 100, 2)
  end

  love.graphics.printf(boxes[x].corp, 100, 150, 800)
  if corpEntry then
    love.graphics.rectangle("fill", 100, 160, 100, 2)
  end

  love.graphics.printf(boxes[x].weight .. " lbs", 100, 200, 800)
  if weightEntry then
    love.graphics.rectangle("fill", 100, 210, 100, 2)
  end
end
