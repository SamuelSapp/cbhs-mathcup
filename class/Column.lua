Column = Class{
  init = function(self, columnNumber)
    self.topicKey = "column" .. columnNumber .. ".topic"
    self.topic = data[self.topicKey]
    self.squares = {}
    self.width = (love.graphics.getWidth()-20)/5
    self.height = (love.graphics.getHeight()-20)/8
    
    table.insert(self.squares, 0, Square((columnNumber-1)*self.width+10, (2)*self.height+10, self.width, self.height, self.topicKey, self.topic, "", "", ""))
    
    for i = 1, 5 do
      local squareKey = "column" .. columnNumber .. ".square" .. i
      local valueKey = squareKey .. ".value"
      local questionKey = squareKey .. ".question"
      local answerKey = squareKey .. ".answer"
      table.insert(self.squares, i, Square((columnNumber-1)*self.width+10, (i+2)*self.height+10, self.width, self.height, squareKey, data[valueKey], self:getData(questionKey), self:getData(answerKey), self.topic))
    end
    
    self:errorCheck()
  end;
  
  update = function(self, dt)
  end;

  draw = function(self)
    for index, box in pairs(self.squares) do
      box:draw()
    end
  end;
  
  getData = function(self, key)
    local textObject = {}
    local sWidth = love.graphics.getWidth()
    local sHeight = love.graphics.getHeight()
    textObject.text = data[key]:gsub("|", "\n")
    textObject.x = data[key .. ".xpos"]
    textObject.y = data[key .. ".ypos"]
    textObject.width = data[key .. ".width"]
    if textObject.x == nil or textObject.x == "" then
      textObject.x = sWidth/6
    else
      textObject.x = (sWidth*(textObject.x/100)) - (sWidth*(textObject.width/100)/2)
    end
    
    if textObject.width == nil or textObject.width == "" then
      textObject.width = sWidth*2/3
    else
      textObject.width = sWidth*(textObject.width/100)
    end
    
    if textObject.y == nil or textObject.y == "" then
      textObject.y = sHeight/3
    else
      textObject.y = (sHeight*(100-textObject.y)/100) - (questionFont:getWidth(textObject.text)/textObject.width)*questionFont:getHeight()/2
    end
    
    textObject.offset = questionFont:getHeight()/2
    
    return textObject
  end;
  
  errorCheck = function(self)
    if self.topic == nil then
      love.errhand("Missing " .. self.topicKey .. " in data file")
    end
    if topicFont:getWidth(self.topic) > self.width*2 then
      love.errhand("A topic does not fit. Either reduce topicFontSize or shorten the " .. self.topicKey .." text in data file")
    end
  end;
}