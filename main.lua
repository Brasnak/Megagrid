function love.load(arg)
  token = love.graphics.newImage("sprites/token.png")
  love.graphics.setDefaultFilter("linear", "nearest", 1)
  love.window.setTitle("Megagrid")
  love.window.setMode(320, 320, {resizable = true, minwidth = 320, minheight = 320})
end

function love.draw()
  scaleimage, scaleheight, scalewidth = calculateScale()
  love.graphics.clear()
  love.graphics.setColor(255, 160, 20)
  love.graphics.draw(token, 30 * scalewidth, 30 * scaleheight, 0 , scaleimage, scaleimage)
end

--Used to determine Sprite scale and relative position
--Currently designed for an original window of 320x320

function calculateScale()
  scalewidth, scaleheight, scaleimage = 1
  width, height = love.window.getDesktopDimensions()
  if width > height then
    scalewidth = width / 320
    scaleheight, scaleimage = height / 320
  elseif height < width then
    scaleheight = height / 320
    scalewidth, scaleimage = width / 320
  else
    scaleimage, scalewidth, scaleheight = height / 320
  end
  return scaleimage, scaleheight, scalewidth
end
