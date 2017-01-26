-- commands.lua

require "commands/commandsList"

local commands = {}

function getCommands() -- retrieve all of our comands
  commands = getCommandsList()
end

function cleanInput(text) -- deletes any unneeded spaces
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

  return text
end

function newCommand(text)
  text = cleanInput(text) -- clean up the text if needed

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

  local isFound = false -- if the command is found

  for i = 1, #commands do
    if parsedText[1] == nil then break end

    if parsedText[1]:lower() == commands[i].name then -- if command name matches text
      if commands[i].paramNum == 1 then -- 1 possible parameter
        commands[i].call(commands[i], commands, parsedText[2])
      else -- no parameters
        commands[i].call(commands[i], commands)
      end

      isFound = true
    end
  end

  if isFound == false and parsedText[1] ~= nil then -- if not, return an error
    addLine("Error: '" .. parsedText[1] .. "' is an unknown command.")
  end
end
