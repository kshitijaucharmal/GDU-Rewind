require "states/BaseState"
require "states/Lvl1State"
require "states/TitleScreenState"
require "StateMachine"
push = require "libraries/push"


-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  love.physics.setMeter(128)
  love.window.setTitle("REWIND")

  gStateMachine = StateMachine {

    ['title'] = function() return TitleScreenState() end,
    ['level1'] = function() return Lvl1State() end
  }
  gStateMachine:change("level1")
end

--To resize the screen
function love.resize(w, h)
  push:resize(w, h)
end

function love.update(dt)
  if love.keypressed('escape') then
    love.event.quit()
  end
  gStateMachine:update(dt)
end

function love.draw()
  push:start()
  gStateMachine:draw()
  push:finish()
end
