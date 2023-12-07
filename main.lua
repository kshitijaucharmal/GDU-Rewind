require "states/BaseState"
require "states/PlayState"
require "states/TitleScreenState"
require "states/EndScreenState"
require "StateMachine"
push = require "libraries/push"

-- Globals 5:4 ratio
WIDTH = 1250
HEIGHT = 1000
--Virtual Width and Height
virtual_WIDTH = 800
virtual_HEIGHT = 640

--sound effects
rewind = love.audio.newSource("assets/sounds/Rewind_sfx.mp3", "static")
jump_sfx = love.audio.newSource("assets/sounds/Jump effect.mp3", "static")
victory = love.audio.newSource("assets/sounds/Victory Sound Effect.mp3", "stream")
death_sfx = love.audio.newSource("assets/sounds/death_sfx.mp3", "static")

-- Shaders
ghostModeShader = love.graphics.newShader("shaders/ghost_mode.glsl")
glitchShader = love.graphics.newShader("shaders/glitch.glsl")

function love.load()
  push:setupScreen(virtual_WIDTH, virtual_HEIGHT, WIDTH, HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
  -- love.window.setMode(WIDTH, HEIGHT)
  love.window.setTitle("REWIND")

  gStateMachine = StateMachine {

    ['title'] = function() return TitleScreenState() end,
    ['level1'] = function() return PlayState() end,
    ['Endscreen'] = function() return EndScreenState() end
  }
  gStateMachine:change("title")
end

function love.update(dt)
  ghostModeShader:send("u_sepia_opacity", 0.0)
  ghostModeShader:send("u_correct_ratio", false)
  ghostModeShader:send("u_radius", 0.75)
  ghostModeShader:send("u_softness", 0.45)
  ghostModeShader:send("u_vignette_opacity", 0.0)

  ghostModeShader:send("time", love.timer.getTime())
  glitchShader:send("time", love.timer.getTime())

  gStateMachine:update(dt)
end

--To resize the screen
function love.resize(w, h)
  push:resize(w, h)
end

function love.draw()
  push:start()
  gStateMachine:draw()

  --love.graphics.setShader(ghostModeShader)
  love.graphics.setShader(glitchShader)
  push:finish()
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

--Press Q to Quit
