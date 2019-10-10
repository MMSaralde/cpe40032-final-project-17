TutorialState = Class{__includes = BaseState}

function TutorialState:enter(params)
   self.highScores = params.highScores
 end
 
 function TutorialState:exit()
 end
 
function TutorialState:init()
end

function TutorialState:update(dt)
  if love.keyboard.isDown('space') then
   gStateMachine:change('title', {
            highScores = self.highScores
        })
  end
end

function TutorialState:render()
    love.graphics.setFont(tutorialFont)
    love.graphics.printf('GOAL: DESTROY ALL THE CIRCLES! ',0, 30, WINDOW_WIDTH, 'center')
    love.graphics.setFont(largeFont)
     love.graphics.printf('CONTROLS',0, 250, WINDOW_WIDTH, 'center')
    love.graphics.printf('movement: w,a,s,d',0, 300, WINDOW_WIDTH, 'center')
    love.graphics.printf('shoot: left mouse',0, 350, WINDOW_WIDTH, 'center')
    love.graphics.printf('teleport: space',0, 400, WINDOW_WIDTH, 'center')
    love.graphics.printf('TIP: HIT THE SMALLEST FIRST!',0, 500, WINDOW_WIDTH, 'center')
    love.graphics.printf('Press SPACE to return',0, 600, WINDOW_WIDTH, 'center')
end