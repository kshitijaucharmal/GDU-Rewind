
function Assets()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local assets = {}

  assets.tileSize = 128
  assets.tileset = love.graphics.newImage("assets/spritesheet_retina.png")
  assets.player = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 1, assets.tileSize, assets.tileSize, assets.tileset:getWidth(), assets.tileset:getHeight())

  return assets
end

return Assets()
