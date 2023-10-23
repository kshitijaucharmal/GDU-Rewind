
function Tile(tileImg, x, y, world, movement)
  local tile = {}
  tile.debug = false
  tile.tileset = assets.tileset
  tile.image = tileImg
  local bx = x + cellSize * 0.5
  local by = y + cellSize * 0.5
  tile.body = love.physics.newBody(world, bx, by, movement)
  tile.shape = love.physics.newRectangleShape(cellSize, cellSize)
  tile.fixture = love.physics.newFixture(tile.body, tile.shape)

  function tile.draw(self)
    local dx = self.body:getX() - cellSize * 0.5
    local dy = self.body:getY() - cellSize * 0.5
    love.graphics.draw(self.tileset, self.image, dx, dy, 0, 40/128, 40/128)

    if self.debug then
      love.graphics.setColor(0, 1, 0)
      love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
      love.graphics.setColor(1, 1, 1)
    end
  end

  return tile
end

return Tile
