--terminal.lua

terminal = {}

function terminal:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  end
end

function terminal:enter()
  addLine("Hello.")
end

function terminal:update(dt)
  updateLines(dt)
end

function terminal:draw()
  --love.graphics.printf(">Hello", 50, 50, 150)
  drawLines()
end
