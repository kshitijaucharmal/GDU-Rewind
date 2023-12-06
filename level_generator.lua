function LevelLoader()
  local mapper = require('mapper')

  local lvlgen = {}
  lvlgen.level = {}

  function lvlgen.LoadLevel(self, currentLevel, currentLevelImgData)
    for i = 1, currentLevel:getWidth() do
      for j = 1, currentLevel:getHeight() do
        local r, g, b, a = currentLevelImgData:getPixel(i - 1, j - 1)

        -- Skip alpha
        if a == 0 then goto continue end

        local x = (i - 1) * cellSize
        local y = (j - 1) * cellSize
        mapper.mapColorToTile({ r, g, b }, x, y, self.level)

        ::continue::
      end
    end
  end

  function lvlgen.setup_walls()
    -- Create walls as static bodies
    local leftWall = love.physics.newBody(world, 0, love.graphics.getHeight() / 2)
    local rightWall = love.physics.newBody(world, virtual_WIDTH, love.graphics.getHeight() / 2)
    local topWall = love.physics.newBody(world, love.graphics.getWidth() / 2, 0)
    local bottomWall = love.physics.newBody(world, love.graphics.getWidth() / 2, love.graphics.getHeight())

    -- Create shapes for the walls
    local leftWallShape = love.physics.newEdgeShape(0, -love.graphics.getHeight() / 2, 0, love.graphics.getHeight() / 2)
    local rightWallShape = love.physics.newEdgeShape(0, -love.graphics.getHeight() / 2, 0, love.graphics.getHeight() / 2)
    local topWallShape = love.physics.newEdgeShape(-love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, 0)
    local bottomWallShape = love.physics.newEdgeShape(-love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, 0)

    -- Attach shapes to the walls
    love.physics.newFixture(leftWall, leftWallShape)
    love.physics.newFixture(rightWall, rightWallShape)
    love.physics.newFixture(topWall, topWallShape)
    love.physics.newFixture(bottomWall, bottomWallShape)
  end

  function lvlgen.draw(self)
    for _, tile in ipairs(self.level) do
      tile:draw()
    end
  end

  return lvlgen
end

return LevelLoader()
