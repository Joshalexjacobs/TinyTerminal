-- commandsList.lua

local commandsList = {
  { -- 1
    name = "help", -- command name
    text = {""}, -- text if needed
    desc = "HELP - Outputs all possible commands.", -- description
    paramNum = 0, -- number of parameters
    call = function(command, commands) -- command function when called
      for i = 1, #commands do
        addLine(commands[i].desc)
      end
    end
  },
  { -- 2
    name = "clear",
    text = {""},
    desc = "CLEAR - Clears the screen.",
    paramNum = 0,
    call = function(command, commands, param)
      --param = param or nil
      clearLines()
    end
  },
  { -- 3
    name = "adventures",
    text = {""},
    desc = "ADVENTURES - Lists all available adventures.",
    paramNum = 0, -- gives a description of the adventure "adventures dungeon"
    call = function(command, commands)
      getAdventureNames()
    end
  },
  { -- 4 etc..
    name = "play",
    text = {""},
    desc = "PLAY $ADVENTURE - Launches an adventure to play.",
    paramNum = 1,
    call = function(command, commands, name)
      name = name or nil

      if name == nil then
        getAdventureNames() -- if name is nil, return list of adventures
      else
        print(name)
        --setAdventure(getAdventure(name)) -- else, set adventure
      end
    end
  },
  {
    name = "exit",
    text = {""},
    desc = "EXIT - Closes the terminal.",
    paramNum = 0,
    call = function(command, commands)
      love.event.quit()
    end
  }
}

function getCommandsList()
  return commandsList
end
