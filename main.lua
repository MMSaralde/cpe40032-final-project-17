Class = require 'lib/class'
require 'lib/dependancies'

function love.load()
  love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  love.window.setTitle('project_singko_v10')
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
          gStateMachine:update(dt)
    end
    
  
function love.draw()
          camera:attach()
          screen:apply()
          gStateMachine:render()
          camera:detach()
          camera:draw() 
  end
