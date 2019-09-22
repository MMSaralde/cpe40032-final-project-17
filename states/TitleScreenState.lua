TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
    -- nothing
end

function TitleScreenState:update(dt)
    if love.keyboard.isDown('enter') or love.keyboard.isDown('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
  love.graphics.clear(40, 45, 52, 255)
    love.graphics.setFont(hugeFont)
    love.graphics.printf('project_Singko_v10', 0, 64, 1280, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 200, 1280, 'center')
    love.graphics.printf('Press q to quit', 0, 300, 1280, 'center')
    if love.keyboard.isDown('q') or love.keyboard.isDown('Q') then
      love.event.quit()
      end
end