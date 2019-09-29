TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
      -- screen:setScale(300,200)
end

function TitleScreenState:update(dt)
    --love.graphics.setColor(255,0,0,50)
  if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then
    --love.graphics.reset()    
    gStateMachine:change('countdown')
elseif  love.keyboard.isDown('q') or love.keyboard.isDown('Q') then
      love.event.quit()
    elseif love.keyboard.isDown('l') or love.keyboard.isDown('L') then
     gStateMachine:change('leaderboard', {
        highScores = loadHighScores()
    })
    elseif
    love.keyboard.isDown('t') then
      gStateMachine:change('tutorial')
    end
  
end

function TitleScreenState:render()
    --love.graphics.clear(40, 45, 52, 255)
    --love.graphics.setColor(255,255,255,150)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('50/50', 0, 150, WINDOW_WIDTH, 'center')
    love.graphics.setFont(largeFont)
    love.graphics.printf('PRESS ENTER', 0, 500, WINDOW_WIDTH ,'center')
    love.graphics.printf('LEADERBOARD : L', 0, 540, WINDOW_WIDTH ,'center')
    love.graphics.printf('TUTORIAL : T', 0, 580, WINDOW_WIDTH, 'center')
    love.graphics.printf('QUIT : Q', 0, 620, WINDOW_WIDTH, 'center')
end