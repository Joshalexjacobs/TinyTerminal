-- conveyor.lua

local conveyorBelt = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "conveyorBelt",
  speed = 40, -- might need this?
  behaviour = function(dt, entity) -- update
    -- update function
  end,
  spriteSheet = "adventures/room/img/conveyor1.png",
  spriteGrid = {x = 48, y = 48, w = 144, h = 288},
  animations = function(grid)
    animations = {
      anim8.newAnimation(grid(1, 1), 0.1), -- 1 stopped
      --anim8.newAnimation(grid("1-3", "2-3", 1, 4), 0.1, "pauseAtEnd"), -- 2 moving
    }
    return animations
  end,
}

return conveyorBelt
