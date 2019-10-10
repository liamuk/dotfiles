local tiling = require "hs.tiling"
local hotkey = require "hs.hotkey"
local spaces = require "hs._asm.undocumented.spaces"

hs.window.animationDuration = 0

function nextSpace(direction)
  local cur = spaces.activeSpace()
  local screens = spaces.layout()
  for screen in pairs(screens) do
    for i,space in ipairs(screens[screen]) do
      if cur == space then
        return screens[screen][i+direction]
      end
    end
  end
end

-- in karabiner, bind caps_lock to f18
hyper = hs.hotkey.modal.new({}, "F17")
f18 = hs.hotkey.bind({}, "F18", function() hyper:enter() end, function() hyper:exit() end)
hyper:bind({}, "n", function() tiling.cycleScreen(1) end)
hyper:bind({"shift"}, "n", function() tiling.cycleScreen(-1) end)
hyper:bind({}, "j", function() tiling.cycle(1) end)
hyper:bind({}, "k", function() tiling.cycle(-1) end)
hyper:bind({"shift"}, "j", function() tiling.moveWindow(1) end)
hyper:bind({"shift"}, "k", function() tiling.moveWindow(-1) end)
hyper:bind({}, "space", function() tiling.promote() end)
hyper:bind({}, "z", function() tiling.goToLayout("fullscreen") end)
hyper:bind({}, "x", function() tiling.goToLayout("main-vertical-variable") end)
hyper:bind({}, "f", function() tiling.toggleFloat() end)
hyper:bind({}, "h", function() tiling.adjustMainVertical(-0.025) end)
hyper:bind({}, "l", function() tiling.adjustMainVertical(0.025) end)
hyper:bind({}, "=", function() tiling.setMainVertical(0.5) end)
hyper:bind({}, "]", function() spaces.changeToSpace(nextSpace(1)) end)
hyper:bind({}, "[", function() spaces.changeToSpace(nextSpace(-1)) end)
hyper:bind({"shift"}, "]", function() spaces.moveWindowToSpace(hs.window.focusedWindow():id(), nextSpace(1)) end)
hyper:bind({"shift"}, "[", function() spaces.moveWindowToSpace(hs.window.focusedWindow():id(), nextSpace(-1)) end)

tiling.set("defaultLayout", "main-vertical-variable")
tiling.retile()
