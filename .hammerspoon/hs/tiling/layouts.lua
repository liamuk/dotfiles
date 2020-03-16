local fnutils = require "hs.fnutils"
local layouts = {}

layouts['fullscreen'] = function(windows)
  fnutils.each(windows, function(window)
    window:maximize()
  end)
end

layouts['main-vertical-variable'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  local space = getSpace()
  local mainVertical = space.mainVertical

  if mainVertical == nil then
      mainVertical = 0.5
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    if index == 1 then
      frame.w = frame.w * mainVertical
    else
      frame.x = frame.x + frame.w * mainVertical
      frame.w = frame.w * (1 - mainVertical)
      frame.h = frame.h / (winCount - 1)
      frame.y = frame.y + frame.h * (index - 2)
    end

    win:setFrame(frame)
  end
end

return layouts
