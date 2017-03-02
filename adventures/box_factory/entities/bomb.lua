-- bomb.lua

local bomb = {
  w = 78,
  h = 96,
  offX = 1,
  offY = 1,
  name = "bomb",
  speed = 40, -- might need this?
  timers = {},
  behaviour = function(dt, entity) -- update
    local event = getCurEvent()

    if event.name == "noLabel" and event.getState() == "bomb" then
     if checkTimer("startBomb", entity.timers) == false then
       addTimer(120.0, "startBomb", entity.timers)
     elseif updateTimer(dt, "startBomb", entity.timers) then
       -- nothing
     end
    end

  end,
  spriteSheet = "adventures/box_factory/img/bombx6.png",
  spriteGrid = {x = 78, y = 96, w = 78, h = 96},
  animations = function(grid)
    animations = {         -- r, c
      anim8.newAnimation(grid(1, 1), 0.1), -- 1
    }
    return animations
  end,
  draw = function(entity)
    local event = getCurEvent()

    if event.name == "noLabel" and event.getState() == "bomb" then
      entity.animations[entity.curAnim]:draw(entity.spriteSheet, entity.x, entity.y, 0, 1, 1, entity.offX, entity.offY)

      local bTime = getTime("startBomb", entity.timers)
      bTime = math.floor(bTime*10^2) / 10^2 -- scale bTime down to 2 decimal points

      local min = bTime % 60
      print(min)

      love.graphics.setColor({0, 0, 0, 255})
      love.graphics.printf(bTime, entity.x, entity.y, 100, "center")
      love.graphics.setColor({255, 255, 255, 255})
    end
  end
}

return bomb
