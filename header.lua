-- header.lua
-- this is the header you see above the terminal at all times

local xButton = {
  x = -5,
  y = -5,
  w = nil,
  h = nil,
  hover = false
}

function headerLoad()
  xButton.w, xButton.h = love.graphics.getHeight() * 0.10, love.graphics.getHeight() * 0.10
end

function headerClicked(x, y)
  if x > xButton.x and x < xButton.x + xButton.w and y > xButton.y and y < xButton.y + xButton.h then
    love.event.quit()
    -- in the future, open a dialog asking "Are you sure? Y/N"
  end
end

function headerUpdate()
  local x, y = love.mouse.getPosition()

  if x > xButton.x and x < xButton.x + xButton.w and y > xButton.y and y < xButton.y + xButton.h then
    xButton.hover = true
  else
    xButton.hover = false
  end
end

function headerDraw()
  -- set line width
  love.graphics.setLineWidth(4)

  -- top bar
  love.graphics.rectangle("line", -5, -5, love.graphics.getWidth() + 10, love.graphics.getHeight() * 0.10)

  -- X button
  if xButton.hover then -- if mouse is over X, draw rect
    love.graphics.rectangle("fill", xButton.x, xButton.y, xButton.w, xButton.h)
    love.graphics.setColor({0, 0, 0, 255})
  --else
    --love.graphics.rectangle("line", xButton.x, xButton.y, xButton.w, xButton.h)
  end

  -- draw X
  love.graphics.line(10, 10, love.graphics.getHeight() * 0.10 - 15, love.graphics.getHeight() * 0.10 - 15)
  love.graphics.line(10, love.graphics.getHeight() * 0.10 - 15, love.graphics.getHeight() * 0.10 - 15, 10)

  -- reset
  love.graphics.setLineWidth(1)
  love.graphics.setColor({255, 255, 255, 255})

  -- header Title
  love.graphics.printf("Terminal.lua", 0, 5, love.graphics.getWidth(), "center")
end
