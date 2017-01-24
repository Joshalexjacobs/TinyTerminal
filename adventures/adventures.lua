-- adventure.lua
-- keeps track of all adventures

local adventures = {
  require "adventures/room/room"
}

function getAdventureNames()
  for _, adventure in ipairs(adventures) do
    addLine("> " .. adventure.name)
  end
end

function getAdventure(name)
  for _, adventure in ipairs(adventures) do
    if name:lower() == adventure.name:lower() then
      return adventure
    end
  end

  return nil
end
