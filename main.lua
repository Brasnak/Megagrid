function love.load(arg)
  token = love.graphics.newImage("sprites/token.png")
  gamegrid = love.graphics.newSpriteBatch(love.graphics.newImage("sprites/Field.png"), 100)
  field = love.graphics.newQuad(0, 0, 64, 64, 256, 64)
  love.graphics.setDefaultFilter("linear", "nearest", 1)
  love.window.setTitle("Megagrid")
  love.window.setMode(320, 320, {resizable = true, minwidth = 320, minheight = 320})
  scaleimage, offsetH, offsetW = 1, 0, 0 -- Use scaleimage for image scale and add offset to image placement
  baseW, baseH = 320, 320  --Screensize at scale 1 for 5x5 sprites
  for y = 0, 4, 1 do
    for x = 0, 4, 1 do
      gamegrid:add(field, x * 64, y * 64)
    end
  end
end

function love.update(dt)

end

function love.resize(w, h)
  if w > h then
    offsetH = 0
    offsetW = (w - h) / 2
    scaleimage = h / baseH
  else
    offsetW = 0
    offsetH = (h - w) / 2
    scaleimage = w / baseW
  end
end

function love.draw()
  love.graphics.clear()
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(gamegrid, 0 + offsetW, 0 + offsetH, 0, scaleimage, scaleimage)
  love.graphics.setColor(255, 160, 20)
  for y = 0, 4, 1 do
    for x = 0, 4, 1 do
      love.graphics.draw(token, x * 64 * scaleimage + offsetW, y * 64 * scaleimage + offsetH, 0 , scaleimage, scaleimage)
    end
  end
end
