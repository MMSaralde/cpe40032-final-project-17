ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
    self.time = params.time
end

function ScoreState:init()
      love.mouse.setVisible(true)
    end
    
function ScoreState:exit()
end

function ScoreState:update(dt)
    if love.keyboard.isDown('R') or love.keyboard.isDown('r') then
        gStateMachine:change('play')
        reset()
    elseif love.keyboard.isDown('M') or love.keyboard.isDown('m') then
      local highScore = false
        local scoreIndex = 11
        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        if highScore then
            gStateMachine:change('enterhighscore', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex,
                time = self.time
            }) 
        else 
            gStateMachine:change('title', {
                highScores = self.highScores
            }) 
        end
    end
      
      
end

function ScoreState:render()
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('DEAD', 0, 150, 1280, 'center')

    love.graphics.setFont(largeFont)
    love.graphics.printf('Score: '.. tostring(self.score), 0, 460, 1280, 'center')
    love.graphics.printf('Time: '..string.sub(tostring(time),1,1),0,490,1280,'center')
    
    love.graphics.setFont(mediumFont)
    love.graphics.printf('PRESS R TO RESTART', 0, 550, 1280, 'center')
    love.graphics.printf('M FOR MENU, ESC TO GIVE UP', 0, 570, 1280, 'center')
end