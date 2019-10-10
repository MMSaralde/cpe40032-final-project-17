CountdownState = Class{__includes = BaseState}
local anim8 = require 'lib/anim8'
local image, animation, image_black, animation_2 
COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
    image = love.graphics.newImage('graphics/player_sprite.png')
      local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation = anim8.newAnimation(g('1-2',1), 0.1)
      
      image_black = love.graphics.newImage('graphics/player_sprite_black.png')
       local g_2 = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
      animation_2 = anim8.newAnimation(g_2('1-2',1), 0.1)
end

function CountdownState:update(dt)
   animation:update(dt)
    animation_2:update(dt)
    self.timer = self.timer + dt
    if self.timer > COUNTDOWN_TIME then
       gSounds['count']:play()
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        if self.count == 2 then
        camera:fade(1, {255, 255, 255, 255})
      end
      
      end
        if self.count == 0 then
            gStateMachine:change('play')
            camera:fade(1, {0, 0, 0, 0})
        end
    end


function CountdownState:render()
   animation:draw(image, 500 , 250)
    animation_2:draw(image_black,740,250)
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(self.count), 20, 150, 1280, 'center')
end