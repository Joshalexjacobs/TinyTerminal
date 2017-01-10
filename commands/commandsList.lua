-- commandsList.lua

local commandsList = {
  { -- 1
    name = "help",
    text = {"Current commands you have access to :",
    "LAUNCH $(ADVENTURE) - Launches a new adventure.",
    "ADVENTURES - Lists all possible adventures.",
    "SETTINGS - Lists all settings/preferences.",
    "CLEAR - Clears the screen.",
    "To view this list again type 'HELP'."},
    desc = "HELP - Outputs all possible commands.",
    call = function(command, commands)
      for i = 1, #commands do
        addLine(commands[i].desc)
      end
    end
  },
  { -- 2
    name = "clear",
    text = {""},
    desc = "CLEAR - Clears the screen.",
    call = function(command, commands)
      clearLines()
    end
  },
  {
    name = "adventures",
    text = {""},
    desc = "ADVENTURES - Lists all available adventures.",
    call = function(command, commands)
      getAdventureNames()
    end
  },
  {
    name = "play",
    text = {""},
    desc = "PLAY $ADVENTURE - Launches an adventure to play.",
    call = function(command, commands)
      getAdventureNames()
    end
  }
}

function getCommandsList()
  return commandsList
end
