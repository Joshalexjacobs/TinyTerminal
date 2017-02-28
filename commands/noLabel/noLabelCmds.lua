-- noLabelCmds.liu

local noLabelCmds = {
  { -- 1
    name = "look", -- command name
    alias = {"examine", "check", "look inside", "investigate"}, -- other words that will trigger this command
    text = {""}, -- text if needed
    desc = "", -- description
    paramNum = 0, -- number of parameters
    call = function(event) -- command function when called
      addLine(event.desc)
    end
  },
  { -- 2
    name = "open",
    alias = {"cut", "tear", "open box", "cut open", "cut box"},
    text = {""},
    desc = "",
    paramNum = 0,
    call = function(event)
      if event.state == "close" then
        event.state = "open"
        event.desc = "There appears to be something inside."
        addLine("You open the box.")
        -- change box animation to open
      else
        addLine("The box is already open")
      end

    end
  },
  { -- 3
    name = "help", -- command name
    alias = {"?", "hint"}, -- other words that will trigger this command
    text = {""}, -- text if needed
    desc = "", -- description
    paramNum = 0, -- number of parameters
    call = function(event) -- command function when called
      if event.state == "close" then
        addLine("Maybe I should open it?")
      elseif event.state == "open" then
        addLine("I think there's something in there.")
      elseif event.state == "bomb" then
        addLine("Looks like a bomb... Feels like a bomb...")
        addLine("I should probably not let this thing blow up.")
      end
    end
  },
  { -- 4
    name = "grab", -- command name
    alias = {"pick up"}, -- other words that will trigger this command
    text = {""}, -- text if needed
    desc = "", -- description
    paramNum = 0, -- number of parameters
    call = function(event) -- command function when called
      if event.state == "open" then
        addLine("You reach inside and pull out a bomb.")
        event.desc = "You're holding what appears to be a bomb. There are 4 wires: Red, Blue, Yellow, and Green"
        event.state = "bomb"
      elseif event.state == "bomb" then
        addLine("You're already holding the bomb.")
      else
        addLine("There is nothing to grab.")
      end
    end
  },
}

return noLabelCmds
