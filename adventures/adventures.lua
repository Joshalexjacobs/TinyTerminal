-- adventure.lua
-- this is a test adventure file

-- require all Adventure files
-- local dungeon = require "adventures/dungeon"

local adventures = {
  require "adventures/dungeon"
}

function loadAdventures()

end

function getAdventureNames()
  for _, adventure in ipairs(adventures) do
    addLine("> " .. adventure.name)
  end
end

function getAdventure(name)
  for _, adventure in ipairs(adventures) do
    if name == adventure.name then
      return adventure
    end
  end
end

function adventureUpdate(dt)
  --
end
