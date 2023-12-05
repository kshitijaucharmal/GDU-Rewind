-- Import the Player module


function Ghost(x, y, world)
    local ghost = {}
    ghost.x = x
    ghost.y = y
    ghost.world = world

    ghost.dead = false

    ghost.posCounter = 1

    ghost.debug = false

    -- Properties
    ghost.width = player.width
    ghost.height = player.height
    ghost.scaleX = (player.width / assets.tileSize) * 2 -- Mirrored horizontally
    ghost.scaleY = 32 / assets.tileSize

    -- flipped
    ghost.flipped = true

    -- Physics setup
    ghost.body = love.physics.newBody(world, x, y, "dynamic")
    ghost.shape = love.physics.newRectangleShape(ghost.width, ghost.height)
    ghost.fixture = love.physics.newFixture(ghost.body, ghost.shape)
    ghost.fixture:setUserData("Ghost")
    ghost.body:setFixedRotation(true)
    ghost.fixture:setMask(5)

    function ghost.clone(self)
      local clone = {}
      clone = Ghost(-100, -100, self.world)
      return clone
    end

    --to set pos of player every frame
    function ghost.setPos(self)
        if self.posCounter <= 0 then
          ghost.dead = true
          return
        end

        --as here first index is x then y
        ghost.body:setPosition(player_positions[self.posCounter][1], player_positions[self.posCounter][2])

        --posCounter will dec as we retrive the positions
        self.posCounter = self.posCounter - 1
    end

    function ghost.draw(self)
        -- position
        x = self.body:getX() - self.width
        y = self.body:getY() - 32 * 0.5

        local scaleX = self.scaleX
        -- Decide orientation
        if self.flipped then
            x = self.body:getX() + self.width
            scaleX = -self.scaleX
        end

        -- Draw Ghost sprite Sprite
        love.graphics.draw(assets.tileset, assets.ghost, x, y, 0, scaleX, self.scaleY)

        -- Draw hitbox
        if self.debug then
            love.graphics.setColor(0, 1, 0)
            love.graphics.circle("line", ghost.body:getX(), ghost.body:getY(), ghost.shape:getRadius())
            love.graphics.setColor(1, 1, 1)
        end
    end

    return ghost
end

return Ghost
