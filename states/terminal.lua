--terminal.lua

terminal = {}

require "adventures/adventures"

local buffer = "" -- current user input
local bufferLog = {} -- keeps a log of all user input
local logPos = 1 -- bufferLog position
local username = "$ "
local inputEnabled = true

local currentAdventure = nil -- current adventure selected
local adventureActive = false -- is the current adventure active?

local settings = {
  printSpeed = 3
}

function terminal:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  elseif key == "return" then
    addLine(username .. buffer, 0.0, false, true)
    newCommand(buffer)
    table.insert(bufferLog, 2, buffer) -- the first position of bufferLog is always empty, so we push to the second position
    buffer = ""
    logPos = 1
  elseif key == "backspace" then
    buffer = string.sub(buffer, 1, #buffer - 1)
  elseif key == "up" then
    logPos = logPos + 1
    if logPos > #bufferLog then
      logPos = 1
    end
    buffer = bufferLog[logPos]
  elseif key == "down" then
    logPos = logPos - 1
    if logPos <= 0 then
      logPos = 1
    end
    buffer = bufferLog[logPos]
  end
end

function terminal:textinput(t)
  if inputEnabled then
    buffer = buffer .. t
  end
end

function terminal:enter()
  table.insert(bufferLog, "")
  loadLines(settings)
  --loadAdventures()
  addLine("Terminal v1.2.7 Loaded")
  addLine(". . .")
  addLine("Type 'HELP' for a short list of commands.")

  getCommands()
end

function terminal:update(dt)
  updateLines(dt)
  updateBuffer(buffer)
  updateCursor(dt)

  if adventureActive then
    -- call adventureUpdate
  end
end

function terminal:draw()
  drawLines()
end
