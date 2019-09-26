Constants = Class{}

camera = Camera(x,y,1280,720)

screen:setRotation(rotation)
screen:setShear(x, y)
screen:setScale(x, y)
screen:setShake()
screen:setDimensions(love.graphics.getDimensions())

mouse = {}
player_speed = 500

particle = love.graphics.newImage("graphics/snow.png")
snow_system = love.graphics.newParticleSystem(particle, 1000)
	snow_system:setEmissionRate(100)
	snow_system:setSpeed(1,3)
	snow_system:setLinearAcceleration(-20, 50, 20, 100)
	snow_system:setSizes(0.7,0.6,0.5)
	snow_system:setPosition(1280/2,0)
	snow_system:setEmitterLifetime(-1)
	snow_system:setParticleLifetime(3,5.5)
	snow_system:setDirection(.45)
	snow_system:setAreaSpread("normal",300,0)
  snow_system:setColors(255,255,255,200)
  
background = love.graphics.newImage('graphics/grid.jpg')
backgroundScroll = 0
BACKGROUND_SCROLL_SPEED = 500
BACKGROUND_LOOPING_POINT = 480

--BACKGROUND_LOOPING_POINT_Y = -480
--BACKGROUND_SCROLL_SPEED_Y = -30

player = love.graphics.newImage('graphics/player_2.png')
cursor = love.graphics.newImage('graphics/crosshair.png')
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

mouse.x, mouse.y = love.mouse.getPosition()

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
            },
            {
                x = WINDOW_WIDTH - 100,
                y = 100,
            },
            {
                x = WINDOW_WIDTH - 100,
                y = 100,
            }
        }
        for asteroidIndex, asteroid in ipairs(asteroids) do
            asteroid.angle = love.math.random() * (2 * math.pi)
            asteroid.stage = #asteroidStages
        end
      end
      

function love.keypressed(key)
   if key=='escape' then 
     love.event.quit()
      elseif key == 'space' then 
        shipX = mouse.x
        shipY = mouse.y
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

      
effect = love.graphics.newShader [[extern number time;vec4 effect(vec4 color, Image texture, vec2 texture_coords,vec2          pixel_coords){return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);}]]
    