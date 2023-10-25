-- Import the Player module


function Ghost(x, y, world, player)
    local ghost = {}

    -- all players position
    ghost.all_pos = {}
    ghost.posCounter = 0

    -- Properties
    ghost.width = player.width
    ghost.height = player.height
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


    --to store pos of player every frame
    function ghost.storePos(self)
        local playerPos = { player.body:getX(), player.body:getY() }
        table.insert(self.all_pos, playerPos)

        self.posCounter = self.posCounter + 1
    end

    --to set pos of player every frame
    function ghost.setPos(self)
        ghost.body:setPosisition(ghost.all_pos[self.posCounter][1], ghost.all_pos[self.posCounter][2])
        self.posCounter = self.posCounter - 1
    end

    return ghost
end

return Ghost
