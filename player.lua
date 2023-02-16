
local Player = {
	world = {},
	x = 300,
	y = 150,
	width = 50,
	height = 50,
	mass = 50
}

function Player:load(world)
	self.world = world

	self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
	self.shape = love.physics.newRectangleShape(self.width, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape)

	self.body:setMass(self.mass)
end

function Player:update(dt) end

function Player:draw()
	love.graphics.setColor(0,0.5,1)
	love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))
end

return Player
