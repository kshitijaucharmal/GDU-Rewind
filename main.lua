
-- Importing classes
local playerClass = require('player')
local platformClass = require('platform')

-- Importing Assets
print('Loading Assets.....')
assets = require('load_assets')
print('Done.')

-- Global Values
WIDTH = 800
HEIGHT = 640

-- Setup window
function love.setup()
  love.window.setMode(WIDTH, HEIGHT)
end

-- Setup
love.physics.setMeter(128) -- the height of a meter
-- create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81 * 4
local world = love.physics.newWorld(0, 4*9.81*128, true)

local player = playerClass(WIDTH / 2, HEIGHT - 100, world)
local platforms = {}

-- is player on ground ?
local isGrounded = true

-- Load function
function love.load()
  love.graphics.setBackgroundColor(21/255, 21/255, 21/255)
  -- Get Info about collisions
  world:setCallbacks(beginContact, endContact)

  -- Adding platforms
  local p = platformClass(WIDTH / 2, HEIGHT - 60, WIDTH, 40, world)
  table.insert(platforms, p)
  p = platformClass(WIDTH/2, HEIGHT - 150, 100, 20, world)
  table.insert(platforms, p)
end

-- Update function
function love.update(dt)
  -- Update world physics
  world:update(dt)

  -- move player with keyboard
  player:move()
end

-- When two bodies start colliding
function beginContact(a, b, coll)
  if a:getUserData() == "Player" and b:getUserData() == "Platform" then
    -- Just landed on ground
    isGrounded = true
  end
end

-- When two bodies end colliding
function endContact(a, b, coll)
  if a:getUserData() == "Player" and b:getUserData() == "Platform" then
    -- in the air now
    isGrounded = false
  end
end

function love.keypressed(key)
  -- Jump if w or up
  if isGrounded and (key == 'w' or key == 'up') then
    player:jump()
  end
end

-- draw everything
function love.draw()
  for _, platform in pairs(platforms) do
    platform:draw()
  end
  player:draw()
end
