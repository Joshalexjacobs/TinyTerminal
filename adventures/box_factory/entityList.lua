-- entityList.lua

local conveyorBelt = require "adventures/box_factory/entities/conveyor"
local PRU = require "adventures/box_factory/entities/PRU"
local bomb = require "adventures/box_factory/entities/bomb"

local entityDictionary = {
  {name = "conveyorBelt", entity = conveyorBelt},
  {name = "PRU", entity = PRU},
  {name = "bomb", entity = bomb}
}

function getEntity(entity) -- passes an actual entity object
  for i = 1, #entityDictionary do
    if entity.name == entityDictionary[i].name then
      local ourEntity = entityDictionary[i].entity -- instead of writing entityDictionary[i].entity.behaviour etc...

      -- load required entity stuff
      entity.behaviour = ourEntity.behaviour
      entity.spriteSheet = maid64.newImage(ourEntity.spriteSheet) -- need to load spritesheet
      entity.spriteGrid = ourEntity.spriteGrid

      entity.spriteGrid = anim8.newGrid(entity.spriteGrid.x, entity.spriteGrid.y, entity.spriteGrid.w, entity.spriteGrid.h, 0, 0, 0)
      entity.animations = ourEntity.animations(entity.spriteGrid)
    end
  end
end
