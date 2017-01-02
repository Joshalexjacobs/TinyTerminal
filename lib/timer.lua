-- timer.lua --

timer = {
  time = nil,
  label = nil
}

function addTimer(startTime, name, timerList)
  local newTimer = copy(timer, newTimer)
  newTimer.time, newTimer.label = startTime, name

  table.insert(timerList, newTimer)
end

local function findTimer(name, timerList)
  for i = 1, #timerList do
    if timerList[i].label == name then return i end
  end

  return 0
end

function checkTimer(name, timerList)
  if #timerList <= 0 then return false end

  index = findTimer(name, timerList)
  if index == 0 then return false
  elseif timerList[index].label == name then
    return true
  end
end

function resetTimer(startTime, name, timerList)
  timerList[findTimer(name, timerList)].time = startTime
end

function updateTimer(dt, name, timerList) -- update all existing timers
  if #timerList <= 0 then
    --print("no timers found")
    return false
  end -- if timerList does not contain any timers

  index = findTimer(name, timerList)

  if index == 0 then return false end

  if timerList[index].time <= 0 then
    return true
  elseif timerList[index].time > 0 then
    timerList[index].time = timerList[index].time - dt
    return false
  end
end

function deleteTimer(name, timerList)
  table.remove(timerList, findTimer(name, timerList))
end
