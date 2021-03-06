function love.load(arg)
  math.randomseed(os.time())
  token = love.graphics.newImage("sprites/token.png")
  field = love.graphics.newQuad(0, 0, 64, 64, 256, 64)
  cursor = love.image.newImageData("sprites/cursor.png")
  colors = {color(211, 121, 121), color(211, 167, 121), color(210, 210, 121), color(165, 211, 121), color(121, 164, 211), color(210, 121, 163)}
  currentColor = 0
  drawColor = 0
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle("Megagrid")
  love.window.setMode(320, 320, {resizable = true, minwidth = 320, minheight = 320})
  scaleimage, offsetH, offsetW = 1, 0, 0 -- Use scaleimage for image scale and add offset to image placement
  baseW, baseH = 320, 320  --Screensize at scale 1 for 5x5 sprites
  gridsizeX, gridsizeY = 5, 5
  updateCursor()
  gamegrid, spritegrid = createGrid(gridsizeX, gridsizeY)
  love.graphics.setColor(255, 255, 255)
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

  love.graphics.draw(spritegrid, 0 + offsetW, 0 + offsetH, 0, scaleimage, scaleimage)
  for y, rowTable in pairs(gamegrid) do
    for x, color in pairs(rowTable) do
      if color > 0 and color <= #colors then
        drawToken(color, x, y)
      end
    end
  end
end

function love.mousepressed(x, y, button, isTouch)
  if x >= offsetW and x < baseW * scaleimage + offsetW and y >= offsetH and y < baseH * scaleimage + offsetH and love.mouse.isDown(1) then
    local tileX = math.floor((x - offsetW) / (64 * scaleimage))
    local tileY = math.floor((y - offsetH) / (64 * scaleimage))
    gamegrid[tileY][tileX] = currentColor
  end
end

function love.wheelmoved(x, y)
  y = -y
  currentColor = (currentColor + y) % (#colors + 1)
  updateCursor()
end

-- math.floor(math.random(1, #colors)) | Use for correct answer generation
-----------------------------------New Functions-----------------------------------------------


--used to define colors faster
function color(r, g, b)
  local color = {}

  color["r"] = r
  color["g"] = g
  color["b"] = b

  return color
end

--creats the puzzle grid both visualy and logically
function createGrid(sizeX, sizeY)
  local logic = {}
  local sprites = love.graphics.newSpriteBatch(love.graphics.newImage("sprites/Field.png"), 100)
  for y = 0, sizeY - 1, 1 do
    logic[y] = {}
    for x = 0, sizeX - 1, 1 do
      sprites:add(field, x * 64, y * 64)
      logic[y][x] = 0
    end
  end
  return logic, sprites
end

--used to draw the tokens
function drawToken(colorID, tileX, tileY)
  drawColor = colorID
  local spriteData = love.image.newImageData("sprites/token.png")
  spriteData:mapPixel(colorToken)
  love.graphics.draw(love.graphics.newImage(spriteData), tileX * 64 * scaleimage + offsetW, tileY * 64 * scaleimage + offsetH, 0, scaleimage, scaleimage)

end

--colors cursor imagedata in currently active color
function colorCursor(x, y, r, g, b, a)
  local toColor

  if currentColor == 0 then
    toColor = color(255, 255, 255)
  else
    toColor = colors[currentColor]
  end

  r = toColor.r
  g = toColor.g
  b = toColor.b

  return r, g, b, a
end

function colorToken(x, y, r, g, b, a)
  local toColor
  toColor = colors[drawColor]

  r = toColor.r * (r / 255)
  g = toColor.g * (g / 255)
  b = toColor.b * (b / 255)

  return r, g, b, a
end

--sets the cursor to the currently selected color
function updateCursor()
  cursor:mapPixel(colorCursor)
  love.mouse.setCursor(love.mouse.newCursor(cursor, 30, 30))
end
