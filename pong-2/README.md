# pong-2 (Rectangle Update)

This version adds rectangles rendered on the game window for the left and right paddles.
The ball is also rendered at the center of the game window.
The text ("Pong") is centered at the bottom of the screen.

# Functions used

1. `love.graphics.newFont(path, size)`

   Loads a font file into memory at a specific path, setting it to a specific size, and storing it in an object we can use to globally change the currently active font that Love2D is using to render text (functioning like a state machine)

1. `love.graphics.setFont(font)`

   Sets Love2D's currently active font (of which there can only be one at a time) to a passed in `font` object that we can create with `love.graphs.newFont(path, size)`

1. `love.graphics.clear(r, g, b, a)`

   Wipes the entire screen with a color defined by a RGBA set, each component being a value from 0 to 1 (for Love11) (we just do color value / 255 (e.g. 45/255))

1. `love.graphics.rectangle(mode, x, y, width, height`

   Draws a rectangle onto the screen using whichever our active color is (`love.graphics.setColor`, which we don't need to use in this project as almost everything is white, the default Love2D color).

   `mode` can be set to `fill` or `line`, which result in a filled or outlined rectangle respectively.

   The other 4 parameters are its position and size dimensions.

# References

1. [love.graphics.newFont](https://love2d.org/wiki/love.graphics.newFont)
1. [love.graphics.setFont](https://love2d.org/wiki/love.graphics.setFont)
