Class = require "libraries/class"
BaseState = Class {}

function BaseState:init() end

function BaseState:enter() end

function BaseState:exit() end

function BaseState:update(dt) end

function BaseState:draw() end

function BaseState:check_keypressed(key) end

function BaseState:check_keyreleased(key) end

function BaseState:check_beginContact(a, b, coll) end

function BaseState:reset_game() end
