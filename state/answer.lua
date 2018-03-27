answer = {}

function answer:init()
  love.graphics.setBackgroundColor(4,55,99,255)
  
  backText = "Return to Question"
  forwardText = "Back to Board"
  mousePoint = HC.point(love.mouse.getX(),love.mouse.getY())
end

function answer:enter(previous, activeSquare)
  sWidth = love.graphics.getWidth()
  sHeight = love.graphics.getHeight()
  titleX = sWidth/8
  titleY = sHeight/8
  box1x = sHeight/16
  box2x = sWidth - sHeight/16 - sWidth/5
  boxy = sHeight*13/16
  boxWidth = sWidth/5
  boxHeight = sHeight/8
  
  if slideMoveFont:getWidth(backText) > boxWidth-10 then
    backTextY = boxy+(boxHeight/2)-(slideMoveFont:getHeight()/2)
  else
    backTextY = boxy+(boxHeight/2)
  end
  
  if slideMoveFont:getWidth(forwardText) > boxWidth-10 then
    forwardTextY = boxy+(boxHeight/2)-(slideMoveFont:getHeight()/2)
  else
    forwardTextY = boxy+(boxHeight/2)
  end
  
  returnButton = HC.rectangle(box1x, boxy, boxWidth, boxHeight)
  nextButton = HC.rectangle(box2x, boxy, boxWidth, boxHeight)
  
  activeAnswer = activeSquare.answer
  love.mouse.setCursor()
end

function answer:update()
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

function answer:draw()
  love.graphics.setColor(yellow)
  love.graphics.setFont(slideTopFont)
  love.graphics.printf(activeSquare.topicName .. " - " .. activeSquare.value .. " Answer", sWidth/10, sHeight/20, sWidth*8/10, "center") 
  
  if activeSquare.numAImages > 0 then
    love.graphics.setColor(255,255,255,255)
    for index, image in pairs(activeSquare.answerImages) do
      love.graphics.draw(image.picture, image.x, image.y, 0, image.scale, image.scale, image.picture:getWidth()/2, image.picture:getHeight()/2)
    end
  end
  
  love.graphics.setColor(yellow)
  love.graphics.setFont(questionFont)
  love.graphics.printf(activeAnswer.text, activeAnswer.x, activeAnswer.y, activeAnswer.width, "center", 0, 1, 1, 0, activeAnswer.offset)
  
  love.graphics.setFont(slideMoveFont)
  love.graphics.printf(backText, box1x, backTextY, boxWidth-10, "center", 0, 1, 1, 0, yOffset)
  love.graphics.printf(forwardText, box2x, forwardTextY, boxWidth-10, "center", 0, 1, 1, 0, yOffset)
  
  love.graphics.setColor(0,0,0,255)
  returnButton:draw("line")
  nextButton:draw("line")
  
  if isExiting then
    exitBox:draw()
  end
end

function answer:draw_ui()
  
end

function answer:mousepressed(x, y, button, isTouch)
  if isExiting == false then
    if button == 1 then
      if mousePoint:collidesWith(returnButton) then
        Gamestate.switch(question, activeSquare)
      elseif mousePoint:collidesWith(nextButton) then
        Gamestate.switch(board, activeSquare)
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

function answer:keypressed(key)
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