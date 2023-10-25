-- Import the Player module
local Player = require("player")

function Ghost(x, y, world, player)
    local ghost = {}

    -- Properties
    ghost.width = 16
    ghost.height = 28
    ghost.scaleX = -1 -- Mirrored horizontally
    ghost.scaleY = 32 / assets.tileSize

    -- Physics setup
    ghost.body = love.physics.newBody(world, x, y, "dynamic")
    ghost.shape = love.physics.newRectangleShape(ghost.width, ghost.height)
    ghost.fixture = love.physics.newFixture(ghost.body, ghost.shape)
    ghost.fixture:setUserData("Ghost")
    ghost.fixture:setFriction(0)
    ghost.body:setFixedRotation(true)

    -- Speed for automatic movement
    ghost.speed = 280

    -- Automatically move towards player
    function ghost.autoMove(self, playerX)
        local x, y = self.body:getLinearVelocity()
        
        x = 0
        y = 0
        -- Calculate direction to player
        local direction = playerX > self.body:getX() and 1 or -1

        -- Set velocity to move towards the player
        x = direction * self.speed

        self.body:setLinearVelocity(x, y)
    end

    -- Draw function (similar to Player's draw function)
    function ghost.draw(self)
        local x = self.body:getX() - ghost.width
        local y = self.body:getY() - 32 * 0.5

        love.graphics.draw(assets.tileset, assets.ghost, x, y, 0, ghost.scaleX, ghost.scaleY)
    end

    return ghost
end

return Ghost
