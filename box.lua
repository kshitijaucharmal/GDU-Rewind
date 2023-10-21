
function Box(x, y, w, h)
  return {
    x = x,
    y = y,
    w = w,
    h = h,

    colliding = function(self, box2)
      a = self
      b = box2
      return a.x < b.x+b.w and
        a.x+a.w > b.x and
        a.y < b.y+b.h and
        a.y+a.h > b.y
    end
  }

end

return Box
