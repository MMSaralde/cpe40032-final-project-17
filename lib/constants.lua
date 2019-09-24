Constants = Class{}
camera = Camera()
screen:setRotation(rotation)
screen:setDimensions(love.graphics.getDimensions())
mouse = {}
player_speed = 500

player = love.graphics.newImage('player.png')
gun = love.graphics.newImage('gun.png')
cursor = love.graphics.newImage('crosshair.png')
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720


shipRadius = 30
bulletRadius = 5  

smallFont = love.graphics.newFont('font/font.ttf', 8)
mediumFont = love.graphics.newFont('font/font.ttf', 16)
largeFont = love.graphics.newFont('font/font.ttf', 32)
hugeFont = love.graphics.newFont('font/font.ttf', 300)

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
      

function love.keypressed(key)
      if key=='escape' then love.event.quit() 
    end
    
      if key == 'space' then 
        shipX = mouse.x
        shipY = mouse.y
      end
      
      if key == 'e' then
        screen:setScale(200, 300)
        end
      
    end
    
function love.mousepressed( x, y, button, istouch, presses )
  if button == 1 then
    if bulletTimer >= 0.1 then
            bulletTimer = 0

            table.insert(bullets, {
                x = shipX + math.cos(shipAngle) * shipRadius,
                y = shipY + math.sin(shipAngle) * shipRadius,
                 a = shipX - math.cos(shipAngle) * shipRadius,
                b = shipY - math.sin(shipAngle) * shipRadius,
                angle = shipAngle,
                timeLeft = 5,
            })
        end
      end
    end
    
asteroidStages = {
        {
            speed = 500,
            radius = 15
        },
        {
            speed = 400,
            radius = 30
        },
        {
            speed = 300,
            radius = 50
        },
        {
            speed = 200,
            radius = 80
        }
    }
    