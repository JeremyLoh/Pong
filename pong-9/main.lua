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
        fullscreen = false,
        resizable = true,
        vsync = true,
    })
    -- Create new fonts
    smallFont = love.graphics.newFont("font.ttf", 8)
    scoreFont = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(smallFont)

    -- Create sounds using a table. We can index the keys in table and call the 'play' method
    sounds = {
        ["paddle_hit"] = love.audio.newSource("audio/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("audio/score.wav", "static"),
        ["wall_hit"] = love.audio.newSource("audio/wall_hit.wav", "static"),
        ["win"] = love.audio.newSource("audio/win.wav", "static"),
    }

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

--[[
    Called by Love2D whenever we resize the screen. 
    We push the new width and height so that the virtual resolution is adjusted accordingly
]]
function love.resize(width, height)
    push:resize(width, height)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "return" or key == "kpenter" then
        if gameState == "start" then 
            hasPlayedWinSound = false
            gameState = "play"
        elseif gameState == "serve" then
            gameState = "play"
        elseif gameState == "win" then
            hasPlayedWinSound = false
            gameState = "serve"
            player1Score = 0
            player2Score = 0
            servingPlayer = winner == 1 and 2 or 1
        end
    end
end

--[[
    Runs on every frame, with deltaTime (dt) passed in, the delta in seconds since the last frame (supplied by Love2D)
]]
function love.update(dt)
    checkGameState()
    checkPlayerScore()
    updatePlayerOneMovement()
    updatePlayerTwoMovement()
    player1:update(dt)
    player2:update(dt)
    -- Update ball position, scaled velocity by dt so movement is framerate independent
    if gameState == "play" then
        ball:update(dt)
    end
end

function checkGameState()
    if gameState == "play" then
        randomMovement = math.random(10, 120)
        -- Check for collision with paddles
        if ball:hasCollision(player1) then
            sounds["paddle_hit"]:play()
            ball.dx = -ball.dx * 1.05
            -- Shift ball out of paddle
            ball.x = player1.x + PADDLE_WIDTH
            -- Keep velocity going in same direction
            ball.dy = ball.dy < 0 and -randomMovement or randomMovement
        end
        if ball:hasCollision(player2) then
            sounds["paddle_hit"]:play()
            ball.dx = -ball.dx * 1.05
            -- Shift ball out of paddle
            ball.x = player2.x - BALL_WIDTH 
            -- Keep velocity going in same direction
            ball.dy = ball.dy < 0 and -randomMovement or randomMovement
        end
        -- Check for collision with upper game screen
        if ball.y <= 0 then
            sounds["wall_hit"]:play()
            ball.y = 0
            ball.dy = -ball.dy
        end
        -- Check for collision with bottom game screen
        if ball.y + BALL_WIDTH >= VIRTUAL_HEIGHT then
            sounds["wall_hit"]:play()
            ball.y = VIRTUAL_HEIGHT - BALL_WIDTH
            ball.dy = -ball.dy
        end
    elseif gameState == "serve" then
        -- Set velocity to face opponent
        if servingPlayer == 1 then 
            ball:moveRight()
        else 
            ball:moveLeft()
        end
    end
end

function checkPlayerScore()
    -- Check for score
    if ball.x > VIRTUAL_WIDTH then
        sounds["score"]:play()
        -- Increment player1 score
        player1Score = player1Score + 1
        ball:reset()
        servingPlayer = 2
        gameState = "serve"
    elseif ball.x < 0 then
        sounds["score"]:play()
        -- Increment player2 score
        player2Score = player2Score + 1
        ball:reset()
        servingPlayer = 1
        gameState = "serve"
    end
    -- Check for win condition
    if player1Score == 10 then
        playVictorySound()
        gameState = "win"
        winner = 1
    elseif player2Score == 10 then
        playVictorySound()
        gameState = "win"
        winner = 2
    end
end

function playVictorySound()
    if not hasPlayedWinSound then
        sounds["win"]:play()
        hasPlayedWinSound = true
    end
end

function updatePlayerOneMovement()
    if love.keyboard.isDown("w") then
        -- Reduce Y to move towards top of screen (start is at 0)
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("s") then 
        player1.dy = PADDLE_SPEED
    else 
        player1.dy = 0
    end
end

function updatePlayerTwoMovement()
    if love.keyboard.isDown("up") then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown("down") then 
        player2.dy = PADDLE_SPEED
    else 
        player2.dy = 0
    end
end

function love.draw()
    -- Begin rendering at virtual resolution
    push:start()
    -- clear the screen with a specific color; 
    -- a color similar to some versions of the original Pong
    love.graphics.clear(40/255, 40/255, 40/255, 255/255)
    displayTitle()
    displayInstructions()
    displayScore()
    displayFPS()
    -- Render objects
    player1:render()
    player2:render()
    ball:render()
    -- End rendering at virtual resolution
    push:finish()
end

function displayTitle()
    love.graphics.setFont(smallFont)
    love.graphics.printf("Pong!", 0, VIRTUAL_HEIGHT-10, VIRTUAL_WIDTH, "center")
end

function displayInstructions()
    love.graphics.setFont(smallFont)
    if gameState == "start" then 
        love.graphics.printf("Press Enter to start the game!", 0, 0, VIRTUAL_WIDTH, "center")
    elseif gameState == "win" then
        love.graphics.printf("Press Enter to restart the game!", 0, 0, VIRTUAL_WIDTH, "center")
    elseif gameState == "serve" then
        love.graphics.printf("Player " .. tostring(servingPlayer) .. " turn to serve! Press Enter to serve!", 0, 0, VIRTUAL_WIDTH, "center")
    end
end

function displayScore()
    -- Print player score
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2 - 50, 10)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2 + 25, 10)
    if gameState == "win" then
        love.graphics.printf("Player " .. winner .. " is the winner!", 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, "center")
    end
end

function displayFPS()
    fps = love.timer.getFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(fps), 10, 10)
    -- Reset color to white
    love.graphics.setColor(1, 1, 1, 1)
end
