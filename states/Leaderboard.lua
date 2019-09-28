Leaderboard = Class{__includes = BaseState}

function Leaderboard:enter(params)
    self.highScores = params.highScores
end

function Leaderboard:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.isDown('space') then
        gStateMachine:change('title', {
            highScores = self.highScores
        })
    end
end

function Leaderboard:render()
    love.graphics.printf('High Scores', 0, 20, WINDOW_WIDTH, 'center')
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', WINDOW_WIDTH / 4, 
            60 + i * 13, 50, 'left')

        -- score name
        love.graphics.printf(name, WINDOW_WIDTH / 4 + 38, 
            60 + i * 13, 50, 'right')
        
        -- score itself
        love.graphics.printf(tostring(score), WINDOW_WIDTH / 2,
            60 + i * 13, 100, 'right')
    end

    love.graphics.printf("Press space to return",
        0, WINDOW_HEIGHT - 18, WINDOW_WIDTH, 'center')
end
