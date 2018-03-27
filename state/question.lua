question = {}

function question:init()
  love.graphics.setBackgroundColor(4,55,99,255)
  
  returnText = "Return to Board"
  nextText = "Go to Answer"
  mousePoint = HC.point(love.mouse.getX(),love.mouse.getY())
end

function question:enter(previous, activeSquare)
  sWidth = love.graphics.getWidth()
  sHeight = love.graphics.getHeight()
  titleX = sWidth/8
  titleY = sHeight/8
  box1x = sHeight/16
  box2x = sWidth - sHeight/16 - sWidth/5
  boxy = sHeight*13/16
  boxWidth = sWidth/5
  boxHeight = sHeight/8
  if slideMoveFont:getWidth(returnText) > boxWidth-10 then
    returnTextY = boxy+(boxHeight/2)-(slideMoveFont:getHeight()/2)
  else
    returnTextY = boxy+(boxHeight/2)
  end
  
  if slideMoveFont:getWidth(nextText) > boxWidth-10 then
    nextTextY = boxy+(boxHeight/2)-(slideMoveFont:getHeight()/2)
  else
    nextTextY = boxy+(boxHeight/2)
  end
  yOffset = slideMoveFont:getHeight()/2
  
  returnButton = HC.rectangle(box1x, boxy, boxWidth, boxHeight)
  nextButton = HC.rectangle(box2x, boxy, boxWidth, boxHeight)
  
  activeQuestion = activeSquare.question
  love.mouse.setCursor()
end

function question:update()
  mousePoint:moveTo(love.mouse.getX(),love.mouse.getY())
  if isExiting == false then
    if mousePoint:collidesWith(returnButton) or mousePoint:collidesWith(nextButton) then
      love.mouse.setCursor(cursor)
    else
      love.mouse.setCursor()
    end
  else
    if mousePoint:collidesWith(exitBox.yes) or mousePoint:collidesWith(exitBox.no) then
      love.mouse.setCursor(cursor)
    else
      love.mouse.setCursor()
    end
  end
end

function question:draw()
  love.graphics.setColor(yellow)
  love.graphics.setFont(slideTopFont)
  love.graphics.printf(activeSquare.topicName .. " - " .. activeSquare.value .. " Question", sWidth/10, sHeight/20, sWidth*8/10, "center") 
  
  if activeSquare.numQImages > 0 then
    for index, image in pairs(activeSquare.questionImages) do
      love.graphics.setColor(255,255,255,255)
      love.graphics.draw(image.picture, image.x, image.y, 0, image.scale, image.scale, image.picture:getWidth()/2, image.picture:getHeight()/2)
    end
  end
  
  love.graphics.setColor(yellow)
  love.graphics.setFont(questionFont)
  love.graphics.printf(activeQuestion.text, activeQuestion.x, activeQuestion.y, activeQuestion.width, "center", 0, 1, 1, 0, activeQuestion.offset)
  
  love.graphics.setFont(slideMoveFont)
  love.graphics.printf(returnText, box1x, returnTextY, boxWidth-10, "center", 0, 1, 1, 0, yOffset)
  love.graphics.printf(nextText, box2x, nextTextY, boxWidth-10, "center", 0, 1, 1, 0, yOffset)
  
  love.graphics.setColor(0,0,0,255)
  returnButton:draw("line")
  nextButton:draw("line")
  
  if isExiting then
    exitBox:draw()
  end
end

function question:mousepressed(x, y, button, isTouch)
  if isExiting == false then
    if button == 1 then
      if mousePoint:collidesWith(returnButton) then
        activeSquare.wasClicked = false
        Gamestate.switch(board, activeSquare)
      elseif mousePoint:collidesWith(nextButton) then
        Gamestate.switch(answer, activeSquare)
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

function question:keypressed(key)
  if isExiting == false then
    if key == "escape" then
      isExiting = true
    end
  else
    if key == "escape" then
      isExiting = false
    end
  end
end