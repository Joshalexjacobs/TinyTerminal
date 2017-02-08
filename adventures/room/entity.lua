-- entity.lua

require "adventures/room/entityList"

local entity = {
  x = 0,
  y = 0,
  w = 0,
  h = 0,
  offX = 0,
  offY = 0,
  name = "",
  behaviour = nil,
  spriteSheet = "",
  spriteGrid = {x = 0, y = 0, w = 0, h = 0},
  animations = {},
  curAnim = 1,
  timers = {}
}

local entities = {}

function addEntity(x, y, name)
  local newEntity = copy(entity, newEntity) -- copy base entity object

  newEntity.x, newEntity.y, newEntity.name  = x, y, name
  getEntity(newEntity)

  table.insert(entities, newEntity)
end

function updateEntities(dt)
  for _, newEntity in ipairs(entities) do
    newEntity.behaviour(dt, newEntity)

    -- update each entities' animation
    newEntity.animations[newEntity.curAnim]:update(dt)
  end
end

function drawEntities()
  for _, newEntity in ipairs(entities) do
    newEntity.animations[newEntity.curAnim]:draw(newEntity.spriteSheet, newEntity.x, newEntity.y, 0, 1, 1, newEntity.offX, newEntity.offY)
  end
end
