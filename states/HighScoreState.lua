HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)
   self.highScores = params.highScores
end

function HighScoreState:update(dt)
    if love.keyboard.isDown('space') then
        gStateMachine:change('title', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()
  love.graphics.printf('LEADERBOARD', 0, 20, WINDOW_WIDTH, 'center')

    -- iterate over all high score indices in our high scores table
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

    love.graphics.printf("Press SPACE to return to the main menu!",
        0, WINDOW_HEIGHT - 18, WINDOW_WIDTH, 'center')
end
