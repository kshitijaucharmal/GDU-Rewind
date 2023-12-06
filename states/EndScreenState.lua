Class = require 'libraries/class'

require('globals')

EndScreenState = Class { __includes = BaseState }

function EndScreenState:init()
    EndScreen = love.graphics.newImage("assets/EndScreen.png")
    victory:play()
end

function EndScreenState:draw()
    love.graphics.draw(EndScreen, -25, 0, 0, 0.7, 0.7)
    -- love.graphics.draw(drawable,x,y,r,sx,sy,ox,oy)
end

function EndScreenState:check_keypressed(key)
    if key == "space" then
        victory:stop()
        gStateMachine:change("title")
    end
end
