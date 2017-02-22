-- conveyor.lua

local conveyorBelt = {
  w = 14,
  h = 14,
  offX = 1,
  offY = 1,
  name = "conveyorBelt",
  speed = 0,
  timers = {},
  behaviour = function(dt, entity) -- update
    local frame = entity.animations[entity.curAnim]:getFrameInfo()
    local x, y = frame:getViewport() -- get our current frame quad

    if isBoxMoving() == false and checkTimer("stop", entity.timers) == false then
      addTimer(0.6 ,"stop", entity.timers) -- if the box is stopping, slow down the conveyor belt
      entity.curAnim = 2
      entity.animations[entity.curAnim]:gotoFrame(1 + (x / 64) + (3 * (y / 64))) -- make sure its on the same frame as the first anim
    elseif isBoxMoving() == false and updateTimer(dt, "stop", entity.timers) then
      entity.animations[entity.curAnim]:pause() -- after the timer is up, halt the conveyor belt completely
    elseif isBoxMoving() == true and checkTimer("stop", entity.timers) == true then
      entity.animations[2]:resume() -- if the box is moving again, resume anim 2...
      entity.curAnim = 1 -- set the animation back to the fast conveyor belt
      entity.animations[entity.curAnim]:gotoFrame(1 + (x / 64) + (3 * (y / 64))) -- line up the frames
      deleteTimer("stop", entity.timers) -- and delete the stop timer
    end
  end,
  spriteSheet = "adventures/box_factory/img/conveyor1.png",
  spriteGrid = {x = 64, y = 64, w = 192, h = 384},
  animations = function(grid)
    animations = {
      anim8.newAnimation(grid("1-3", "1-5", 1, 6), 0.075), -- 1 fast
      anim8.newAnimation(grid("1-3", "1-5", 1, 6), 0.2), -- 2 slow
    }
    return animations
  end,
}

return conveyorBelt
