function Assets()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local assets = {}
  assets.tileSize = 128
  assets.tileset = love.graphics.newImage("assets/spritesheet_retina.png")
  --added extra black n white tileset
  assets.tileset2 = love.graphics.newImage("assets/spritesheet_retina(black n white).png")

  assets.levelImgData = love.image.newImageData("assets/map4.png")
  assets.level = love.graphics.newImage(assets.levelImgData)

  assets.bg = love.graphics.newImage("assets/Backgrounds/colored_talltrees.png")

  assets.player = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 5, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.ghost = love.graphics.newQuad(assets.tileSize * 9, assets.tileSize * 5, assets.tileSize, assets.tileSize,
    assets.tileset2:getWidth(), assets.tileset2:getHeight())

  assets.blank = love.graphics.newQuad(assets.tileSize * 6, assets.tileSize * 8, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.ground = love.graphics.newQuad(assets.tileSize * 2, assets.tileSize * 5, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.tree = love.graphics.newQuad(assets.tileSize * 2, assets.tileSize * 4, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())
  assets.finish = love.graphics.newQuad(assets.tileSize * 3, assets.tileSize * 9, assets.tileSize, assets.tileSize,
    assets.tileset:getWidth(), assets.tileset:getHeight())

  return assets
end

return Assets()
