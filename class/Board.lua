Board = Class{
  init = function(self)
    
    self.columns = {}
    for i = 1, 5 do
      table.insert(self.columns, i, Column(i))
    end
    self:errorCheck()
  end;
  
  update = function(self, dt)

  end;

  draw = function(self)
    for index, currentColumn in pairs(self.columns) do
      currentColumn:draw()
    end
  end;
  
  errorCheck = function(self)
    if data["allin.label"] == nil then
      love.errhand("Missing allinlabel in data file")
    end
    if data["allin.question"] == nil then
      love.errhand("Missing allinquestion in data file")
    end
    if data["allin.answer"] == nil then
      love.errhand("Missing allinanswer in data file")
    end
  end;
  
  getData = function(self, key)
    local textObject = {}
    local sWidth = love.graphics.getWidth()
    local sHeight = love.graphics.getHeight()
    textObject.text = data[key]
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
}
