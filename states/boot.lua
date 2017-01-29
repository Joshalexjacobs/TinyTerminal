--boot.lua
-- a simple boot screen, currently not a priority

boot = {}

function boot:keypressed(key, code)
  if key == 'escape' then -- quit on escape
    love.event.quit()
  end
end

function boot:enter()
  -- not final, just messing around:
  addLine("Copyright (C) 1986, Quick Line Software, Inc", 2.0)
  addLine("")
  addLine("Memory Pro - 64KB", 0.2)
  addLine("MEMORY TEST:" , 1.0)
  addLine(".", 1.0)
  addLine(".", 1.0)
  addLine(".", 1.0)
  addLine("262144K OK", 0.5)
  addLine("", 0.2)
  addLine("QK-Comp OS v1.34", 1.0)
  addLine("CHECKING INTEGRITY: ", 1.0)
  addLine(".", 1.0)
  addLine(".", 1.0)
  addLine(".", 1.0)
  addLine("OK", 3.0, true)
  addLine("ModuSound Card Active", 1.0)
  --addLine("Loading from C drive")
  --addLine(".", 1.0, true)
end

function boot:update(dt)
  updateLines(dt)
end

function boot:draw()
  drawLines()
end
