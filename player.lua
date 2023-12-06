require('globals')

function Player(x, y, world)
  local player = {}
  player.debug = false

  player.start_pos = { x, y }

  player.width = 16
  player.height = 28
  player.scaleX = (player.width / assets.tileSize) * 2
  player.scaleY = 32 / assets.tileSize

  -- flipped
  player.flipped = true
  player.stop_factor = 0.3

  -- Physics setup
  player.body = love.physics.newBody(world, x, y, "dynamic")
  player.shape = love.physics.newCircleShape(player.width - 4)
  player.fixture = love.physics.newFixture(player.body, player.shape)
  player.fixture:setUserData("Player")
  player.fixture:setFriction(0)
  player.body:setFixedRotation(true)
  player.fixture:setCategory(1)
  player.fixture:setMask(5)

  -- chars
  player.jumpForce = 800
  player.speed = 250

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

  function player.reset_pos(self)
    player.body:setPosition(player_start_pos[1], player_start_pos[2])
  end

  function player.draw(self)
    -- position
    x = self.body:getX() - player.width
    y = self.body:getY() - 32 * 0.5

    local scaleX = player.scaleX
    -- Decide orientation
    if player.flipped then
      x = self.body:getX() + player.width
      scaleX = -player.scaleX
    end

    -- Draw Player Sprite
    love.graphics.draw(assets.tileset, assets.player, x, y, 0, scaleX, player.scaleY)

    -- Draw hitbox
    if player.debug then
      love.graphics.setColor(0, 0, 1)
      love.graphics.circle("line", player.body:getX(), player.body:getY(), player.shape:getRadius())
      love.graphics.setColor(1, 1, 1)
    end
  end

  function player.limitJump(self)
    x, y = self.body:getLinearVelocity()
    y = y * self.stop_factor
    self.body:setLinearVelocity(x, y)
  end

  function player:destroy()
    local fixture = self.fixture
    local body = fixture:getBody()

    -- Remove the fixture
    fixture:destroy()

    -- Remove the body
    body:destroy()

    -- Remove references
    self.fixture = nil
    self = nil
  end

  return player
end

return Player
