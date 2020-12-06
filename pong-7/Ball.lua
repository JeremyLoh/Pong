--[[
    Representation of a Ball object in Pong
]]

Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    -- "Seed" the RNG (math.random) so that calls to random are random using current time
    math.randomseed(os.time())
    -- Set ball speed for x and y axis
    self:newBallSpeed()
end

function Ball:newBallSpeed()
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH/2 - self.width
    self.y = VIRTUAL_HEIGHT/2 - self.height
    self:newBallSpeed()
end

--[[
    Adds velocity to position, scaled by deltatime (dt)
]]
function Ball:update(dt)
    self.x = self.x + (self.dx * dt)
    self.y = self.y + (self.dy * dt)
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:hasCollision(paddle)
    return self:hasXAxisCollision(paddle.x, paddle.x + paddle.width) and
        self:hasYAxisCollision(paddle.y, paddle.y + paddle.height)
end

function Ball:hasXAxisCollision(p1, p2)
    Pmin = math.min(p1, p2)
    Pmax = math.max(p1, p2)
    Bmin = math.min(self.x, self.x + self.width)
    Bmax = math.max(self.x, self.x + self.width)
    return Bmin <= Pmax and Bmax >= Pmin
end

function Ball:hasYAxisCollision(p1, p2)
    Pmin = math.min(p1, p2)
    Pmax = math.max(p1, p2)
    Bmin = math.min(self.y, self.y + self.height)
    Bmax = math.max(self.y, self.y + self.height)
    return Bmin <= Pmax and Bmax >= Pmin
end

