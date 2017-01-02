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

function addLine(text, timer, clear)
  if clear == nil then clear = false end
  if timer == nil then timer = 0.0 end

  if #lines == 18 then
    table.remove(lines, 1)
  end

  newLine = copy(line, newLine)
  newLine.text, newLine.clear = text, clear

  addTimer(timer, "end", newLine.timers)

  --line = "> " .. line
  table.insert(lines, newLine)
end

function updateLines(dt)
  -- animate text to be displayed
  for _, newLine in ipairs(lines) do
    if newLine.writing then
      newLine.written = string.sub(newLine.text, 1, newLine.textPos)
      newLine.textPos = newLine.textPos + 1

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
end
