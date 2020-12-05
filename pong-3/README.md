# pong-3 (Updating paddles)

Make the paddles move and keep track of player score. The player score is also shown in the game.
The paddles currently can move out of the game window (to be fixed in a future update)

# Functions used

1. `love.keyboard.isDown(key)`

   Returns `true` or `false` depending on whether the specified key is currently held down. Differs from `love.keypressed(key)` in that this can be called arbitrarily and will continuously return true if the key is pressed down, where `love.keypressed(key)` will only fire its code once every time the key is initially pressed down. However, since we want to be able to move our paddles up and down by holding down the appropriate keys, we need a function to test for longer periods of input (we therefore use the `love.keyboard.isDown(key)` function)
