
function Assets()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local assets = {}

  assets.tileSize = 128
  assets.tileset = love.graphics.newImage("assets/spritesheet_retina.png")
  
  -- Rect Shape
  --assets.player = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 1, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  --assets.ghost = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 2, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  
  -- Capsule Shape
  assets.player = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 5, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.ghost = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 6, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())

  -- Numbers
  assets.zero = love.graphics.newQuad(assets.tileSize * 1, assets.tileSize * 6, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.one = love.graphics.newQuad(assets.tileSize * 1, assets.tileSize * 5, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.two = love.graphics.newQuad(assets.tileSize * 2, assets.tileSize * 3, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.three = love.graphics.newQuad(assets.tileSize * 1, assets.tileSize * 3, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.four = love.graphics.newQuad(assets.tileSize * 0, assets.tileSize * 10, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.five = love.graphics.newQuad(assets.tileSize * 0, assets.tileSize * 9, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.six = love.graphics.newQuad(assets.tileSize * 0, assets.tileSize * 8, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.seven = love.graphics.newQuad(assets.tileSize * 1, assets.tileSize * 4, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.eight = love.graphics.newQuad(assets.tileSize * 0, assets.tileSize * 6, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.nine = love.graphics.newQuad(assets.tileSize * 0, assets.tileSize * 5, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())

  return assets
end

return Assets()
