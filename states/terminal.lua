--terminal.lua

terminal = {}

require "adventures/adventures"

local buffer = "" -- current user input
local bufferLog = {} -- keeps a log of all user input
local maxBufferSize = 48 -- ensures user input doesn't trail off screen
local logPos = 1 -- bufferLog position
local username = "$ " -- this goes in front of the user's input
local inputEnabled = true -- if we want to disable input, set to false

local curAdventure = nil -- current adventure selected
local adventureActive = false -- is the current adventure active?

local settings = { -- all settings will be stored in here
  printSpeed = 3
}

function terminal:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  elseif key == "return" then
    if adventureActive then -- log input to the current adventure
      curAdventure.input(curAdventure, cleanInput(buffer))
      table.insert(bufferLog, 2, buffer) -- reset buffer
      buffer = ""
      logPos = 1
    else
      addLine(username .. buffer, 0.0, false, true)
      newCommand(buffer)
      table.insert(bufferLog, 2, buffer) -- the first position of bufferLog is always empty, so we push to the second position
      buffer = ""
      logPos = 1
    end
  elseif key == "backspace" then -- delete from buffer
    buffer = string.sub(buffer, 1, #buffer - 1)
  elseif key == "up" then -- get previous input
    logPos = logPos + 1
    if logPos > #bufferLog then
      logPos = 1
    end
    buffer = bufferLog[logPos]
  elseif key == "down" then -- get older input
    logPos = logPos - 1
    if logPos <= 0 then
      logPos = 1
    end
    buffer = bufferLog[logPos]
  end
end

function terminal:textinput(t) -- add user keystrokes to existing input
  if inputEnabled and #buffer < maxBufferSize then
    buffer = buffer .. t
  end
end

function terminal:enter()
  table.insert(bufferLog, "") -- bufferLog[1] will always be an empty space
  loadLines(settings) -- send setting preferences to lines.lua

  addLine("QK-Comp OS v1.34", 0.2)
  addLine("Type 'HELP' for a short list of commands.")

  getCommands() -- load all terminal commands
end

function setAdventure(name) -- set a new adventure
  if name ~= nil then
    curAdventure = name
    adventureActive = true
    curAdventure.enter(curAdventure)
    -- clear bufferLog, set bufferPosition, add "" to bufferlog
  end
end

function advAdventure(newState) -- advance adventure by changing its current state
  curAdventure.changeState(newLine.trigger)
end

function terminal:update(dt)
  updateLines(dt)
  updateBuffer(buffer)
  updateCursor(dt)

  if adventureActive then -- call adventure update
    curAdventure.update(dt, curAdventure)
  end
end

function terminal:draw()
  drawLines()

  if adventureActive then -- call adventure draw
    curAdventure.draw(curAdventure)
  end
end
