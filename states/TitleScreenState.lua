TitleScreenState = Class{__includes = BaseState}

local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2

function TitleScreenState:enter(params)
    self.highScores = params.highScores
  end
  
  function TitleScreenState:exit()
  end
  
function TitleScreenState:init()
      image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
end

function TitleScreenState:update(dt)
    animation:update(dt)
    animation_2:update(dt)
  if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then   
    gStateMachine:change('countdown')
    
      elseif love.keyboard.isDown('t') or love.keyboard.isDown('T') then
      gStateMachine:change('tutorial', {
                highScores = self.highScores
            })
      
        elseif love.keyboard.isDown('l') or love.keyboard.isDown('L') then
            gStateMachine:change('highscore', {
                highScores = self.highScores
            })
    end
end

function TitleScreenState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.setColor(204, 254, 255)
    love.graphics.printf('50/50', 0, 150, WINDOW_WIDTH, 'center')
    animation:draw(image,398,250)
    animation_2:draw(image_black, 1000,300)
    love.graphics.setFont(largeFont)
    love.graphics.printf('PRESS ENTER', 0, 540, WINDOW_WIDTH ,'center')
    love.graphics.printf('TUTORIAL : T', 0, 580, WINDOW_WIDTH, 'center')
        love.graphics.printf('LEADERBOARD : L', 0, 620, WINDOW_WIDTH, 'center')
end