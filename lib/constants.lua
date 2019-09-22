Constants = Class{}

mouse = {}
player_speed = 500
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
shipRadius = 30
bulletRadius = 5   

smallFont = love.graphics.newFont('font/font.ttf', 8)
mediumFont = love.graphics.newFont('font/font.ttf', 16)
largeFont = love.graphics.newFont('font/font.ttf', 32)
hugeFont = love.graphics.newFont('font/font.ttf', 56)

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