require "states/BaseState"
require "states/Lvl1State"
require "states/Lvl2State"
require "states/TitleScreenState"
require "StateMachine"
push = require "libraries/push"
Class = require "libraries/class"

-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000

--sound effects
rewind = love.audio.newSource("assets/sounds/rewind_sfx.mp3", "static")
jump_sfx = love.audio.newSource("assets/sounds/Jump effect.mp3", "static")
bg_music = love.audio.newSource("assets/sounds/Space theme bg.mp3", "stream")
death_sfx = love.audio.newSource("assets/sounds/death_sfx.mp3", "static")


function love.load()
  push:setupScreen(virtual_WIDTH, virtual_HEIGHT, WIDTH, HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  love.window.setMode(WIDTH, HEIGHT)
  love.window.setTitle("REWIND")

  ghostModeShader = love.graphics.newShader("shaders/ghost_mode.glsl")

  gStateMachine = StateMachine {

    ['title'] = function() return TitleScreenState() end,
    ['level1'] = function() return Lvl1State() end,
    ['level2'] = function() return Lvl2State() end
  }
  gStateMachine:change("title")
end

function love.update(dt)
  ghostModeShader:send("u_sepia_opacity", 0.0)
  ghostModeShader:send("u_correct_ratio", false)
  ghostModeShader:send("u_radius", 0.75)
  ghostModeShader:send("u_softness", 0.45)
  ghostModeShader:send("u_vignette_opacity", 0.0)

  gStateMachine:update(dt)
end

function love.draw()
  push:start()
  gStateMachine:draw()
  push:finish()
  love.graphics.setShader(ghostModeShader)
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  gStateMachine:check_keypressed(key)
end

function love.keyreleased(key)
  gStateMachine:check_keyreleased(key)
end

function beginContact(a, b, coll)
  gStateMachine:check_beginContact(a, b, coll)
end

--Press Q to Quit
--To resize the screen
function love.resize(w, h)
  push:resize(w, h)
end
