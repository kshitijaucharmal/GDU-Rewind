colors = {}
colors.white = {1, 1, 1}
colors.black = {0, 0, 0}
colors.red = {1, 0, 0}
colors.green = {0, 1, 0}
colors.blue = {0, 0, 1}

function compareColors(col1, col2)
  if col1[1] == col2[1] and col1[2] == col2[2] and col1[3] == col2[3] then
    return true
  end
  return false
end
