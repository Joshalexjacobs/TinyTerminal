--lines.lua

local line = { -- a line object
  text = nil,
  written = "",
  textPos = 1,
  writing = true,
  timers = {},
  clear = false,
}

local lines = {} -- all of our lines that we're able to draw within the lineMax
local overflow = {} -- all the lines in queue to be drawn
local buffer = ""

local cursor = { -- our blinking cursor
  x = 0,
  y = 0,
  w = 8,
  h = 17.5,
  isOn = true,
  pos = 0, -- for moving left and right (not in use)
  timers = {}
}

local printSpeed = 1 -- default value
local lineMax = 18 -- default value

function loadLines(settings)
  addTimer(0.4, "blink", cursor.timers) -- cursor blink timer

  -- load terminal settings
  printSpeed = settings.printSpeed
end

function addLine(text, timer, clear, isBuffer)
  if timer == nil then timer = 0.0 end -- if theres a timer after draw
  if clear == nil then clear = false end -- clear screen after drawing/timer?
  if isBuffer == nil then isBuffer = false end -- if text is user input

  while #text > 48 do -- cuts the string up into segments of 48 characters each
    addLine(string.sub(text, 1, 48))
    text = string.sub(text, 49, #text)
  end

  newLine = copy(line, newLine) -- copy base line object
  newLine.text, newLine.clear = text, clear

  addTimer(timer, "end", newLine.timers)

  if isBuffer then newLine.textPos = #newLine.text end -- don't write user input, display it instantly

  if #lines == lineMax then -- if lines is maxed, send text to overflow
    table.insert(overflow, newLine)
  else
    table.insert(lines, newLine)
  end
end

function setLineMax(x) -- changes the line max from 18 to x
  local tempLines = {}

  for i = 0, x - 1 do -- keep the last x lines
    if #lines - i <= 0 then break end
    table.insert(tempLines, 1, lines[#lines - i])
  end

  lines = tempLines
  lineMax = x
end

function clearLines() -- clears all lines
  -- if there are any unfinished timers in lines, add them to the start of overflow
  for _, newLine in ipairs(lines) do
    if isTimerDone("end", newLine.timers) == false then
      table.insert(overflow, 1, newLine)
    end
  end

  lines = {}

  -- insert as many lines from overflow as possible
  if #overflow > 0 then
    for i = 1, lineMax do
      table.insert(lines, overflow[1])
      table.remove(overflow, 1)
    end
  end
end

function updateBuffer(text)
  buffer = "> " .. text
end

function updateCursor(dt) -- blink and move our cursor depending on buffer length
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
  --cursor.y = 16 + 17 * (18 + 1) + 2
  cursor.y = 341
end

function updateLines(dt)
  -- still testing the overflow, but it seems to be working so far
  if #overflow > 0 and #lines > 0 and isTimerDone("end", lines[#lines].timers) then
    table.remove(lines, 1)
    table.insert(lines, overflow[1])
    table.remove(overflow, 1)
  end

  -- animate text to be displayed
  for _, newLine in ipairs(lines) do
    if newLine.writing then
      newLine.written = string.sub(newLine.text, 1, newLine.textPos)
      newLine.textPos = newLine.textPos + printSpeed

      if newLine.textPos >= #newLine.text and updateTimer(dt, "end", newLine.timers) then
        newLine.writing = false
        if newLine.clear then -- if the clear flag is set, clear the screen after the timer is finished
          clearLines()
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
