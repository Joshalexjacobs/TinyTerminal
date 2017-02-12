-- conveyor.lua

local conveyorBelt = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "conveyorBelt",
  speed = 40, -- might need this?
  timers = {},
  behaviour = function(dt, entity) -- update
    -- update function
    if entity.curAnim == 1 then
      entity.curAnim = 2
    end

    if isBoxMoving() then -- in the future slow down the belt before stopping completely
      entity.animations[entity.curAnim]:pause()
    else
      entity.animations[entity.curAnim]:resume()
    end
  end,
  spriteSheet = "adventures/room/img/conveyor1.png",
  spriteGrid = {x = 64, y = 64, w = 192, h = 384},
  animations = function(grid)
    animations = {
      anim8.newAnimation(grid(1, 1), 0.1), -- 1 stopped -- probably won't need this, just need to start and stop anim 2
      anim8.newAnimation(grid("1-3", "1-5", 1, 6), 0.1), -- 2 moving
    }
    return animations
  end,
}

return conveyorBelt
