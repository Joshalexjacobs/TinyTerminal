--terminal.lua

terminal = {}

local buffer = ""
local username = "User$ "
local inputEnabled = true

function terminal:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  elseif key == "return" then
    addLine(username .. buffer, 0.0, false, true)
    buffer = ""
  elseif key == "backspace" then
    buffer = string.sub(buffer, 1, #buffer - 1)
  end
end

function terminal:textinput(t)
  if inputEnabled then
    buffer = buffer .. t
  end
end

function terminal:enter()
  loadLines()
  addLine("Hello.")
end

function terminal:update(dt)
  updateLines(dt)
  updateBuffer(username .. buffer)
  updateCursor(dt)
end

function terminal:draw()
  drawLines()
end
