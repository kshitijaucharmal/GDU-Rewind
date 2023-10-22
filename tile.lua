
function Tile(tileImg, x, y, world, movement)
  local tile = {}
  tile.tileset = assets.tileset
  tile.image = tileImg
  tile.body = love.physics.newBody(world, x, y, movement)
  tile.shape = love.physics.newRectangleShape(cellSize, cellSize)
  tile.fixture = love.physics.newFixture(tile.body, tile.shape)

  function tile.draw(self)
    --love.graphics.rectangle("fill", self.body:getWorldPoints(self.shape:getPoints()))
    love.graphics.draw(self.tileset, self.image, self.body:getX(), self.body:getY(), 0, 40/128, 40/128)
  end

  return tile
end

return Tile
