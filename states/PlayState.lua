PlayState = Class{__includes = BaseState}

local anim8 = require 'lib/anim8'
local image, animation

function PlayState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
    self.time = params.time
end

function PlayState:init()
    reset()
    self.score = 0
    score = 0
    t = 0
    time = 0
    love.mouse.setVisible(false)
    
    image = love.graphics.newImage('graphics/player_sprite.png')
  local g = anim8.newGrid(32,32, image:getWidth(), image:getHeight())
  animation = anim8.newAnimation(g('1-2',1), 0.1)
    
end

function PlayState:update(dt)
  animation:update(dt)
      t = t + dt
      effect:send("time", t)
      time = time + dt 
      mouse.x, mouse.y = love.mouse.getPosition()
      shipAngle =  math.atan2(mouse.y-shipY, mouse.x-shipX) % (2 * math.pi)
    
    if love.keyboard.isDown('d') then
            backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)% BACKGROUND_LOOPING_POINT
      elseif love.keyboard.isDown('a') then
            backgroundScroll = (backgroundScroll - BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
          end
          
    if love.keyboard.isDown('w') then
      shipY = (shipY - player_speed*dt) % WINDOW_HEIGHT 
    end
    
    if love.keyboard.isDown('s') then
      shipY = (shipY + player_speed*dt) % WINDOW_HEIGHT
    end
    
     if love.keyboard.isDown('d') then
      shipX = (shipX + player_speed*dt) % WINDOW_WIDTH
    end
    
    if love.keyboard.isDown('a') then
      shipX = (shipX - player_speed*dt) % WINDOW_WIDTH
    end

    local function areCirclesIntersecting(aX, aY, aRadius, bX, bY, bRadius)
        return (aX - bX)^2 + (aY - bY)^2 <= (aRadius + bRadius)^2
    end

    for bulletIndex = #bullets, 1, -1 do
        local bullet = bullets[bulletIndex]

        bullet.timeLeft = bullet.timeLeft - dt
        if bullet.timeLeft <= 0 then
            table.remove(bullets, bulletIndex)
        else
            local bulletSpeed = 900
            bullet.x = (bullet.x + math.cos(bullet.angle) * bulletSpeed * dt) % WINDOW_WIDTH
            bullet.y = (bullet.y + math.sin(bullet.angle) * bulletSpeed * dt) % WINDOW_HEIGHT
            
            bullet.a = (bullet.a - math.cos(bullet.angle) * bulletSpeed * dt) % WINDOW_WIDTH
            bullet.b = (bullet.b - math.sin(bullet.angle) * bulletSpeed * dt) % WINDOW_HEIGHT
        end

        for asteroidIndex = #asteroids, 1, -1 do
            local asteroid = asteroids[asteroidIndex]

      if areCirclesIntersecting(bullet.x, bullet.y, bulletRadius, asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius) or areCirclesIntersecting(bullet.a, bullet.b, bulletRadius, asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius) then
                table.remove(bullets, bulletIndex)
                self.score = self.score + 1
                score = self.score + 1
                gSounds['hit']:play()

                if asteroid.stage > 1 then
                    local angle1 = love.math.random() * (2 * math.pi)
                    local angle2 = (angle1 - math.pi) % (2 * math.pi)           
                    table.insert(asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle1,
                        stage = asteroid.stage - 1,
                    })
                    table.insert(asteroids, {
                        x = asteroid.x,
                        y = asteroid.y,
                        angle = angle2,
                        stage = asteroid.stage -1,
                    })
                end
                table.remove(asteroids, asteroidIndex)
                break
            end
        end
    end
    bulletTimer = bulletTimer + dt
    for asteroidIndex, asteroid in ipairs(asteroids) do
        asteroid.x = (asteroid.x + math.cos(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % WINDOW_WIDTH
        asteroid.y = (asteroid.y + math.sin(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % WINDOW_HEIGHT
           
       if areCirclesIntersecting(shipX, shipY, shipRadius, asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius) then
            camera:shake(8, 1, 60)
            gStateMachine:change('score', {
                  score = self.score,
                  highScores = loadHighScores(),
                  time = self.time
                })
            break
        end
    end
    
   if #asteroids >= 50 then
      table.remove(asteroids,asteroidIndex)
    end
    
  if #asteroids == 0 then
     gStateMachine:change('enterhighscore', {
                   score = self.score,
                   highScores = self.highScores,
                   time = self.time
                })
    end
end

function PlayState:render()
  love.graphics.draw(cursor, mouse.x- cursor:getWidth() / 2, mouse.y- cursor:getHeight() / 2)
  animation:draw(image, shipX-16,shipY-16)
  love.graphics.setFont(mediumFont)
   love.graphics.setColor(204, 254, 255)
  love.graphics.print('Mouse Coordinates: ' .. mouse.x .. ', ' .. mouse.y..
  '     FPS: '..tostring(love.timer.getFPS())..
  '     Score: '..(tostring(score)))

love.graphics.reset()

    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate(x * WINDOW_WIDTH, y * WINDOW_HEIGHT)
            love.graphics.setShader(effect)
            love.graphics.circle('line', shipX, shipY, shipRadius)
            love.graphics.reset()
            local shipCircleDistance = 30
            love.graphics.setColor(249,38,114)
            love.graphics.circle(
                'line',
                shipX + math.cos(shipAngle) * shipCircleDistance,
                shipY + math.sin(shipAngle) * shipCircleDistance,
                5
            )
            love.graphics.reset()
            love.graphics.setColor(102,217,239)
            love.graphics.circle(
                'line',
                shipX - math.cos(shipAngle) * shipCircleDistance,
                shipY - math.sin(shipAngle) * shipCircleDistance,
                5
            )
            love.graphics.reset()
            for bulletIndex, bullet in ipairs(bullets) do
              love.graphics.setColor(249,38,114)
              love.graphics.circle('line', bullet.x, bullet.y, bulletRadius)
                love.graphics.setColor(102,217,239)
                 love.graphics.circle('line', bullet.a, bullet.b, bulletRadius)
                 love.graphics.reset()
               end
          --love.graphics.setShader(effect)
          love.graphics.setColor(227, 86, 129)
            for asteroidIndex, asteroid in ipairs(asteroids) do
                love.graphics.circle('line', asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius)
            end
            love.graphics.reset()
        end
    end
end

function PlayState:enter()
end

function PlayState:exit()
end