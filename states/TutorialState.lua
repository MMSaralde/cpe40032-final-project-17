TutorialState = Class{__includes = BaseState}

function TutorialState:init()
end

function TutorialState:update(dt)
    --love.graphics.setColor(255,0,0,50)
  if love.keyboard.isDown('space') then
    gStateMachine:change('title')
  end
end

function TutorialState:render()
    --love.graphics.clear(40, 45, 52, 255)
    --love.graphics.setColor(255,255,255,150)
    love.graphics.printf('w,a,s,d = controls     mouse.left = fire      space =  teleport to cursor      goal : get a score and time of 50', 0, 150, WINDOW_WIDTH, 'center')
    love.graphics.printf('space = title', 0, 500, WINDOW_WIDTH ,'center')
end