ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
     love.mouse.setVisible(true)
end

function ScoreState:update(dt)
    if love.keyboard.isDown('R') or love.keyboard.isDown('r') then
        gStateMachine:change('play')
        reset()
    end
    
    if love.keyboard.isDown('M') or love.keyboard.isDown('m') then
      gStateMachine:change('title')
end
end


function ScoreState:render()
    love.graphics.clear(40, 45, 52, 255)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('DEAD', 0, 200, 1280, 'center')

    love.graphics.setFont(largeFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 460, 1280, 'center')
    love.graphics.printf('Time '..tostring(game_timer),0,100,1280,'center')
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('PRESS R TO RESTART', 0, 500, 1280, 'center')
    love.graphics.printf('M FOR MENU, ESC TO GIVE UP', 0, 540, 1280, 'center')
end