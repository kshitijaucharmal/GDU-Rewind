-- tile.lua

local Tile = {}

function Tile(tileImg, x, y, world, movement)
  local tile = {}
  tile.debug = false
  tile.tileset = assets.tileset
  tile.image = tileImg
  local halfCellSize = cellSize * 0.5
  local bx = x + halfCellSize
  local by = y + halfCellSize
  tile.body = love.physics.newBody(world, bx, by, movement)
  tile.shape = love.physics.newRectangleShape(cellSize, cellSize)
  tile.fixture = love.physics.newFixture(tile.body, tile.shape)

  function tile:draw()
    -- Check if the body is not destroyed before trying to draw
    if not self.body:isDestroyed() then
      local dx = self.body:getX() - halfCellSize
      local dy = self.body:getY() - halfCellSize
      love.graphics.draw(self.tileset, self.image, dx, dy, 0, cellSize / assets.tileSize, cellSize / assets.tileSize)

      if self.debug then
        love.graphics.setColor(0, 1, 0)
        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.setColor(1, 1, 1)
      end
    end
  end

  function tile:destroy()
    -- Destroy the body and fixture
    if not self.body:isDestroyed() then
      self.body:destroy()
    end
  end

  return tile
end

return Tile
