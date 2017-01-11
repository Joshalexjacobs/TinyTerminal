-- adventure.lua
-- keeps track of all adventures

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

  return nil
end

function adventureUpdate(dt)
  --
end
