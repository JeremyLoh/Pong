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
-- the "Class" library allows us to represent objects and classes
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "class"

require "Ball"
require "Paddle"

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
-- Speed that we move our paddle; multiplied by dt in update
PADDLE_SPEED = 200
BALL_WIDTH = 5
BALL_HEIGHT = 5

-- Called once at start of game
function love.load()
    -- Use nearest neighbour filtering on upscaling and downscaling to prevent blurring of text and graphics
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- Set title of application window 
    love.window.setTitle("Pong")

    -- Initialize the virtual resolution, will be rendered within the actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen=false,
        resizable=false,
        vsync=true,
    })
    -- Create new fonts
    smallFont = love.graphics.newFont("font.ttf", 8)
    scoreFont = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(smallFont)

    -- Initialize a ball at the middle of the game screen
    ball = Ball(VIRTUAL_WIDTH/2 - BALL_WIDTH, VIRTUAL_HEIGHT/2 - BALL_HEIGHT, BALL_WIDTH, BALL_HEIGHT)

    -- Initialize score variables for players
    player1Score = 0
    player2Score = 0

    -- Create player paddles (paddle moves along Y axis)
    player1 = Paddle(10, 30, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- Game state variable used to transition between different parts of the game
    -- (used for beginning, menus, main game, high score list, etc.)
    -- Use this to determine behaviour during render and update
    gameState = "start"
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "return" or key == "kpenter" then
        if gameState == "start" then 
            gameState = "play"
        elseif gameState == "play" then 
            -- Reset game state
            gameState = "start"
            ball:reset()
        end
    end
end

--[[
    Runs on every frame, with deltaTime (dt) passed in, the delta in seconds since the last frame (supplied by Love2D)
]]
function love.update(dt)
    -- Player 1 movement
    if love.keyboard.isDown("w") then
        -- Reduce Y to move towards top of screen (start is at 0)
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("s") then 
        player1.dy = PADDLE_SPEED
    else 
        player1.dy = 0
    end

    -- Player 2 movement
    if love.keyboard.isDown("up") then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then 
        player2.dy = PADDLE_SPEED
    else 
        player2.dy = 0
    end

    -- Check for play state
    if gameState == "play" then
        randomMovement = math.random(10, 120)
        -- Check for collision with paddles
        if ball:hasCollision(player1) then
            ball.dx = -ball.dx * 1.05
            -- Shift ball out of paddle
            ball.x = player1.x + PADDLE_WIDTH
            -- Keep velocity going in same direction
            ball.dy = ball.dy < 0 and -randomMovement or randomMovement
        end
        if ball:hasCollision(player2) then
            ball.dx = -ball.dx * 1.05
            -- Shift ball out of paddle
            ball.x = player2.x - BALL_WIDTH 
            -- Keep velocity going in same direction
            ball.dy = ball.dy < 0 and -randomMovement or randomMovement
        end
        -- Check for collision with upper game screen
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end
        -- Check for collision with bottom game screen
        if ball.y + BALL_WIDTH >= VIRTUAL_HEIGHT then
            ball.y = VIRTUAL_HEIGHT - BALL_WIDTH
            ball.dy = -ball.dy
        end
        -- Update ball position, scaled velocity by dt so movement is framerate independent
        ball:update(dt)
    end
    player1:update(dt)
    player2:update(dt)
end

function love.draw()
    -- Begin rendering at virtual resolution
    push:start()
    -- clear the screen with a specific color; 
    -- a color similar to some versions of the original Pong
    love.graphics.clear(40/255, 40/255, 40/255, 255/255)
    
    love.graphics.setFont(smallFont)
    love.graphics.printf("Pong!", 0, VIRTUAL_HEIGHT-10, VIRTUAL_WIDTH, "center")
    if gameState == "start" then 
        love.graphics.printf("Press Enter to start/reset the game!", 0, 0, VIRTUAL_WIDTH, "center")
    end

    -- Print player score
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50, 10)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 25, 10)

    -- Render objects
    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    -- End rendering at virtual resolution
    push:finish()
end

function displayFPS()
    fps = love.timer.getFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(fps), 10, 10)
end
