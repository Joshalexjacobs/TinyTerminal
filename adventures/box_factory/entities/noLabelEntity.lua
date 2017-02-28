-- noLabelEntity.lua

local noLabelEntity = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "noLabelEntity",
  speed = 40, -- might need this?
  timers = {},
  behaviour = function(dt, entity) -- update
    -- nothing yet
  end,
  spriteSheet = "",
  spriteGrid = {x = 128, y = 128, w = 384, h = 256},
  animations = function(grid)
    animations = {         -- r, c
      -- anim8.newAnimation(grid(1, 1), 0.1), -- 1
    }
    return animations
  end,
  draw = function(entity)
    entity.animations[entity.curAnim]:draw(entity.spriteSheet, entity.x, entity.y, 0, 1, 1, entity.offX, entity.offY)
  end
}

return noLabelEntity
