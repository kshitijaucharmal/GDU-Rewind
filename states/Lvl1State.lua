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
ghost_spawn_timer = 1

virtual_WIDTH = 800
virtual_HEIGHT = 640

cellSize = virtual_WIDTH / assets.level1ImgData:getWidth()

-- Load LevelLoader
lvlgen = require('level_generator')
ghostClass = require('ghost')
playerClass = require('player')

local isGrounded = true

--Track ghost state
game_ghost_Mode = false
player_positions = {}

all_ghosts = {}
no_player = false
player_at_start = true
player_start_pos = {}

function Lvl1State:init()
  --sound effects
  rewind = love.audio.newSource("assets/sounds/Rewind - Sound Effect.mp3", "static")
  jump_sfx = love.audio.newSource("assets/sounds/Jump effect.mp3", "static")

  --love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
  love.physics.setMeter(128)
  world = love.physics.newWorld(0, 2 * 9.81 * 128, true)
  -- Get Info about collisions
  world:setCallbacks(beginContact, endContact)

  lvlgen:LoadLevel(assets.level1, assets.level1ImgData)
  local ghost = ghostClass(-100, -100, world)
  table.insert(all_ghosts, ghost)

  self.ghostSpawnTimer = 0
  player_start_pos = { player.body:getX(), player.body:getY() }

  --loading music
  bg_music = love.audio.newSource("assets/sounds/Space theme bg.mp3", "stream")
end

-- When two bodies start colliding
function beginContact(a, b, coll)
  if a:getUserData() == "Ground" and b:getUserData() == "Player" then
    -- Just landed on ground
    isGrounded = true
  end
  if a:getUserData() == "Ghost" and b:getUserData() == "Player" then
    -- DIEEEE!!
    player.fixture:destroy()
  end
  if a:getUserData() == "Finish" and b:getUserData() == "Player" then
    -- Reached Finish Line
    all_ghosts[1].posCounter = #player_positions
    game_ghost_Mode = true
    player_at_start = false
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

function Lvl1State:update(dt)
  world:update(dt)

  bg_music:play()
  player:move()

  if game_ghost_Mode then
    -- --play rewind sfx
    rewind:play()
    rewind:stop()

    if not player_at_start then
      player:reset_pos()
      player_at_start = true
    end
    --update ghost spawn time
    self.ghostSpawnTimer = self.ghostSpawnTimer + dt
    for i = 1, #all_ghosts, 1 do
      if not all_ghosts[i].dead then
        all_ghosts[i]:setPos()
      end
    end
    for i = #all_ghosts, 1, -1 do
      if all_ghosts[i].dead then
        table.remove(all_ghosts, i)
      end
    end
    if self.ghostSpawnTimer > ghost_spawn_timer then
      local newGhost = all_ghosts[1]:clone()
      newGhost.posCounter = #player_positions
      table.insert(all_ghosts, newGhost)
      self.ghostSpawnTimer = 0
    end
  else
    --will store pos of player
    local playerPos = { player.body:getX(), player.body:getY() }
    table.insert(player_positions, playerPos)
  end
end

function Lvl1State:check_keypressed(key)
  if isGrounded and (key == 'up' or key == "w") then
    player:jump()
    isGrounded = false
    jump_sfx:play()
  end
end

function Lvl1State:check_keyreleased(key)
  if (key == 'w' or key == 'up') then
    player:limitJump()
  end
end

function Lvl1State:draw()
  love.graphics.draw(assets.bg, 0, 0, 0, 1, 0.7)
  lvlgen:draw()

  for i = 1, #all_ghosts, 1 do
    if not all_ghosts[i].dead then
      all_ghosts[i]:draw()
    end
  end
end
