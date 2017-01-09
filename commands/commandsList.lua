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
  }
}

function getCommandsList()
  return commandsList
end
