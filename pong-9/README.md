# pong-9 (Audio and Screen Resize update)

This update adds audio to our game. Sounds are added as a key values in a table.

This update also allows the application window to be resized.

# Adding game audio

```Lua
sounds = {
    ["paddle_hit"] = love.audio.newSource("audio/paddle_hit.wav", "static"),
    ["score"] = love.audio.newSource("audio/score.wav", "static"),
    ["wall_hit"] = love.audio.newSource("audio/wall_hit.wav", "static"),
    ["win"] = love.audio.newSource("audio/win.wav", "static"),
}
-- Call play function
sounds["paddle_hit"]:play()
```

Audio tool:

1. `bfxr` https://www.bfxr.net/

   Simple sound-generating program.

# Resizing application window

```Lua
-- In Love.load function
-- Initialize the virtual resolution, will be rendered within the actual window no matter its dimensions
push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true,
})

--[[
    Called by Love2D whenever we resize the screen.
    We push the new width and height so that the virtual resolution is adjusted accordingly
]]
function love.resize(width, height)
    push:resize(width, height)
end
```

# Functions used

1. `love.audio.newSource(path, [type])`

   Creates a Love2D audio object that we can play back at any point in our program. Can also be given a `type` of `stream` or `static`. `stream` assets will be streamed from disk as needed, whereas `static` assets will be preserved in memory.

   For larger sound effects and music tracks, streaming is more memory effective. In our examples, audio assets are static, since they are so small that they won't take up much memory at all.

1. `love.resize(width, height)`

   Called by Love2D every time we resize the application. Logic should go in here if anything in the game (e.g. UI) is sized dynamically based on the window size.

   `push:resize()` needs to be called here for our use case so that it can dynamically rescale its internal canvas to fit our new window dimensions
