# pong-0

This version just outputs "Hello Pong!" at the center of the screen (1280 x 720px)

# Important Love2D functions

1. `love.load()`

   Used to initialize the game state at the very beginning of program execution. (to override it in a `main.lua` file)

1. `love.update(dt)`

   Called by Love2D for each frame. `dt` (deltaTime) will be the elapsed time in seconds since the last frame. We use this to scale any changes in our game for even behaviour across frame rates

1. `love.draw()`

   Called each frame by Love2D after update for drawing things to the screen once they have changed. (Contains rendering behaviour)

Love2D expects these functions to be implemented in `main.lua` and calls them internally. If we don't define them, it will still function but our game will be fundamentally incomplete, at least if `update` or `draw` are missing!

1. `love.graphics.printf(text, x, y, [width], [align])`

   Versatile print function that can align text left, center, right on the screen

   [width] refers to the amount to align

   [align] is the mode of alignment

1. `love.window.setMode(width, height, params)`

   Used to initialize the window's dimensions and to set parameters like vsync (vertical sync), whether we're fullscreen or not, and whether the window is resizable after startup. Won't be using past this example in favour of the push resolution library, which has its own method like this, but useful to know if encountered in other code
