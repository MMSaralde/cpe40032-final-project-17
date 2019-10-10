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
        ['highscore'] = function() return HighScoreState() end,
        ['enterhighscore'] = function() return EnterHighScoreState() end
    }
  gStateMachine:change('title', {
        highScores = loadHighScores()
    })
    reset()
end

function love.update(dt)
          gSounds['bg_3']:play()
          camera:update(dt)
          screen:update(dt)
    gStateMachine:update(dt)
  end
    
function love.draw()
          camera:attach()
          screen:apply()
          love.graphics.setColor(39,40,34)
          love.graphics.draw(background, -backgroundScroll, 0)
          love.graphics.reset()
          gStateMachine:render()
          camera:detach()
          camera:draw() 
  end
  
