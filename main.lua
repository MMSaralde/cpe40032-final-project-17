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
          --gSounds['bg_music']:play()
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
  
  
function loadHighScores()
    love.filesystem.setIdentity('5050')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.exists('5050.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'xyz\n'
            scores = scores .. tostring(i * 1) .. '\n'
        end

        love.filesystem.write('5050.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('5050.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end
