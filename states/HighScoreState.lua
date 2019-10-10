HighScoreState = Class{__includes = BaseState}
local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2

function HighScoreState:enter(params)
   self.highScores = params.highScores
end

function HighScoreState:init()
    image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
    end
    

function HighScoreState:update(dt)
      animation:update(dt)
    animation_2:update(dt)
    if love.keyboard.isDown('space') then
        gStateMachine:change('title', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()
   animation:draw(image, 500 , 17)
    animation_2:draw(image_black,740,17)
     love.graphics.setColor(204, 254, 255)
     love.graphics.setFont(mediumFont_2)
  love.graphics.printf('LEADERBOARD', 0, 20, WINDOW_WIDTH, 'center')
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'
        love.graphics.printf(tostring(i) .. '.', WINDOW_WIDTH / 4 + 70, 
            35 + i * 60, 50, 'left')
        love.graphics.printf(name, WINDOW_WIDTH / 4 + 108, 
            35 + i * 60, 50, 'right')
        love.graphics.printf(tostring(score), WINDOW_WIDTH / 2 + 70,
            35 + i * 60, 100, 'right')
    end
    love.graphics.reset()
    love.graphics.printf("Press SPACE to return to the main menu!",
        0, WINDOW_HEIGHT - 40, WINDOW_WIDTH, 'center')
end
