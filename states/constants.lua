Constants = Class{}

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
  
camera = Camera(x,y,WINDOW_WIDTH,WINDOW_HEIGHT)

screen:setRotation(rotation)
screen:setShear(x, y)
screen:setScale(x, y)
screen:setShake()
screen:setDimensions(love.graphics.getDimensions())

mouse = {}
player_speed = 500

background = love.graphics.newImage('graphics/grid_4.jpg')
backgroundScroll = 0
BACKGROUND_SCROLL_SPEED = 500
BACKGROUND_LOOPING_POINT = 480

player = love.graphics.newImage('graphics/player_3.png')
cursor = love.graphics.newImage('graphics/crosshair.png')

--player_2 =love.graphics.newImage('graphics/player_sprite.png')
--player_animate = GenerateQuads('player_2',32,32)

mouse.x, mouse.y = love.mouse.getPosition()

shipRadius = 30
bulletRadius = 5  

smallFont = love.graphics.newFont('font/font.ttf', 8)
mediumFont = love.graphics.newFont('font/font.ttf', 16)
largeFont = love.graphics.newFont('font/font.ttf', 30)
tutorialFont = love.graphics.newFont('font/font.ttf', 80)
hugeFont = love.graphics.newFont('font/font.ttf', 300)

gSounds = {
        ['bg_music'] = love.audio.newSource('sounds/bg_1.ogg'),
        ['hit'] = love.audio.newSource('sounds/hit.ogg'),
        ['count'] = love.audio.newSource('sounds/countdown.wav'),
        ['bg_3'] = love.audio.newSource('sounds/bg_3.mp3')
    }
    
   
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
                x = WINDOW_WIDTH -50,
                y = 300,
            },
            {
                x = WINDOW_WIDTH- 100,
                y = 200,
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
        },
         {
            speed = 100,
            radius = 90
        }
    }

      
effect = love.graphics.newShader [[extern number time;vec4 effect(vec4 color, Image texture, vec2 texture_coords,vec2          pixel_coords){return vec4((1.0+sin(time))/2.0, abs(cos(time)), abs(sin(time)), 1.0);}]]

function loadHighScores()
    love.filesystem.setIdentity('5050')
    if not love.filesystem.exists('5050.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'QWE\n'
            scores = scores .. tostring(i * 1) .. '\n'  
        end
        love.filesystem.write('5050.lst', scores)
    end
    local name = true
    local currentName = nil
    local counter = 1

    local scores = {}

    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end
    for line in love.filesystem.lines('5050.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end
        name = not name
    end
    return scores
end
