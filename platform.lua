
function Platform(x, y, w, h, world)
  local platform = {}
  -- Physics setup
  platform.body = love.physics.newBody(world, x, y, "static")
  platform.shape = love.physics.newRectangleShape(w, h)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.fixture:setUserData("Platform")

  function platform.draw(self)
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.setColor(1, 1, 1)
  end

  return platform
end

return Platform
