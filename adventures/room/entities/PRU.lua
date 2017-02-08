-- PRU.lua

local PRU = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "PRU",
  speed = 40, -- might need this?
  behaviour = function(dt, entity) -- update
    -- update function
  end,
  spriteSheet = "adventures/room/img/PRU.png",
  spriteGrid = {x = 128, y = 128, w = 384, h = 128},
  animations = function(grid)
    animations = {
      anim8.newAnimation(grid(1, 1), 0.1), -- 1 nothing
      anim8.newAnimation(grid(2, 1), 0.1), -- 2 correct
      anim8.newAnimation(grid(3, 1), 0.1), -- 3 incorrect
    }
    return animations
  end,
}

return PRU
