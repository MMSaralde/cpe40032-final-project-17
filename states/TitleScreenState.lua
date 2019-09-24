TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
       screen:setScale(300,200)
end

function TitleScreenState:update(dt)
    if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.clear(40, 45, 52, 255)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('pr5', 0, 150, WINDOW_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 500, WINDOW_WIDTH ,'center')
    love.graphics.printf('q = quit', 0, 550, WINDOW_WIDTH, 'center')
    if love.keyboard.isDown('q') or love.keyboard.isDown('Q') then
      love.event.quit()
      end
end