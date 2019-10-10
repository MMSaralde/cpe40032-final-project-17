CountdownState = Class{__includes = BaseState}

COUNTDOWN_TIME = 0.75

function CountdownState:init()
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt
    if self.timer > COUNTDOWN_TIME then
       gSounds['count']:play()
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        if self.count == 2 then
        camera:fade(1, {255, 255, 255, 255})
      end
      
      end
        if self.count == 0 then
            gStateMachine:change('play')
            camera:fade(1, {0, 0, 0, 0})
        end
    end


function CountdownState:render()
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(self.count), 20, 150, 1280, 'center')
end