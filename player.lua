
function Player(x, y, world)
  local player = {}
  player.width = 32
  player.height = 32
  player.scaleX = player.width / assets.tileSize
  player.scaleY = player.height / assets.tileSize

  -- flipped
  player.flipped = true

  -- Physics setup
  player.body = love.physics.newBody(world, x, y, "dynamic")
  player.shape = love.physics.newRectangleShape(player.width, player.height)
  player.fixture = love.physics.newFixture(player.body, player.shape)
  player.fixture:setUserData("Player")
  player.fixture:setFriction(0)
  player.body:setFixedRotation(true)

  -- chars
  player.jumpForce = 1200
  player.speed = 280

  -- move with keyboard
  function player.move(self)
    x, y = self.body:getLinearVelocity()

    -- Only move if keypressed
    if love.keyboard.isDown('left', 'a') then
      x = -player.speed
      player.flipped = true
    elseif love.keyboard.isDown('right', 'd') then
      x = player.speed
      player.flipped = false
    else
      x = 0
    end

    -- Set the velocity to calculated x and y
    self.body:setLinearVelocity(x, y)
  end

  function player.jump(self)
    x, y = self.body:getLinearVelocity()
    -- Set y velocity to jumpForce
    self.body:setLinearVelocity(x, -self.jumpForce)
  end

  function player.draw(self)
    -- Draw hitbox
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))

    -- position
    x = self.body:getX() - player.width * 0.5
    y = self.body:getY() - player.height * 0.5

    local scaleX = player.scaleX
    -- Decide orientation
    if player.flipped then
      x = self.body:getX() + player.width * 0.5
      scaleX = -player.scaleX
    end

    -- Draw Player Sprite
    love.graphics.draw(assets.tileset, assets.player, x, y, 0, scaleX, player.scaleY)
  end

  return player
end

return Player
