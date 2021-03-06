# Pong

Atari's 1972 classic, implemented in Lua with LÖVE

The finished game (Windows 64 bit) is located at `Pong-Final-Game` directory (https://github.com/JeremyLoh/Pong/tree/main/Pong-Final-Game).
To play the game, download this directory and run the `pong.exe` file. 

# Playing the game

The current game version is for 2 players. Each player controls a paddle that can only move up or down. Player 1 controls the left paddle with the `W` and `S` keys on the keyboard while Player 2 controls the right paddle with the `UP` and `DOWN` arrow keys on the keyboard. A point will be awarded when the ball gets past your opponent's edge. The first player to reach 10 points wins! 

![image](https://user-images.githubusercontent.com/38811217/101348661-f630b780-38c6-11eb-92b1-5289999bb06d.png)
![image](https://user-images.githubusercontent.com/38811217/101348778-309a5480-38c7-11eb-9ff3-52eaa2388b97.png)

# What is Lua?

Portuguese for "moon", invented in 1993 in Brazil

Flexible, lightweight scripting language focused around "tables" (similar to a dictionary in Python)

Intended for embedded use in larger applications

Very popular in the video game industry

Similar(ish) to JavaScript

Excellent for storing data as well as code (data-driven design)

# What is Love2D?

Love2D (LÖVE) is a compiled game framework used to make 2D games in Lua.

A Fast 2D game development framework written in C++

Uses Lua as its scripting language

Contains modules for graphics, keyboard input, math, audio, windowing, physics, and much more

Completely free and portable to all major desktops and Android/iOS

Great for prototyping

# What is a game loop?

An infinite loop where the following steps happen:

1. Process user input
1. Update game
1. Render changes

# 2D Coordinate System

System where objects have an X and Y coordinate (X, Y) and are drawn accordingly;

(0,0) would be the top left of our system, with positive directions moving down and to the right and negative values moving up and to the left

http://rbwhitaker.wikidot.com/monogame-introduction-to-2d-graphics

# Pong game implementation

1. Draw shapes to the screen (paddles and ball)
1. Control 2D position of paddles based on input
1. Collision detection between paddles and ball to deflect ball back toward opponent
1. Collision detection between ball and map boundaries to keep ball within vertical bounds and to detect score (outside horizontal bounds)
1. Sound effects when ball hits paddles/walls or when a point is scored
1. Scorekeeping to determine winner
