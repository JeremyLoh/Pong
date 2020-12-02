--[[
    Originally programmed by Atari in 1972. 
    Features two paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. 
    First to 10 points wins.

    This version is built to more closely resemble the NES than the original Pong machines or the Atari 2600 in terms of resolution, though in widescreen aspect ratio (16:9) so that it looks nicer on modern systems

    This version also has rectangles rendered on the game window for the left and right paddles. The ball is also rendered at the center of the game window.
]]

-- Use push library, allows us to draw the game at a virtual resolution, instead of how large our window is. Used to provide a more retro aesthetic
-- https://github.com/Ulydev/push
push = require "push"

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
BALL_WIDTH = 5
BALL_HEIGHT = 5

-- Called once at start of game
function love.load()
    -- Use nearest neighbour filtering on upscaling and downscaling to prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Create a new font
    smallFont = love.graphics.newFont('font.ttf', 8)
    -- Set active font
    love.graphics.setFont(smallFont)

    -- Initialize the virtual resolution, will be rendered within the actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen=false,
        resizable=false,
        vsync=true,
    })
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    -- Begin rendering at virtual resolution
    push:start()
    -- clear the screen with a specific color; 
    -- a color similar to some versions of the original Pong
    love.graphics.clear(40/255, 40/255, 40/255, 255/255)
    
    love.graphics.printf("Pong!", 0, VIRTUAL_HEIGHT-10, VIRTUAL_WIDTH, "center")

    -- render first paddle (left side)
    love.graphics.rectangle('fill', 10, 50, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- render second paddle (right side)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- render ball at center
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - BALL_WIDTH, VIRTUAL_HEIGHT/2 - BALL_HEIGHT, BALL_WIDTH, BALL_HEIGHT)

    -- End rendering at virtual resolution
    push:finish()
end
