--[[
    Originally programmed by Atari in 1972. 
    Features two paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. 
    First to 10 points wins.

    This version is built to more closely resemble the NES than the original Pong machines or the Atari 2600 in terms of resolution, though in widescreen aspect ratio (16:9) so that it looks nicer on modern systems
]]

-- Use push library, allows us to draw the game at a virtual resolution, instead of how large our window is. Used to provide a more retro aesthetic
-- https://github.com/Ulydev/push
push = require "push"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Run once when the game first starts up; used to initialize the game
function love.load()
    -- Use nearest neighbour filtering on upscaling and downscaling to prevent blurring of text and graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Initialize the virtual resolution, will be rendered within the actual window no matter its dimensions
    -- Replaces our love.window.setMode function call
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT , {
        fullscreen=false,
        resizable=false,
        vsync=true,
    })
end

-- Called by Love2D for each frame after update
function love.draw()
    love.graphics.printf(
        "Hello Pong Low Res!",
        0,
        WINDOW_HEIGHT/2 -6,
        WINDOW_WIDTH,
        "center"
    )
end

--[[
    Keyboard handling, called by Love2D for each frame
    Passes in the key we pressed so that we can access
]]
function love.keypressed(key)
    -- Keys are accessed by their string name
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    -- Begin rendering at virtual resolution
    push:start()
    love.graphics.printf("Hello Pong!", 0, VIRTUAL_HEIGHT/2 - 6, VIRTUAL_WIDTH, "center")
    -- End rendering at virtual resolution
    push:finish()
end
