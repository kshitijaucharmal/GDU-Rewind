Class = require "libraries/class"
StateMachine = Class {}

function StateMachine:init(states)
    self.empty = {
        draw = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end,
        check_keypressed = function(key) end,
        check_keyreleased = function(key) end,
        check_beginContact = function(a, b, coll) end,
        reset_game = function() end
    }
    self.states = states or {}
    self.current = self.empty
end

function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:draw()
    self.current:draw()
end

function StateMachine:check_keypressed(key)
    self.current:check_keypressed(key)
end

function StateMachine:check_keyreleased(key)
    self.current:check_keyreleased(key)
end

function StateMachine:check_beginContact(a, b, coll)
    self.current:check_beginContact(a, b, coll)
end

function StateMachine:reset_game()
    self.current:reset_game()
end
