ExitDialogue = Class{
  init = function(self)
    self.width = (love.graphics.getWidth())/5
    self.height = (love.graphics.getHeight())/8
    self.no = HC.rectangle(self.width*4/3, self.height*5/2, self.width, self.height)
    self.yes = HC.rectangle(self.width*8/3, self.height*5/2, self.width, self.height)
  end;
  
  draw = function(self)
    love.graphics.setColor(255,255,255,255)
    love.graphics.rectangle("fill", self.width, self.height, self.width*3, self.height*3)
    love.graphics.setColor(0,0,0,255)
    love.graphics.rectangle("line", self.width, self.height, self.width*3, self.height*3)
    love.graphics.setColor(4,55,99,255)
    self.yes:draw("fill")
    love.graphics.setColor(4,55,99,255)
    self.no:draw("fill")
    love.graphics.setColor(0,0,0,255)
    love.graphics.setFont(slideTopFont)
    love.graphics.printf("Are you sure you want to exit?", self.width, self.height*6/5, self.width*3, "center")
    love.graphics.setColor(255,255,0,255)
    love.graphics.printf("No", self.width*4/3, self.height*6/2, self.width, "center", 0, 1, 1, 0, love.graphics.getFont():getHeight()/2)
    love.graphics.printf("Yes", self.width*8/3, self.height*6/2, self.width, "center", 0, 1, 1, 0, love.graphics.getFont():getHeight()/2)
  end
}