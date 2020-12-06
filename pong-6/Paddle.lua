--[[
    Representation of a Paddle object in Pong
]]

Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    -- Set initial movement speed to be 0
    self.dy = 0
end

function Paddle:update(dt)
    movement = self.dy * dt
    if self.dy < 0 then
        -- Moving upwards
        self.y = math.max(0, self.y + movement)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + movement)
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end