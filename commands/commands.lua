-- commands.lua

require "commands/commandsList"

-- a list of surface level commands and their outputs, currently just a HELP command
local command = {
  name = "help", -- aliases: ?
  text = {"Current commands you have access to :",
  "LAUNCH $(ADVENTURE) - Launches a new adventure.",
  "ADVENTURES - Lists all possible adventures.",
  "SETTINGS - Lists all settings/preferences.",
  "CLEAR - Clears the screen.",
  "To view this list again type 'HELP'."}
}

-- once the commandsList.lua file is finished, all commands will be stored in the local variable below
local commands = {}

function newCommand(text)
  -- remove all leading spaces, " help"
  while string.find(text, ' ') == 1 do
    text = string.sub(text, 2, #text)
  end

  -- removes 1 trailing space, "help "
  if string.find(text, ' ') == #text then
    text = string.sub(text, 1, #text - 1)
  end

  if text:lower() == command.name then
    for i = 1, #command.text do
      addLine(command.text[i])
    end
  end
end
