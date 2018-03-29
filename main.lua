Class = require "hump.class"
Gamestate = require "hump.gamestate"
Camera = require "hump.camera"

HC = require "hc"

require "state/title"
require "state/board"
require "state/question"
require "state/answer"

require "class/Board"
require "class/Column"
require "class/Square"
require "class/ExitDialogue"
require "class/SpecialDialogue"

debug = false

data = {}

SW = love.graphics.getWidth()
SH = love.graphics.getHeight()

function love.load(arg)
  isExiting = false
  if love.filesystem.isFused() or debug == false then
    local dir = love.filesystem.getSourceBaseDirectory()
    local success = love.filesystem.mount(dir, "mathcup")
    
    if success then
      for line in love.filesystem.lines("mathcup/data.txt") do
        for key, value in line:gmatch("(.-):(.*)") do
          data[key] = value
        end
      end
    end
  else
    local cwd = love.filesystem.getWorkingDirectory()
    
    for line in love.filesystem.lines("data.txt") do
      for key, value in line:gmatch("(.-):(.*)") do
        data[key] = value
      end
    end
  end
  love.graphics.setLineWidth(3)
  errorCheck()
  titleFont = love.graphics.newFont("cambria.ttc", tonumber(data["title.fontsize"])*SH/1080)
  squareFont = love.graphics.newFont("cambria.ttc", tonumber(data["square.fontsize"])*SH/1080)
  topicFont = love.graphics.newFont("cambria.ttc", tonumber(data["topic.fontsize"])*SH/1080)
  slideMoveFont = love.graphics.newFont("cambria.ttc", tonumber(data["slidemove.fontsize"])*SH/1080)
  questionFont = love.graphics.newFont("cambria.ttc", tonumber(data["question.fontsize"])*SH/1080)
  finalQuestionFont = love.graphics.newFont("cambria.ttc", tonumber(data["finalquestion.fontsize"])*SH/1080)
  slideTopFont = love.graphics.newFont("cambria.ttc", tonumber(data["slidetop.fontsize"])*SH/1080)
  
  yellow = {220,220,0,255}
  
  Gamestate.registerEvents()
  Gamestate.switch(board)
end

function errorCheck()
  if data["title.fontsize"] == nil then
    love.errhand("Missing title.fontsize in data file")
  end
  
  if data["square.fontsize"] == nil then
    love.errhand("Missing square.fontsize in data file")
  end
  
  if data["topic.fontsize"] == nil then
    love.errhand("Missing topic.fontsize in data file")
  end
  
  if data["slidemove.fontsize"] == nil then
    love.errhand("Missing slidemove.fontsize in data file")
  end
  
  if data["question.fontsize"] == nil then
    love.errhand("Missing question.fontsize in data file")
  end
  
  if data["finalquestion.fontsize"] == nil then
    love.errhand("Missing finalquestion.fontsize in data file")
  end
end