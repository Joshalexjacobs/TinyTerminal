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

  -- removes all trailing spaces, "help "
  for i = 1, #text do
    if string.find(text, ' ', #text) == #text then
      text = string.sub(text, 1, #text - 1)
    end
  end

  -- create command/parameter array
  local parsedText = {}

  -- find any spaces in-between commands
  while string.find(text, ' ', 1) ~= nil do -- while there are remaining spaces, add item to parsedText
    local tempText = string.sub(text, 1, string.find(text, ' ', 1) - 1)
    table.insert(parsedText, tempText)
    text = string.sub(text, string.find(text, ' ', 1) + 1, #text)
  end

  if #text > 0 then -- add remaining text to parsedText
    table.insert(parsedText, text)
  end

  local isFound = false

  for i = 1, #commands do
    if parsedText[1]:lower() == commands[i].name then -- if command name matches text
      if commands[i].paramNum == 1 then -- 1 possible parameter
        commands[i].call(commands[i], commands, parsedText[2])
      else -- no parameters
        commands[i].call(commands[i], commands)
      end

      isFound = true
    end
  end

  if isFound == false then
    addLine("Error: '" .. parsedText[1] .. "' is an unknown command.")
  end
end
