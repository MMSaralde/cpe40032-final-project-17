ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then
        gStateMachine:change('countdown')
        reset()
    end
    
    if love.keyboard.isDown('t') or love.keyboard.isDown('T') then
      gStateMachine:change('title')
end
end


function ScoreState:render()
    love.graphics.clear(40, 45, 52, 255)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(largeFont)
    love.graphics.printf('Oof! You lost!', 0, 64, 1280, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, 1280, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, 1280, 'center')
    love.graphics.printf('Press t to return to title state', 0, 460, 1280, 'center')
end