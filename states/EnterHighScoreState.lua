EnterHighScoreState = Class{__includes = BaseState}

local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2

local chars = {
    [1] = 65,
    [2] = 65,
    [3] = 65
}
local highlightedChar = 1

function EnterHighScoreState:init()
    image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
    end
    
function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:exit()
end


function EnterHighScoreState:update(dt)
        animation:update(dt)
    animation_2:update(dt)
    if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])
        for i = 10, self.scoreIndex, -1 do
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end
        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score
        local scoresStr = ''

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
        end

        love.filesystem.write('5050.lst', scoresStr)

        gStateMachine:change('highscore', {
            highScores = self.highScores
        })
    end
    if love.keyboard.isDown('left') and highlightedChar > 1 then
        highlightedChar = highlightedChar - 1
    elseif love.keyboard.isDown('right') and highlightedChar < 3 then
        highlightedChar = highlightedChar + 1
    end

    if love.keyboard.isDown('up') then
        chars[highlightedChar] = chars[highlightedChar] + 1
        if chars[highlightedChar] > 90 then
            chars[highlightedChar] = 65
        end
    elseif love.keyboard.isDown('down') then
        chars[highlightedChar] = chars[highlightedChar] - 1
        if chars[highlightedChar] < 65 then
            chars[highlightedChar] = 90
        end
    end
end

function EnterHighScoreState:render()
  animation:draw(image, 500 ,WINDOW_HEIGHT /2)
    animation_2:draw(image_black,740,WINDOW_HEIGHT/2)
      love.graphics.setFont(largeFont)
         love.graphics.setColor(204, 254, 255)
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, 50,WINDOW_WIDTH, 'center')
    love.graphics.setFont(largeFont)
    if highlightedChar == 1 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.print(string.char(chars[1]), WINDOW_WIDTH / 2 - 28 -24, WINDOW_HEIGHT / 2)
    love.graphics.setColor(255, 255, 255, 255)

    if highlightedChar == 2 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.print(string.char(chars[2]), WINDOW_WIDTH / 2 - 6, WINDOW_HEIGHT / 2)
    love.graphics.setColor(255, 255, 255, 255)

    if highlightedChar == 3 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.print(string.char(chars[3]), WINDOW_WIDTH / 2 + 20 +20, WINDOW_HEIGHT / 2)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.reset()
    
    love.graphics.printf('Press Enter to confirm!', 0, WINDOW_HEIGHT - 100,
        WINDOW_WIDTH, 'center')
end