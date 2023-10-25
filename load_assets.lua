function Assets()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local assets = {}

  assets.tileSize = 128
  --here size of one tile in texture is 128 pixels
  assets.tileset = love.graphics.newImage("assets/spritesheet_retina.png")
  assets.player = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 1, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())
  -- love.graphics.newQuad(x,y,width,height,sw,sh)
  -- here assets.tileset:getWidth() is total width and height of whole texture respectivly
  assets.ghost = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 6, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())

  return assets
end

return Assets()
