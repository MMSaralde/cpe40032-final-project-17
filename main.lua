Class = require 'lib/class'
require 'states/dependancies'
function love.load()
  love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  love.window.setTitle('50/50      Press Esc to quit anytime!')
  math.randomseed(os.time())
  gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['tutorial'] = function() return TutorialState() end,
        ['leaderboard'] = function() return Leaderboard() end,
        ['enterleaderboard'] = function() return enterLeaderboard() end
    }
   gStateMachine:change('title', {
        highScores = loadHighScores()
    })
    reset()
end

function love.update(dt)
          gSounds['bg_music']:play()
          camera:update(dt)
          screen:update(dt)
          --snow_system:update(dt)
     if love.keyboard.isDown('d') then
 backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
    
    elseif love.keyboard.isDown('a') then
 backgroundScroll = (backgroundScroll - BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
    end
          
          gStateMachine:update(dt)
    end
    
function love.draw()
          camera:attach()
          screen:apply()
          --love.graphics.draw(snow_system)
          love.graphics.setColor(128,128,128)
          love.graphics.draw(background, -backgroundScroll, 0)
          love.graphics.reset()
          gStateMachine:render()
          camera:detach()
          camera:draw() 
  end
  
