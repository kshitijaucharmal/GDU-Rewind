require "states/BaseState"
require "states/Lvl1State"
require "states/TitleScreenState"
require "StateMachine"

-- Globals
WIDTH = 800
HEIGHT = 640

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  love.physics.setMeter(128)

  gStateMachine = StateMachine {

    ['title'] = function() return TitleScreenState() end,
    ['level1'] = function() return Lvl1State() end
  }
  gStateMachine:change("level1")
end

function love.update(dt)
  gStateMachine:update(dt)
end

function love.draw()
  gStateMachine:draw()
end
