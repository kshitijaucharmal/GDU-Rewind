require "states/BaseState"
require "states/Lvl1State"
require "states/TitleScreenState"
require "StateMachine"
push = require "libraries/push"

-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000

function love.load()
  push:setupScreen(virtual_WIDTH, virtual_HEIGHT, WIDTH, HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  love.window.setMode(WIDTH, HEIGHT)
  love.physics.setMeter(128)
  love.window.setTitle("REWIND")

  gStateMachine = StateMachine {

    ['title'] = function() return TitleScreenState() end,
    ['level1'] = function() return Lvl1State() end
  }
  gStateMachine:change("title")
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

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  end
  gStateMachine:check_keypressed(key)
end

function love.keyreleased(key)
  gStateMachine:check_keyreleased(key)
end

--Press Q to Quit
