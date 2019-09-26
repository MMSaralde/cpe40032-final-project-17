Class = require 'lib/class'
require 'states/dependancies'

function love.load()
  love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  love.window.setTitle('pr5')
  math.randomseed(os.time())
  gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
   gStateMachine:change('title')
    reset()
end

function love.update(dt)
          camera:update(dt)
          screen:update(dt)
          if love.keyboard.isDown('w') then
      backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    end
    
    if love.keyboard.isDown('s') then

    end
    
     if love.keyboard.isDown('d') then
 backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
    end
    
    if love.keyboard.isDown('a') then
 backgroundScroll = (backgroundScroll - BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
    end
          
     
          gStateMachine:update(dt)
    end
    
  
function love.draw()
          camera:attach()
          screen:apply()
          love.graphics.draw(background, -backgroundScroll, 0)
          gStateMachine:render()
          camera:detach()
          camera:draw() 
  end