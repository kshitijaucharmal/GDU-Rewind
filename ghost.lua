
function Ghost(x, y, world)
  local ghost = {}
  ghost.debug = false

  ghost.width = 16
  ghost.height = 28
  ghost.scaleX = (ghost.width / assets.tileSize) * 2
  ghost.scaleY = 32 / assets.tileSize

  -- flipped
  ghost.flipped = true
  ghost.stop_factor = 0.3

  -- Physics setup
  ghost.body = love.physics.newBody(world, x, y, "dynamic")
  ghost.shape = love.physics.newRectangleShape(ghost.width, ghost.height)
  ghost.fixture = love.physics.newFixture(ghost.body, ghost.shape)
  ghost.fixture:setUserData("Ghost")
  ghost.body:setFixedRotation(true)

  -- chars
  ghost.jumpForce = 1200
  ghost.speed = 280

  -- move with keyboard
  function ghost.move(self)
    x, y = self.body:getLinearVelocity()

    -- Only move if keypressed
    if love.keyboard.isDown('left', 'a') then
      x = -ghost.speed
      ghost.flipped = true
    elseif love.keyboard.isDown('right', 'd') then
      x = ghost.speed
      ghost.flipped = false
    else
      x = 0
    end

    -- Set the velocity to calculated x and y
    self.body:setLinearVelocity(x, y)
  end

  function ghost.jump(self)
    x, y = self.body:getLinearVelocity()
    -- Set y velocity to jumpForce
    self.body:setLinearVelocity(x, -self.jumpForce)
  end

  function ghost.draw(self)
    -- position
    x = self.body:getX() - ghost.width
    y = self.body:getY() - 32 * 0.5

    local scaleX = ghost.scaleX
    -- Decide orientation
    if ghost.flipped then
      x = self.body:getX() + ghost.width
      scaleX = -ghost.scaleX
    end

    -- Draw ghost Sprite
    love.graphics.draw(assets.tileset, assets.ghost, x, y, 0, scaleX, ghost.scaleY)

    -- Draw hitbox
    if ghost.debug then
      love.graphics.setColor(0, 0, 1)
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
      love.graphics.setColor(1, 1, 1)
    end
  end

  return ghost
end

return Ghost
