--main.lua

Gamestate = require "lib/Gamestate"
require "lib/maid64" -- used for correct scaling
require "lib/timer"
anim8 = require "lib/anim8" -- anim8
anim8 = require "lib/anim8" -- maid64
require "lines" -- lines.lua
require "commands/commands" -- commands.lua

require "states/boot"
require "states/terminal"
require "header"

-- global copy function
function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

-- globals
DEBUG = true

function love.load(arg)
  math.randomseed(os.time()) -- seed love.math.rand() using os time
  love.graphics.setDefaultFilter("nearest", "nearest") -- set nearest pixel distance

  --love.window.setMode(480, 432, {resizable=true, vsync=true, minwidth=160, minheight=144, msaa=0}) -- set the window mode
  love.window.setMode(256 * 2, 180 * 2, {resizable=false, borderless=true, vsync=true, msaa=0}) -- set the window mode
  maid64.setup(256 * 2, 180 * 2)

  -- fonts
  detailFont = love.graphics.newFont("lib/Monaco.dfont", 12)
  terminalFont = love.graphics.newFont("lib/Monaco.dfont", 16)
  bigTerminalFont = love.graphics.newFont("lib/Monaco.dfont", 20)
  love.graphics.setFont(terminalFont)

  -- shaders
  --[[
  canvas = love.graphics.newCanvas()
  local str = love.filesystem.read('shaders/CRT-Simple.frag')
  shader = love.graphics.newShader(str)
  shader:send('inputSize', {love.graphics.getWidth(), love.graphics.getHeight()})
  shader:send('textureSize', {love.graphics.getWidth(), love.graphics.getHeight()})
  ]]

  headerLoad()

  Gamestate.registerEvents()
  Gamestate.switch(terminal) -- swtich to game screen
  --Gamestate.switch(boot)
end

function love.mousepressed(x, y, button)
  if button == 1 then
    headerClicked(x, y)
  end
end

function love.update(dt)
  headerUpdate()
end

function love.draw()
  headerDraw()
end

-- see if there is a love.moveWindow() function
-- https://love2d.org/forums/viewtopic.php?t=80265
-- that way the player can move the terminal around when clicking and dragging the header

--[[ -- when maid64 is implemented in the near future
function love.resize(w, h)
    -- this is used to resize the screen correctly
    maid64.resize(w, h)
    camera = Camera(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + player.y - 80)
    camera.smoother = Camera.smooth.upwardDamped(1)
end
]]
