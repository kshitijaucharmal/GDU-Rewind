Class = require 'libraries/class'

require('globals')

EndScreenState = Class { __includes = BaseState }



function EndScreenState:init()
    if player_health > 0 then
        EndScreen = love.graphics.newImage("assets/EndScreen.png")
        victory:play()
    else
        GameOverScreen = love.graphics.newImage("assets/GameOver.png")
        GameOver_sfx:play()
    end
end

function EndScreenState:draw()
    if player_health > 0 then
        love.graphics.draw(EndScreen, -25, 0, 0, 0.7, 0.7)
    else
        love.graphics.draw(GameOverScreen, -25, 0, 0, 0.7, 0.7)
    end
end

function EndScreenState:check_keypressed(key)
    if key == "space" then
        victory:stop()
        GameOver_sfx:stop()
        gStateMachine:change("title")
    end
end
