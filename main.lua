-- Colors
require('colors')
-- Assets
assets = require('load_assets')

-- Globals
WIDTH = 800
HEIGHT = 640
cellSize = WIDTH / assets.levelImgData:getWidth()

-- Load LevelLoader
lvlgen = require('level_generator')

local isGrounded = true

--Temp states
game_ghost_Mode = false

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  --love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
  love.physics.setMeter(128)
  world = love.physics.newWorld(0, 2 * 9.81 * 128, true)
  -- Get Info about collisions
  world:setCallbacks(beginContact, endContact)


  lvlgen:LoadLevel()
end

-- When two bodies start colliding
function beginContact(a, b, coll)
  if a:getUserData() == "Ground" and b:getUserData() == "Player" then
    -- Just landed on ground
    isGrounded = true
  end
end

-- When two bodies end colliding
function endContact(a, b, coll)
  -- Nothing here yet
end

function love.update(dt)
  world:update(dt)

  player:move()
end

function love.keypressed(key)
  if isGrounded and (key == 'w' or key == 'up') then
    player:jump()
    isGrounded = false
  end
end

function love.keyreleased(key)
  if (key == 'w' or key == 'up') then
    player:limitJump()
  end
end

function love.draw()
  love.graphics.draw(assets.bg, 0, 0, 0, 1, 0.7)
  lvlgen:draw()
end
