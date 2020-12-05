# pong-4 (Ball update)

This update adds movement to the ball and 2 game states (`start` and `play`).
The paddle movement has also been limited to the game window.

Lua Ternary
https://nachtimwald.com/2019/02/20/lua-ternary/

# Functions used

1. `math.randomseed(num)`

   "Seeds" the random number generator used by Lua (`math.random`) with some value such that its randomness is dependent on that supplied value, allowing us to pass in different numbers each playthrough to guarantee non-consistency across different program executions (or uniformity if we want to have consistent behaviour for testing)

   math.random() with no arguments generates a real number between 0 and 1.
   math.random(upper) generates integer numbers between 1 and upper (both inclusive).
   math.random(lower, upper) generates integer numbers between lower and upper (both inclusive).

   http://lua-users.org/wiki/MathLibraryTutorial

1. `os.time()`

   Lua function that returns, in seconds, the time since 00:00:00 UTC, January 1, 1970, also known as Unix epoch time

1. `math.random(min, max)`

   Returns a random number, dependent on the seeded random number generator, between `min` and `max`, inclusive

1. `math.min(num1, num2)`

   Returns the lesser of the two numbers passed in

1. `math.max(num1, num2)`

   Returns the greater of the two numbers passed in
