-- commands.lua

-- a list of surface level commands and their outputs
local command = {
  name = "help", -- aliases: ?
  text = {"Current commands you have access to :",
  "LAUNCH $(ADVENTURE) - Launches a new adventure.",
  "ADVENTURES - Lists all possible adventures.",
  "To view this list again type 'HELP'."}
}

function newCommand(text)
  -- remove all front spaces, " "
  --while string.find(text, ' ') == ' ' do
    --string.find(text, ' ')
  --end

  if text:lower() == command.name then
    for i = 1, #command.text do
      addLine(command.text[i])
    end
  end
end
