-- Categories
-- 1 -> Default
-- 2 -> Player
-- 3 -> Ground
-- 4 -> Obstacles
-- 5 -> Props

function Mapper()
  local tileClass = require('tile')
  local playerClass = require('player')
  local mapper = {}

  function mapper.mapColorToTile(color, x, y, level)
    local tile = nil
    if compareColors(color, colors.white) then
      tile = tileClass(assets.blank, x, y, world, "static")
      tile.fixture:setUserData("Blank")
      --tile.fixture:setCategory(3)
    elseif compareColors(color, colors.black) then
      tile = tileClass(assets.ground, x, y, world, "static")
      tile.fixture:setUserData("Ground")
      tile.fixture:setCategory(3)
    elseif compareColors(color, colors.red) then
      player = playerClass(x, y, world)
      tile = player
    elseif compareColors(color, colors.green) then
      tile = tileClass(assets.tree, x, y, world, "static")
      tile.fixture:setCategory(5)
    elseif compareColors(color, colors.blue) then
      tile = tileClass(assets.finish, x, y, world, "static")
      tile.fixture:setUserData("Finish")
    else
      print("Wrong Color")
    end
    table.insert(level, tile)
  end

  return mapper
end

return Mapper()
