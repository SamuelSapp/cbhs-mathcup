board = {}

function board:init()
  activeBoard = Board()
  cursor = love.mouse.getSystemCursor("hand")
  love.graphics.setBackgroundColor(4,55,99,255)
  titleX = SW/2
  titleY = SH/8
  mousePoint = HC.point(love.mouse.getX(),love.mouse.getY())
  exitBox = ExitDialogue()
  specialBox = nil
  ringsImage = love.graphics.newImage("rings.png")
end

function board:enter()
  
end

function board:draw()
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(ringsImage, SW*.035, SH*.26, 0, SW/1920*.16, SH/1080*.16)
  activeBoard:draw()
  love.graphics.setFont(titleFont)
  love.graphics.setColor(yellow)
  love.graphics.print(data["board.Title"], titleX, titleY, 0, 1, 1, titleFont:getWidth(data["board.Title"])/2, titleFont:getHeight()/2)
  if specialBox ~= nil then
    specialBox:draw()
  end
  if isExiting then
    exitBox:draw()
  end
end

function board:draw_ui()
  
end

function board:update()
  mousePoint:moveTo(love.mouse.getX(),love.mouse.getY())
  local highlight = false
  
  if isExiting == false then
    if specialBox == nil then
      for index1, tempColumn in pairs(activeBoard.columns) do
        for index2, tempSquare in pairs(tempColumn.squares) do
          test = mousePoint:collidesWith(tempSquare.body)
          if test and tempSquare.isQuestion and tempSquare.wasClicked == false then
            highlight = true
          end
        end
      end
    else
      if mousePoint:collidesWith(specialBox.yes) or mousePoint:collidesWith(specialBox.no) then
        highlight = true
      end
    end
  else
    if mousePoint:collidesWith(exitBox.yes) or mousePoint:collidesWith(exitBox.no) then
      highlight = true
    end
  end
  
  if highlight then
    love.mouse.setCursor(cursor)
  else
    love.mouse.setCursor()
  end
end

function board:mousepressed(x, y, button, isTouch)
  if isExiting == false then
    if specialBox == nil then
      if button == 1 then
        for index1, tempColumn in pairs(activeBoard.columns) do
          for index2, tempSquare in pairs(tempColumn.squares) do
            test = mousePoint:collidesWith(tempSquare.body)
            if test and tempSquare.isQuestion and tempSquare.wasClicked == false then
              activeSquare = tempSquare
              if data[activeSquare.squareKey .. ".special"] ~= nil then
                specialBox = SpecialDialogue(data[activeSquare.squareKey .. ".special"])
              else
                activeSquare.wasClicked = true
                Gamestate.switch(question, activeSquare)
              end
            end
          end
        end
      end
    else
      if button == 1 then
        if mousePoint:collidesWith(specialBox.yes) then
          activeSquare.wasClicked = true
          specialBox = nil
          Gamestate.switch(question, activeSquare)
        elseif mousePoint:collidesWith(specialBox.no) then
          specialBox = nil
        end
      end
    end
  else
    if button == 1 then
      if mousePoint:collidesWith(exitBox.yes) then
        love.event.quit()
      elseif mousePoint:collidesWith(exitBox.no) then
        isExiting = false
      end
    end
  end
end

function board:keypressed(key)
  if isExiting == false then
    if key == "r" then
      activeBoard = Board()
    end
    if key == "escape" then
      isExiting = true
    end
  else
    if key == "escape" then
      isExiting = false
    end
  end
end