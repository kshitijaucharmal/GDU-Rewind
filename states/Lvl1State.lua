Class = require 'libraries/class'
-- Colors
require('colors')
-- Assets
assets = require('load_assets')
push = require "libraries/push"

Lvl1State = Class { __includes = BaseState }

-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000

virtual_WIDTH = 800
virtual_HEIGHT = 640

cellSize = virtual_WIDTH / assets.level1ImgData:getWidth()

-- Load LevelLoader
lvlgen = require('level_generator')
ghostClass = require('ghost')

local isGrounded = true

--Track ghost state
game_ghost_Mode = false

all_ghosts = {}

function Lvl1State:init()
    push:setupScreen(virtual_WIDTH, virtual_HEIGHT, WIDTH, HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    --love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
    love.physics.setMeter(128)
    world = love.physics.newWorld(0, 2 * 9.81 * 128, true)
    -- Get Info about collisions
    world:setCallbacks(beginContact, endContact)


    lvlgen:LoadLevel(assets.level1, assets.level1ImgData)
    local ghost = ghostClass(100, 100, world)
    table.insert(all_ghosts, ghost)

    self.ghostSpawnTimer = 0

    --loading music
    bg_music = love.audio.newSource("assets/sounds/Space theme bg.mp3", "stream")
end

-- When two bodies start colliding
function beginContact(a, b, coll)
    if a:getUserData() == "Ground" and b:getUserData() == "Player" then
        -- Just landed on ground
        isGrounded = true
    end
    if a:getUserData() == "Finish" and b:getUserData() == "Player" then
        -- Reached Finish Line
        game_ghost_Mode = true
    end
end

-- When two bodies end colliding
function endContact(a, b, coll)
    -- Nothing here yet
end

--To resize the screen
function love.resize(w, h)
    push:resize(w, h)
end

function all_ghosts_dead()
  for _, ghost in ipairs(all_ghosts) do
    if ghost.dead then
      return true
    end
  end
end

function Lvl1State:update(dt)
    world:update(dt)

    bg_music:play()
    player:move()

    if game_ghost_Mode then
      for _, ghost in ipairs(all_ghosts) do
        if not ghost.dead then
          ghost:setPos()
        end
      end

      --update ghost spawn time
      self.ghostSpawnTimer = self.ghostSpawnTimer + dt

      if self.ghostSpawnTimer > 2 then
        local newGhost = all_ghosts[1]:clone()
        table.insert(all_ghosts, newGhost)

        self.ghostSpawnTimer = 0
      end
    else
      for _, ghost in ipairs(all_ghosts) do
        --will store pos of player
        ghost:storePos()
      end
    end
end

function love.keypressed(key)
    if isGrounded and (key == 'up' or key == "space") then
        player:jump()
        isGrounded = false
    end
end

function love.keyreleased(key)
    if (key == 'w' or key == 'up') then
        player:limitJump()
    end
end

function Lvl1State:draw()
    push:start()
    love.graphics.draw(assets.bg, 0, 0, 0, 1, 0.7)
    lvlgen:draw()

    if game_ghost_Mode and not all_ghosts_dead() then
      for _, ghost in ipairs(all_ghosts) do
        ghost:draw()

        --Draw all ghost
        --for _, ghostInstance in ipairs(all_ghosts) do
            --ghostInstance:draw()
        --end
      end
    end
    push:finish()
end
