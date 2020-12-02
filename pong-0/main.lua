--[[
    Originally programmed by Atari in 1972. 
    Features two paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. 
    First to 10 points wins.
]]

-- Declare constant variables for entire application
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Runs when the game first starts, only once
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable=false,
        fullscreen=false,
        vsync=true,
    })
end

-- Called each frame by Love2D after update
function love.draw() 
    -- Default font size in Love2D is 12px, shift down by 6px to center
    love.graphics.printf(
        "Hello Pong!",       -- text to render
        0,                   -- starting X
        WINDOW_HEIGHT/2 - 6, -- Starting Y (halfway down the screen)
        WINDOW_WIDTH,        -- Number of pixels to center within (the entire screen here) (Wrap the line after this many horizontal pixels.)
        "center"             -- AlignMode
    )
end
