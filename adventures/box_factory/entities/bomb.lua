-- bomb.lua

local bomb = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "bomb",
  speed = 40, -- might need this?
  timers = {},
  behaviour = function(dt, entity) -- update
    -- nothing
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
    end
  end
}

return bomb
