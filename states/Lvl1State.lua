Class = require 'libraries/class'
-- Colors
require('colors')

require('globals')

-- Load LevelLoader
local lvlgen = require('level_generator')
local ghostClass = require('ghost')
local ghost_spawn_time = 2

--Track ghost state
local game_ghost_Mode = false

local player_at_start = true
local player_dead = false
local load_next_level = false
local level_number = 1

Lvl1State = Class { __includes = BaseState }

local isGrounded = true
function Lvl1State:init()
  --love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
  love.physics.setMeter(128)
  self.world = love.physics.newWorld(0, 2 * 9.81 * 128, true)
  -- Get Info about collisions
  self.world:setCallbacks(self.beginContact, self.endContact)
  self.player_positions = {}

  -- Spawn Level
  lvlgen:LoadLevel(assets.levels[level_number], assets.level_datas[level_number], self.world)
  self.player = lvlgen.level.player

  self.all_ghosts = {}
  local ghost = ghostClass(-100, -100, self.world)
  table.insert(self.all_ghosts, ghost)

  self.ghostSpawnCtr = 0.0
  player_start_pos = { self.player.body:getX(), self.player.body:getY() }

  --loading music
  self.bg_music = love.audio.newSource("assets/sounds/Space theme bg.mp3", "stream")
end

-- When two bodies start colliding
function Lvl1State:beginContact(body1, body2, coll)
  if body1:getUserData() == "Ground" and body2:getUserData() == "Player" then
    -- Just landed on ground
    isGrounded = true
  end
  if body1:getUserData() == "Ghost" and body2:getUserData() == "Player" then
    -- DIEEEE!!
    player_dead = true
  end
  if body1:getUserData() == "Finish" and body2:getUserData() == "Player" then
    -- Reached Finish Line
    if game_ghost_Mode then
      load_next_level = true
    else
      self.all_ghosts[1].posCounter = #self.player_positions
      game_ghost_Mode = true
      self.ghostSpawnCtr = 0.0
      player_at_start = false
    end
  end
end

-- When two bodies end colliding
function Lvl1State:endContact(a, b, coll)
  -- Nothing here yet
end

function Lvl1State:reset_game()
  -- Spawn Level
  self.player_positions = {}
  self.player.body:setPosition(player_start_pos[1], player_start_pos[2])
  game_ghost_Mode = false
  player_at_start = true
  self.ghostSpawnCtr = 0.0
  player_dead = false
  for i = #self.all_ghosts,1, -1 do
    local g = self.all_ghosts[i]
    table.remove(self.all_ghosts, i)
    g:destroy()
  end
  local ghost = ghostClass(-100, -100, self.world)
  table.insert(self.all_ghosts, ghost)
end

function Lvl1State:next_level()
  for i = #lvlgen.level, 1, -1 do
    if lvlgen.level[i].fixture:getUserData() ~= "Player" then
      lvlgen.level[i]:destroy()
      table.remove(lvlgen.level, i)
    end
  end
  level_number = level_number + 1
  if level_number > #assets.levels then
    level_number = 1
  end
  self.player = {}
  lvlgen:LoadLevel(assets.levels[level_number], assets.level_datas[level_number])
  player_start_pos = { self.player.body:getX(), self.player.body:getY() }
  load_next_level = false
  self:reset_game()
end

function Lvl1State:update(dt)
  self.world:update(dt)

  self.bg_music:play()
  self.player:move()

  if load_next_level then
    self:next_level()
    return
  end

  if player_dead then
    self:reset_game()
  end

  if game_ghost_Mode then
    -- Shader Stuff
    ghostModeShader:send("u_vignette_opacity", 0.8)
    ghostModeShader:send("u_correct_ratio", false)
    ghostModeShader:send("u_radius", 0.8)
    ghostModeShader:send("u_softness", 0.45)
    ghostModeShader:send("u_sepia_opacity", 0.5)

    -- --play rewind sfx
    rewind:play()
    rewind:stop()

    if not player_at_start then
      self.player:reset_pos()
      player_at_start = true
    end
    --update ghost spawn time
    self.ghostSpawnCtr = self.ghostSpawnCtr + dt
    for i = 1, #self.all_ghosts, 1 do
      if not self.all_ghosts[i].dead then
        self.all_ghosts[i]:setPos()
      end
    end
    if self.ghostSpawnCtr > ghost_spawn_time then
      self.ghostSpawnCtr = 0.0
      local newGhost = self.all_ghosts[1]:clone()
      newGhost.dead = false
      newGhost.posCounter = #self.player_positions
      table.insert(self.all_ghosts, newGhost)
    end

  else
    --will store pos of player
    local playerPos = { self.player.body:getX(), self.player.body:getY() }
    table.insert(self.player_positions, playerPos)
  end
end

function Lvl1State:check_keypressed(key)
  if isGrounded and (key == 'up' or key == "w") then
    self.player:jump()
    isGrounded = false
    jump_sfx:play()
  end
end

function Lvl1State:check_keyreleased(key)
  if (key == 'w' or key == 'up') then
    self.player:limitJump()
  end
end

function Lvl1State:draw()
  love.graphics.draw(assets.bg, 0, 0, 0, 1, 1)
  lvlgen:draw()

  for i = 1, #self.all_ghosts, 1 do
    if not self.all_ghosts[i].dead then
      self.all_ghosts[i]:draw()
    end
  end
end
