--boot.lua

boot = {}

function boot:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  end
end

function boot:enter()
  addLine("Apple II Pro")
  -- pause between each line?
end

function boot:update()
  --addLine("ProDOS 1.0")
  --addLine("1-Jan-17")
  --addLine("Sun 19:02")

  updateLines()
end

function boot:draw()
  drawLines()
end
