# pong-1 (The Low Resolution Update)

Update text to be lower resolution
Use `push` library, https://github.com/Ulydev/push/blob/master/push.lua

# Functions used

1. `love.graphics.setDefaultFilter(min, mag)`

   Sets the texture scaling filter when minimizing and magnifying textures and fonts.

   Default is bilinear, which causes blurriness (to reduce pixelation effect), and for our use case we typically want nearest-neighbour filtering ('nearest'), which results in perfect pixel upscaling and downscaling, simulating a retro feel

1. `love.keypressed(key)`

   A Love2D callback function that executes whenever we press a key, assuming we have implemented this in our `main.lua` in the same vein as `love.load()`, `love.update(dt)` and `love.draw()`.

1. `love.event.quit()`

   Simple function that terminates the application

# Texture Filtering

"Point" == "Nearest Neighbour" ('nearest' in the source code)

Billinear/trilinear/anisotropic filtering cause blurriness in 2D

https://answers.unity.com/questions/602721/sprite-filtering-pointbilinear.html

# References

1. [love.graphics.setDefaultFilter](https://love2d.org/wiki/love.graphics.setDefaultFilter)
1. [FilterMode](https://love2d.org/wiki/FilterMode)
