-- PRU.lua

local PRU = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "PRU",
  speed = 40, -- might need this?
  timers = {},
  behaviour = function(dt, entity) -- update
    local n = getiCount()
    if n == 1 then entity.curAnim = 2
    elseif n == 2 then entity.curAnim = 3
    elseif n == 3 and checkTimer("next", entity.timers) == false then
      entity.curAnim = 4
      addTimer(2.0, "next", entity.timers)
    end

    if updateTimer(dt, "next", entity.timers) then
      entity.curAnim = 1
      deleteTimer("next", entity.timers)
    end
  end,
  spriteSheet = "adventures/box_factory/img/PRU.png",
  spriteGrid = {x = 128, y = 128, w = 384, h = 256},
  animations = function(grid)
    animations = {         -- r, c
      anim8.newAnimation(grid(1, 1), 0.1), -- 1 nothing
      anim8.newAnimation(grid(2, 1), 0.1), -- 2 correct 1/3
      anim8.newAnimation(grid(3, 1), 0.1), -- 3 correct 2/3
      anim8.newAnimation(grid(1, 2), 0.1), -- 4 correct 3/3
      anim8.newAnimation(grid(3, 2), 0.1), -- 5 incorrect
    }
    return animations
  end,
  draw = function(entity)
    entity.animations[entity.curAnim]:draw(entity.spriteSheet, entity.x, entity.y, 0, 1, 1, entity.offX, entity.offY)
  end
}

return PRU
