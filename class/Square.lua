Square = Class{
  init = function(self, x, y, w, h, squareKey, value, question, answer, topicName)
    self.body = HC.rectangle(x, y, w, h)
    self.width = w
    self.height = h
    self.wasClicked = false
    self.squareKey = squareKey
    self.value = value
    self.question = question
    self.answer = answer
    self.topicName = topicName
    self.numQImages = 0
    self.numAImages = 0
    self.x = x
    if question.text ~= "" and question.text ~= nil then
      self.font = squareFont
      self.qFont = questionFont
      self.isQuestion = true
      self.y = y+(h/2)
      self.textColor = yellow
    else 
      self.font = topicFont
      self.isQuestion = false
      if self.font:getWidth(value) > self.width-10 then
        self.y = y+(self.height/2)-(self.font:getHeight()/2)
      else
        self.y = y+(h/2)
      end
      self.textColor = {255,255,255,255}
    end
    
    self:setImages()
    
    self:errorCheck()
  end;
  
  update = function(self, dt)
    
  end;

  draw = function(self)
    love.graphics.setColor(0,0,0,255)
    self.body:draw("line")
    if self.wasClicked == false then
      love.graphics.setFont(self.font)
      love.graphics.setColor(self.textColor)
      love.graphics.printf(self.value, self.x, self.y, self.width-10, "center", 0, 1, 1, 0, self.font:getHeight()/2)
    end
  end;
  
  errorCheck = function(self)
    if self.value == nil then
      love.errhand("Missing " .. self.squareKey .. "value in data file")
    end
    if self.question == nil then
      love.errhand("Missing " .. self.squareKey .. "question in data file")
    end
    if self.answer == nil then
      love.errhand("Missing " .. self.squareKey .. "answer in data file")
    end
  end;
  
  setImages = function(self)
    local sWidth = love.graphics.getWidth()
    local sHeight = love.graphics.getHeight()
    self.questionImages = {}
    local i = 1
    local imageKey = self.squareKey .. ".question.image" .. i
    while data[imageKey] ~= nil and data[imageKey] ~= "" do
      local image = {}
      if debug then
        image.picture = love.graphics.newImage(data[imageKey])
      else
        image.picture = love.graphics.newImage("cbhs-mathcup/" .. data[imageKey])
      end
    
      local iWidth = image.picture:getWidth()
      local iHeight = image.picture:getHeight()
      local x = tonumber(data[imageKey .. ".xpos"])
      local y = tonumber(data[imageKey .. ".ypos"])
      local scale = tonumber(data[imageKey .. ".size"])
      image.x = sWidth*x/100
      image.y = sHeight*(100-y)/100
      --if iWidth > iHeight then
      --  scale = (sWidth/iWidth)*(scale/100)
      --else
        scale = (SH/1080)*(scale/100)
     -- end
      
      image.scale = scale
      self.questionImages[i] = image
      self.numQImages = self.numQImages + 1
      i = i + 1
      imageKey = self.squareKey .. ".question.image" .. i
    end
    
    self.answerImages = {}
    i = 1
    imageKey = self.squareKey .. ".answer.image" .. i
    while data[imageKey] ~= nil and data[imageKey] ~= "" do
      local image = {}
      if debug then
        image.picture = love.graphics.newImage(data[imageKey])
      else
        image.picture = love.graphics.newImage("mathcup/" .. data[imageKey])
      end
      local iWidth = image.picture:getWidth()
      local iHeight = image.picture:getHeight()
      local x = tonumber(data[imageKey .. ".xpos"])
      local y = tonumber(data[imageKey .. ".ypos"])
      local scale = tonumber(data[imageKey .. ".size"])
      image.x = sWidth*x/100
      image.y = sHeight*(100-y)/100
      scale = (SH/1080)*(scale/100)
      
      image.scale = scale
      self.answerImages[i] = image
      self.numAImages = self.numAImages + 1
      i = i + 1
      imageKey = self.squareKey .. ".answer.image" .. i
    end
  end;
}