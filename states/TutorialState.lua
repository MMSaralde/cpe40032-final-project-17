TutorialState = Class{__includes = BaseState}
local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2 
function TutorialState:enter(params)
   self.highScores = params.highScores
 end
 
 function TutorialState:exit()
 end
 
function TutorialState:init()
  image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
end

function TutorialState:update(dt)
    animation:update(dt)
    animation_2:update(dt)
  if love.keyboard.isDown('space') then
   gStateMachine:change('title', {
            highScores = self.highScores
        })
  end
end

function TutorialState:render()
   animation:draw(image, 500 , 250)
    animation_2:draw(image_black,740,250)
    love.graphics.setFont(tutorialFont)
    love.graphics.printf('GOAL: DESTROY ALL THE CIRCLES! ',0, 30, WINDOW_WIDTH, 'center')
    love.graphics.setFont(largeFont)
     love.graphics.printf('CONTROLS',0, 250, WINDOW_WIDTH, 'center')
    love.graphics.printf('MOVEMENT : W A S D',0, 350, WINDOW_WIDTH, 'center')
    love.graphics.printf('SHOOT : LEFT MOUSE',0, 400, WINDOW_WIDTH, 'center')
    love.graphics.printf('TELEPORT TO TARGET : SPACE',0, 450, WINDOW_WIDTH, 'center')
    love.graphics.reset()
    love.graphics.printf('Press SPACE to return',0, 650, WINDOW_WIDTH, 'center')
end