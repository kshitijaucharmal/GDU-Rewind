-- Colors
require('colors')

require('globals')

-- Load LevelLoader
local lvlgen = require('level_generator')
local ghostClass = require('ghost')
local ghost_spawn_timer = 2

--Track ghost state
local game_ghost_Mode = false

local all_ghosts = {}
local player_at_start = true
local player_dead = false

Lvl2State = Class { __includes = BaseState }

local isGrounded = true
function Lvl2State:init()
    --sound effects
    rewind = love.audio.newSource("assets/sounds/Rewind - Sound Effect.mp3", "static")
    jump_sfx = love.audio.newSource("assets/sounds/Jump effect.mp3", "static")
    bg_music = love.audio.newSource("assets/sounds/Space theme bg.mp3", "stream")

    --love.graphics.setBackgroundColor(150/255, 200/255, 255/255)
    love.physics.setMeter(128)
    world = love.physics.newWorld(0, 2 * 9.81 * 128, true)
    -- Get Info about collisions
    world:setCallbacks(beginContact, endContact)

    -- Spawn Level
    lvlgen:LoadLevel(assets.level2, assets.level2ImgData)
    lvlgen.setup_walls()

    local ghost = ghostClass(-100, -100, world)
    table.insert(all_ghosts, ghost)

    ghostSpawnTimer = 0.0
    player_start_pos = { player.body:getX(), player.body:getY() }

    --loading music
end

-- When two bodies start colliding
function Lvl2State:check_beginContact(a, b, coll)
    if a:getUserData() == "Ground" and b:getUserData() == "Player" then
        -- Just landed on ground
        isGrounded = true
    end
    if a:getUserData() == "Ghost" and b:getUserData() == "Player" then
        -- DIEEEE!!
        player_dead = true
    end
    if a:getUserData() == "Finish" and b:getUserData() == "Player" then
        -- Reached Finish Line
        if game_ghost_Mode then

        else
            all_ghosts[1].posCounter = #player_positions
            game_ghost_Mode = true
            ghostSpawnTimer = 0.0
            player_at_start = false
        end
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

function Lvl2State:reset_game()
    -- Spawn Level
    player_positions = {}
    player.body:setPosition(player_start_pos[1], player_start_pos[2])
    game_ghost_Mode = false
    player_at_start = true
    ghostSpawnTimer = 0.0
    player_dead = false
    for i = #all_ghosts, 1, -1 do
        local g = all_ghosts[i]
        table.remove(all_ghosts, i)
        g:destroy()
    end
    local ghost = ghostClass(-100, -100, world)
    table.insert(all_ghosts, ghost)
end

function Lvl2State:update(dt)
    world:update(dt)

    bg_music:play()
    player:move()

    if player_dead then
        Lvl2State:reset_game()
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
            player:reset_pos()
            player_at_start = true
        end
        --update ghost spawn time
        ghostSpawnTimer = ghostSpawnTimer + dt
        for i = 1, #all_ghosts, 1 do
            if not all_ghosts[i].dead then
                all_ghosts[i]:setPos()
            end
        end
        if ghostSpawnTimer > ghost_spawn_timer then
            ghostSpawnTimer = 0.0
            local newGhost = all_ghosts[1]:clone()
            newGhost.dead = false
            newGhost.posCounter = #player_positions
            table.insert(all_ghosts, newGhost)
        end
    else
        --will store pos of player
        local playerPos = { player.body:getX(), player.body:getY() }
        table.insert(player_positions, playerPos)
    end
end

function Lvl2State:check_keypressed(key)
    if isGrounded and (key == 'up' or key == "w") then
        player:jump()
        isGrounded = false
        jump_sfx:play()
    end
end

function Lvl2State:check_keyreleased(key)
    if (key == 'w' or key == 'up') then
        player:limitJump()
    end
end

function Lvl2State:draw()
    love.graphics.draw(assets.bg, 0, 0, 0, 1, 1)
    lvlgen:draw()

    for i = 1, #all_ghosts, 1 do
        if not all_ghosts[i].dead then
            all_ghosts[i]:draw()
        end
    end
end
