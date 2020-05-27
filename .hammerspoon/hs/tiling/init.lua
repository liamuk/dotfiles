local tiling = {}

local spaces = require "hs._asm.undocumented.spaces"
local layouts = require "hs.tiling.layouts"

local currentWindows = {}
local spaceInfos = {}
local settings = { defaultLayout = "main-vertical-variable" }

local excluded = {}

tileTimer = hs.timer.doAfter(0, function() end);

-- navigate to layout by name
function tiling.goToLayout(name)
  local space = getSpace()
  if layouts[name] ~= nil then
    space.layout = name
    hs.alert.show(space.layout)
    apply(space.windows, space.layout)
  else
    hs.alert.show('Layout ' .. name .. ' does not exist', 1)
  end
end

function tiling.toggleFloat()
  local id = hs.window:focusedWindow():id()
  excluded[id] = not excluded[id]
  tiling.retile()
end

function tiling.set(name, value)
  settings[name] = value
end

function tiling.setWindows(windows)
  currentWindows = windows
end

function tiling.retile()
  tileTimer:stop()
  tileTimer = hs.timer.doAfter(0.05, function ()
    local space = getSpace()
    apply(space.windows, space.layout)
  end)
end

function tiling.cycleScreen(direction)
  local space = getSpace()
  local nextScreen
  if direction == 1 then
    nextScreen = hs.screen.mainScreen():next()
  else
    nextScreen = hs.screen.mainScreen():previous()
  end
  local windows = hs.fnutils.filter(hs.window.visibleWindows(), function (w)
    return
      not excluded[w:id()] and
      w:isStandard() and
      w:screen() == nextScreen
  end)
  print("focusing ", windows[1])
  -- it is necessary to call becomemain if we are already focused on the app
  windows[1]:becomeMain()
  windows[1]:focus()
end

function tiling.cycle(direction)
  print("switching")
  local space = getSpace()
  print("switching to ", space.windows[nextIndex])
  for k, v in pairs(space.windows) do
    print(k, v)
  end
  local win = hs.window:focusedWindow() or space.windows[1]
  local currentIndex = hs.fnutils.indexOf(space.windows, win)
  local layout = space.layout
  if not currentIndex then return end
  nextIndex = currentIndex + direction
  if nextIndex > #space.windows then
    nextIndex = 1
  elseif nextIndex < 1 then
    nextIndex = #space.windows
  end
  -- it is necessary to call becomemain if we are already focused on the app
  space.windows[nextIndex]:becomeMain()
  space.windows[nextIndex]:focus()
end

function tiling.promote()
  local space = getSpace()
  local windows = space.windows
  local win = hs.window:focusedWindow() or windows[1]
  local i = hs.fnutils.indexOf(windows, win)
  if not i then return end

  local current = table.remove(windows, i)
  table.insert(windows, 1, current)
  win:focus()
  apply(windows, space.layout)
end

function tiling.moveWindow(direction)
  local space = getSpace()
  local windows = space.windows
  local win = hs.window:focusedWindow() or windows[1]
  local i = hs.fnutils.indexOf(windows, win)
  if not i then return end
  if i+direction < 1 or i+direction > #windows then return end

  local current = table.remove(windows, i)
  table.insert(windows, i+direction, current)
  win:focus()
  apply(windows, space.layout)
end

function tiling.setMainVertical(val)
  if val > 0 and val < 1 then
    local space = getSpace()
    if space.layout == 'main-vertical-variable' then
      space.mainVertical = val
      tiling.retile()
    end
  end
end

function tiling.adjustMainVertical(factor)
  local space = getSpace()
  if space.layout == 'main-vertical-variable' then
    if space.mainVertical == nil then
      space.mainVertical = 0.5
    end
    tiling.setMainVertical(space.mainVertical + factor)
  end
end

function apply(windows, layout)
  layouts[layout](windows)
end

function getSpace()
  local spaceID = spaces.activeSpace()
  local spaceInfo = {}
  trueWindows = hs.fnutils.filter(currentWindows, function (w)
    return
      not excluded[w:id()] and
      not (w:application():title() == "Electron") and
      not (w:application():title() == "Siempre") and
      w:isStandard() and
      w:screen() == hs.screen.mainScreen()
  end)

  if spaceInfos[spaceID] == nil then
    spaceInfo.windows = trueWindows
    spaceInfo.layout = settings.defaultLayout
    spaceInfos[spaceID] = spaceInfo
  else
    spaceInfo = spaceInfos[spaceID]
    spaceInfo.windows = hs.fnutils.filter(spaceInfo.windows, function(win)
      return hs.fnutils.contains(trueWindows, win)
    end)
    hs.fnutils.each(trueWindows, function(win)
      if hs.fnutils.contains(spaceInfo.windows, win) == false then
        table.insert(spaceInfo.windows, win)
      end
    end)
  end
  spaceInfo.windows = hs.fnutils.filter(spaceInfo.windows, function(win)
    return win:isStandard()
  end)

  return spaceInfo
end

local windows = hs.window.filter.new():setOverrideFilter({currentSpace=true});
windows.forceRefreshOnSpaceChange = true
windows:subscribe(
  hs.window.filter.windowMoved,
  function (win)
    tiling.setWindows(windows:getWindows())
    local space = getSpace()
    if win == space.windows[1] then
       tiling.setMainVertical(win:frame().w/win:screen():frame().w)
    elseif hs.fnutils.contains(space.windows, win) then
      tiling.setMainVertical(1-(win:frame().w/win:screen():frame().w))
    else
      tiling.retile()
    end
  end
)
windows:subscribe(
  {hs.window.filter.windowCreated,
  hs.window.filter.windowDestroyed,
  hs.window.filter.windowInCurrentSpace,
  hs.window.filter.windowNotInCurrentSpace},
  function ()
    tiling.setWindows(windows:getWindows())
    tiling.retile()
  end
)

return tiling
