PlayState = Class{__includes = BaseState}
function PlayState:init()
     mouse.x, mouse.y = love.mouse.getPosition()
     self.score = 0
     score = 0
     t = 0
     game_timer = 0
    love.mouse.setVisible(false)
end

function PlayState:update(dt)
   effect = love.graphics.newShader [[extern number time;vec4 effect(vec4 color, Image texture, vec2 texture_coords,vec2          pixel_coords){return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);}]]
    t = t + dt
     game_timer = game_timer +dt
    effect:send("time", t)
    mouse.x, mouse.y = love.mouse.getPosition()
    shipAngle =  math.atan2(mouse.y-shipY, mouse.x-shipX) % (2 * math.pi)
    

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
            local bulletSpeed = 500
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
                        stage = asteroid.stage ,
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
            --reset()
            --gStateMachine:change('score')
            camera:shake(8, 1, 60)
            gStateMachine:change('score', {
                    score = self.score
                })
            break
        end
    end
      
         
  if #asteroids == 0 then
       -- reset()
     gStateMachine:change('score', {
                   score = self.score
                })
    end
end

function PlayState:render()
love.graphics.clear(40, 45, 52, 255)
 love.graphics.draw(cursor, mouse.x- cursor:getWidth() / 2, mouse.y- cursor:getHeight() / 2)
love.graphics.setColor(255,255,255)
love.graphics.draw(player,shipX-16,shipY-16)
love.graphics.setFont(mediumFont)
love.graphics.print('Mouse Coordinates: ' .. mouse.x .. ', ' .. mouse.y..
  '     Turret Angle: '..shipAngle..
  '     FPS: '..tostring(love.timer.getFPS())..
  '     Score: '..tostring(score)..
  '     game_timer: '..tostring(game_timer))

    for y = -1, 1 do
        for x = -1, 1 do
           -- love.graphics.origin()
            love.graphics.translate(x * WINDOW_WIDTH, y * WINDOW_HEIGHT)
            love.graphics.setColor(0, 255, 0,50)
            love.graphics.setShader(effect)
            love.graphics.circle('line', shipX, shipY, shipRadius)
            love.graphics.setShader()
            love.graphics.setColor(255, 255, 255)
            local shipCircleDistance = 30
            love.graphics.circle(
                'line',
                shipX + math.cos(shipAngle) * shipCircleDistance,
                shipY + math.sin(shipAngle) * shipCircleDistance,
                5
            )
            
            love.graphics.circle(
                'line',
                shipX - math.cos(shipAngle) * shipCircleDistance,
                shipY - math.sin(shipAngle) * shipCircleDistance,
                5
            )

            for bulletIndex, bullet in ipairs(bullets) do
                love.graphics.setColor(255, 255, 0)
                love.graphics.setShader(effect)
                love.graphics.circle('line', bullet.x, bullet.y, bulletRadius)
                 love.graphics.circle('line', bullet.a, bullet.b, bulletRadius)
                love.graphics.setShader()
            end
            
            for asteroidIndex, asteroid in ipairs(asteroids) do
                love.graphics.setColor(255, 255, 255)
                love.graphics.circle('line', asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius)
            end
        end
    end
end


function PlayState:enter()
end

function PlayState:exit()
end