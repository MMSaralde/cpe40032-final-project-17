ScoreState = Class{__includes = BaseState}
local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2
function ScoreState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
    self.time = params.time
end

function ScoreState:init()
      love.mouse.setVisible(true)
       image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
    end
    
function ScoreState:exit()
end

function ScoreState:update(dt)
   animation:update(dt)
    animation_2:update(dt)
    if love.keyboard.isDown('R') or love.keyboard.isDown('r') then
        gStateMachine:change('play')
        reset()
    elseif love.keyboard.isDown('M') or love.keyboard.isDown('m') then
      local highScore = false
        local scoreIndex = 11
        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gStateMachine:change('enterhighscore', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex,
                time = self.time
            }) 
        else 
            gStateMachine:change('title', {
                highScores = self.highScores
            }) 
        end
    end
      
      
end

function ScoreState:render()
      animation:draw(image, 520,460)
    animation_2:draw(image_black,720,460)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('DEAD', 0, 150, 1280, 'center')

    love.graphics.setFont(largeFont)
    love.graphics.printf('Score: '.. tostring(self.score), 0, 460, 1280, 'center')
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('PRESS R TO RESTART', 0, 550, 1280, 'center')
    love.graphics.printf('M FOR MENU, ESC TO GIVE UP', 0, 570, 1280, 'center')
end