require "conf"
require "library/fs"

function setAvatar(file)
  if string.sub(file, -4) == ".png" then
    avatars[file] = love.graphics.newImage(file)
  end
end

function love.load()
  width, height = love.graphics.getDimensions()
  avatarId = "assets/avatars/ava1.png"
  avatars = {}
  traverse("assets/avatars", setAvatar)
  image = avatars[avatarId]
end

function love.draw()
  local frame = math.floor(love.timer.getTime() * 3) % 2

  -- world canvas
  -- ...

  -- ideally:
  -- pre store each canvas as such:
  -- sprite[direction][animation-frame] = canvas
  -- then when the time comes to render it, just look up then
  -- love.graphics.draw(canvas, x, y, 0, 1, 1)

  -- sprite canvas
  canvas = love.graphics.newCanvas(width/16, height/16)
  canvas:setFilter("nearest", "nearest")
  love.graphics.setCanvas(canvas)

  quad = love.graphics.newQuad(frame*16, 0, 16, 16, image:getWidth(), image:getHeight())
  canvas:renderTo(function()
      -- left
      --love.graphics.draw(image, quad, 0, 0, 0, 1, 1, 0, 0)
      -- right
      love.graphics.draw(image, quad, 0, 0, 0, -1, 1, 16, 0)
  end)

  love.graphics.setCanvas(nil)
  love.graphics.draw(canvas, 0, 0, 0, 8, 8)
end

function love.threaderror(thread, errorstr)
  print("Thread error!\n" .. errorstr)
end

function love.keyreleased(key)
  if key == "escape" then
    love.event.quit()
  end
end
