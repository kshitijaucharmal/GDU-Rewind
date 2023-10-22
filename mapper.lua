function Mapper()
  local tileClass = require('tile')
  local mapper = {}

  function mapper.mapColorToTile(color, x, y, level)
    if compareColors(color, colors.white) then
      table.insert(level, tileClass(assets.blank, x, y, world, "static"))
    elseif compareColors(color, colors.black) then
      table.insert(level, tileClass(assets.ground, x, y, world, "static"))
    elseif compareColors(color, colors.red) then
      table.insert(level, tileClass(assets.blank, x, y, world, "static"))
    elseif compareColors(color, colors.green) then
      table.insert(level, tileClass(assets.tree, x, y, world, "dynamic"))
    elseif compareColors(color, colors.blue) then
      table.insert(level, tileClass(assets.finish, x, y, world, "static"))
    else
      print("Wrong Color")
    end
  end

  return mapper
end

return Mapper()
