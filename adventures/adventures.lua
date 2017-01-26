-- adventure.lua
-- keeps track of all adventures

local adventures = {
  require "adventures/room/room" -- our adventure files
}

function getAdventureNames() -- returns a list of adentures
  for _, adventure in ipairs(adventures) do
    addLine("> " .. adventure.name)
  end
end

function getAdventure(name) -- returns adventure object to be played
  for _, adventure in ipairs(adventures) do
    if name:lower() == adventure.name:lower() then
      return adventure
    end
  end

  return nil
end
