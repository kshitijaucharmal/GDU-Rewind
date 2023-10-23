
-- Globals
WIDTH = 800
HEIGHT = 640
cellSize = 800 / 20

-- Colors
require('colors')
-- Assets
assets = require('load_assets')

-- Load LevelLoader
lvlgen = require('level_generator')

function love.load()
  love.window.setMode(WIDTH, HEIGHT)
  love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
  love.physics.setMeter(128)
  world = love.physics.newWorld(0, 2 * 9.81 * 128, true)

  lvlgen:LoadLevel()
end

function love.update(dt)
  world:update(dt)

  player:move()
end

function love.keypressed(key)
  if key == 'w' or key == 'up' then
    player:jump()
  end
end

function love.draw()
  lvlgen:draw()
end
