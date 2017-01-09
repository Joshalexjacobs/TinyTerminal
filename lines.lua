--lines.lua

local line = {
  text = nil,
  written = "",
  textPos = 1,
  writing = true,
  timers = {},
  clear = false,
}

local lines = {}

local buffer = ""

local cursor = {
  x = 0,
  y = 0,
  w = 8,
  h = 17.5,
  isOn = true,
  pos = 0, -- for moving left and right
  timers = {}
}

local printSpeed = 1 -- default value

function loadLines(settings)
  addTimer(0.4, "blink", cursor.timers)

  -- load settings
  printSpeed = settings.printSpeed
end

function addLine(text, timer, clear, isBuffer)
  if timer == nil then timer = 0.0 end
  if clear == nil then clear = false end
  if isBuffer == nil then isBuffer = false end

  while #text > 48 do -- cuts the string up into segments of 48 characters each
    addLine(string.sub(text, 1, 48))
    text = string.sub(text, 49, #text)
  end

  newLine = copy(line, newLine)
  newLine.text, newLine.clear = text, clear

  addTimer(timer, "end", newLine.timers)

  if isBuffer then newLine.textPos = #newLine.text end

  table.insert(lines, newLine)
end

function clearLines()
  lines = {}
end

function updateBuffer(text)
  buffer = "> " .. text
end

function updateCursor(dt)
  if updateTimer(dt, "blink", cursor.timers) then
    if cursor.isOn then
      cursor.isOn = false
      resetTimer(0.4, "blink", cursor.timers)
    else
      cursor.isOn = true
      resetTimer(0.4, "blink", cursor.timers)
    end
  end

  cursor.x = (#buffer * 10) + 5
  cursor.y = 16 + 17 * (18 + 1) + 2
end

function updateLines(dt)
  if #lines > 18 then
    table.remove(lines, 1)
  end

  -- animate text to be displayed
  for _, newLine in ipairs(lines) do
    if newLine.writing then
      newLine.written = string.sub(newLine.text, 1, newLine.textPos)
      newLine.textPos = newLine.textPos + printSpeed

      if newLine.textPos >= #newLine.text and updateTimer(dt, "end", newLine.timers) then
        newLine.writing = false
        if newLine.clear then -- if the clear flag is set, clear the screen after the timer is finished
          lines = {}
        end
      else
        return
      end
    end
  end
end

function drawLines()
  for i, newLine in ipairs(lines) do
    if newLine.writing then
      love.graphics.printf(newLine.written, 5, 16 + 17 * i, love.graphics.getWidth(), "left")
    else
      love.graphics.printf(newLine.text, 5, 16 + 17 * i, love.graphics.getWidth(), "left")
    end
  end

  love.graphics.printf(buffer, 5, 339, love.graphics.getWidth(), "left")

  if cursor.isOn then
    love.graphics.rectangle("fill", cursor.x, cursor.y, cursor.w, cursor.h)
  end

  love.graphics.printf(#lines, 0, 0, love.graphics.getWidth(), "right")
end
