--boot.lua

boot = {}

function boot:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  end
end

function boot:enter()
  addLine("Apple II Pro", 0.2)
  addLine("ProDOS 1.0", 0.2)
  addLine("1-Jan-17", 0.2)
  addLine("Sun 19:02", 0.2)
  addLine(".", 1.0, true)
end

function boot:update(dt)
  updateLines(dt)
end

function boot:draw()
  drawLines()
end
