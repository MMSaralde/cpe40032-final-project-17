Class = require 'lib/class'
push = require 'lib/push'
require 'lib/constants'
require 'lib/StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'


function love.load()
  love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  love.window.setTitle('project_singko_v10')
  math.randomseed(os.time())
  
  gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    
      gStateMachine:change('title')
      
     function reset()
       shipX = WINDOW_WIDTH / 2
        shipY = WINDOW_HEIGHT / 2
        shipAngle = 0
        shipSpeedX = 0
        shipSpeedY = 0

        bullets = {}
        bulletTimer = 0

        asteroids = {
            {
                x = 100,
                y = 100,
            },
            {
                x = WINDOW_WIDTH - 100,
                y = 100,
            },
            {
                x = WINDOW_WIDTH / 2,
                y = WINDOW_HEIGHT - 100,
            }
        }
        for asteroidIndex, asteroid in ipairs(asteroids) do
            asteroid.angle = love.math.random() * (2 * math.pi)
            asteroid.stage = #asteroidStages
        end
    end
    reset()
end

function love.update(dt)
      gStateMachine:update(dt)
    --[[mouse.x, mouse.y = love.mouse.getPosition()
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
        end

        for asteroidIndex = #asteroids, 1, -1 do
            local asteroid = asteroids[asteroidIndex]

            if areCirclesIntersecting(bullet.x, bullet.y, bulletRadius, asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius) then
                table.remove(bullets, bulletIndex)

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
                        stage = asteroid.stage - 1,
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
            reset()
            break
        end
    end

    if #asteroids == 0 then
        reset()
    end
end]]--
end


function love.mousepressed( x, y, button, istouch, presses )
  if button == 1 then
    if bulletTimer >= 0.1 then
            bulletTimer = 0

            table.insert(bullets, {
                x = shipX + math.cos(shipAngle) * shipRadius,
                y = shipY + math.sin(shipAngle) * shipRadius,
                angle = shipAngle,
                timeLeft = 1,
            })
        end
      end
    end
    
    function love.keypressed(key)
      if key=='escape' then love.event.quit() end
    end
    

function love.draw()
    gStateMachine:render()
  --[[love.graphics.clear(40, 45, 52, 255)
    for y = -1, 1 do
        for x = -1, 1 do
            love.graphics.origin()
            love.graphics.translate(x * WINDOW_WIDTH, y * WINDOW_HEIGHT)
    
            love.graphics.setColor(0, 0, 255)
            love.graphics.circle('line', shipX, shipY, shipRadius)

            love.graphics.setColor(0, 255, 255)
            local shipCircleDistance = 20
            love.graphics.circle(
                'line',
                shipX + math.cos(shipAngle) * shipCircleDistance,
                shipY + math.sin(shipAngle) * shipCircleDistance,
                5
            )

            for bulletIndex, bullet in ipairs(bullets) do
                love.graphics.setColor(0, 255, 0)
                love.graphics.circle('line', bullet.x, bullet.y, bulletRadius)
            end

            for asteroidIndex, asteroid in ipairs(asteroids) do
                love.graphics.setColor(255, 255, 0)
                love.graphics.circle('line', asteroid.x, asteroid.y, asteroidStages[asteroid.stage].radius)
            end
        end
    end
end]]--
end
