-- commands.lua

require "commands/commandsList"

-- once the commandsList.lua file is finished, all commands will be stored in the local variable below
local commands = {}

function getCommands()
  commands = getCommandsList()
end

function newCommand(text)
  -- remove all leading spaces, " help"
  while string.find(text, ' ') == 1 do
    text = string.sub(text, 2, #text)
  end

  -- removes 1 trailing space, "help "
  if string.find(text, ' ') == #text then
    text = string.sub(text, 1, #text - 1)
  end

  -- !!!
  -- before i can write the code to parse the parameter, i neeed to figure out how to remove
  -- all trailing spaces from input. that way i can find the single remaining space and divy up
  -- each command. if there are 2 remaining spaces after all leading and trailing spaces are removed,
  -- call an error for now. in the future it can be chopped up into 1 - X parameters.

  local isFound = false

  for i = 1, #commands do
    if text:lower() == commands[i].name then -- if command name matches text
      if commands[i].paramNum > 0 then
        commands[i].call(commands[i], commands, "oof")
      else
        commands[i].call(commands[i], commands)
      end
      isFound = true
    end
  end

  if isFound ~= true then
    addLine("Error: '" .. text .. "' is an unknown command.")
  end
end
